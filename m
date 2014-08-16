Return-Path: <aniroop.mathur@gmail.com>
MIME-Version: 1.0
In-Reply-To: <53ECC9F9.1050105@kernel.org>
References: <1407911391-26696-1-git-send-email-a.mathur@samsung.com>
	<53EB2AFE.10900@metafoo.de>
	<CADYu309nTht96H077D6YGvhRYz6Xfux7Qri5Hi7dfgQMtOz-Pg@mail.gmail.com>
	<53EB7AD9.9010602@metafoo.de>
	<CADYu30-RHmysR5vhvNLGXMBx2gnQ6rkdW-pPzyVY=E4KYg8g9w@mail.gmail.com>
	<53EC8463.2030802@metafoo.de>
	<53ECC9F9.1050105@kernel.org>
Date: Sat, 16 Aug 2014 20:14:23 +0530
Message-ID: <CADYu308GLWp1u4XUYTm+W5mF3bCdfq=km8VgYBMN5xc2P3GDdQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] IIO: Added write function in iio_buffer_fileops
From: Aniroop Mathur <aniroop.mathur@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: a.mathur@samsung.com, "cpgs ." <cpgs@samsung.com>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, p.shailesh@samsung.com, r.mahale@samsung.com,
	vidushi.koul@samsung.com, narendra.m1@samsung.com
Content-Type: multipart/alternative; boundary=14dae94ed6cd8279b30500c02cc5
List-ID: <linux-iio@vger.kernel.org>

--14dae94ed6cd8279b30500c02cc5
Content-Type: text/plain; charset=UTF-8

On Thu, Aug 14, 2014 at 8:08 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> On 14/08/14 10:41, Lars-Peter Clausen wrote:
> > On 08/13/2014 06:33 PM, Aniroop Mathur wrote:
> >> On Wed, Aug 13, 2014 at 8:18 PM, Lars-Peter Clausen <lars@metafoo.de>
> wrote:
> >>> On 08/13/2014 03:42 PM, Aniroop Mathur wrote:
> >>>>
> >>>> On Wed, Aug 13, 2014 at 2:38 PM, Lars-Peter Clausen <lars@metafoo.de>
> >>>> wrote:
> >>>>>
> >>>>> On 08/13/2014 08:29 AM, a.mathur@samsung.com wrote:
> >>>>>>
> >>>>>>
> >>>>>> From: Aniroop Mathur <a.mathur@samsung.com>
> >>>>>>
> >>>>>> Earlier, user space can only read from iio device node but cannot
> write
> >>>>>> to
> >>>>>> it.
> >>>>>> This patch adds write function in iio buffer file operations,
> >>>>>> which will allow user-space applications/HAL to write the data
> >>>>>> to iio device node.
> >>>>>> So now there will be two way communication between IIO subsystem
> >>>>>> and user space. (userspace <--> kernel)
> >>>>>>
> >>>>>> It can be used by HAL or any user-space application which wants to
> >>>>>> write data to iio device node/buffer upon receiving some data from
> it.
> >>>>>> As an example,
> >>>>>> It is useful for iio device simulator application which need to
> record
> >>>>>> the data by reading from iio device node and replay the recorded
> data
> >>>>>> by writing back to iio device node.
> >>>>>>
> >>>>>
> >>>>> I'm not convinced that this is something that should be added to the
> >>>>> kernel.
> I'm inclined to agree with Lars.  As an additional point this will cause
> confusion when we have buffered writing for output devices (DACs).
>
>
> >>>>> I'm wondering why can't this be done in userspace, e.g. by having a
> >>>>> simulator mode for the application or by using LD_PRELOAD. Having
> this in
> >>>>> userspace will be much more flexible and will be easier to implement
> >>>>> correctly and you'll most likely want to simulate more than just
> buffer
> >>>>> access, for example setting/getting properties of the device or
> channel.
> >>>>> For
> >>>>> the libiio[1] we are planning to implement a test backend that when
> >>>>> activated will allow to simulate a whole device rather than just
> buffer
> >>>>> support.
> >>>>>
> >>>>> [1] https://github.com/analogdevicesinc/libiio
> >>>>>
> >>>>>
> >>>>
> >>>> In normal Input Subsystem, there is two way communication between
> >>>> kernel and userpace. It has both read and write functionality. :)
> >>>> Why there is only one way communication in case of IIO ?
> Why should there be?
>


