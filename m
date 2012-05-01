Return-Path: <kkeal@invensense.com>
From: Kerry Keal <kkeal@invensense.com>
References: <abd67b68b54fc6c88b83c91a200ace5e@mail.gmail.com>
 <4F9FAAB9.7060003@metafoo.de> <4F9FE357.6050004@cam.ac.uk>
 <4F9FE632.3040308@metafoo.de> <4F9FEA37.5040107@cam.ac.uk>
 <4F9FEDC6.8070400@metafoo.de> <4F9FF002.2060900@metafoo.de>
 <4F9FF82E.80906@cam.ac.uk> <4FA02576.2060607@metafoo.de> <6adea11c-371d-4d73-bb36-f9681db7265d@email.android.com>
 <4fab27b061c75547b5b02a7f409753f5@mail.gmail.com>
In-Reply-To: <4fab27b061c75547b5b02a7f409753f5@mail.gmail.com>
MIME-Version: 1.0
Date: Tue, 1 May 2012 15:47:57 -0700
Message-ID: <3713a0b46fef4a7338272684ab404017@mail.gmail.com>
Subject: RE: different data rate in IIO ?
To: Ge Gao <ggao@invensense.com>, Jonathan Cameron <jic23@cam.ac.uk>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi,

The MEMS sensor industry is moving towards multiple devices integrated on
the same chip. We currently are shipping a sensor with gyro, accel, and
compass on one chip and we have a also ship a gyro/accel chip. There are
other companies that have announce or are shipping multiple sensors on one
chip also.

If we have to have multiple IIO devices, we are increasing the data
traffic and causing more sys calls than simply adding a header to the
packet. For Android, we have a 64-bit timestamp associated with each
sensor measurement. If we integrate everything into one ringbuffer, we can
just store and read the timestamp one time for a compass, accel, and gyro
measurement at the cost of 1 header. The overhead of the header is more
than made up for with the lack of 2 timestamps and requiring 2 less
syscalls. I'm worried that our IIO driver we are developing will take up
more CPU resource and cost more battery life than our sysFS driver without
IIO.

Regards,
Kerry Keal


-----Original Message-----
From: linux-iio-owner@vger.kernel.org
[mailto:linux-iio-owner@vger.kernel.org] On Behalf Of Ge Gao
Sent: Tuesday, May 01, 2012 11:29 AM
To: Jonathan Cameron; Lars-Peter Clausen
Cc: linux-iio@vger.kernel.org
Subject: RE: different data rate in IIO ?

Thanks for the advice. So it seems everyone agrees that multiple IIO
device is the way to go. What about the using a flag to indicate which
data will come like the one below:
Under IIO architecture, can we have another kind of ring buffer in
addition to sw_ring and kfifo, such as header to indicate data
type(gyro_x, gyro_y, gyro_z, accel_x, accel_y, accel_z, compass_x,
compass_y, compass_z, quaternion_x, quaternion_y, quaternion_z,
quaternion_c) followed by actual data.
Also can we have some definition for quaternion? It is an important datum
for rotation calculation. It contains 4 elements, x, y, z and a constant.

Ge


-----Original Message-----
From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
Sent: Tuesday, May 01, 2012 11:05 AM
To: Lars-Peter Clausen
Cc: Ge Gao; linux-iio@vger.kernel.org
Subject: Re: different data rate in IIO ?



Lars-Peter Clausen <lars@metafoo.de> wrote:

>On 05/01/2012 04:50 PM, Jonathan Cameron wrote:
>> On 5/1/2012 3:15 PM, Lars-Peter Clausen wrote:
>>> On 05/01/2012 04:05 PM, Lars-Peter Clausen wrote:
>>> [...]
>>> Ah, seems as if the refcounting infrastructure is already ready for
>>> use after we have called device_initialize, so the above plan should
>>> work
>quite
>>> well.
>>> Call device_del in iio_device_unregister and device_put in
>>> iio_device_free and free the struct in the release callback.
>> That makes sense given it just splits the two parts of
>device_unregister
>> apart.
>> Don't suppose you want to do the patch?
>
>I could write the patch, but I don't have a setup at hand right now
>where I could test it, so this would have to wait until next week. I
>wouldn't mind if you took care of it though :)
I'll aim to do it Saturday....  nothing to test on till then.
>
>- Lars

--
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
the body of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html
