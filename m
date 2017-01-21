Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35293 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751212AbdAUOm3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 09:42:29 -0500
Subject: Re: [PATCH v2 08/15] staging: iio: isl29028: made error messages
 consistent
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <20170117092502.6951-1-masneyb@onstation.org>
 <20170117092502.6951-9-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0348708b-2c80-be76-4f73-de50ab808483@kernel.org>
Date: Sat, 21 Jan 2017 14:42:27 +0000
MIME-Version: 1.0
In-Reply-To: <20170117092502.6951-9-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/01/17 09:24, Brian Masney wrote:
> The wording and style of the different error messages was not
> consistent. This patch makes the wording and style consistent
> throughout the driver.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  drivers/staging/iio/light/isl29028.c | 56 ++++++++++++++++++++----------------
>  1 file changed, 32 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index 8e7b3db..cffecf9 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -200,14 +200,16 @@ static int isl29028_read_als_ir(struct isl29028_chip *chip, int *als_ir)
>  	ret = regmap_read(chip->regmap, ISL29028_REG_ALSIR_L, &lsb);
>  	if (ret < 0) {
>  		dev_err(dev,
> -			"Error in reading register ALSIR_L err %d\n", ret);
> +			"%s(): Error %d reading register ALSIR_L\n",
> +			__func__, ret);
>  		return ret;
>  	}
>  
>  	ret = regmap_read(chip->regmap, ISL29028_REG_ALSIR_U, &msb);
>  	if (ret < 0) {
>  		dev_err(dev,
> -			"Error in reading register ALSIR_U err %d\n", ret);
> +			"%s(): Error %d reading register ALSIR_U\n",
> +			__func__, ret);
>  		return ret;
>  	}
>  
> @@ -232,8 +234,8 @@ static int isl29028_read_proxim(struct isl29028_chip *chip, int *prox)
>  
>  	ret = regmap_read(chip->regmap, ISL29028_REG_PROX_DATA, &data);
>  	if (ret < 0) {
> -		dev_err(dev, "Error in reading register %d, error %d\n",
> -			ISL29028_REG_PROX_DATA, ret);
> +		dev_err(dev, "%s(): Error %d reading register PROX_DATA\n",
> +			__func__, ret);
>  		return ret;
>  	}
>  
> @@ -250,7 +252,8 @@ static int isl29028_als_get(struct isl29028_chip *chip, int *als_data)
>  
>  	ret = isl29028_set_als_ir_mode(chip, ISL29028_MODE_ALS);
>  	if (ret < 0) {
> -		dev_err(dev, "Error in enabling ALS mode err %d\n", ret);
> +		dev_err(dev, "%s(): Error %d enabling ALS mode\n", __func__,
> +			ret);
>  		return ret;
>  	}
>  
> @@ -280,7 +283,8 @@ static int isl29028_ir_get(struct isl29028_chip *chip, int *ir_data)
>  
>  	ret = isl29028_set_als_ir_mode(chip, ISL29028_MODE_IR);
>  	if (ret < 0) {
> -		dev_err(dev, "Error in enabling IR mode err %d\n", ret);
> +		dev_err(dev, "%s(): Error %d enabling IR mode\n", __func__,
> +			ret);
>  		return ret;
>  	}
>  
> @@ -301,14 +305,15 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
>  	case IIO_PROXIMITY:
>  		if (mask != IIO_CHAN_INFO_SAMP_FREQ) {
>  			dev_err(dev,
> -				"proximity: mask value 0x%08lx not supported\n",
> -				mask);
> +				"%s(): proximity: Mask value 0x%08lx is not supported\n",
> +				__func__, mask);
>  			break;
>  		}
>  
>  		if (val < 1 || val > 100) {
>  			dev_err(dev,
> -				"Samp_freq %d is not in range[1:100]\n", val);
> +				"%s(): proximity: Sampling frequency %d is not in the range [1:100]\n",
> +				__func__, val);
>  			break;
>  		}
>  
> @@ -317,21 +322,23 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
>  	case IIO_LIGHT:
>  		if (mask != IIO_CHAN_INFO_SCALE) {
>  			dev_err(dev,
> -				"light: mask value 0x%08lx not supported\n",
> -				mask);
> +				"%s(): light: Mask value 0x%08lx is not supported\n",
> +				__func__, mask);
>  			break;
>  		}
>  
>  		if ((val != 125) && (val != 2000)) {
>  			dev_err(dev,
> -				"lux scale %d is invalid [125, 2000]\n", val);
> +				"%s(): light: Lux scale %d is not in the set {125, 2000}\n",
> +				__func__, val);
>  			break;
>  		}
>  
>  		ret = isl29028_set_als_scale(chip, val);
>  		break;
>  	default:
> -		dev_err(dev, "Unsupported channel type\n");
> +		dev_err(dev, "%s(): Unsupported channel type %x\n",
> +			__func__, chan->type);
>  		break;
>  	}
>  
> @@ -385,7 +392,8 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
>  		ret = IIO_VAL_INT;
>  		break;
>  	default:
> -		dev_err(dev, "mask value 0x%08lx not supported\n", mask);
> +		dev_err(dev, "%s(): mask value 0x%08lx is not supported\n",
> +			__func__, mask);
>  		break;
>  	}
>  
> @@ -438,8 +446,8 @@ static int isl29028_chip_init_and_power_on(struct isl29028_chip *chip)
>  
>  	ret = regmap_write(chip->regmap, ISL29028_REG_CONFIGURE, 0x0);
>  	if (ret < 0) {
> -		dev_err(dev, "%s(): write to reg %d failed, err = %d\n",
> -			__func__, ISL29028_REG_CONFIGURE, ret);
> +		dev_err(dev, "%s(): Error %d clearing the CONFIGURE register\n",
> +			__func__, ret);
>  		return ret;
>  	}
>  
> @@ -493,8 +501,8 @@ static int isl29028_probe(struct i2c_client *client,
>  	chip->regmap = devm_regmap_init_i2c(client, &isl29028_regmap_config);
>  	if (IS_ERR(chip->regmap)) {
>  		ret = PTR_ERR(chip->regmap);
> -		dev_err(&client->dev, "regmap initialization failed: %d\n",
> -			ret);
> +		dev_err(&client->dev, "%s: Error %d initializing regmap\n",
> +			__func__, ret);
>  		return ret;
>  	}
>  
> @@ -506,16 +514,16 @@ static int isl29028_probe(struct i2c_client *client,
>  	ret = regmap_write(chip->regmap, ISL29028_REG_TEST1_MODE, 0x0);
>  	if (ret < 0) {
>  		dev_err(&client->dev,
> -			"%s(): write to reg %d failed, err = %d\n", __func__,
> -			ISL29028_REG_TEST1_MODE, ret);
> +			"%s(): Error %d writing to TEST1_MODE register\n",
> +			__func__, ret);
>  		return ret;
>  	}
>  
>  	ret = regmap_write(chip->regmap, ISL29028_REG_TEST2_MODE, 0x0);
>  	if (ret < 0) {
>  		dev_err(&client->dev,
> -			"%s(): write to reg %d failed, err = %d\n", __func__,
> -			ISL29028_REG_TEST2_MODE, ret);
> +			"%s(): Error %d writing to TEST2_MODE register\n",
> +			__func__, ret);
>  		return ret;
>  	}
>  
> @@ -535,8 +543,8 @@ static int isl29028_probe(struct i2c_client *client,
>  	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
>  	if (ret < 0) {
>  		dev_err(&client->dev,
> -			"iio registration fails with error %d\n",
> -			ret);
> +			"%s(): iio registration failed with error %d\n",
> +			__func__, ret);
>  		return ret;
>  	}
>  
> 