Below is the use case for which write function is required:

I am working on Sensor Simulator application for android phones.
This android application will simulate the sensor values
for any other already developed 3rd party/organization application/s
and not for simulator application itself.
In other words, I need to check the working of other sensor applications by
using my simulator application and along with it, checking of HAL and
Framework too.

For simulation, below is the data flow
by using user-space libiio and by directly writing to iio buffer.

Hardware--Driver--IIO--General_IIO_HAL--Framework--Other_Sensor_Application/s
   |
   | --> libiio <--> Simulator_Sensor_Application
   |
                   | <--> Simulator_Sensor_Application


If we use libiio,
Sensor_Simulator_Application will not be able to send sensor data to
Other_Sensor_Application/s because it can only write and read data for
itself.
Reading and writing data for itself is not what is required. There is a need
to send data to other application/s.
Also, we could not check HAL and Framework here.

If we directly write to iio buffer,
Sensor_Simulator_Application will be able to send sensor data to
Other_Sensor_Application/s and this in turn will also check whether there
are any problems in hal and framework for Other_Application to work
properly.
So, if some Other_Sensor_Application is behaving differently
for same sensor data it means there is some problem in
HAL/Framework/Application itself.

Also importantly, we can change the recorded data and check
Other_Application
working with that new data.
As an example,
There is an application, which uses accel+gyro+pressure to calculate
amount of calories burnt of an individual.
So once recorded the data physically by going in outside environment,
we can change just the pressure data and measure the amount of calories
burnt
without actually physically going outside at new height for new pressure.

Now to write directly to IIO buffer, there is a need of two things
that should be present in IIO subsystem:
1. Write function in iio_buffer file_ops.
2. Multiple file descriptor support for same device node.
   because both Simulator_Sensor_Application and Other_Sensor_Application/s
   need to open device node for their use.

Currently, both are not present in IIO subsystem.
So first, I am hoping to add write function and
after that adding multiple fd support.

In input subsystem, both facilities are available.

How can we achieve this task without directly writing to iio buffer ?
How will user-space libiio help us for this task ?


> >>>
> >>>
> >>> I've not seen a compelling reason yet why this must be implemented in
> kernel
> >>> space. In my opinion, as outlined above, userspace if both easier and
> more
> >>> flexible.
> >>>
> >>>
> >>>>
> >>>> For Input devices, I completed simulation just by reading and writing
> at
> >>>> input device node /dev/input/eventX.
> >>>> But for IIO devices, I am stuck as there is no write function
> available
> >>>> for iio device node /dev/iio:device0.
> >>>>
> >>>> As per my understanding, if we do the simulation in userspace
> >>>> then we need to create one more buffer in userpace. This will lead to
> >>>> extra memory usage. With write functionality in IIO just like
> >>>> in Input subsystem, we can avoid extra memory space. :)
> >>>
> >>>
> >>> No, you don't actually have to create a additional buffer. Just return
> the
> >>> data that you'd otherwise have passed to write().
> >>>
> >>>
> >>
> >> If there is no buffer, then there is clearly a chance of data
> loss/miss. :)
> >> Because if one application is reading the data with frequency 5 Hz
> >> and other application is writing the data at frequency 50 Hz (20 ms
> delay)
> >> so this reading application will miss reading a lot of data.
> >> Like in this case, after every 200 ms, 9 out of 10 data will be missed.
> >
> > Not if implemented correctly. Even with the current kernel
> implementation you'll have this issues as the buffer will
> > simply overflow when you write faster than you read.
> >
>


Generally, there is less difference between read and write frequency.
But there is difference.
So, in case of a buffer, there is very very less chance of data loss.
But in case of no buffer, there will be data loss/miss.

