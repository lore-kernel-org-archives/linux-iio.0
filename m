Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:34924 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754348Ab3GPLaG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jul 2013 07:30:06 -0400
Date: Tue, 16 Jul 2013 13:30:03 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Josh Wu <josh.wu@atmel.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	<plagnioj@jcrosoft.com>, linux-iio@vger.kernel.org,
	jic23@cam.ac.uk, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH 2/5] iio: at91: Use different prescal, startup mask in
 MR for different IP
Message-ID: <20130716133003.7c208cdf@skate>
In-Reply-To: <51E50864.6020904@atmel.com>
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com>
	<1373789069-11604-3-git-send-email-josh.wu@atmel.com>
	<20130715125815.GC2962@lukather>
	<51E505EA.4060502@atmel.com>
	<51E50864.6020904@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Nicolas Ferre,

On Tue, 16 Jul 2013 10:46:28 +0200, Nicolas Ferre wrote:

> > Ok, that make sense. I will use compatible names for the capabilities in
> > next version. Thanks.
> 
> Hold on a little bit Josh, I know that Jean-Christophe is not in favor 
> of the use of multiple compatible strings. So, as the code is already 
> there, let's wait and see if we find another argument...

I've asked exactly this question last week at Linaro Connect during the
ARM SoC consolidation panel/discussion, where Grant Likely, Arnd
Bergmann, Olof and others were answering Device Tree related questions.

My question, which precisely had the at91-adc DT binding in mind was
precisely whether we should use different compatible properties to
identify different revisions of an IP block and let the driver handle
those differences, or whether the DT binding should provide sufficient
properties (register offsets, bit numbers, etc.) to make the driver
independent of the IP revisions. And clearly, the answer was that
different compatible properties should be used to identify the
different versions of the IP block, and the driver should abstract out
the differences. I.e, was has been done for at91-adc is completely the
opposite of the best practices for Device Tree on ARM.

See
http://www.youtube.com/watch?v=zF_AXLgkFy4&feature=player_detailpage#t=1581s
where I ask exactly this question, and get answers from Olof Johansson
and Grant Likely. They clearly say that the solution of having separate
compatible properties and a driver that handles the differences is the
way to go. So the way at91-adc (and possibly other at91 drivers) is
using the Device Tree is wrong, there should have been multiple
compatible properties. It's a shame because this is something we did say
when we submitted at91-adc and during the reviews, but the maintainer
wasn't listening to our comments...

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
