Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:38309 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbcGNHzP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Jul 2016 03:55:15 -0400
Subject: Re: [PATCH] iio: ad5380: Fix probe failure when no external reference
 is supplied
To: =?UTF-8?B?UGF3ZcWCIEdydWR6acWEc2tp?= <pgrudzinski@openmailbox.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20160713233202.812-1-pgrudzinski@openmailbox.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <db7bbbe6-9c9d-8672-4436-a19cff47525c@metafoo.de>
Date: Thu, 14 Jul 2016 09:55:02 +0200
MIME-Version: 1.0
In-Reply-To: <20160713233202.812-1-pgrudzinski@openmailbox.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/14/2016 01:32 AM, Paweł Grudziński wrote:
> From: Pawel Grudzinski <pgrudzinski@openmailbox.org>
> 
> Driver fails to load when there is no external Vref regulator defined,
> leaving no way to use internal reference. ad5380_probe function tries to
> obtain regulator with demv_regulator_get and checks for error, in which
> case it would use internal reference. Even without "Vref" regulator defined
> devm_regulator_get returns dummy regulator which makes function omit use of
> internal reference and causes failure on regulator_get_voltage.
> 
> Replace demv_regulator_get with demv_regulator_get_optional, which returns
> error instead of dummy regulator if it does not find one which is specified
> by the caller to make ad5380_probe configure internal reference when no
> "Vref" regulator is supplied.
> 
> Signed-off-by: Paweł Grudziński <pgrudzinski@openmailbox.org>

Looks good, thanks. But there is a way to improve on it even more, see
comments inline. Up to you whether you want to do this or not.

Either way.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
> There are couple more places where I suspect similar issue with devices
> having integrated reference, but I am sending this one because I tested it
> with hardware. If this gets accepted, I will look through other drivers
> obtaining Vref in same manner.

I believe most of those drivers predate the get_optional() API.

> 
>  drivers/iio/dac/ad5380.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
> index 97d2c51..257d455 100644
> --- a/drivers/iio/dac/ad5380.c
> +++ b/drivers/iio/dac/ad5380.c
> @@ -401,7 +401,7 @@ static int ad5380_probe(struct device *dev, struct regmap *regmap,
>  	if (st->chip_info->int_vref == 2500)
>  		ctrl |= AD5380_CTRL_INT_VREF_2V5;
>  
> -	st->vref_reg = devm_regulator_get(dev, "vref");
> +	st->vref_reg = devm_regulator_get_optional(dev, "vref");

Ideally we'd do something like

    st->vref_reg = devm_regulator_get_optional(&st->spi->dev, "vref");
    if (!IS_ERR(st->vref_reg)) {
	/* use external vref */
    } else {
        if (PTR_ERR(st->vref_reg) != -ENODEV) {
            ret = PTR_ERR(st->vref_reg);
            goto err_free_reg;
        }
        /* use internal vref ... */
    }

This makes sure that real errors returned by regulator_get_optional() are
actually handled. The only error that we want to ignore is the case where no
regulator has been specified, if a regulator has been specified but there is
a problem with the specification we don't want to switch to internal vref
mode, but rather propagate the error. This is especially important to make
probe deferring work, which kicks in when the DAC is tried to be probed
before the regulator has finished probing.


>  	if (!IS_ERR(st->vref_reg)) {
>  		ret = regulator_enable(st->vref_reg);
>  		if (ret) {
> 