Generally, as you know, application requests for frequency at which
hardware should send data for their reading.
But driver frequency to write data in buffer
and application frequency to read data does not match exactly.
So either fast or slow, we end with either data loss
or same data being sent again to app.

Therefore, buffer is required to avoid such cases.




> >
> > [...]
> If we have a usecase for playback functionality like this I would prefer
> it to
> be on a separate IIO device.  When Lars' DAC buffered code is ready it will
> be relatively easy to string together a fake DAC with a fake ADC to get
> this sort of functionality.   It will be rather more interesting to
> work out how to setup an arbitary device but it could be done,
> most likely using configfs.
>
> This would be more similar to uinput than the writing to the chardevs
> directly as you are suggesting here.
>
> >>>>> Are you sure that this works? iio_push_to_buffer() expects a data
> buffer
> >>>>> of
> >>>>> size rb->bytes_per_datum bytes. On the other hand
> rb->bytes_per_datum is
> >>>>> only valid when the buffer is enabled, so for this to work the buffer
> >>>>> would
> >>>>> need to be enabled. Which means you'd inject the fake data in the
> middle
> >>>>> of
> >>>>> the real data stream.
> >>>>>
> >>>>>
> >>>>
> >>>> Yes, It works :)
> >>>> In one patch, bytes_per_datum has been removed from kifo_in.
> >>>> Patch - iio:kfifo_buf Take advantage of the fixed record size used in
> IIO
> >>>> commit c559afbfb08c7eac215ba417251225d3a8e01062
> >>>> - ret = kfifo_in(&kf->kf, data, r->bytes_per_datum);
> >>>> + ret = kfifo_in(&kf->kf, data, 1);
> >>>> So, I think we can now write only one byte of data.
> >>>
> >>>
> >>> No, we need to write 1 record and the size of one record is
> bytes_per_datum.
> >>> If you only write one byte you'll cause a out of bounds access.
> >>>
> >>>
> >>
> >> This is the code flow below which I checked:
> >>
> >> kfifo_in(&kf->kf, data, 1);
> >> so len=1
> >> kfifo_copy_in(fifo, buf, len, fifo->in);
> >> l = min(len, size - off);
> >> memcpy(fifo->data + off, src, l);
> >>
> >> In memcpy, if l is 1, so it will copy one byte only.
> >> So, how it is writing one record and not one byte ?
> > You missed this part:
> >
> >     if (esize != 1) {
> >         off *= esize;
> >         size *= esize;
> >         len *= esize;
> >     }
> >
> > so len gets multiplied by the record size. len=1 means 1 record.
> >
>

Oh, I really missed this part.
Thank you Mr. Lars for the correction.

So, in the write function,
we can just replace 1 by rb->bytes_per_datum.
And add the check like below:
+ if(!rb || rb->bytes_per_datum==0)
+ return -1;

I initially write the code with bytes_per_datum only.
But changed to 1 after seeing the latest kernel and
got confused with "1" value.

Is there anything else need to be changed ?



> >>
> >>>>
> >>>> Initially, I wrote the code for write functionality in kernel version
> 3.6
> >>>> using bytes_per_datum instead of fixed size of 1 byte.
> >>>> It worked fine. :)
> >>>> For this, we just need to replace size 1 by r->bytes_per_datum.
> >>>>
> >>>> We are not injecting data in middle of real data stream.
> >>>> When we inject the recorded data, we disabled the hardware chip,
> >>>> so no new/real data is pushed to the buffer during that time.
> >>>>
> >>>> To record, we enabled the buffer, read the real data and save it.
> >>>> To replay, we disabled the hardware chip and injected saved data by
> >>>> writing back to iio device node.
> >>>> So, Buffer is still enabled at time of writing to iio device node. :)
> >>>
> >>>
> >>> How do you disable the hardware without disabling the buffer?
> >>>
> >> I disabled the hardware by powering off the chip.
> >> And after writing is complete, chip is powered on again. :)
> >
> > But how do you disable the device when the buffer is still active?
> > IIO expects the device to be active when the buffer is active.
> Agreed. This sounds like a pretty uggly hack.  I would not be happy with
> having this in any driver.
>

