Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:33912 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750733AbdKEG2L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Nov 2017 01:28:11 -0500
Subject: Re: getting started w/ iio driver
To: "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-iio@vger.kernel.org
References: <4d347c06-b53a-de3d-f8f1-8e05684a4ebd@metux.net>
From: Phil Reid <preid@electromag.com.au>
Message-ID: <de1ee059-5a30-2445-4d66-42eeead8d09a@electromag.com.au>
Date: Sun, 5 Nov 2017 14:28:01 +0800
MIME-Version: 1.0
In-Reply-To: <4d347c06-b53a-de3d-f8f1-8e05684a4ebd@metux.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 3/11/2017 11:12, Enrico Weigelt, metux IT consult wrote:
> Hi folks,
> 
> i'm currently developing an iio driver for a custom adc and looking for
> the optimal approach.
> 
> The device is made up of 3x 24bit-SD-ADCs and a fpga (as buffer+bridge)
> connected via EIM. All ADCs operate at the same (configurable, up to
> 500khz) sampling rate and each have their own hw buffer. For each buffer
> there's a separate interrupt line.
> 
> So, i'd need an irq handler, which fetches the data into a suitable
> buffer and push it into iio. is that what iio_triggered_buffer_setup()
> etc is for ? How does that relate to triggers ?
> 
I have something very similar. Multiple SD ADC's connected to an FPGA.

Multiple ADC channels clocked with common sample rate.

My approach was to have a master IIO device that controls common parameters
(sample rate etc) and an IIO device per channel.
I wanted the channel data to be separated into a separate stream and the
ability to start / stop channels independently.
The master device creates the child devices nd manages an interdependencies..

FGPA writes directly to memory buffers (FPGA is the DMA master)
The IIO system can provide a queue of memory buffers to fill.
And then in the hard IRQ it updates the target address.

I based the DMA stuff on Lars-Peter's dummy dma buffer example.
http://comments.gmane.org/gmane.linux.kernel.iio/20283

The dma buffer code is in mainline by I don't think the example driver is.




-- 
Regards
Phil Reid
