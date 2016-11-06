Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55675 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751691AbcKFMLd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Nov 2016 07:11:33 -0500
Subject: Re: [PATCH 7/9] staging: iio: tsl2583: fix issue with changes to
 calibscale and int_time not being set on the chip
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478177780-28699-1-git-send-email-masneyb@onstation.org>
 <1478177780-28699-8-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <16c8bfcb-469f-9dca-2cf4-460aa8172301@kernel.org>
Date: Sun, 6 Nov 2016 12:03:53 +0000
MIME-Version: 1.0
In-Reply-To: <1478177780-28699-8-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/11/16 12:56, Brian Masney wrote:
> When updating the in_illuminance_calibscale and
> in_illuminance_integration_time sysfs attributes, these values were not
> actually written to the chip. The chip would continue to use the old
> parameters. Extracted out tsl2583_set_als_gain() and
> tsl2583_set_als_time() functions that are now called when these sysfs
> attributes are updated. The chip initialization now calls these these
> new functions.
> 
> Rename taos_chip_on() to tsl2583_chip_init() since it is now only called
> during device probing and when the power management code wakes the
> device back up. tsl2583_chip_init() was refactored to use the new
> functions mentioned above.
> 
> Previously, the current chip state was represented as a tristate
> (working, suspended, and unknown). The unknown state was not used. The
> chip state is now represented with a single boolean value (suspended).
Last part should probably have been a separate patch.  Earlier stages could
also have been futher broken up I think to make it easier to review.

The additional init in the resume path should also protect against suspends
which actually cut the power to the chip which is nice.

Just enough bits and pieces inline that I'd like you to do another pass
on this.