Taking example of pressure sensor hardware chip,

Case1: Normal case,
1. We enabled the iio software buffer.
2. Pressure Hardware chip generates an interrupt.
3. Driver receives the interrupt call and make
   a call to push data to iio buffer

But if there is no change in pressure i.e. there is no new data
hardware chip will not generate any interrupt and hence
no data is pushed to iio software buffer.
And iio software buffer is still active and waiting if there is any data
comes.

Case 2: My case,
1. We enable the iio software buffer.
2. We record the pressure real data if there is.
3. We power off the pressure hardware chip
   or second way, we disable the irq only.

In this case too, there will be no interrupt call received by driver,
and hence no data is pushed to iio buffer.
And iio software buffer is still active and waiting if there is any data
comes.

In both cases, from iio buffer perspective,
iio software buffer is active and waiting for some data.

I cannot see any difference for IIO buffer in both cases.
So, I am not able to understand the problem here with IIO buffer ?

Later in case 2, as buffer is active,
Sensor_Simulator_Application can write data to it
and Other_Sensor_Application/s can read data from it.
And after simulation is over,
we power on the hardware chip again or second way, enable the irq again,
everything gets back to normal as before.

Thanks,
Aniroop

--14dae94ed6cd8279b30500c02cc5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Thu, Aug 14, 2014 at 8:08 PM, Jonathan Cameron <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:jic23@kernel.org" target=3D"_blank">jic23@kernel.org=
</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div class=3D"">On 14/08/14 10:41, Lars-Peter Clausen wrot=
e:<br>

&gt; On 08/13/2014 06:33 PM, Aniroop Mathur wrote:<br>
&gt;&gt; On Wed, Aug 13, 2014 at 8:18 PM, Lars-Peter Clausen &lt;<a href=3D=
"mailto:lars@metafoo.de">lars@metafoo.de</a>&gt; wrote:<br>
&gt;&gt;&gt; On 08/13/2014 03:42 PM, Aniroop Mathur wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On Wed, Aug 13, 2014 at 2:38 PM, Lars-Peter Clausen &lt;<a=
 href=3D"mailto:lars@metafoo.de">lars@metafoo.de</a>&gt;<br>
&gt;&gt;&gt;&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; On 08/13/2014 08:29 AM, <a href=3D"mailto:a.mathur@sam=
sung.com">a.mathur@samsung.com</a> wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; From: Aniroop Mathur &lt;<a href=3D"mailto:a.mathu=
r@samsung.com">a.mathur@samsung.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Earlier, user space can only read from iio device =
node but cannot write<br>
&gt;&gt;&gt;&gt;&gt;&gt; to<br>
&gt;&gt;&gt;&gt;&gt;&gt; it.<br>
&gt;&gt;&gt;&gt;&gt;&gt; This patch adds write function in iio buffer file =
operations,<br>
&gt;&gt;&gt;&gt;&gt;&gt; which will allow user-space applications/HAL to wr=
ite the data<br>
&gt;&gt;&gt;&gt;&gt;&gt; to iio device node.<br>
&gt;&gt;&gt;&gt;&gt;&gt; So now there will be two way communication between=
 IIO subsystem<br>
