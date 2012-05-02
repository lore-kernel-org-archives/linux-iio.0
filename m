Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:37396 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492Ab2EBI3M (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 2 May 2012 04:29:12 -0400
Message-ID: <4FA0F053.9040607@cam.ac.uk>
Date: Wed, 02 May 2012 09:29:07 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Kerry Keal <kkeal@invensense.com>
CC: Ge Gao <ggao@invensense.com>, Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org
Subject: Re: different data rate in IIO ?
References: <abd67b68b54fc6c88b83c91a200ace5e@mail.gmail.com> <4F9FAAB9.7060003@metafoo.de> <4F9FE357.6050004@cam.ac.uk> <4F9FE632.3040308@metafoo.de> <4F9FEA37.5040107@cam.ac.uk> <4F9FEDC6.8070400@metafoo.de> <4F9FF002.2060900@metafoo.de> <4F9FF82E.80906@cam.ac.uk> <4FA02576.2060607@metafoo.de> <6adea11c-371d-4d73-bb36-f9681db7265d@email.android.com> <4fab27b061c75547b5b02a7f409753f5@mail.gmail.com> <3713a0b46fef4a7338272684ab404017@mail.gmail.com>
In-Reply-To: <3713a0b46fef4a7338272684ab404017@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/1/2012 11:47 PM, Kerry Keal wrote:
> Hi,
>
> The MEMS sensor industry is moving towards multiple devices integrated on
> the same chip. We currently are shipping a sensor with gyro, accel, and
> compass on one chip and we have a also ship a gyro/accel chip. There are
> other companies that have announce or are shipping multiple sensors on one
> chip also.
Sure. Analog have been there for years, though they sample everything at the
same rate so don't make life tricky for us.
>
> If we have to have multiple IIO devices, we are increasing the data
> traffic and causing more sys calls than simply adding a header to the
> packet. For Android, we have a 64-bit timestamp associated with each
> sensor measurement. If we integrate everything into one ringbuffer, we can
> just store and read the timestamp one time for a compass, accel, and gyro
> measurement at the cost of 1 header. The overhead of the header is more
> than made up for with the lack of 2 timestamps and requiring 2 less
> syscalls.
Conversely userspace then has no way of knowing how much data to read.  
It could either
poke the header out, take a look and read the right amount, or always 
ask for a large
number and get given some arbitary smaller amount. (obviously this can 
happen now
but at least we know immediately where the boundaries lie).

The other big nasty is how we deal with demuxing this data flow. To 
sumarize the point
of the demux unit.  Multiple elements of the kernel / userspace want 
access to different
subsets of the incoming data.  IIO will ensure a superset of channels 
(if possible) is captured
and calculates a series of pseudo static demux tables.  These are then 
used to efficiently
rebuild the datastream as requested by the individual clients, providing 
them with only
what the want (note this functionality is under review at the mo). This 
is an absolute
requirement for the SoC adc type drivers and I am loath to having 
different data paths
for different IIO devices.  The only drivers that don't do this at the 
moment will be
the ones with substantial hardware buffers as obviously userspace can't 
demux what
it can't see!

We could obviously have a data stream with a header, but then the demux 
will have to
all be done dynamically which is going to be rather costly.

I suppose we could, for now, assume that devices that are doing 
hetrogeneous capture
like yours will never have more than one client and just push directly 
into the buffer.

 From the point of view of the timestamp, we just handle that as another 
channel type
so it won't be in the header anyway.

Lets consider the header.   It will need to be big enough to handle 
reasonably bulky devices.
Minimal approach is probably a bitmask.  We don't want to get into the 
game of doing the
mask on sets of channels.  So reasonably we need at least 32 bits, 
probably better to set
at 64 bits.  At a guess this is best anyway as data alignment will get 
in the way.

My biggest concern with all this is fragmenation in userspace code.   
Handling the two
buffer approaches will require rather different code.

Another large concern is that these separate devices are triggered by 
what to IIO will look
like different triggers as they are running at different frequencies.  
This is going to
make for some uggly interfaces to control the frequency.
>   I'm worried that our IIO driver we are developing will take up
> more CPU resource and cost more battery life than our sysFS driver without
> IIO.
Sure I fully appreciate your concern.  Don't suppose datasheets are 
available for the
9 axis part yet?  Looking at the 6050 stuff that's around gives some 
hints.  I'm particularly
interested in how the on chip fifo works.  Taking that 6050 we have 
8Khz/n gyroscope
frequency, 1khz accelerometer and the onchip fifo has the same issue we 
do. It deals with
it by repeating values.  So lets look at the overhead of that assuming 
addition of 3 x 16 bit
magnetometer readings and 3 x 16 bit for the quaternion?

I've made up the frequencies - real numbers would of course be better!  
Particularly useful
would be numbers that people typically actually use.  I doubt anyone 
samples the gyro at
8khz for example.

3 accel -> 48bits  (1khz)
3 gyro -> 48bits   (8khz)
3 magn -> 48bits (1khz)
3 quat -> 48bits  (250hz)
1 temp -> 16 bits  (1khz)
external sensors ouch 24 x 8 bits. (ignoring for now)
1 timestamp -> 64 bits (8khz)

So in every 32 packets (we have
1 with 40 bytes (accel gyro magn quat temp timestamp)
3 with 24 bytes ( accel gyro magn temp timestamp)
28 with 16 bytes  (timestamp + gyro)

So with a 8 bytes header added to each we would have a total of 816 bytes
Without header but allowing full space we would have 1536 bytes.
So in this case it's a significant saving in space.  However drop that 
gyro to
1kz and it all changes.  In 32 packets then we have
8 with 40 bytes
24 with 24 bytes

1152 with header vs 1280 without.

Note also that the buffer implemenation will probably add another header 
chunk
to every packet to allow us to avoid computing the packet length for 
each one.
At the moment our kfifo buf as such an overhead for everything anyway
(on the list to deal with!).

Hence, there clearly is a point at which a header may be sensible, but 
I'm not convinced
we have reached it here.  Obviously if you are using all those 24 bytess 
of auxiliary sensors
at a really low data rate that the numbers swing round completely!

Over to you guys to tell use what the actual frequencies and data sizes 
are rather than
my exercise in guessing here!

Jonathan





>
> Regards,
> Kerry Keal
>
>
> -----Original Message-----
> From: linux-iio-owner@vger.kernel.org
> [mailto:linux-iio-owner@vger.kernel.org] On Behalf Of Ge Gao
> Sent: Tuesday, May 01, 2012 11:29 AM
> To: Jonathan Cameron; Lars-Peter Clausen
> Cc: linux-iio@vger.kernel.org
> Subject: RE: different data rate in IIO ?
>
> Thanks for the advice. So it seems everyone agrees that multiple IIO
> device is the way to go. What about the using a flag to indicate which
> data will come like the one below:
> Under IIO architecture, can we have another kind of ring buffer in
> addition to sw_ring and kfifo, such as header to indicate data
> type(gyro_x, gyro_y, gyro_z, accel_x, accel_y, accel_z, compass_x,
> compass_y, compass_z, quaternion_x, quaternion_y, quaternion_z,
> quaternion_c) followed by actual data.
> Also can we have some definition for quaternion? It is an important datum
> for rotation calculation. It contains 4 elements, x, y, z and a constant.
>
> Ge
>
>
> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
> Sent: Tuesday, May 01, 2012 11:05 AM
> To: Lars-Peter Clausen
> Cc: Ge Gao; linux-iio@vger.kernel.org
> Subject: Re: different data rate in IIO ?
>
>
>
> Lars-Peter Clausen<lars@metafoo.de>  wrote:
>
>> On 05/01/2012 04:50 PM, Jonathan Cameron wrote:
>>> On 5/1/2012 3:15 PM, Lars-Peter Clausen wrote:
>>>> On 05/01/2012 04:05 PM, Lars-Peter Clausen wrote:
>>>> [...]
>>>> Ah, seems as if the refcounting infrastructure is already ready for
>>>> use after we have called device_initialize, so the above plan should
>>>> work
>> quite
>>>> well.
>>>> Call device_del in iio_device_unregister and device_put in
>>>> iio_device_free and free the struct in the release callback.
>>> That makes sense given it just splits the two parts of
>> device_unregister
>>> apart.
>>> Don't suppose you want to do the patch?
>> I could write the patch, but I don't have a setup at hand right now
>> where I could test it, so this would have to wait until next week. I
>> wouldn't mind if you took care of it though :)
> I'll aim to do it Saturday....  nothing to test on till then.
>> - Lars
> --
> Sent from my Android phone with K-9 Mail. Please excuse my brevity.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html

