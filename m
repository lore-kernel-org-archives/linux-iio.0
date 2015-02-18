Return-Path: <acourbot@nvidia.com>
Message-ID: <54E3E61A.3040006@nvidia.com>
Date: Wed, 18 Feb 2015 10:08:42 +0900
From: Alexandre Courbot <acourbot@nvidia.com>
MIME-Version: 1.0
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC: <kernel@pengutronix.de>, Mark Brown <broonie@linaro.org>, Linus Walleij
	<linus.walleij@linaro.org>
Subject: Re: [PATCH] iio: improve usage of gpiod API
References: <1424164881-11816-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1424164881-11816-1-git-send-email-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 02/17/2015 06:21 PM, Uwe Kleine-K=C3=B6nig wrote:
> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)=

> which appeared in v3.17-rc1, the gpiod_get* functions take an additiona=
l
> parameter that allows to specify direction and initial value for
> outputs.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Nice, thanks for taking the time to do this!

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
-------------------------------------------------------------------------=
----------
This email message is for the sole use of the intended recipient(s) and m=
ay contain
confidential information.  Any unauthorized review, use, disclosure or di=
stribution
is prohibited.  If you are not the intended recipient, please contact the=
=20sender by
reply email and destroy all copies of the original message.
-------------------------------------------------------------------------=
----------
