Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>, Jonathan Cameron
	<jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>
Date: Wed, 20 Apr 2011 08:36:48 +0100
Subject: RE: iio_trigger_poll_chained causes NULL pointer access
Message-ID: <544AC56F16B56944AEC3BD4E3D59177137547D656F@LIMKCMBX1.ad.analog.com>
References: <544AC56F16B56944AEC3BD4E3D591771375475ED44@LIMKCMBX1.ad.analog.com>
 <4DADAD72.9070701@cam.ac.uk>
 <544AC56F16B56944AEC3BD4E3D59177137547D64CA@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177137547D64CA@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hennerich, Michael wrote on 2011-04-19:
> Jonathan Cameron wrote on 2011-04-19:
>> On 04/19/11 16:22, Hennerich, Michael wrote:
>>> Hi Jonathan,
>>>
>>> The AD7606 ring buffer doesn't use the thread, and installs only
>>> the hard handler.
>>>
>>>         indio_dev->pollfunc->h =3D &ad7606_trigger_handler_th;
>>>         indio_dev->pollfunc->thread =3D NULL; This crashes the system
>>> in handle_nested_irq (null pointer
>>> action->thread_fn) called from iio_trigger_poll_chained().
>> I knew that wouldn't work, but didn't realize it wouldn't just fail
>> with an error...
>>
>> The only thing I can think to do is to actually set both h and
>> thread to ad7606_trigger_handler_th.
>>
>> As it returns IRQ_HANDLED, if it is called via irq_trigger_poll, it
>> will happen in interrupt context and thread will never run.
>>
>> If it is called via irq_trigger_poll_handler (e.g. for non interrupt
>> context) it'll happen outside interrupt context. Given timing is never
>> going to be that tight for userspace triggers, this probably isn't a
>> problem.
>>
>> Can you try that out and see if it works?
>
> I know that setting the thread function will effectively avoid the
> crash. However I actually haven't traced if it's actually being called
> once the Hard handler returned IRQ_HANDLED.
>
> I'll have try.

I did some tests, using the sysfs trigger. The top-half handler is never be=
ing called.
That's due to the fact that iio_trigger_poll_chained() calls handle_nested_=
irq(),
which will only call the bottom-half thread function.

I guess there is some fundamental issue here.

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
