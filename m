Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:47290 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751578AbaBFVMy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2014 16:12:54 -0500
Message-ID: <52F3FB6E.3070201@metafoo.de>
Date: Thu, 06 Feb 2014 22:15:26 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: John Syn <john3909@gmail.com>
CC: linux-iio@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Matt Flax <flatmax@flatmax.org>
Subject: Re: DMA sampling and IIO
References: <CF17C5B7.1940A%john3909@gmail.com> <52F35C5B.7080409@metafoo.de> <CF19225A.196C9%john3909@gmail.com>
In-Reply-To: <CF19225A.196C9%john3909@gmail.com>
Content-Type: text/plain; charset=EUC-KR
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/06/2014 08:43 PM, John Syn wrote:
> 
> 
> On 2/6/14, 1:56 AM, "Lars-Peter Clausen" <lars@metafoo.de> wrote:
> 
>> On 02/05/2014 07:42 PM, John Syn wrote:
>>> I©öm working on a project that uses the ADE7878 Energy Measurement part
>>> from Analog Devices. Currently there is an IIO device driver in the
>>> staging/iio/meter folder, but I would like to extend this by adding high
>>> speed sampling of the AC waveforms. The ADE7878 will continuously output
>>> samples (8 Khz) of the voltage/current waveforms via an I2S interface. I
>>> plan to use DMA to store these values in a buffer and then use IIO Ring
>>> Buffer to access these values from User Space.
>>>
>>> Was this considered in the IIO framework and does anyone have any
>>> suggestions on how I might proceed?
>>
>> Hi,
>>
>> We do have patches for better integration of DMA (especially for high
>> speed
>> devices) into the IIO framework[1]. This is not yet upstream since it is
>> still a bit WIP, but I'm confident that it will find it's way into
>> upstream
>> soon. The patches are pretty isolated, so they can easily be applied on
>> top
>> of a upstream tree.
> I¡¯d like to have a look at your DMA patch. Hopefully it will help point me
> in the right direction.

I posted a link to the main patch at the bottom of the last email.

>>
>> But with DMA you'll need a host component that supports this. The ADE7878
>> driver on it's own can not do any DMA since it doesn't know how it is
>> connected to the host system. I2S is typically used for audio and all I2S
>> host driver reside in the audio subsystem. The tricky part will now be -
>> if
>> there is already a I2S driver for your host system - how to bridge the
>> audio
>> driver with the ADE7878 driver and expose the result as a DMA capable IIO
>> device.
> I¡¯ll never understand why I2S is so integrated into the sound subsystem.

I guess this is because it is the traditional area where I2S is used and nobody
cared so far about using it somewhere else in the context of the Linux kernel.
Not having to have a extra layer of abstraction in the middle between ALSA/ASoC
and the I2S peripheral driver helped to keep things simple.

> There are plenty applications of I2S that have nothing to do with sound. I
> think I can make this work via an SPI interface, but with some patch work
> because the ADE7878 will drive the SPI clock.

There is nothing conceptually wrong with using I2S for for this.  The thing is
just that it might require some work since you are the first one to try this.
You have to do all the R&D. But something similar is true for SPI since the SPI
framework has no support for continuous SPI transfers.

> I also plan to use EDMA to store each measurement in a separate buffer
> (Voltage A, Voltage B, Voltage C, Current A, etc) which will make
> processing each measurement channel much easier. Question is, how
> to use IIO Ring Buffer given multiple channels?

Do you want to store each channel in it's own buffer? This would also be a new
thing within the IIO framework, so far we have only worked with interleaved
streams. Again this is not a conceptual problem, just something that hasn't
been done before and will require some work.

- Lars
