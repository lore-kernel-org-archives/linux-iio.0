Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49277 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933327Ab3GPTDp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jul 2013 15:03:45 -0400
Message-ID: <51E5990A.4050709@kernel.org>
Date: Tue, 16 Jul 2013 20:03:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
CC: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Josh Wu <josh.wu@atmel.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	plagnioj@jcrosoft.com, linux-iio@vger.kernel.org, jic23@cam.ac.uk,
	linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH 2/5] iio: at91: Use different prescal, startup mask in
 MR for different IP
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com> <1373789069-11604-3-git-send-email-josh.wu@atmel.com> <20130715125815.GC2962@lukather> <51E505EA.4060502@atmel.com> <51E50864.6020904@atmel.com> <20130716133003.7c208cdf@skate>
In-Reply-To: <20130716133003.7c208cdf@skate>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/16/2013 12:30 PM, Thomas Petazzoni wrote:
> Dear Nicolas Ferre,
> 
> On Tue, 16 Jul 2013 10:46:28 +0200, Nicolas Ferre wrote:
> 
>>> Ok, that make sense. I will use compatible names for the capabilities in
>>> next version. Thanks.
>>
>> Hold on a little bit Josh, I know that Jean-Christophe is not in favor 
>> of the use of multiple compatible strings. So, as the code is already 
>> there, let's wait and see if we find another argument...
> 
> I've asked exactly this question last week at Linaro Connect during the
> ARM SoC consolidation panel/discussion, where Grant Likely, Arnd
> Bergmann, Olof and others were answering Device Tree related questions.
> 
> My question, which precisely had the at91-adc DT binding in mind was
> precisely whether we should use different compatible properties to
> identify different revisions of an IP block and let the driver handle
> those differences, or whether the DT binding should provide sufficient
> properties (register offsets, bit numbers, etc.) to make the driver
> independent of the IP revisions. And clearly, the answer was that
> different compatible properties should be used to identify the
> different versions of the IP block, and the driver should abstract out
> the differences. I.e, was has been done for at91-adc is completely the
> opposite of the best practices for Device Tree on ARM.
> 
> See
> http://www.youtube.com/watch?v=zF_AXLgkFy4&feature=player_detailpage#t=1581s
> where I ask exactly this question, and get answers from Olof Johansson
> and Grant Likely. They clearly say that the solution of having separate
> compatible properties and a driver that handles the differences is the
> way to go. So the way at91-adc (and possibly other at91 drivers) is
> using the Device Tree is wrong, there should have been multiple
> compatible properties. It's a shame because this is something we did say
> when we submitted at91-adc and during the reviews, but the maintainer
> wasn't listening to our comments...
> 

Thanks for getting some clarity on this Thomas.  So I'll ask the somewhat obvious
question - how do we unwind from where we are to where we want to be wrt to the
bindings?



