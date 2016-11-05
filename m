Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50910 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753925AbcKEQTj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Nov 2016 12:19:39 -0400
Subject: Re: [PATCH 3/6] staging: iio: ad7192: add DVdd regulator
To: Eva Rachel Retuya <eraretuya@gmail.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <1477933475-21914-1-git-send-email-eraretuya@gmail.com>
 <1477933475-21914-4-git-send-email-eraretuya@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5b91cab1-ee98-8cd0-9a30-6f42c16a2ce4@kernel.org>
Date: Sat, 5 Nov 2016 16:19:37 +0000
MIME-Version: 1.0
In-Reply-To: <1477933475-21914-4-git-send-email-eraretuya@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/10/16 17:04, Eva Rachel Retuya wrote:
> The AD7190/AD7192/AD7193/AD7195 is supplied with two power sources:
> AVdd as analog supply voltage and DVdd as digital supply voltage.
> 
> Attempt to fetch and enable the regulator 'dvdd'. Bail out if any error
> occurs.
> 
> Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
Looks good.  Applied to the togreg branch of iio.git etc etc.

Jonathan
> ---
>  drivers/staging/iio/adc/ad7192.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index 29e32b7..3f8dc66 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -153,6 +153,7 @@
>  
>  struct ad7192_state {
>  	struct regulator		*reg;
> +	struct regulator		*dvdd;
>  	u16				int_vref_mv;
>  	u32				mclk;
>  	u32				f_order;
> @@ -642,6 +643,19 @@ static int ad7192_probe(struct spi_device *spi)
>  		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
>  		return ret;
>  	}
> +
> +	st->dvdd = devm_regulator_get(&spi->dev, "dvdd");
> +	if (IS_ERR(st->dvdd)) {
> +		ret = PTR_ERR(st->dvdd);
> +		goto error_disable_reg;
> +	}
> +
> +	ret = regulator_enable(st->dvdd);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable specified DVdd supply\n");
> +		goto error_disable_reg;
> +	}
> +
>  	voltage_uv = regulator_get_voltage(st->reg);
>  
>  	if (pdata->vref_mv)
> @@ -677,7 +691,7 @@ static int ad7192_probe(struct spi_device *spi)
>  
>  	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
>  	if (ret)
> -		goto error_disable_reg;
> +		goto error_disable_dvdd;
>  
>  	ret = ad7192_setup(st, pdata);
>  	if (ret)
> @@ -690,6 +704,8 @@ static int ad7192_probe(struct spi_device *spi)
>  
>  error_remove_trigger:
>  	ad_sd_cleanup_buffer_and_trigger(indio_dev);
> +error_disable_dvdd:
> +	regulator_disable(st->dvdd);
>  error_disable_reg:
>  	regulator_disable(st->reg);
>  
> @@ -704,6 +720,7 @@ static int ad7192_remove(struct spi_device *spi)
>  	iio_device_unregister(indio_dev);
>  	ad_sd_cleanup_buffer_and_trigger(indio_dev);
>  
> +	regulator_disable(st->dvdd);
>  	regulator_disable(st->reg);
>  
>  	return 0;
> 

