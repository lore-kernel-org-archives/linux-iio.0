Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:51958 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbbJGHNE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 7 Oct 2015 03:13:04 -0400
Subject: Re: [PATCH] iio: mxs-lradc: Fix temperature offset
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Marek Vasut <marex@denx.de>
References: <1444141347-15301-1-git-send-email-alexandre.belloni@free-electrons.com>
 <415576093.114803.1444157033983.JavaMail.open-xchange@oxbaltgw07.schlund.de>
 <561456ED.5010108@denx.de> <20151007004447.GC3485@piout.net>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	=?UTF-8?Q?Janusz_U=c5=bcycki?= <j.uzycki@elpromaelectronics.com>,
	Jonathan Cameron <jic23@kernel.org>
From: Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <5614C5F8.5020000@i2se.com>
Date: Wed, 7 Oct 2015 09:12:56 +0200
MIME-Version: 1.0
In-Reply-To: <20151007004447.GC3485@piout.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 07.10.2015 um 02:44 schrieb Alexandre Belloni:
> Hi,
>
> On 07/10/2015 at 01:19:09 +0200, Marek Vasut wrote :
>>>> /* The calculated value from the ADC is in Kelvin, we
>>>> * want Celsius for hwmon so the offset is
>>>> - * -272.15 * scale
>>>> + * -273.15 * scale
>>>> */
>>>> - *val = -1075;
>>>> - *val2 = 691699;
>>>> + *val = -1079;
>>>> + *val2 = 644268;
>>>>
>>> i think it would be nice to break down the calculation of these magic values in
>>> a second patch.
>> Indeed, I agree. I hope Alexandre can send another patch for that soon :-)
>>
> On my side, I'm not sure this is worth more than a comment. If
> necessary, I can write that the datasheet specifies that the scale is
> 4/1.012 here also.

I'm okay with that.
