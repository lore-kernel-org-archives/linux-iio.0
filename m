Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3096 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbbBRHWg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Feb 2015 02:22:36 -0500
Message-ID: <54E43D9E.9040008@nvidia.com>
Date: Wed, 18 Feb 2015 16:22:06 +0900
From: Alexandre Courbot <acourbot@nvidia.com>
MIME-Version: 1.0
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	"Linus Walleij" <linus.walleij@linaro.org>,
	<kernel@pengutronix.de>, Mark Brown <broonie@linaro.org>
Subject: Re: [PATCH] iio: improve usage of gpiod API
References: <1424164881-11816-1-git-send-email-u.kleine-koenig@pengutronix.de> <54E3E61A.3040006@nvidia.com> <20150218071523.GH19388@pengutronix.de>
In-Reply-To: <20150218071523.GH19388@pengutronix.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/18/2015 04:15 PM, Uwe Kleine-König wrote:
> On Wed, Feb 18, 2015 at 10:08:42AM +0900, Alexandre Courbot wrote:
>> On 02/17/2015 06:21 PM, Uwe Kleine-König wrote:
>>> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
>>> which appeared in v3.17-rc1, the gpiod_get* functions take an additional
>>> parameter that allows to specify direction and initial value for
>>> outputs.
>>>
>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>
>> Nice, thanks for taking the time to do this!
> I have some more, just didn't come around to wrap in commits and send
> out:
>
> 	http://git.pengutronix.de/?p=ukl/linux.git;a=commitdiff;h=1783b17ba922f92d043bad650c0209de1c201080;hp=e36f014edff70fc02b3d3d79cead1d58f289332e
>
> I will do one patch a day ...

That's great - do these cover all the uses of gpiod_get* that need to be 
updated? If so, you could close this series with a final patch that 
removes the macro definitions allowing variable arguments.
