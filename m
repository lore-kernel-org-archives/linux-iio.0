Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:50299 "EHLO
	19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbbE0ARd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2015 20:17:33 -0400
From: Greg Wilson-Lindberg <GWilson@sakuraus.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Tue, 26 May 2015 17:17:08 -0700
Subject: TI tsadc sample frequency question
Message-ID: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D7AB@sfamail.SAKURAUS.LOCAL>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This probably falls closer to a stupid user question, but I can't seem to find it addressed in any of the documentation that I have found so far.

As a partial work around for the TS TSADC problems that are being discussed in another thread I'm enabling a buffer for a short time, pulling the samples, and disabling the buffer. I'm trying to understand the number of samples that will actually be collected during the time that I have the buffer enabled.

I'm currently enabling the buffer for 0.1 seconds, according to the mfd/ti_am335x_tsadc.h file a single sample takes 116us to process, so 6 samples (4 ts + 2 adc) should take 696us, or ~1436 sample sets per second, or ~143 samples per 0.1 seconds.

No matter what size I set the buffer to, I get that number of samples back. So even though I should only be able to collect ~143 samples, if I set the buffer size to 256, I get 256 samples back.

Is there some way (low overhead preferable) to reset the buffer so that I only get the samples that have been collected in the time that the buffer has been enabled? Or is there some way to figure out what the number of samples are the I would get back in some time period, so I can set the buffer size accordingly?
 
Greg Wilson-Lindberg
Sakura Finetek
310-783-5075
