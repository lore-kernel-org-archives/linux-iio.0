Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38508 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbbBVJvy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 Feb 2015 04:51:54 -0500
Message-ID: <54E9A6B8.2000506@kernel.org>
Date: Sun, 22 Feb 2015 09:51:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?B?VXdlIEtsZWluZS1Lw7Y=?= =?UTF-8?B?bmln?=
	<u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org
CC: kernel@pengutronix.de, Mark Brown <broonie@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] iio: improve usage of gpiod API
References: <1424164881-11816-1-git-send-email-u.kleine-koenig@pengutronix.de> <54E3E61A.3040006@nvidia.com>
In-Reply-To: <54E3E61A.3040006@nvidia.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/02/15 01:08, Alexandre Courbot wrote:
> On 02/17/2015 06:21 PM, Uwe Kleine-König wrote:
>> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
>> which appeared in v3.17-rc1, the gpiod_get* functions take an additional
>> parameter that allows to specify direction and initial value for
>> outputs.
>>
>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Nice, thanks for taking the time to do this!
> 
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Have picked up the reviewed bys and added them to v3 (which covers a few more drivers)
on the basis it was much the same and you guys would approve ;)

Jonathan
> -----------------------------------------------------------------------------------
> This email message is for the sole use of the intended recipient(s) and may contain
> confidential information.  Any unauthorized review, use, disclosure or distribution
> is prohibited.  If you are not the intended recipient, please contact the sender by
> reply email and destroy all copies of the original message.
> -----------------------------------------------------------------------------------

