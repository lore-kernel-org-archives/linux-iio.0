Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752418AbdGIR27 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Jul 2017 13:28:59 -0400
Date: Sun, 9 Jul 2017 18:28:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH v2 5/9] staging: iio: tsl2x7x: cleaned up i2c calls in
 tsl2x7x_als_calibrate()
Message-ID: <20170709182858.6e7b613c@kernel.org>
In-Reply-To: <20170706225626.6716-6-masneyb@onstation.org>
References: <20170706225626.6716-1-masneyb@onstation.org>
        <20170706225626.6716-6-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu,  6 Jul 2017 18:56:22 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The calibration function calls i2c_smbus_write_byte() and
> i2c_smbus_read_byte(). These two function calls are replaced with a
> single call to i2c_smbus_read_byte_data() by this patch. This patch
> also removes an unnecessary call that reads the CNTRL register
> a second time. One of the error paths returned -1 if the ADC was not
> enabled and this patch changes that return value to -EINVAL.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 34 ++++++++++++----------------------
>  1 file changed, 12 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 6c9f06b..5734628 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -542,39 +542,29 @@ static void tsl2x7x_defaults(struct tsl2X7X_chip *chip)
>  static int tsl2x7x_als_calibrate(struct iio_dev *indio_dev)
>  {
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> -	u8 reg_val;
>  	int gain_trim_val;
>  	int ret;
>  	int lux_val;
>  
> -	ret = i2c_smbus_write_byte(chip->client,
> -				   (TSL2X7X_CMD_REG | TSL2X7X_CNTRL));
> +	ret = i2c_smbus_read_byte_data(chip->client,
> +				       TSL2X7X_CMD_REG | TSL2X7X_CNTRL);
>  	if (ret < 0) {
>  		dev_err(&chip->client->dev,
> -			"failed to write CNTRL register, ret=%d\n", ret);
> +			"%s: failed to read from the CNTRL register\n",
> +			__func__);
>  		return ret;
>  	}
>  
> -	reg_val = i2c_smbus_read_byte(chip->client);
> -	if ((reg_val & (TSL2X7X_CNTL_ADC_ENBL | TSL2X7X_CNTL_PWR_ON))
> -		!= (TSL2X7X_CNTL_ADC_ENBL | TSL2X7X_CNTL_PWR_ON)) {
> -		dev_err(&chip->client->dev,
> -			"%s: failed: ADC not enabled\n", __func__);
> -		return -1;
> -	}
> -
> -	ret = i2c_smbus_write_byte(chip->client,
> -				   (TSL2X7X_CMD_REG | TSL2X7X_CNTRL));
> -	if (ret < 0) {
> +	if ((ret & (TSL2X7X_CNTL_ADC_ENBL | TSL2X7X_CNTL_PWR_ON))
> +			!= (TSL2X7X_CNTL_ADC_ENBL | TSL2X7X_CNTL_PWR_ON)) {
>  		dev_err(&chip->client->dev,
> -			"failed to write ctrl reg: ret=%d\n", ret);
> -		return ret;
> -	}
> -
> -	reg_val = i2c_smbus_read_byte(chip->client);
> -	if ((reg_val & TSL2X7X_STA_ADC_VALID) != TSL2X7X_STA_ADC_VALID) {
> +			"%s: Device is not powered on and/or ADC is not enabled\n",
> +			__func__);
> +		return -EINVAL;
> +	} else if ((ret & TSL2X7X_STA_ADC_VALID) != TSL2X7X_STA_ADC_VALID) {
>  		dev_err(&chip->client->dev,
> -			"%s: failed: STATUS - ADC not valid.\n", __func__);
> +			"%s: The two ADC channels have not completed an integration cycle\n",
> +			__func__);
>  		return -ENODATA;
>  	}
>  

