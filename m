Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:12579 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab3GQIXS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jul 2013 04:23:18 -0400
Message-ID: <51E65475.4010109@atmel.com>
Date: Wed, 17 Jul 2013 10:23:17 +0200
From: Nicolas Ferre <nicolas.ferre@atmel.com>
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jonathan Cameron <jic23@kernel.org>
CC: Josh Wu <josh.wu@atmel.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	<plagnioj@jcrosoft.com>, <linux-iio@vger.kernel.org>,
	<jic23@cam.ac.uk>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree-discuss@lists.ozlabs.org>
Subject: Re: [PATCH 2/5] iio: at91: Use different prescal, startup mask in
 MR for different IP
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com> <1373789069-11604-3-git-send-email-josh.wu@atmel.com> <20130715125815.GC2962@lukather> <51E505EA.4060502@atmel.com> <51E50864.6020904@atmel.com> <20130716133003.7c208cdf@skate> <51E5990A.4050709@kernel.org> <20130716211706.39665234@skate>
In-Reply-To: <20130716211706.39665234@skate>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/07/2013 21:17, Thomas Petazzoni :
> Dear Jonathan Cameron,
>
> On Tue, 16 Jul 2013 20:03:38 +0100, Jonathan Cameron wrote:
>
>> On 07/16/2013 12:30 PM, Thomas Petazzoni wrote:
>>> I've asked exactly this question last week at Linaro Connect during the
>>> ARM SoC consolidation panel/discussion, where Grant Likely, Arnd
>>> Bergmann, Olof and others were answering Device Tree related questions.
>>>
>>> My question, which precisely had the at91-adc DT binding in mind was
>>> precisely whether we should use different compatible properties to
>>> identify different revisions of an IP block and let the driver handle
>>> those differences, or whether the DT binding should provide sufficient
>>> properties (register offsets, bit numbers, etc.) to make the driver
>>> independent of the IP revisions. And clearly, the answer was that
>>> different compatible properties should be used to identify the
>>> different versions of the IP block, and the driver should abstract out
>>> the differences. I.e, was has been done for at91-adc is completely the
>>> opposite of the best practices for Device Tree on ARM.
>>>
>>> See
>>> http://www.youtube.com/watch?v=zF_AXLgkFy4&feature=player_detailpage#t=1581s
>>> where I ask exactly this question, and get answers from Olof Johansson
>>> and Grant Likely. They clearly say that the solution of having separate
>>> compatible properties and a driver that handles the differences is the
>>> way to go. So the way at91-adc (and possibly other at91 drivers) is
>>> using the Device Tree is wrong, there should have been multiple
>>> compatible properties. It's a shame because this is something we did say
>>> when we submitted at91-adc and during the reviews, but the maintainer
>>> wasn't listening to our comments...
>>>
>>
>> Thanks for getting some clarity on this Thomas.  So I'll ask the somewhat obvious
>> question - how do we unwind from where we are to where we want to be wrt to the
>> bindings?
>
> During Linaro Connect last week, there was some discussion about
> marking DT bindings as unstable for a little while, once they get
> reviewed by a group of DT "experts" that mark them as stable. Until
> they are stable, the kernel does not offer any ABI guarantees, and we
> are free to change the DT bindings as needed.
>
> Now, since this unstable/stable thing is not in place at the moment,
> deciding whether to break or not existing bindings is something to be
> decided by the maintainer of this platform, judging what is the best
> option depending on whether there are already many users of the DT for
> this platform or not, for example.

I didn't had in mind that the current discussion about the addition of 
some properties could cast doubt on the entire at91-adc binding!

The binding itself has several drawbacks and is kind of over engineered, 
I agree with that. Some register offsets in particular have nothing to 
do in a DT binding.
On the other hand, some values are highly dependent on the SoC process 
itself and can't be stored in the driver because it would require to 
change the driver for each new SoC, depending on the electrical 
characteristics.
In conclusion, we have to be cautious with this binding and make sure 
that we don't throw the baby out with the bath water.

Moreover, at the time we are just beginning to be comfortable with DT on 
AT91 and beginning to overcome the difficulty of converting our 
platforms, I see this new step on the path to "mainline + DT stable" as 
another slowdown.

Bye,
-- 
Nicolas Ferre
