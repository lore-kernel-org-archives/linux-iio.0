Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:50080 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753431AbaBFVf4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2014 16:35:56 -0500
Message-ID: <52F400D7.7050204@metafoo.de>
Date: Thu, 06 Feb 2014 22:38:31 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Alessandro Rubini <rubini@gnudd.com>
CC: john3909@gmail.com, linux-iio@vger.kernel.org, broonie@kernel.org,
	flatmax@flatmax.org
Subject: Re: DMA sampling and IIO
References: <52F3F84F.5040001@metafoo.de>  <52F35C5B.7080409@metafoo.de>  <CF17C5B7.1940A%john3909@gmail.com> <20140206205327.GA11958@mail.gnudd.com> <20140206211637.GA14525@mail.gnudd.com>
In-Reply-To: <20140206211637.GA14525@mail.gnudd.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/06/2014 10:16 PM, Alessandro Rubini wrote:
>>> ZIO already supports dma. And mmaping the buffer from user space.  It
>>> is in the design since inception, and in the code since Feb 2012 (git
>>> log says).
>>
>> I know. And I did study the ZIO DMA code (among other things),
>> before I implemented the IIO DMA code. As you might remember from
>> our last discussion, my preference is to add the features that are
>> in ZIO but not in IIO to IIO and then ditch ZIO instead of having
>> two frameworks for the class of devices.
>
> I remember. And we both know that the class of devices that ZIO already
> supports cannot be supported by IIO, unless many incompatible changes
> are made (sub-nanosecond timestamps, symmetric input and output,
> hot-swap of buffer and trigger type, ...).
>

I still don't see why it is necessary to make incompatible changes to IIO to 
support this. There is nothing wrong with extending the API, while staying 
backwards compatible.

> I'm happy all accelerometers have the same interface to user space,
> this is definitely useful. But that's clearly not the same class of
> devices.
>
>> and then ditch ZIO
>
> How can you "ditch" something you don't use? Or is your employer
> currently using zio while helping iio catch up?

I meant in general.

>
> Our users will not stop using it, despite your desire, because it
> already serves them pretty well: 100MS ADC, with DMA and mmap, all
> sysfs-based, completely run-time configurable, and v2.6.24..v3.12 (13
> untested yet).

I have no desire to stop anybody from stopping using ZIO. But my recommendation 
is to work towards a unified framework. The sooner the switch is made the 
easier the migration path will be.

I think we have systems with 4x 250MS ADCs also doing DMA and mmap and 
streaming over the network[1]. All with IIO, so again, there _is_ a huge 
overlap of the classes of devices supported by both IIO and ZIO.

-Lars

[1] https://wiki.analog.com/resources/fpga/xilinx/fmc/ad-fmcjesdadc1-ebz

