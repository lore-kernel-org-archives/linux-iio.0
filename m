Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-143.synserver.de ([212.40.185.143]:1240 "EHLO
	smtp-out-188.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750853AbbKWJPd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Nov 2015 04:15:33 -0500
Message-ID: <5652D931.8000205@metafoo.de>
Date: Mon, 23 Nov 2015 10:15:29 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Phil Reid <preid@electromag.com.au>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: iio: Non multiplexed ADC Data
References: <5652CEC5.7080804@electromag.com.au>
In-Reply-To: <5652CEC5.7080804@electromag.com.au>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/23/2015 09:31 AM, Phil Reid wrote:
> I'm in th eprocess of writing a driver for a custom ADC controller.
> It's an FPGA based ADC controller with multiple ADC channels with a built in
> DMA master.

Is it a single ADC with a sequencer or multiple ADCs?

> All channels share some attributes, eg Sample rate, with other per channel
> attributes, eg Gain.
> The DMA controller de-multiplexes the ADC data by having a separate target
> buffer for each channel.

I'm curious, why?

> Look at the libiio interface this configuration doesn't seem to be catered for.
> eg: iio_device_create_buffer creates a single buffer for all enabled
> channels to share.
> 
> The best way I can see is to create an iio device per channel and have them
> share a common data block.
> Not sure what interesting behaviour this may cause.

Yes, you are right, this is not supported at the moment. But we'll have to
add support for this at some point. In my opinion the best way to address
this is to add multi-planar buffers, similar like you can for example find
the in the video world[1], where different components can be in different
buffers, rather than being interleaved in a single buffer.

In addition to having a scan_index a channel would have a plane_index and
for each unique plane_index for the enabled channels one buffer would need
to be allocated.

Since using this with the read()/write() API still requires multiplexing
over a single stream its probably not the best suited API for this and I
guess it will work much better with the (not yet upstream) mmap[2] support.


The workaround with multiple devices might work somewhat but I think it will
be very cumbersome to use, e.g. all your buffers can be enabled/disabled
independently through the API, which probably doesn't really match the hardware.

- Lars

[1] http://linuxtv.org/downloads/v4l-dvb-apis/planar-apis.html
[2]
http://events.linuxfoundation.org/sites/events/files/slides/iio_high_speed.pdf#page=18
