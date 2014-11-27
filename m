Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:50841 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbaK0PUV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 27 Nov 2014 10:20:21 -0500
Message-ID: <547740C8.6020604@imgtec.com>
Date: Thu, 27 Nov 2014 12:18:32 -0300
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Andrew Bresticker <abrestic@chromium.org>,
	James Hartley <james.hartley@imgtec.com>,
	Jonathan Cameron <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<robh+dt@kernel.org>, <Pawel.Moll@arm.com>, <Mark.Rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<Naidu.Tellapati@imgtec.com>, Phani Movva <Phani.Movva@imgtec.com>
Subject: Re: [PATCH v3 1/3] iio: adc: Cosmic Circuits 10001 ADC driver
References: <1415888044-16635-1-git-send-email-ezequiel.garcia@imgtec.com> <1415888044-16635-2-git-send-email-ezequiel.garcia@imgtec.com> <546FE3A7.6040308@gmx.de> <5474C062.2020604@imgtec.com> <5474F7A5.6030008@gmx.de> <5474FCC8.8080906@imgtec.com> <5475085E.8090806@gmx.de> <54773E63.4020300@imgtec.com> <5477406A.8020403@metafoo.de>
In-Reply-To: <5477406A.8020403@metafoo.de>
Content-Type: text/plain; charset="iso-8859-15"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 11/27/2014 12:16 PM, Lars-Peter Clausen wrote:
> [...]
>>>>
>>>>>>>> +
>>>>>>>> +    adc_dev->reg = devm_regulator_get(&pdev->dev, "vref");
>>>>>>>> +    if (IS_ERR_OR_NULL(adc_dev->reg))
>>>>>>>> +        return -EINVAL;
>>>>>>>     if (IS_ERR(adc_dev->reg))
>>>>>>>         return PTR_ERR(adc_dev->reg);
>>>>>>
>>>>>> Are you sure? What if devm_regulator_get() returns NULL?
>>>>>>
>>>>> I had a look at it, but couldn't figure out a condition in which it
>>>>> would return NULL. But I'd be happy to be informed of anything
>>>>> different.
>>>>
>>>> If CONFIG_REGULATOR=n you get NULL there (although I added a select
>>>> REGULATOR
>>>> on the v4 I just posted).
>>>>
>>> Indeed, thanks. Now I'm thinking if it would make sense to handle
>>> this special case in a special way (as it would be caused by an
>>> invalid kernel config). Well, I guess, I leave it up to you.
>>
>> Well, adding the select REGULATOR that shouldn't happen, so let's better
>> drop the NULL check entirely.
> 
> Doing a 'select REGULATOR' can (and probably will sooner or later)
> create nasty dependency loops. User selectable config items should not
> be selected by another config item. If the driver really has a hard
> dependency on the regulator framework then 'depends on REGULATOR' is the
> right thing to do.
> 

Fine, then. 'depends on REGULATOR' it is.

-- 
Ezequiel
