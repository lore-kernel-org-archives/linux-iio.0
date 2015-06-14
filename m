Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44418 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295AbbFNO3t (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Jun 2015 10:29:49 -0400
Message-ID: <557D8FDA.2020005@kernel.org>
Date: Sun, 14 Jun 2015 15:29:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg Wilson-Lindberg <GWilson@sakuraus.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Patil, Rachna" <rachna@ti.com>,
	Zubair Lutfullah <zubair.lutfullah@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: TI tsadc sample frequency question
References: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D7AB@sfamail.SAKURAUS.LOCAL>
In-Reply-To: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D7AB@sfamail.SAKURAUS.LOCAL>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/05/15 01:17, Greg Wilson-Lindberg wrote:
> This probably falls closer to a stupid user question, but I can't
> seem to find it addressed in any of the documentation that I have
> found so far.
I'm not that familiar with the driver, but as no one who is has replied.
I'll take a stab at answering you.
> 
> As a partial work around for the TS TSADC problems that are being
> discussed in another thread I'm enabling a buffer for a short time,
> pulling the samples, and disabling the buffer. I'm trying to
> understand the number of samples that will actually be collected
> during the time that I have the buffer enabled.
> 
> I'm currently enabling the buffer for 0.1 seconds, according to the
> mfd/ti_am335x_tsadc.h file a single sample takes 116us to process, so
> 6 samples (4 ts + 2 adc) should take 696us, or ~1436 sample sets per
> second, or ~143 samples per 0.1 seconds.
> 
> No matter what size I set the buffer to, I get that number of samples
> back. So even though I should only be able to collect ~143 samples,
> if I set the buffer size to 256, I get 256 samples back.
This device is fairly unusual in that it has a substantial hardware fifo.
There is no explicit 'trigger' between samples to tell you when data is
available, rather we just have the fifo threshold interrupts.  These then
push into a software fifo.  It's this software fifo you are reading from.

> 
> Is there some way (low overhead preferable) to reset the buffer so
> that I only get the samples that have been collected in the time that
> the buffer has been enabled?
The hardware fifo is flushed on enabling of the buffer.  For the software
fifo, your might have to just do a non blocking read of the whole fifo size.
Then it will be empty.
You will stop getting fifo interrupts the moment the buffer is disabled, so no
more samples should come in.  There is also an explicit flush of the buffer
at disable to try and clear out anything that turned up since the last interrupt.
> Or is there some way to figure out what
> the number of samples are the I would get back in some time period,
> so I can set the buffer size accordingly?
A the moment this driver doesn't seem to expose sampling frequency control
except via the device tree parameters. IIRC this is because it's not easy
to calculate as the actual frequency is dependent on a whole load of
elements related to the channel setup.

I've cc'd a few people involved with this driver, perhaps they can give
you some more detailed options.
> 
> Greg Wilson-Lindberg Sakura Finetek 310-783-5075 -- To unsubscribe
> from this list: send the line "unsubscribe linux-iio" in the body of
> a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html