&gt;&gt;&gt;&gt;&gt;&gt; and user space. (userspace &lt;--&gt; kernel)<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; It can be used by HAL or any user-space applicatio=
n which wants to<br>
&gt;&gt;&gt;&gt;&gt;&gt; write data to iio device node/buffer upon receivin=
g some data from it.<br>
&gt;&gt;&gt;&gt;&gt;&gt; As an example,<br>
&gt;&gt;&gt;&gt;&gt;&gt; It is useful for iio device simulator application =
which need to record<br>
&gt;&gt;&gt;&gt;&gt;&gt; the data by reading from iio device node and repla=
y the recorded data<br>
&gt;&gt;&gt;&gt;&gt;&gt; by writing back to iio device node.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; I&#39;m not convinced that this is something that shou=
ld be added to the<br>
&gt;&gt;&gt;&gt;&gt; kernel.<br>
</div>I&#39;m inclined to agree with Lars.=C2=A0 As an additional point thi=
s will cause<br>
confusion when we have buffered writing for output devices (DACs).<br>
<div class=3D""><br>
<br>
&gt;&gt;&gt;&gt;&gt; I&#39;m wondering why can&#39;t this be done in usersp=
ace, e.g. by having a<br>
&gt;&gt;&gt;&gt;&gt; simulator mode for the application or by using LD_PREL=
OAD. Having this in<br>
&gt;&gt;&gt;&gt;&gt; userspace will be much more flexible and will be easie=
r to implement<br>
&gt;&gt;&gt;&gt;&gt; correctly and you&#39;ll most likely want to simulate =
more than just buffer<br>
&gt;&gt;&gt;&gt;&gt; access, for example setting/getting properties of the =
device or channel.<br>
&gt;&gt;&gt;&gt;&gt; For<br>
&gt;&gt;&gt;&gt;&gt; the libiio[1] we are planning to implement a test back=
end that when<br>
&gt;&gt;&gt;&gt;&gt; activated will allow to simulate a whole device rather=
 than just buffer<br>
&gt;&gt;&gt;&gt;&gt; support.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; [1] <a href=3D"https://github.com/analogdevicesinc/lib=
iio" target=3D"_blank">https://github.com/analogdevicesinc/libiio</a><br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; In normal Input Subsystem, there is two way communication =
between<br>
&gt;&gt;&gt;&gt; kernel and userpace. It has both read and write functional=
ity. :)<br>
&gt;&gt;&gt;&gt; Why there is only one way communication in case of IIO ?<b=
r>
</div>Why should there be?<br></blockquote><div><br></div><div><br></div><d=
iv><div>Below is the use case for which write function is required:</div><d=
iv><br></div><div>I am working on Sensor Simulator application for android =
phones.</div>
<div>This android application will simulate the sensor values=C2=A0</div><d=
iv>for any other already developed 3rd party/organization application/s=C2=
=A0</div><div>and not for simulator application itself.</div><div>In other =
words, I need to check the working of other sensor applications by</div>
<div>using my simulator application and along with it, checking of HAL and=
=C2=A0</div><div>Framework too.</div><div><br></div><div>For simulation, be=
low is the data flow=C2=A0</div><div>by using user-space libiio and by dire=
ctly writing to iio buffer.</div>
<div><br></div><div>Hardware--Driver--IIO--General_IIO_HAL--Framework--Othe=
r_Sensor_Application/s</div><div><span class=3D"" style=3D"white-space:pre"=
>				</span> =C2=A0 |</div><div><span class=3D"" style=3D"white-space:pre">=
				</span> =C2=A0 | --&gt; libiio &lt;--&gt; Simulator_Sensor_Application<=
/div>
<div><span class=3D"" style=3D"white-space:pre">				</span> =C2=A0 |</div><=
div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
&lt;--&gt; Simulator_Sensor_Application</div><div><br></div><div><br></div>=
<div>If we use libiio,=C2=A0</div><div>Sensor_Simulator_Application will no=
t be able to send sensor data to=C2=A0</div>
<div>Other_Sensor_Application/s because it can only write and read data for=
 itself.</div><div>Reading and writing data for itself is not what is requi=
