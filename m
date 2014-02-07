Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:59198 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbaBGSSb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 7 Feb 2014 13:18:31 -0500
Received: by mail-pb0-f45.google.com with SMTP id un15so3580774pbc.32
        for <linux-iio@vger.kernel.org>; Fri, 07 Feb 2014 10:18:30 -0800 (PST)
Date: Fri, 07 Feb 2014 10:18:36 -0800
Subject: Re: DMA sampling and IIO
From: John Syn <john3909@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Alessandro Rubini <rubini@gnudd.com>
CC: <linux-iio@vger.kernel.org>, <broonie@kernel.org>,
	<flatmax@flatmax.org>
Message-ID: <CF1A5DFD.198CB%john3909@gmail.com>
References: <52F3F84F.5040001@metafoo.de>
 <52F35C5B.7080409@metafoo.de>
 <CF17C5B7.1940A%john3909@gmail.com>
 <20140206205327.GA11958@mail.gnudd.com>
 <20140206211637.GA14525@mail.gnudd.com>
 <52F400D7.7050204@metafoo.de>
In-Reply-To: <52F400D7.7050204@metafoo.de>
Mime-version: 1.0
Content-type: text/plain;
	charset="ISO-8859-1"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On 2/6/14, 1:38 PM, "Lars-Peter Clausen" <lars@metafoo.de> wrote:

>On 02/06/2014 10:16 PM, Alessandro Rubini wrote:
>>>> ZIO already supports dma. And mmaping the buffer from user space.  It
>>>> is in the design since inception, and in the code since Feb 2012 (git
>>>> log says).
>>>
>>> I know. And I did study the ZIO DMA code (among other things),
>>> before I implemented the IIO DMA code. As you might remember from
>>> our last discussion, my preference is to add the features that are
>>> in ZIO but not in IIO to IIO and then ditch ZIO instead of having
>>> two frameworks for the class of devices.
>>
>> I remember. And we both know that the class of devices that ZIO already
>> supports cannot be supported by IIO, unless many incompatible changes
>> are made (sub-nanosecond timestamps, symmetric input and output,
>> hot-swap of buffer and trigger type, ...).
>>
>
>I still don't see why it is necessary to make incompatible changes to IIO
>to 
>support this. There is nothing wrong with extending the API, while
>staying 
>backwards compatible.
>
>> I'm happy all accelerometers have the same interface to user space,
>> this is definitely useful. But that's clearly not the same class of
>> devices.
>>
>>> and then ditch ZIO
>>
>> How can you "ditch" something you don't use? Or is your employer
>> currently using zio while helping iio catch up?
>
>I meant in general.
>
>>
>> Our users will not stop using it, despite your desire, because it
>> already serves them pretty well: 100MS ADC, with DMA and mmap, all
>> sysfs-based, completely run-time configurable, and v2.6.24..v3.12 (13
>> untested yet).
>
>I have no desire to stop anybody from stopping using ZIO. But my
>recommendation 
>is to work towards a unified framework. The sooner the switch is made the
>easier the migration path will be.
>
>I think we have systems with 4x 250MS ADCs also doing DMA and mmap and
>streaming over the network[1]. All with IIO, so again, there _is_ a huge
>overlap of the classes of devices supported by both IIO and ZIO.
Hi Lars and Alessandro,

I don¹t think this type of discussion helps create a better solution. I¹ve
been reading through IIO and ZIO docs and I was wondering what is it that
the IIO framework offers that the ZIO framework doesn¹t. Clearly ZIO
framework has several features that are not in the IIO framework. I¹m not
talking about the number of devices supported, but rather I would like to
concentrate on the frameworks themselves. Moving forward, I see two
possible solutions:


1) Update the IIO framework to incorporate the features of the ZIO
framework
2) Adopt the ZIO framework and migrate the IIO drivers to the ZIO
framework.

Forget about ownership of any one solution, but rather ask the question,
which solution is the least disruptive in the long term and which solution
gets us to a comprehensive framework soonest. Incrementally updating IIO
to add ZIO features can be very disruptive over time. Updating devices to
the ZIO framework can also be very disruptive. Which solution is the
better way forward? What am I missing here?

Regards,
John
>
>-Lars
>
>[1] https://wiki.analog.com/resources/fpga/xilinx/fmc/ad-fmcjesdadc1-ebz
>


