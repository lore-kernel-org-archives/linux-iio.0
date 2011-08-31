Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:57965 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946Ab1HaLbW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 31 Aug 2011 07:31:22 -0400
Message-ID: <4E5E1D77.1080303@cam.ac.uk>
Date: Wed, 31 Aug 2011 12:39:35 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 11/12] iio: ad7291: reset device and setup irq before
 it is enabled
References: <1314788260-5791-1-git-send-email-michael.hennerich@analog.com> <1314788260-5791-11-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1314788260-5791-11-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/31/11 11:57, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
Looks right.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
merged
> ---
>  drivers/staging/iio/adc/ad7291.c |   27 ++++++++++++++++-----------
>  1 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
> index 334951c..0811c5e 100644
> --- a/drivers/staging/iio/adc/ad7291.c
> +++ b/drivers/staging/iio/adc/ad7291.c
> @@ -589,8 +589,10 @@ static int __devinit ad7291_probe(struct i2c_client *client,
>  	i2c_set_clientdata(client, indio_dev);
>  
>  	chip->client = client;
> -	/* Tsense always enabled */
> -	chip->command = AD7291_NOISE_DELAY | AD7291_T_SENSE_MASK;
> +
> +	chip->command = AD7291_NOISE_DELAY |
> +			AD7291_T_SENSE_MASK | /* Tsense always enabled */
> +			AD7291_ALERT_POLARITY; /* set irq polarity low level */
>  
>  	if (voltage_uv) {
>  		chip->int_vref_mv = voltage_uv / 1000;
> @@ -607,6 +609,18 @@ static int __devinit ad7291_probe(struct i2c_client *client,
>  	indio_dev->info = &ad7291_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> +	ret = ad7291_i2c_write(chip, AD7291_COMMAND, AD7291_RESET);
> +	if (ret) {
> +		ret = -EIO;
> +		goto error_disable_reg;
> +	}
> +
> +	ret = ad7291_i2c_write(chip, AD7291_COMMAND, chip->command);
> +	if (ret) {
> +		ret = -EIO;
> +		goto error_disable_reg;
> +	}
> +
>  	if (client->irq > 0) {
>  		ret = request_threaded_irq(client->irq,
>  					   NULL,
> @@ -616,15 +630,6 @@ static int __devinit ad7291_probe(struct i2c_client *client,
>  					   indio_dev);
>  		if (ret)
>  			goto error_disable_reg;
> -
> -		/* set irq polarity low level */
> -		chip->command |= AD7291_ALERT_POLARITY;
> -	}
> -
> -	ret = ad7291_i2c_write(chip, AD7291_COMMAND, chip->command);
> -	if (ret) {
> -		ret = -EIO;
> -		goto error_unreg_irq;
>  	}
>  
>  	ret = iio_device_register(indio_dev);