red. There is a need</div><div>to send data to other application/s.</div>
<div>Also, we could not check HAL and Framework here.</div><div><br></div><=
div>If we directly write to iio buffer,</div><div>Sensor_Simulator_Applicat=
ion will be able to send sensor data to=C2=A0</div><div>Other_Sensor_Applic=
ation/s and this in turn will also check whether there</div>
<div>are any problems in hal and framework for Other_Application to work pr=
operly.</div><div>So, if some Other_Sensor_Application is behaving differen=
tly=C2=A0</div><div>for same sensor data it means there is some problem in=
=C2=A0</div>
<div>HAL/Framework/Application itself.</div><div><br></div><div>Also import=
antly, we can change the recorded data and check Other_Application=C2=A0</d=
iv><div>working with that new data.</div><div>As an example,</div><div>Ther=
e is an application, which uses accel+gyro+pressure to calculate=C2=A0</div=
>
<div>amount of calories burnt of an individual.</div><div>So once recorded =
the data physically by going in outside environment,</div><div>we can chang=
e just the pressure data and measure the amount of calories burnt</div>
<div>without actually physically going outside at new height for new pressu=
re.</div><div><br></div><div>Now to write directly to IIO buffer, there is =
a need of two things</div><div>that should be present in IIO subsystem:</di=
v>
<div>1. Write function in iio_buffer file_ops.</div><div>2. Multiple file d=
escriptor support for same device node.</div><div>=C2=A0 =C2=A0because both=
 Simulator_Sensor_Application and Other_Sensor_Application/s</div><div>=C2=
=A0 =C2=A0need to open device node for their use.</div>
<div>=C2=A0 =C2=A0</div><div>Currently, both are not present in IIO subsyst=
em.</div><div>So first, I am hoping to add write function and=C2=A0</div><d=
iv>after that adding multiple fd support.=C2=A0</div><div><br></div><div>In=
 input subsystem, both facilities are available.</div>
<div><br></div><div>How can we achieve this task without directly writing t=
o iio buffer ?</div><div>How will user-space libiio help us for this task ?=
</div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,2=
04);border-left-style:solid;padding-left:1ex">

<div class=3D"">&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I&#39;ve not seen a compelling reason yet why this must be imp=
lemented in kernel<br>
&gt;&gt;&gt; space. In my opinion, as outlined above, userspace if both eas=
ier and more<br>
&gt;&gt;&gt; flexible.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; For Input devices, I completed simulation just by reading =
and writing at<br>
&gt;&gt;&gt;&gt; input device node /dev/input/eventX.<br>
&gt;&gt;&gt;&gt; But for IIO devices, I am stuck as there is no write funct=
ion available<br>
&gt;&gt;&gt;&gt; for iio device node /dev/iio:device0.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; As per my understanding, if we do the simulation in usersp=
ace<br>
&gt;&gt;&gt;&gt; then we need to create one more buffer in userpace. This w=
ill lead to<br>
&gt;&gt;&gt;&gt; extra memory usage. With write functionality in IIO just l=
ike<br>
&gt;&gt;&gt;&gt; in Input subsystem, we can avoid extra memory space. :)<br=
>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; No, you don&#39;t actually have to create a additional buffer.=
 Just return the<br>
&gt;&gt;&gt; data that you&#39;d otherwise have passed to write().<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; If there is no buffer, then there is clearly a chance of data loss=
/miss. :)<br>
&gt;&gt; Because if one application is reading the data with frequency 5 Hz=
<br>
&gt;&gt; and other application is writing the data at frequency 50 Hz (20 m=
s delay)<br>
&gt;&gt; so this reading application will miss reading a lot of data.<br>
&gt;&gt; Like in this case, after every 200 ms, 9 out of 10 data will be mi=
ssed.<br>
&gt;<br>
&gt; Not if implemented correctly. Even with the current kernel implementat=
ion you&#39;ll have this issues as the buffer will<br>
&gt; simply overflow when you write faster than you read.<br>
&gt;<br></div></blockquote><div><br></div><div><br></div><div><div>Generall=
y, there is less difference between read and write frequency.</div><div>But=
 there is difference.</div><div>So, in case of a buffer, there is very very=
 less chance of data loss.</div>
<div>But in case of no buffer, there will be data loss/miss.</div><div><br>=
</div><div>Generally, as you know, application requests for frequency at wh=
ich</div><div>hardware should send data for their reading.</div><div>But dr=
iver frequency to write data in buffer=C2=A0</div>
<div>and application frequency to read data does not match exactly.</div><d=
iv>So either fast or slow, we end with either data loss=C2=A0</div><div>or =
same data being sent again to app.</div><div><br></div><div>Therefore, buff=
er is required to avoid such cases.</div>
</div><div><br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-=
left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div =
class=3D"">

