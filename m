Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50939 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755998AbcKEQWt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Nov 2016 12:22:49 -0400
Subject: Re: [PATCH 5/6] staging: iio: ad9832: add DVDD regulator
To: Eva Rachel Retuya <eraretuya@gmail.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <1477933475-21914-1-git-send-email-eraretuya@gmail.com>
 <1477933475-21914-6-git-send-email-eraretuya@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b22be244-5b5c-0cd6-dab3-2be2865a5b8f@kernel.org>
Date: Sat, 5 Nov 2016 16:22:47 +0000
MIME-Version: 1.0
In-Reply-To: <1477933475-21914-6-git-send-email-eraretuya@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/10/16 17:04, Eva Rachel Retuya wrote:
> The AD9832/AD9835 is supplied with two power sources: AVDD as analog
> supply voltage and DVDD as digital supply voltage.
> 
> Attempt to fetch and enable the regulator 'dvdd'. Bail out if any error
> occurs.
> 
> Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
Applied. 

Thanks,

Jonathan
> ---
>  drivers/staging/iio/frequency/ad9832.c | 33 ++++++++++++++++++++++++---------
>  drivers/staging/iio/frequency/ad9832.h |  2 ++
>  2 files changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 7d8dc6c..6a5ab02 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -222,10 +222,22 @@ static int ad9832_probe(struct spi_device *spi)
>  		return ret;
>  	}
>  
> +	st->dvdd = devm_regulator_get(&spi->dev, "dvdd");
> +	if (IS_ERR(st->dvdd)) {
> +		ret = PTR_ERR(st->dvdd);
> +		goto error_disable_reg;
> +	}
> +
> +	ret = regulator_enable(st->dvdd);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable specified DVDD supply\n");
> +		goto error_disable_reg;
> +	}
> +
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev) {
>  		ret = -ENOMEM;
> -		goto error_disable_reg;
> +		goto error_disable_dvdd;
>  	}
>  	spi_set_drvdata(spi, indio_dev);
>  	st = iio_priv(indio_dev);
> @@ -280,39 +292,41 @@ static int ad9832_probe(struct spi_device *spi)
>  	ret = spi_sync(st->spi, &st->msg);
>  	if (ret) {
>  		dev_err(&spi->dev, "device init failed\n");
> -		goto error_disable_reg;
> +		goto error_disable_dvdd;
>  	}
>  
>  	ret = ad9832_write_frequency(st, AD9832_FREQ0HM, pdata->freq0);
>  	if (ret)
> -		goto error_disable_reg;
> +		goto error_disable_dvdd;
>  
>  	ret = ad9832_write_frequency(st, AD9832_FREQ1HM, pdata->freq1);
>  	if (ret)
> -		goto error_disable_reg;
> +		goto error_disable_dvdd;
>  
>  	ret = ad9832_write_phase(st, AD9832_PHASE0H, pdata->phase0);
>  	if (ret)
> -		goto error_disable_reg;
> +		goto error_disable_dvdd;
>  
>  	ret = ad9832_write_phase(st, AD9832_PHASE1H, pdata->phase1);
>  	if (ret)
> -		goto error_disable_reg;
> +		goto error_disable_dvdd;
>  
>  	ret = ad9832_write_phase(st, AD9832_PHASE2H, pdata->phase2);
>  	if (ret)
> -		goto error_disable_reg;
> +		goto error_disable_dvdd;
>  
>  	ret = ad9832_write_phase(st, AD9832_PHASE3H, pdata->phase3);
>  	if (ret)
> -		goto error_disable_reg;
> +		goto error_disable_dvdd;
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> -		goto error_disable_reg;
> +		goto error_disable_dvdd;
>  
>  	return 0;
>  
> +error_disable_dvdd:
> +	regulator_disable(st->dvdd);
>  error_disable_reg:
>  	regulator_disable(reg);
>  
> @@ -325,6 +339,7 @@ static int ad9832_remove(struct spi_device *spi)
>  	struct ad9832_state *st = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> +	regulator_disable(st->dvdd);
>  	regulator_disable(st->reg);
>  
>  	return 0;
> diff --git a/drivers/staging/iio/frequency/ad9832.h b/drivers/staging/iio/frequency/ad9832.h
> index d32323b..eb0e7f2 100644
> --- a/drivers/staging/iio/frequency/ad9832.h
> +++ b/drivers/staging/iio/frequency/ad9832.h
> @@ -59,6 +59,7 @@
>   * struct ad9832_state - driver instance specific data
>   * @spi:		spi_device
>   * @reg:		supply regulator
> + * @dvdd:		supply regulator for the digital section
>   * @mclk:		external master clock
>   * @ctrl_fp:		cached frequency/phase control word
>   * @ctrl_ss:		cached sync/selsrc control word
> @@ -77,6 +78,7 @@
>  struct ad9832_state {
>  	struct spi_device		*spi;
>  	struct regulator		*reg;
> +	struct regulator		*dvdd;
>  	unsigned long			mclk;
>  	unsigned short			ctrl_fp;
>  	unsigned short			ctrl_ss;
> 

