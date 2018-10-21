Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbeJUW4M (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Oct 2018 18:56:12 -0400
Date: Sun, 21 Oct 2018 15:41:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v2] Staging iio: adc: Match parenthesis alignment
Message-ID: <20181021154133.44cf95ab@archlinux>
In-Reply-To: <20181018013147.15352-1-marcelo.schmitt1@gmail.com>
References: <20181018013147.15352-1-marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 17 Oct 2018 22:31:47 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Change close parenthesis alignment to match respective open parenthesis at
> iio/drivers/staging/iio/adc/ad7606.c line 379.
> This makes the file more compliant with the preferred coding style for the
> linux kernel.
Hi Marcelo,

Nice cleanup and applied to the togreg branch of iio.git and pushed
out as testing for the autobuilders to play with it.
(basically this lets 0-day run a whole bunch of build tests on
it before I push it out in a form that others can rely on not changing)

Patch naming is one of those things that is very inconsistent
in different areas of the kernel.   I take the view that if I'm going
to be fussy I'll fix it up myself when applying if that is the only
thing I'm otherwise going to comment on.

However, definite preference for the name of the driver being in there
somewhere!  When I saw this description I thought we were looking
at a cleanup of the whole directory rather than the single driver
you have here.

Thanks,

Jonathan


> 
> Signed-of-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7606.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
> index 0b728b6ea135..230faae38c12 100644
> --- a/drivers/staging/iio/adc/ad7606.c
> +++ b/drivers/staging/iio/adc/ad7606.c
> @@ -376,7 +376,7 @@ static int ad7606_request_gpios(struct ad7606_state *st)
>  		return 0;
>  
>  	st->gpio_os = devm_gpiod_get_array_optional(dev, "oversampling-ratio",
> -			GPIOD_OUT_LOW);
> +						    GPIOD_OUT_LOW);
>  	return PTR_ERR_OR_ZERO(st->gpio_os);
>  }
>  
