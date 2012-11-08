Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43027 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755351Ab2KHR3I (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 8 Nov 2012 12:29:08 -0500
References: <1352306690-25841-1-git-send-email-alban.bedel@avionic-design.de> <509B7BF0.5050704@antcom.de> <509BD1D9.20100@jic23.retrosnub.co.uk> <20121108175617.06429ab1@avionic-0020.adnet.avionic-design.de>
In-Reply-To: <20121108175617.06429ab1@avionic-0020.adnet.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] staging:iio:lpc32xx_adc: Add scale/offset support
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Thu, 08 Nov 2012 17:28:46 +0000
To: Alban Bedel <alban.bedel@avionic-design.de>
CC: Roland Stigge <stigge@antcom.de>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <f16ac222-cb36-4ada-bd00-c9166ea94dd3@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Alban Bedel <alban.bedel@avionic-design.de> wrote:

>On Thu, 08 Nov 2012 15:38:01 +0000
>Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:
>
>> Why not do this with regulators?  That would give a more flexible
>> system and all that stuff is already well supported (if fixed
>voltages
>> are supplied then used fixed regulators).
>
>I agree that would probably be better. But for me that raise the
>question of having this stuff in the ADC driver at all. Most ADC just
>return a value from 0 to MAX and have no way to find out their supply
>voltage. 
A lot of iio drivers require a regulator for exactly this reason.  Either it is fixed and can go in device tree or it isn't and can be queried or set.


If we start with binding to regulators in the drivers we'll
>soon get a lots of non-flexible and duplicated code.
Why? Duplication maybe but I don't see where inflexibility comes from.. duplication may mean some library functions would be useful.

>
>It would be a lot nicer if the ADC channels could be bound to a
>regulator and a transform function that compute a real world voltage
>out
>of:
> - The ADC value
> - The ADC range
> - The regulator representing the ADC reference voltage
>
>The simplest transform would be a linear curve with an optional offset,
>but any kind of transform would also be possible allowing to represent
>about any circuit that might be between the supply regulator and the
>ADC
>input.
This still sits in the realm of regulators.  Far as iio driver is concerned there is a voltage on a pin.  What that means wrt to resulting scale is device dependent.  It is an obscure use case where the reference inputs are changing frequently..

Now I can see an arguement for a suitable regulator which takes one voltage in and does flexible transformations of it.  Also it can work the otherway with iio driver requesting a different reference value.

Now there may be a case for transforms on incoming adc channels as they are inherently dynamic.  Right now we promise only to give what the adc saw not some way before it on the otherside of weirdness.

So I am not yet convinced! Perhaps example configurations would help?

Remember that we deliberately leave as much data transforming to userspace as possible. So far the only non linear stuff has been slow so it hasn't mattered.

Jonathan
>
>Alban

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
