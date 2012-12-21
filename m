Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.32.191]:38625 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339Ab2LUJH2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 21 Dec 2012 04:07:28 -0500
Message-ID: <50D426C1.5050807@free-electrons.com>
Date: Fri, 21 Dec 2012 10:07:13 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: "ludovic.desroches" <ludovic.desroches@atmel.com>
CC: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 1/3] ARM: AT91: IIO: add low and high res support for
 adc
References: <20121219183236.GP23971@game.jcrosoft.org> <1355942232-26251-1-git-send-email-plagnioj@jcrosoft.com> <50D2EBA1.4050305@free-electrons.com> <50D2EDE6.3090706@atmel.com> <50D3340F.3090209@free-electrons.com> <50D33940.4000607@atmel.com>
In-Reply-To: <50D33940.4000607@atmel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Le 20/12/2012 17:13, ludovic.desroches a écrit :
> On 12/20/2012 04:51 PM, Maxime Ripard wrote:
>> Hi Ludovic,
>>
>> Le 20/12/2012 11:52, ludovic.desroches a écrit :
>>>> I'm wondering, why are you using such a complex dt parsing code, and
>>>> bindings, when you only requires a boolean to switch between 8 and 10
>>>> bits mode (which seem to be the only thing you support)?
>>>
>>> We will have a 10 and 12 bits mode on future ADCs and I would like to
>>> have something which could manage more than two resolutions if it
>>> happens one day.
>>
>> I see your point. I'm not fond at all of the existing bindings for the
>> driver (putting things like registers offset in the dt is a non-sense to
>> me, but hey...), so I'd like to still keep it as simple and non-bloated
>> as possible, but it's true that in the current situation, we probably
>> have no other choice.
>>
> 
> I have the same feeling than you about ADC bindings, I think that there
> are too many parameters exhibited. Moreover, most of them are chip
> relative.
> 
> I have not found other ways to deal with it properly. I would like to
> have them hidden into the driver (depending on the compatible string)
> but it will be a mess if we split parameters into dt and driver.

I'm glad we feel the same way :)

> So the idea was to have a binding which could allow us to manage several
> cases about resolution modes in the future.

Yes, I got the idea. Like I said, if we don't want to touch at the
bindings and do want you suggested, then your patch is the best solution
we have.

Maxime
-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