Jonathan
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  drivers/staging/iio/light/tsl2583.c | 172 ++++++++++++++++--------------------
>  1 file changed, 78 insertions(+), 94 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index 7eab17f..1ff90b3 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -48,6 +48,8 @@
>  #define TSL258X_TMR_LO			0x18
>  #define TSL258X_TMR_HI			0x19
>  
> +#define TSL2583_INTERRUPT_DISABLED	0x00
> +
>  /* tsl2583 cmd reg masks */
>  #define TSL258X_CMD_REG			0x80
>  #define TSL258X_CMD_SPL_FN		0x60
> @@ -55,6 +57,7 @@
>  
>  /* tsl2583 cntrl reg masks */
>  #define TSL258X_CNTL_ADC_ENBL	0x02
> +#define TSL258X_CNTL_PWR_OFF		0x00
>  #define TSL258X_CNTL_PWR_ON		0x01
>  
>  /* tsl2583 status reg masks */
> @@ -67,12 +70,6 @@
>  #define TSL2583_CHIP_ID			0x90
>  #define TSL2583_CHIP_ID_MASK		0xf0
>  
> -enum {
> -	TSL258X_CHIP_UNKNOWN = 0,
> -	TSL258X_CHIP_WORKING = 1,
> -	TSL258X_CHIP_SUSPENDED = 2
> -};
> -
>  /* Per-device data */
>  struct taos_als_info {
>  	u16 als_ch0;
> @@ -94,19 +91,9 @@ struct tsl2583_chip {
>  	struct taos_settings taos_settings;
>  	int als_time_scale;
>  	int als_saturation;
> -	int taos_chip_status;
> -	u8 taos_config[8];
> +	bool suspended;
>  };
>  
> -/*
> - * Initial values for device - this values can/will be changed by driver.
> - * and applications as needed.
> - * These values are dynamic.
> - */
> -static const u8 taos_config[8] = {
> -		0x00, 0xee, 0x00, 0x03, 0x00, 0xFF, 0xFF, 0x00
> -}; /*	cntrl atime intC  Athl0 Athl1 Athh0 Athh1 gain */
> -
>  struct taos_lux {
>  	unsigned int ratio;
>  	unsigned int ch0;
> @@ -188,13 +175,6 @@ static int taos_get_lux(struct iio_dev *indio_dev)
>  	u32 ch0lux = 0;
>  	u32 ch1lux = 0;
>  
> -	if (chip->taos_chip_status != TSL258X_CHIP_WORKING) {
> -		/* device is not enabled */
> -		dev_err(&chip->client->dev, "taos_get_lux device is not enabled\n");
> -		ret = -EBUSY;
> -		goto done;
> -	}
> -
This change is because it's already guaranteed to be in the working state?
>  	ret = i2c_smbus_read_byte_data(chip->client, TSL258X_CMD_REG);
>  	if (ret < 0) {
>  		dev_err(&chip->client->dev, "taos_get_lux failed to read CMD_REG\n");
> @@ -362,26 +342,10 @@ static int taos_als_calibrate(struct iio_dev *indio_dev)
>  	return (int)gain_trim_val;
>  }
>  
> -/*
> - * Turn the device on.
> - * Configuration must be set before calling this function.
> - */
> -static int taos_chip_on(struct iio_dev *indio_dev)
> +static int tsl2583_set_als_time(struct tsl2583_chip *chip)
>  {
> -	int i;
> -	int ret;
> -	u8 *uP;
> -	u8 utmp;
> -	int als_count;
> -	int als_time;
> -	struct tsl2583_chip *chip = iio_priv(indio_dev);
> -
> -	/* and make sure we're not already on */
> -	if (chip->taos_chip_status == TSL258X_CHIP_WORKING) {
> -		/* if forcing a register update - turn off, then on */
> -		dev_info(&chip->client->dev, "device is already enabled\n");
> -		return -EINVAL;
> -	}
> +	int als_count, als_time, ret;
> +	u8 val;
>  
>  	/* determine als integration register */
>  	als_count = (chip->taos_settings.als_time * 100 + 135) / 270;
> @@ -390,60 +354,82 @@ static int taos_chip_on(struct iio_dev *indio_dev)
>  
>  	/* convert back to time (encompasses overrides) */
>  	als_time = (als_count * 27 + 5) / 10;
> -	chip->taos_config[TSL258X_ALS_TIME] = 256 - als_count;
>  
> -	/* Set the gain based on taos_settings struct */
> -	chip->taos_config[TSL258X_GAIN] = chip->taos_settings.als_gain;
> +	val = 256 - als_count;
> +	ret = i2c_smbus_write_byte_data(chip->client,
> +					TSL258X_CMD_REG | TSL258X_ALS_TIME,
> +					val);
> +	if (ret < 0) {
> +		dev_err(&chip->client->dev,
> +			"%s failed to set the als time to %d\n",
> +			__func__, val);
> +		return ret;
> +	}
>  
>  	/* set chip struct re scaling and saturation */
>  	chip->als_saturation = als_count * 922; /* 90% of full scale */
>  	chip->als_time_scale = (als_time + 25) / 50;
>  
> -	/* Power on the device; ADC off. */
> -	chip->taos_config[TSL258X_CNTRL] = TSL258X_CNTL_PWR_ON;
> +	return ret;
> +}
>  
> -	/*
> -	 * Use the following shadow copy for our delay before enabling ADC.
> -	 * Write all the registers.
> -	 */
> -	for (i = 0, uP = chip->taos_config; i < TSL258X_REG_MAX; i++) {
> -		ret = i2c_smbus_write_byte_data(chip->client,
> -						TSL258X_CMD_REG + i,
> -						*uP++);
> -		if (ret < 0) {
> -			dev_err(&chip->client->dev,
> -				"taos_chip_on failed on reg %d.\n", i);
> -			return ret;
> -		}
> -	}
> +static int tsl2583_set_als_gain(struct tsl2583_chip *chip)
> +{
> +	int ret;
>  
> -	usleep_range(3000, 3500);
> -	/*
> -	 * NOW enable the ADC
> -	 * initialize the desired mode of operation
> -	 */
> -	utmp = TSL258X_CNTL_PWR_ON | TSL258X_CNTL_ADC_ENBL;
>  	ret = i2c_smbus_write_byte_data(chip->client,
> -					TSL258X_CMD_REG | TSL258X_CNTRL,
> -					utmp);
> -	if (ret < 0) {
> -		dev_err(&chip->client->dev, "taos_chip_on failed on 2nd CTRL reg.\n");
> -		return ret;
> -	}
> -	chip->taos_chip_status = TSL258X_CHIP_WORKING;
> +					TSL258X_CMD_REG | TSL258X_GAIN,
> +					chip->taos_settings.als_gain);
> +	if (ret < 0)
> +		dev_err(&chip->client->dev, "%s failed to set the gain to %d\n",
> +			__func__, chip->taos_settings.als_gain);
>  
>  	return ret;
>  }
>  
> -static int taos_chip_off(struct iio_dev *indio_dev)
> +static int tsl2583_set_power_state(struct tsl2583_chip *chip, u8 state)
>  {
> -	struct tsl2583_chip *chip = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(chip->client,
> +					TSL258X_CMD_REG | TSL258X_CNTRL, state);
> +	if (ret < 0)
> +		dev_err(&chip->client->dev, "%s failed to set the power state to %d\n",
> +			__func__, state);
>  
> -	/* turn device off */
> -	chip->taos_chip_status = TSL258X_CHIP_SUSPENDED;
> -	return i2c_smbus_write_byte_data(chip->client,
> -					TSL258X_CMD_REG | TSL258X_CNTRL,
> -					0x00);
> +	return ret;
> +}
> +
> +static int tsl2583_chip_init(struct tsl2583_chip *chip)
> +{
> +	int ret;
> +
> +	ret = tsl2583_set_power_state(chip, TSL258X_CNTL_PWR_ON);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_write_byte_data(chip->client,
> +					TSL258X_CMD_REG | TSL258X_INTERRUPT,
> +					TSL2583_INTERRUPT_DISABLED);
> +	if (ret < 0) {
> +		dev_err(&chip->client->dev, "%s failed to disable interrupts\n",
> +			__func__);
> +		return ret;
> +	}
> +
> +	ret = tsl2583_set_als_time(chip);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = tsl2583_set_als_gain(chip);
> +	if (ret < 0)
> +		return ret;
> +
> +	usleep_range(3000, 3500);
> +
> +	/* Enable the ADC and initialize the desired mode of operation */
> +	return tsl2583_set_power_state(chip, TSL258X_CNTL_PWR_ON |
> +					     TSL258X_CNTL_ADC_ENBL);
>  }
>  
>  /* Sysfs Interface Functions */
> @@ -616,7 +602,7 @@ static int tsl2583_read_raw(struct iio_dev *indio_dev,
>  
>  	mutex_lock(&chip->als_mutex);
>  
> -	if (chip->taos_chip_status != TSL258X_CHIP_WORKING) {
> +	if (chip->suspended) {
>  		ret = -EBUSY;
>  		goto read_done;
>  	}
> @@ -693,7 +679,7 @@ static int tsl2583_write_raw(struct iio_dev *indio_dev,
>  
>  	mutex_lock(&chip->als_mutex);
>  
> -	if (chip->taos_chip_status != TSL258X_CHIP_WORKING) {
> +	if (chip->suspended) {
>  		ret = -EBUSY;
>  		goto write_done;
>  	}
> @@ -716,13 +702,14 @@ static int tsl2583_write_raw(struct iio_dev *indio_dev,
>  					break;
>  				}
>  			}
> +			ret = tsl2583_set_als_gain(chip);
>  		}
>  		break;
>  	case IIO_CHAN_INFO_INT_TIME:
>  		if (chan->type == IIO_LIGHT && !val && val2 >= 50 &&
>  		    val2 <= 650 && !(val2 % 50)) {
>  			chip->taos_settings.als_time = val2;
> -			ret = 0;
> +			ret = tsl2583_set_als_time(chip);
>  		}
>  		break;
>  	default:
> @@ -767,8 +754,7 @@ static int taos_probe(struct i2c_client *clientp,
>  	i2c_set_clientdata(clientp, indio_dev);
>  
>  	mutex_init(&chip->als_mutex);
> -	chip->taos_chip_status = TSL258X_CHIP_UNKNOWN;
> -	memcpy(chip->taos_config, taos_config, sizeof(chip->taos_config));
> +	chip->suspended = false;
This should really be set after the power up rather than here...
>  
>  	ret = i2c_smbus_read_byte_data(clientp,
>  				       TSL258X_CMD_REG | TSL258X_CHIPID);
> @@ -808,7 +794,7 @@ static int taos_probe(struct i2c_client *clientp,
>  	taos_defaults(chip);
>  
>  	/* Make sure the chip is on */
> -	ret = taos_chip_on(indio_dev);
> +	ret = tsl2583_chip_init(chip);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -825,10 +811,8 @@ static int taos_suspend(struct device *dev)
>  
>  	mutex_lock(&chip->als_mutex);
>  
> -	if (chip->taos_chip_status == TSL258X_CHIP_WORKING) {
> -		ret = taos_chip_off(indio_dev);
> -		chip->taos_chip_status = TSL258X_CHIP_SUSPENDED;
> -	}
> +	chip->suspended = true;
> +	ret = tsl2583_set_power_state(chip, TSL258X_CNTL_PWR_OFF);
>  
>  	mutex_unlock(&chip->als_mutex);
>  	return ret;
> @@ -842,8 +826,8 @@ static int taos_resume(struct device *dev)
>  
>  	mutex_lock(&chip->als_mutex);
>  
> -	if (chip->taos_chip_status == TSL258X_CHIP_SUSPENDED)
> -		ret = taos_chip_on(indio_dev);
> +	chip->suspended = false;
> +	ret = tsl2583_chip_init(chip);
Would logically expect the two lines above to 'reflect' those in
the suspend so to be in the opposite order.  I'd also be tempted to
name chip_init as something like tsl2583_chip_init_and_power_up
to make it clear that the revers is the power off state above.

>  
>  	mutex_unlock(&chip->als_mutex);
>  	return ret;
> 

