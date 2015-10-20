Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:50257 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966AbbJTRFr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 20 Oct 2015 13:05:47 -0400
Subject: Re: iio_interrupt_trigger
To: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <5623962F.6040105@gmx.net> <5624BB59.20003@metafoo.de>
From: Matthias Meier <matthias.j.meier@gmx.net>
Message-ID: <56267467.10605@gmx.net>
Date: Tue, 20 Oct 2015 19:05:43 +0200
MIME-Version: 1.0
In-Reply-To: <5624BB59.20003@metafoo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Just for information...

I estimated the max ISR rate and sampling accuracy when using iio 
buffering triggered by a hardware PWM timer on a IMX6 dl board:

Up to a ISR rate of ~5kHz the accuracy of the sampling time is about 
+/-25us (measured over several seconds).

Above 10kHz, interrupts are lost (but CPU load still <25%).

Test conditions:

For this test I modified 'generic_buffer' so I could estimate the 
accuracy of the sampling point (by calculating min/max/mean of the time 
difference.
The kernel was 4.2.1 with CONFIG_PREEMPT=y
The ADC device I used is a AD7476 connected via SPI bus.
The scaling_governor was set to performance.
No additional load (buildroot rfs).
The results are about same when using a 4.1 TT-patched kernel with 
CONFIG_PREEMPT_RT_FULL=y (without special isr priority).

Conclusion: accurate high(er) speed sampling seems not to be possible 
this way (without dma buffered continuous sampling)

-- Matthias



