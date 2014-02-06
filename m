Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-125.synserver.de ([212.40.185.125]:1106 "EHLO
	smtp-out-089.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755307AbaBFJ4m (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2014 04:56:42 -0500
Message-ID: <52F35C5B.7080409@metafoo.de>
Date: Thu, 06 Feb 2014 10:56:43 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: John Syn <john3909@gmail.com>
CC: linux-iio@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Matt Flax <flatmax@flatmax.org>
Subject: Re: DMA sampling and IIO
References: <CF17C5B7.1940A%john3909@gmail.com>
In-Reply-To: <CF17C5B7.1940A%john3909@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/05/2014 07:42 PM, John Syn wrote:
> I¹m working on a project that uses the ADE7878 Energy Measurement part
> from Analog Devices. Currently there is an IIO device driver in the
> staging/iio/meter folder, but I would like to extend this by adding high
> speed sampling of the AC waveforms. The ADE7878 will continuously output
> samples (8 Khz) of the voltage/current waveforms via an I2S interface. I
> plan to use DMA to store these values in a buffer and then use IIO Ring
> Buffer to access these values from User Space.
>
> Was this considered in the IIO framework and does anyone have any
> suggestions on how I might proceed?

Hi,

We do have patches for better integration of DMA (especially for high speed 
devices) into the IIO framework[1]. This is not yet upstream since it is 
still a bit WIP, but I'm confident that it will find it's way into upstream 
soon. The patches are pretty isolated, so they can easily be applied on top 
of a upstream tree.

But with DMA you'll need a host component that supports this. The ADE7878 
driver on it's own can not do any DMA since it doesn't know how it is 
connected to the host system. I2S is typically used for audio and all I2S 
host driver reside in the audio subsystem. The tricky part will now be - if 
there is already a I2S driver for your host system - how to bridge the audio 
driver with the ADE7878 driver and expose the result as a DMA capable IIO 
device.

- Lars

[1] 
https://github.com/analogdevicesinc/linux/commit/4edb9c9cbaf88047355c86e421690262406d5eae

