Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:40852 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752733Ab1HaLOO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 31 Aug 2011 07:14:14 -0400
Message-ID: <4E5E1974.7010004@cam.ac.uk>
Date: Wed, 31 Aug 2011 12:22:28 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 04/12] iio: ad7291: Add regulator, reference voltage and
 scale handling
References: <1314788260-5791-1-git-send-email-michael.hennerich@analog.com> <1314788260-5791-4-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1314788260-5791-4-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/31/11 11:57, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
Technically the temp -> adc message change should have been in the earlier
patch fixing that elsewhere, but frankly who cares ;)

Good patch all in all. Thanks.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
merged.
> ---
>  drivers/staging/iio/adc/ad7291.c |   61 ++++++++++++++++++++++++++++++++-----
>  1 files changed, 52 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
> index dda6bcb..382ca3e 100644
> --- a/drivers/staging/iio/adc/ad7291.c
> +++ b/drivers/staging/iio/adc/ad7291.c
> @@ -13,6 +13,8 @@
>  #include <linux/sysfs.h>
>  #include <linux/i2c.h>
>  #include <linux/mutex.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/err.h>
>  
>  #include "../iio.h"
>  #include "../sysfs.h"
> @@ -26,8 +28,8 @@
>   *
>   * The noise-delayed bit as per datasheet suggestion is always enabled.
>   *
> - * Extref control should be based on regulator provision - not handled.
>   */
> +
>  /*
>   * AD7291 registers definition
>   */
> @@ -60,16 +62,21 @@
>   * AD7291 value masks
>   */
>  #define AD7291_CHANNEL_MASK		0xF000
> +#define AD7291_BITS			12
>  #define AD7291_VALUE_MASK		0xFFF
>  #define AD7291_T_VALUE_SIGN		0x400
>  #define AD7291_T_VALUE_FLOAT_OFFSET	2
>  #define AD7291_T_VALUE_FLOAT_MASK	0x2
>  
> +#define AD7291_BITS			12
> +
>  struct ad7291_chip_info {
> -	struct i2c_client *client;
> -	u16 command;
> -	u8 c_mask;	/* Active voltage channels for events */
> -	struct mutex state_lock;
> +	struct i2c_client	*client;
> +	struct regulator	*reg;
> +	u16			int_vref_mv;
> +	u16			command;
> +	u8			c_mask;	/* Active voltage channels for events */
> +	struct mutex 		state_lock;
>  };
>  
>  static int ad7291_i2c_read(struct ad7291_chip_info *chip, u8 reg, u16 *data)
> @@ -419,6 +426,7 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
>  {
>  	int ret;
>  	struct ad7291_chip_info *chip = iio_priv(indio_dev);
> +	unsigned int scale_uv;
>  	u16 regval;
>  	s16 signval;
>  
> @@ -470,6 +478,11 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
>  			signval = (s16)((swab16((u16)ret) & 0x0FFF) << 4) >> 4;
>  			*val = signval;
>  			return IIO_VAL_INT;
> +	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
> +		scale_uv = (chip->int_vref_mv * 1000) >> AD7291_BITS;
> +		*val =  scale_uv / 1000;
> +		*val2 = (scale_uv % 1000) * 1000;
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -478,6 +491,7 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
>  #define AD7291_VOLTAGE_CHAN(_chan)					\
>  {									\
>  	.type = IIO_VOLTAGE,						\
> +	.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),			\
>  	.indexed = 1,							\
>  	.channel = _chan,						\
>  	.event_mask = IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING)|\
> @@ -523,7 +537,7 @@ static int __devinit ad7291_probe(struct i2c_client *client,
>  {
>  	struct ad7291_chip_info *chip;
>  	struct iio_dev *indio_dev;
> -	int ret = 0;
> +	int ret = 0, voltage_uv = 0;
>  
>  	indio_dev = iio_allocate_device(sizeof(*chip));
>  	if (indio_dev == NULL) {
> @@ -531,6 +545,15 @@ static int __devinit ad7291_probe(struct i2c_client *client,
>  		goto error_ret;
>  	}
>  	chip = iio_priv(indio_dev);
> +
> +	chip->reg = regulator_get(&client->dev, "vcc");
> +	if (!IS_ERR(chip->reg)) {
> +		ret = regulator_enable(chip->reg);
> +		if (ret)
> +			goto error_put_reg;
> +		voltage_uv = regulator_get_voltage(chip->reg);
> +	}
> +
>  	mutex_init(&chip->state_lock);
>  	/* this is only used for device removal purposes */
>  	i2c_set_clientdata(client, indio_dev);
> @@ -539,6 +562,13 @@ static int __devinit ad7291_probe(struct i2c_client *client,
>  	/* Tsense always enabled */
>  	chip->command = AD7291_NOISE_DELAY | AD7291_T_SENSE_MASK;
>  
> +	if (voltage_uv) {
> +		chip->int_vref_mv = voltage_uv / 1000;
> +		chip->command |= AD7291_EXT_REF;
> +	} else {
> +		chip->int_vref_mv = 2500; /* Build-in ref */
> +	}
> +
>  	indio_dev->name = id->name;
>  	indio_dev->channels = ad7291_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(ad7291_channels);
> @@ -555,7 +585,7 @@ static int __devinit ad7291_probe(struct i2c_client *client,
>  					   id->name,
>  					   indio_dev);
>  		if (ret)
> -			goto error_free_dev;
> +			goto error_disable_reg;
>  
>  		/* set irq polarity low level */
>  		chip->command |= AD7291_ALERT_POLARITY;
> @@ -571,7 +601,7 @@ static int __devinit ad7291_probe(struct i2c_client *client,
>  	if (ret)
>  		goto error_unreg_irq;
>  
> -	dev_info(&client->dev, "%s temperature sensor registered.\n",
> +	dev_info(&client->dev, "%s ADC registered.\n",
>  			 id->name);
>  
>  	return 0;
> @@ -579,7 +609,13 @@ static int __devinit ad7291_probe(struct i2c_client *client,
>  error_unreg_irq:
>  	if (client->irq)
>  		free_irq(client->irq, indio_dev);
> -error_free_dev:
> +error_disable_reg:
> +	if (!IS_ERR(chip->reg))
> +		regulator_disable(chip->reg);
> +error_put_reg:
> +	if (!IS_ERR(chip->reg))
> +		regulator_put(chip->reg);
> +
>  	iio_free_device(indio_dev);
>  error_ret:
>  	return ret;
> @@ -588,9 +624,16 @@ error_ret:
>  static int __devexit ad7291_remove(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct ad7291_chip_info *chip = iio_priv(indio_dev);
>  
>  	if (client->irq)
>  		free_irq(client->irq, indio_dev);
> +
> +	if (!IS_ERR(chip->reg)) {
> +		regulator_disable(chip->reg);
> +		regulator_put(chip->reg);
> +	}
> +
>  	iio_device_unregister(indio_dev);
>  
>  	return 0;