&gt;<br>
&gt; [...]<br>
</div>If we have a usecase for playback functionality like this I would pre=
fer it to<br>
be on a separate IIO device.=C2=A0 When Lars&#39; DAC buffered code is read=
y it will<br>
be relatively easy to string together a fake DAC with a fake ADC to get<br>
this sort of functionality.=C2=A0 =C2=A0It will be rather more interesting =
to<br>
work out how to setup an arbitary device but it could be done,<br>
most likely using configfs.<br>
<br>
This would be more similar to uinput than the writing to the chardevs<br>
directly as you are suggesting here.<br>
<div><div class=3D"h5"><br>
&gt;&gt;&gt;&gt;&gt; Are you sure that this works? iio_push_to_buffer() exp=
ects a data buffer<br>
&gt;&gt;&gt;&gt;&gt; of<br>
&gt;&gt;&gt;&gt;&gt; size rb-&gt;bytes_per_datum bytes. On the other hand r=
b-&gt;bytes_per_datum is<br>
&gt;&gt;&gt;&gt;&gt; only valid when the buffer is enabled, so for this to =
work the buffer<br>
&gt;&gt;&gt;&gt;&gt; would<br>
&gt;&gt;&gt;&gt;&gt; need to be enabled. Which means you&#39;d inject the f=
ake data in the middle<br>
&gt;&gt;&gt;&gt;&gt; of<br>
&gt;&gt;&gt;&gt;&gt; the real data stream.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Yes, It works :)<br>
&gt;&gt;&gt;&gt; In one patch, bytes_per_datum has been removed from kifo_i=
n.<br>
&gt;&gt;&gt;&gt; Patch - iio:kfifo_buf Take advantage of the fixed record s=
ize used in IIO<br>
&gt;&gt;&gt;&gt; commit c559afbfb08c7eac215ba417251225d3a8e01062<br>
&gt;&gt;&gt;&gt; - ret =3D kfifo_in(&amp;kf-&gt;kf, data, r-&gt;bytes_per_d=
atum);<br>
&gt;&gt;&gt;&gt; + ret =3D kfifo_in(&amp;kf-&gt;kf, data, 1);<br>
&gt;&gt;&gt;&gt; So, I think we can now write only one byte of data.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; No, we need to write 1 record and the size of one record is by=
tes_per_datum.<br>
&gt;&gt;&gt; If you only write one byte you&#39;ll cause a out of bounds ac=
cess.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; This is the code flow below which I checked:<br>
&gt;&gt;<br>
&gt;&gt; kfifo_in(&amp;kf-&gt;kf, data, 1);<br>
&gt;&gt; so len=3D1<br>
&gt;&gt; kfifo_copy_in(fifo, buf, len, fifo-&gt;in);<br>
&gt;&gt; l =3D min(len, size - off);<br>
&gt;&gt; memcpy(fifo-&gt;data + off, src, l);<br>
&gt;&gt;<br>
&gt;&gt; In memcpy, if l is 1, so it will copy one byte only.<br>
&gt;&gt; So, how it is writing one record and not one byte ?<br>
&gt; You missed this part:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (esize !=3D 1) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0off *=3D esize;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size *=3D esize;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len *=3D esize;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; so len gets multiplied by the record size. len=3D1 means 1 record.<br>
&gt;<br></div></div></blockquote><div><br></div><div><div>Oh, I really miss=
ed this part.</div><div>Thank you Mr. Lars for the correction.</div><div><b=
r></div><div>So, in the write function,=C2=A0</div><div>we can just replace=
 1 by rb-&gt;bytes_per_datum.</div>
