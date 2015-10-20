Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-210.synserver.de ([212.40.185.210]:1048 "EHLO
	smtp-out-188.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751793AbbJTRbe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 20 Oct 2015 13:31:34 -0400
Message-ID: <56267A73.2060900@metafoo.de>
Date: Tue, 20 Oct 2015 19:31:31 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Matthias Meier <matthias.j.meier@gmx.net>,
	linux-iio@vger.kernel.org
Subject: Re: iio_interrupt_trigger
References: <5623962F.6040105@gmx.net> <5624BB59.20003@metafoo.de> <56267467.10605@gmx.net>
In-Reply-To: <56267467.10605@gmx.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/20/2015 07:05 PM, Matthias Meier wrote:
> Just for information...
> 
> I estimated the max ISR rate and sampling accuracy when using iio buffering
> triggered by a hardware PWM timer on a IMX6 dl board:
> 
> Up to a ISR rate of ~5kHz the accuracy of the sampling time is about +/-25us
> (measured over several seconds).
> 
> Above 10kHz, interrupts are lost (but CPU load still <25%).
> 
> Test conditions:
> 
> For this test I modified 'generic_buffer' so I could estimate the accuracy
> of the sampling point (by calculating min/max/mean of the time difference.
> The kernel was 4.2.1 with CONFIG_PREEMPT=y
> The ADC device I used is a AD7476 connected via SPI bus.
> The scaling_governor was set to performance.
> No additional load (buildroot rfs).
> The results are about same when using a 4.1 TT-patched kernel with
> CONFIG_PREEMPT_RT_FULL=y (without special isr priority).
> 
> Conclusion: accurate high(er) speed sampling seems not to be possible this
> way (without dma buffered continuous sampling)

Yeah, that is similar to my findings. 5kHz-10kHz is around the maximum you
can do with interrupt driven capture. For higher datarates you'll have to
dedicate a full CPU to polling the data, which is kind of sub-optimal.

I've been working on the concept of SPI offloading, which allows to
pre-program the SPI message to the controller and let the controller execute
it when the interrupt happens. But this required dedicated hardware support
and is not available with all SPI controllers.

The SPI Engine framework allows to create controller that support this type
of offloading, see https://wiki.analog.com/resources/fpga/peripherals/spi_engine

- Lars

