Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727865AbeI2S6f (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Sep 2018 14:58:35 -0400
Date: Sat, 29 Sep 2018 13:30:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: ad5064: Fix regulator handling
Message-ID: <20180929133013.38ed1751@archlinux>
In-Reply-To: <20180928092340.25231-1-lars@metafoo.de>
References: <20180928092340.25231-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 28 Sep 2018 11:23:40 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> The correct way to handle errors returned by regualtor_get() and friends is
> to propagate the error since that means that an regulator was specified,
> but something went wrong when requesting it.
> 
> For handling optional regulators, e.g. when the device has an internal
> vref, regulator_get_optional() should be used to avoid getting the dummy
> regulator that the regulator core otherwise provides.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Sensible cleanup.  Applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to play with it.

I've marked it for stable as it seems safe to apply going back a long way.
However, it may be that it will fail at somepoint due to context changes.
If so, we can think about doing the backport when that happens.

As with other fixes today I'm going to delay this until the upcoming merge
window given we are quite late in the cycle.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5064.c | 53 ++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 38 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
> index bf4fc40ec84d..2f98cb2a3b96 100644
> --- a/drivers/iio/dac/ad5064.c
> +++ b/drivers/iio/dac/ad5064.c
> @@ -808,6 +808,40 @@ static int ad5064_set_config(struct ad5064_state *st, unsigned int val)
>  	return ad5064_write(st, cmd, 0, val, 0);
>  }
>  
> +static int ad5064_request_vref(struct ad5064_state *st, struct device *dev)
> +{
> +	unsigned int i;
> +	int ret;
> +
> +	for (i = 0; i < ad5064_num_vref(st); ++i)
> +		st->vref_reg[i].supply = ad5064_vref_name(st, i);
> +
> +	if (!st->chip_info->internal_vref)
> +		return devm_regulator_bulk_get(dev, ad5064_num_vref(st),
> +					       st->vref_reg);
> +
> +	/*
> +	 * This assumes that when the regulator has an internal VREF
> +	 * there is only one external VREF connection, which is
> +	 * currently the case for all supported devices.
> +	 */
> +	st->vref_reg[0].consumer = devm_regulator_get_optional(dev, "vref");
> +	if (!IS_ERR(st->vref_reg[0].consumer))
> +		return 0;
> +
> +	ret = PTR_ERR(st->vref_reg[0].consumer);
> +	if (ret != -ENODEV)
> +		return ret;
> +
> +	/* If no external regulator was supplied use the internal VREF */
> +	st->use_internal_vref = true;
> +	ret = ad5064_set_config(st, AD5064_CONFIG_INT_VREF_ENABLE);
> +	if (ret)
> +		dev_err(dev, "Failed to enable internal vref: %d\n", ret);
> +
> +	return ret;
> +}
> +
>  static int ad5064_probe(struct device *dev, enum ad5064_type type,
>  			const char *name, ad5064_write_func write)
>  {
> @@ -828,22 +862,11 @@ static int ad5064_probe(struct device *dev, enum ad5064_type type,
>  	st->dev = dev;
>  	st->write = write;
>  
> -	for (i = 0; i < ad5064_num_vref(st); ++i)
> -		st->vref_reg[i].supply = ad5064_vref_name(st, i);
> +	ret = ad5064_request_vref(st, dev);
> +	if (ret)
> +		return ret;
>  
> -	ret = devm_regulator_bulk_get(dev, ad5064_num_vref(st),
> -		st->vref_reg);
> -	if (ret) {
> -		if (!st->chip_info->internal_vref)
> -			return ret;
> -		st->use_internal_vref = true;
> -		ret = ad5064_set_config(st, AD5064_CONFIG_INT_VREF_ENABLE);
> -		if (ret) {
> -			dev_err(dev, "Failed to enable internal vref: %d\n",
> -				ret);
> -			return ret;
> -		}
> -	} else {
> +	if (!st->use_internal_vref) {
>  		ret = regulator_bulk_enable(ad5064_num_vref(st), st->vref_reg);
>  		if (ret)
>  			return ret;
