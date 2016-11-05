Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50874 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755791AbcKEQOu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Nov 2016 12:14:50 -0400
Subject: Re: [PATCH 1/6] staging: iio: set proper supply name to
 devm_regulator_get()
To: Eva Rachel Retuya <eraretuya@gmail.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <1477933475-21914-1-git-send-email-eraretuya@gmail.com>
 <1477933475-21914-2-git-send-email-eraretuya@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d02a07d5-b5d7-e5a1-ddf9-463d7e55f829@kernel.org>
Date: Sat, 5 Nov 2016 16:14:48 +0000
MIME-Version: 1.0
In-Reply-To: <1477933475-21914-2-git-send-email-eraretuya@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/10/16 17:04, Eva Rachel Retuya wrote:
> The name passed to devm_regulator_get() should match the name of the
> supply as specified in the device datasheet. This makes it clear what
> power supply is being referred to in case of presence of other
> regulators.
> 
> Currently, the supply name specified on the affected devices is 'vcc'.
> Use lowercase version of the datasheet name to specify the supply
> voltage.
> 
> Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
Applied to the togreg branch of iio.git which will be initially pushed
out as testing for the autobuilders to play with them.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/adc/ad7192.c                | 2 +-
>  drivers/staging/iio/adc/ad7780.c                | 2 +-
>  drivers/staging/iio/frequency/ad9832.c          | 2 +-
>  drivers/staging/iio/frequency/ad9834.c          | 2 +-
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index bfa12ce..41fb32d 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -633,7 +633,7 @@ static int ad7192_probe(struct spi_device *spi)
>  
>  	st = iio_priv(indio_dev);
>  
> -	st->reg = devm_regulator_get(&spi->dev, "vcc");
> +	st->reg = devm_regulator_get(&spi->dev, "avdd");
>  	if (!IS_ERR(st->reg)) {
>  		ret = regulator_enable(st->reg);
>  		if (ret)
> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> index c9a0c2a..a88236e 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -173,7 +173,7 @@ static int ad7780_probe(struct spi_device *spi)
>  
>  	ad_sd_init(&st->sd, indio_dev, spi, &ad7780_sigma_delta_info);
>  
> -	st->reg = devm_regulator_get(&spi->dev, "vcc");
> +	st->reg = devm_regulator_get(&spi->dev, "avdd");
>  	if (!IS_ERR(st->reg)) {
>  		ret = regulator_enable(st->reg);
>  		if (ret)
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 358400b..744c8ee 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -212,7 +212,7 @@ static int ad9832_probe(struct spi_device *spi)
>  		return -ENODEV;
>  	}
>  
> -	reg = devm_regulator_get(&spi->dev, "vcc");
> +	reg = devm_regulator_get(&spi->dev, "avdd");
>  	if (!IS_ERR(reg)) {
>  		ret = regulator_enable(reg);
>  		if (ret)
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index 6366216..ca3cea6 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -329,7 +329,7 @@ static int ad9834_probe(struct spi_device *spi)
>  		return -ENODEV;
>  	}
>  
> -	reg = devm_regulator_get(&spi->dev, "vcc");
> +	reg = devm_regulator_get(&spi->dev, "avdd");
>  	if (!IS_ERR(reg)) {
>  		ret = regulator_enable(reg);
>  		if (ret)
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 5eecf1c..62f61bc 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -723,7 +723,7 @@ static int ad5933_probe(struct i2c_client *client,
>  	if (!pdata)
>  		pdata = &ad5933_default_pdata;
>  
> -	st->reg = devm_regulator_get(&client->dev, "vcc");
> +	st->reg = devm_regulator_get(&client->dev, "vdd");
>  	if (!IS_ERR(st->reg)) {
>  		ret = regulator_enable(st->reg);
>  		if (ret)
> 

