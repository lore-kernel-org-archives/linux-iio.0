Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1424164881-11816-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1424164881-11816-1-git-send-email-u.kleine-koenig@pengutronix.de>
Date: Tue, 17 Feb 2015 11:05:03 +0100
Message-ID: <CACRpkdZydeFkeVEB_MWDMU5qomJdiqxKmgr1+THjh8dis+JvpA@mail.gmail.com>
Subject: Re: [PATCH] iio: improve usage of gpiod API
From: Linus Walleij <linus.walleij@linaro.org>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
	Alexandre Courbot <acourbot@nvidia.com>, Mark Brown <broonie@linaro.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Feb 17, 2015 at 10:21 AM, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
> which appeared in v3.17-rc1, the gpiod_get* functions take an additional
> parameter that allows to specify direction and initial value for
> outputs.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
