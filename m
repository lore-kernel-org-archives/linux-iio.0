Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58034 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964907AbcIEUJM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Sep 2016 16:09:12 -0400
Subject: Re: [PATCH v2 1/2] iio: fetch and enable regulators unconditionally
To: Crt Mori <cmo@melexis.com>, linux-iio@vger.kernel.org
References: <20160905091449.12297-1-cmo@melexis.com>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        Markus Pargmann <mpa@pengutronix.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b8c09ba1-3952-6939-4d62-22a509751516@kernel.org>
Date: Mon, 5 Sep 2016 21:09:09 +0100
MIME-Version: 1.0
In-Reply-To: <20160905091449.12297-1-cmo@melexis.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/09/16 10:14, Crt Mori wrote:
> This patch is inspired by a comment of Jonathan Cameron on patch of
> Linus Walleij commit aeb55fff3891834e07a3144159a7298a19696af8 ("iio: st_sensors: fetch and enable regulators unconditionally").
> 
> The explanation for this change is same as in that patch:
> "Supplies are *not* optional (optional means that the supply is
> optional in the electrical sense, not the software sense) so we need to
> get the and enable them at all times.
> 
> If the device tree or board file does not define suitable regulators for
> the component, it will be substituted by a dummy regulator, or, if
> regulators are disabled altogether, by stubs. There is no need to use the
> IS_ERR_OR_NULL() check that is considered harmful.
> 
> Reported-by: Linus Wallerij <linus.walleij@linaro.org>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Crt Mori <cmo@melexis.com>
Applied to the togreg branch of iio.git. Initially pushed out as testing
for the autobuilders to do their magic.

Thanks,

Jonathan
> ---
>  drivers/iio/pressure/ms5611_core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
> index feb41f8..a74ed1f 100644
> --- a/drivers/iio/pressure/ms5611_core.c
> +++ b/drivers/iio/pressure/ms5611_core.c
> @@ -416,8 +416,7 @@ static int ms5611_init(struct iio_dev *indio_dev)
>  	return 0;
>  
>  err_regulator_disable:
> -	if (!IS_ERR_OR_NULL(st->vdd))
> -		regulator_disable(st->vdd);
> +	regulator_disable(st->vdd);
>  	return ret;
>  }
>  
> @@ -425,8 +424,7 @@ static void ms5611_fini(const struct iio_dev *indio_dev)
>  {
>  	const struct ms5611_state *st = iio_priv(indio_dev);
>  
> -	if (!IS_ERR_OR_NULL(st->vdd))
> -		regulator_disable(st->vdd);
> +	regulator_disable(st->vdd);
>  }
>  
>  int ms5611_probe(struct iio_dev *indio_dev, struct device *dev,
> 