<div>And add the check like below:</div><div>+ if(!rb || rb-&gt;bytes_per_d=
atum=3D=3D0)</div><div>+ <span class=3D"" style=3D"white-space:pre">	</span=
>return -1;</div><div><br></div><div>I initially write the code with bytes_=
per_datum only.</div>
<div>But changed to 1 after seeing the latest kernel and</div><div>got conf=
used with &quot;1&quot; value.</div><div><br></div><div>Is there anything e=
lse need to be changed ?</div></div><div><br></div><div>=C2=A0<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padd=
ing-left:1ex">
<div><div class=3D"h5">
&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Initially, I wrote the code for write functionality in ker=
nel version 3.6<br>
&gt;&gt;&gt;&gt; using bytes_per_datum instead of fixed size of 1 byte.<br>
&gt;&gt;&gt;&gt; It worked fine. :)<br>
&gt;&gt;&gt;&gt; For this, we just need to replace size 1 by r-&gt;bytes_pe=
r_datum.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; We are not injecting data in middle of real data stream.<b=
r>
&gt;&gt;&gt;&gt; When we inject the recorded data, we disabled the hardware=
 chip,<br>
&gt;&gt;&gt;&gt; so no new/real data is pushed to the buffer during that ti=
me.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; To record, we enabled the buffer, read the real data and s=
ave it.<br>
&gt;&gt;&gt;&gt; To replay, we disabled the hardware chip and injected save=
d data by<br>
&gt;&gt;&gt;&gt; writing back to iio device node.<br>
&gt;&gt;&gt;&gt; So, Buffer is still enabled at time of writing to iio devi=
ce node. :)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; How do you disable the hardware without disabling the buffer?<=
br>
&gt;&gt;&gt;<br>
&gt;&gt; I disabled the hardware by powering off the chip.<br>
&gt;&gt; And after writing is complete, chip is powered on again. :)<br>
&gt;<br>
&gt; But how do you disable the device when the buffer is still active?<br>
&gt; IIO expects the device to be active when the buffer is active.<br>
</div></div>Agreed. This sounds like a pretty uggly hack.=C2=A0 I would not=
 be happy with<br>
having this in any driver.<br></blockquote><div><br></div><div><div>Taking =
example of pressure sensor hardware chip,</div><div><br></div><div>Case1: N=
ormal case,</div><div>1. We enabled the iio software buffer.</div><div>
2. Pressure Hardware chip generates an interrupt.</div><div>3. Driver recei=
ves the interrupt call and make</div><div>=C2=A0 =C2=A0a call to push data =
to iio buffer</div><div><br></div><div>But if there is no change in pressur=
e i.e. there is no new data</div>
<div>hardware chip will not generate any interrupt and hence</div><div>no d=
ata is pushed to iio software buffer.</div><div>And iio software buffer is =
still active and waiting if there is any data comes.</div><div><br></div>
<div>Case 2: My case,</div><div>1. We enable the iio software buffer.</div>=
<div>2. We record the pressure real data if there is.</div><div>3. We power=
 off the pressure hardware chip=C2=A0</div><div>=C2=A0 =C2=A0or second way,=
 we disable the irq only.</div>
<div><br></div><div>In this case too, there will be no interrupt call recei=
ved by driver,</div><div>and hence no data is pushed to iio buffer.</div><d=
iv>And iio software buffer is still active and waiting if there is any data=
 comes.</div>
<div><br></div><div>In both cases, from iio buffer perspective,</div><div>i=
io software buffer is active and waiting for some data.</div><div><br></div=
><div>I cannot see any difference for IIO buffer in both cases.</div><div>
So, I am not able to understand the problem here with IIO buffer ?</div><di=
v><br></div><div>Later in case 2, as buffer is active,</div><div>Sensor_Sim=
ulator_Application can write data to it</div><div>and Other_Sensor_Applicat=
ion/s can read data from it.</div>
<div>And after simulation is over,</div><div>we power on the hardware chip =
again or second way, enable the irq again,</div><div>everything gets back t=
o normal as before.</div></div><div><br></div><div>Thanks,</div><div>Aniroo=
p</div>
</div></div></div>

--14dae94ed6cd8279b30500c02cc5--
