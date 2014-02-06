Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:44341 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756918AbaBFTm5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2014 14:42:57 -0500
Received: by mail-pd0-f177.google.com with SMTP id x10so2088695pdj.8
        for <linux-iio@vger.kernel.org>; Thu, 06 Feb 2014 11:42:57 -0800 (PST)
Date: Thu, 06 Feb 2014 11:43:00 -0800
Subject: Re: DMA sampling and IIO
From: John Syn <john3909@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
CC: <linux-iio@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
	Matt Flax <flatmax@flatmax.org>
Message-ID: <CF19225A.196C9%john3909@gmail.com>
References: <CF17C5B7.1940A%john3909@gmail.com>
 <52F35C5B.7080409@metafoo.de>
In-Reply-To: <52F35C5B.7080409@metafoo.de>
Mime-version: 1.0
Content-type: text/plain;
	charset="EUC-KR"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 2/6/14, 1:56 AM, "Lars-Peter Clausen" <lars@metafoo.de> wrote:

>On 02/05/2014 07:42 PM, John Syn wrote:
>> I©öm working on a project that uses the ADE7878 Energy Measurement part
>> from Analog Devices. Currently there is an IIO device driver in the
>> staging/iio/meter folder, but I would like to extend this by adding high
>> speed sampling of the AC waveforms. The ADE7878 will continuously output
>> samples (8 Khz) of the voltage/current waveforms via an I2S interface. I
>> plan to use DMA to store these values in a buffer and then use IIO Ring
>> Buffer to access these values from User Space.
>>
>> Was this considered in the IIO framework and does anyone have any
>> suggestions on how I might proceed?
>
>Hi,
>
>We do have patches for better integration of DMA (especially for high
>speed 
>devices) into the IIO framework[1]. This is not yet upstream since it is
>still a bit WIP, but I'm confident that it will find it's way into
>upstream 
>soon. The patches are pretty isolated, so they can easily be applied on
>top 
>of a upstream tree.
I¡¯d like to have a look at your DMA patch. Hopefully it will help point me
in the right direction.
>
>But with DMA you'll need a host component that supports this. The ADE7878
>driver on it's own can not do any DMA since it doesn't know how it is
>connected to the host system. I2S is typically used for audio and all I2S
>host driver reside in the audio subsystem. The tricky part will now be -
>if 
>there is already a I2S driver for your host system - how to bridge the
>audio 
>driver with the ADE7878 driver and expose the result as a DMA capable IIO
>device.
I¡¯ll never understand why I2S is so integrated into the sound subsystem.
There are plenty applications of I2S that have nothing to do with sound. I
think I can make this work via an SPI interface, but with some patch work
because the ADE7878 will drive the SPI clock. I also plan to use EDMA to
store each measurement in a separate buffer (Voltage A, Voltage B, Voltage
C, Current A, etc) which will make processing each measurement channel
much easier. Question is, how to use IIO Ring Buffer given multiple
channels? 

Regards,
John
>
>- Lars
>
>[1] 
>https://github.com/analogdevicesinc/linux/commit/4edb9c9cbaf88047355c86e42
>1690262406d5eae
>


