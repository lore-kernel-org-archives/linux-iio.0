Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51034 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbcBXUpF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 24 Feb 2016 15:45:05 -0500
Subject: Re: [PATCH v2 1/2] iio: ina2xx: Fix whitespace and re-order code
To: "Andrew F. Davis" <afd@ti.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Marc Titinger <mtitinger@baylibre.com>
References: <1456335527-3229-1-git-send-email-afd@ti.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56CE164C.5080609@kernel.org>
Date: Wed, 24 Feb 2016 20:45:00 +0000
MIME-Version: 1.0
In-Reply-To: <1456335527-3229-1-git-send-email-afd@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/02/16 17:38, Andrew F. Davis wrote:
> Group of probably overly rigorous whitespace and code cleanups.
>  - Alphabetize includes
>  - Assign to variables in the order they are defined
>  - Alignment issues
>  - Group alike statements together
>  - Use helper macros
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
Fair enough, 

Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with them.

Thanks,

Jonathan
> ---
> Removed some unneeded changes in v1 at Jonathan's suggestion
> 
>  drivers/iio/adc/ina2xx-adc.c | 134 +++++++++++++++++++++----------------------
>  1 file changed, 65 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index d803e50..d3e8207 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -19,17 +19,18 @@
>   *
>   * Configurable 7-bit I2C slave address from 0x40 to 0x4F
>   */
> -#include <linux/module.h>
> -#include <linux/kthread.h>
> +
>  #include <linux/delay.h>
> +#include <linux/i2c.h>
>  #include <linux/iio/kfifo_buf.h>
>  #include <linux/iio/sysfs.h>
> -#include <linux/i2c.h>
> +#include <linux/kthread.h>
> +#include <linux/module.h>
>  #include <linux/regmap.h>
> -#include <linux/platform_data/ina2xx.h>
> -
>  #include <linux/util_macros.h>
>  
> +#include <linux/platform_data/ina2xx.h>
> +
>  /* INA2XX registers definition */
>  #define INA2XX_CONFIG                   0x00
>  #define INA2XX_SHUNT_VOLTAGE            0x01	/* readonly */
> @@ -38,7 +39,7 @@
>  #define INA2XX_CURRENT                  0x04	/* readonly */
>  #define INA2XX_CALIBRATION              0x05
>  
> -#define INA226_ALERT_MASK		0x06
> +#define INA226_ALERT_MASK		GENMASK(2, 1)
>  #define INA266_CVRF			BIT(3)
>  
>  #define INA2XX_MAX_REGISTERS            8
> @@ -113,7 +114,7 @@ struct ina2xx_chip_info {
>  	struct mutex state_lock;
>  	unsigned int shunt_resistor;
>  	int avg;
> -	s64 prev_ns;	/* track buffer capture time, check for underruns*/
> +	s64 prev_ns; /* track buffer capture time, check for underruns */
>  	int int_time_vbus; /* Bus voltage integration time uS */
>  	int int_time_vshunt; /* Shunt voltage integration time uS */
>  	bool allow_async_readout;
> @@ -121,21 +122,21 @@ struct ina2xx_chip_info {
>  
>  static const struct ina2xx_config ina2xx_config[] = {
>  	[ina219] = {
> -		    .config_default = INA219_CONFIG_DEFAULT,
> -		    .calibration_factor = 40960000,
> -		    .shunt_div = 100,
> -		    .bus_voltage_shift = 3,
> -		    .bus_voltage_lsb = 4000,
> -		    .power_lsb = 20000,
> -		    },
> +		.config_default = INA219_CONFIG_DEFAULT,
> +		.calibration_factor = 40960000,
> +		.shunt_div = 100,
> +		.bus_voltage_shift = 3,
> +		.bus_voltage_lsb = 4000,
> +		.power_lsb = 20000,
> +	},
>  	[ina226] = {
> -		    .config_default = INA226_CONFIG_DEFAULT,
> -		    .calibration_factor = 5120000,
> -		    .shunt_div = 400,
> -		    .bus_voltage_shift = 0,
> -		    .bus_voltage_lsb = 1250,
> -		    .power_lsb = 25000,
> -		    },
> +		.config_default = INA226_CONFIG_DEFAULT,
> +		.calibration_factor = 5120000,
> +		.shunt_div = 400,
> +		.bus_voltage_shift = 0,
> +		.bus_voltage_lsb = 1250,
> +		.power_lsb = 25000,
> +	},
>  };
>  
>  static int ina2xx_read_raw(struct iio_dev *indio_dev,
> @@ -149,7 +150,7 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		ret = regmap_read(chip->regmap, chan->address, &regval);
> -		if (ret < 0)
> +		if (ret)
>  			return ret;
>  
>  		if (is_signed_reg(chan->address))
> @@ -251,7 +252,7 @@ static int ina226_set_int_time_vbus(struct ina2xx_chip_info *chip,
>  		return -EINVAL;
>  
>  	bits = find_closest(val_us, ina226_conv_time_tab,
> -			ARRAY_SIZE(ina226_conv_time_tab));
> +			    ARRAY_SIZE(ina226_conv_time_tab));
>  
>  	chip->int_time_vbus = ina226_conv_time_tab[bits];
>  
> @@ -270,7 +271,7 @@ static int ina226_set_int_time_vshunt(struct ina2xx_chip_info *chip,
>  		return -EINVAL;
>  
>  	bits = find_closest(val_us, ina226_conv_time_tab,
> -			ARRAY_SIZE(ina226_conv_time_tab));
> +			    ARRAY_SIZE(ina226_conv_time_tab));
>  
>  	chip->int_time_vshunt = ina226_conv_time_tab[bits];
>  
> @@ -285,8 +286,8 @@ static int ina2xx_write_raw(struct iio_dev *indio_dev,
>  			    int val, int val2, long mask)
>  {
>  	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
> -	int ret;
>  	unsigned int config, tmp;
> +	int ret;
>  
>  	if (iio_buffer_enabled(indio_dev))
>  		return -EBUSY;
> @@ -294,8 +295,8 @@ static int ina2xx_write_raw(struct iio_dev *indio_dev,
>  	mutex_lock(&chip->state_lock);
>  
>  	ret = regmap_read(chip->regmap, INA2XX_CONFIG, &config);
> -	if (ret < 0)
> -		goto _err;
> +	if (ret)
> +		goto err;
>  
>  	tmp = config;
>  
> @@ -310,19 +311,19 @@ static int ina2xx_write_raw(struct iio_dev *indio_dev,
>  		else
>  			ret = ina226_set_int_time_vbus(chip, val2, &tmp);
>  		break;
> +
>  	default:
>  		ret = -EINVAL;
>  	}
>  
>  	if (!ret && (tmp != config))
>  		ret = regmap_write(chip->regmap, INA2XX_CONFIG, tmp);
> -_err:
> +err:
>  	mutex_unlock(&chip->state_lock);
>  
>  	return ret;
>  }
>  
> -
>  static ssize_t ina2xx_allow_async_readout_show(struct device *dev,
>  					   struct device_attribute *attr,
>  					   char *buf)
> @@ -355,6 +356,7 @@ static int set_shunt_resistor(struct ina2xx_chip_info *chip, unsigned int val)
>  		return -EINVAL;
>  
>  	chip->shunt_resistor = val;
> +
>  	return 0;
>  }
>  
> @@ -500,7 +502,7 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
>  
>  static int ina2xx_capture_thread(void *data)
>  {
> -	struct iio_dev *indio_dev = (struct iio_dev *)data;
> +	struct iio_dev *indio_dev = data;
>  	struct ina2xx_chip_info *chip = iio_priv(indio_dev);
>  	unsigned int sampling_us = SAMPLING_PERIOD(chip);
>  	int buffer_us;
> @@ -575,8 +577,7 @@ static int ina2xx_debug_reg(struct iio_dev *indio_dev,
>  }
>  
>  /* Possible integration times for vshunt and vbus */
> -static IIO_CONST_ATTR_INT_TIME_AVAIL \
> - ("0.000140 0.000204 0.000332 0.000588 0.001100 0.002116 0.004156 0.008244");
> +static IIO_CONST_ATTR_INT_TIME_AVAIL("0.000140 0.000204 0.000332 0.000588 0.001100 0.002116 0.004156 0.008244");
>  
>  static IIO_DEVICE_ATTR(in_allow_async_readout, S_IRUGO | S_IWUSR,
>  		       ina2xx_allow_async_readout_show,
> @@ -598,21 +599,23 @@ static const struct attribute_group ina2xx_attribute_group = {
>  };
>  
>  static const struct iio_info ina2xx_info = {
> -	.debugfs_reg_access = &ina2xx_debug_reg,
> -	.read_raw = &ina2xx_read_raw,
> -	.write_raw = &ina2xx_write_raw,
> -	.attrs = &ina2xx_attribute_group,
>  	.driver_module = THIS_MODULE,
> +	.attrs = &ina2xx_attribute_group,
> +	.read_raw = ina2xx_read_raw,
> +	.write_raw = ina2xx_write_raw,
> +	.debugfs_reg_access = ina2xx_debug_reg,
>  };
>  
>  /* Initialize the configuration and calibration registers. */
>  static int ina2xx_init(struct ina2xx_chip_info *chip, unsigned int config)
>  {
>  	u16 regval;
> -	int ret = regmap_write(chip->regmap, INA2XX_CONFIG, config);
> +	int ret;
>  
> -	if (ret < 0)
> +	ret = regmap_write(chip->regmap, INA2XX_CONFIG, config);
> +	if (ret)
>  		return ret;
> +
>  	/*
>  	 * Set current LSB to 1mA, shunt is in uOhms
>  	 * (equation 13 in datasheet). We hardcode a Current_LSB
> @@ -621,7 +624,7 @@ static int ina2xx_init(struct ina2xx_chip_info *chip, unsigned int config)
>  	 * to the user for now.
>  	 */
>  	regval = DIV_ROUND_CLOSEST(chip->config->calibration_factor,
> -			    chip->shunt_resistor);
> +				   chip->shunt_resistor);
>  
>  	return regmap_write(chip->regmap, INA2XX_CALIBRATION, regval);
>  }
> @@ -632,8 +635,8 @@ static int ina2xx_probe(struct i2c_client *client,
>  	struct ina2xx_chip_info *chip;
>  	struct iio_dev *indio_dev;
>  	struct iio_buffer *buffer;
> -	int ret;
>  	unsigned int val;
> +	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
>  	if (!indio_dev)
> @@ -641,8 +644,19 @@ static int ina2xx_probe(struct i2c_client *client,
>  
>  	chip = iio_priv(indio_dev);
>  
> +	/* This is only used for device removal purposes. */
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	chip->regmap = devm_regmap_init_i2c(client, &ina2xx_regmap_config);
> +	if (IS_ERR(chip->regmap)) {
> +		dev_err(&client->dev, "failed to allocate register map\n");
> +		return PTR_ERR(chip->regmap);
> +	}
> +
>  	chip->config = &ina2xx_config[id->driver_data];
>  
> +	mutex_init(&chip->state_lock);
> +
>  	if (of_property_read_u32(client->dev.of_node,
>  				 "shunt-resistor", &val) < 0) {
>  		struct ina2xx_platform_data *pdata =
> @@ -658,25 +672,6 @@ static int ina2xx_probe(struct i2c_client *client,
>  	if (ret)
>  		return ret;
>  
> -	mutex_init(&chip->state_lock);
> -
> -	/* This is only used for device removal purposes. */
> -	i2c_set_clientdata(client, indio_dev);
> -
> -	indio_dev->name = id->name;
> -	indio_dev->channels = ina2xx_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(ina2xx_channels);
> -
> -	indio_dev->dev.parent = &client->dev;
> -	indio_dev->info = &ina2xx_info;
> -	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> -
> -	chip->regmap = devm_regmap_init_i2c(client, &ina2xx_regmap_config);
> -	if (IS_ERR(chip->regmap)) {
> -		dev_err(&client->dev, "failed to allocate register map\n");
> -		return PTR_ERR(chip->regmap);
> -	}
> -
>  	/* Patch the current config register with default. */
>  	val = chip->config->config_default;
>  
> @@ -687,24 +682,28 @@ static int ina2xx_probe(struct i2c_client *client,
>  	}
>  
>  	ret = ina2xx_init(chip, val);
> -	if (ret < 0) {
> -		dev_err(&client->dev, "error configuring the device: %d\n",
> -			ret);
> -		return -ENODEV;
> +	if (ret) {
> +		dev_err(&client->dev, "error configuring the device\n");
> +		return ret;
>  	}
>  
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->channels = ina2xx_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ina2xx_channels);
> +	indio_dev->name = id->name;
> +	indio_dev->info = &ina2xx_info;
> +	indio_dev->setup_ops = &ina2xx_setup_ops;
> +
>  	buffer = devm_iio_kfifo_allocate(&indio_dev->dev);
>  	if (!buffer)
>  		return -ENOMEM;
>  
> -	indio_dev->setup_ops = &ina2xx_setup_ops;
> -
>  	iio_device_attach_buffer(indio_dev, buffer);
>  
>  	return iio_device_register(indio_dev);
>  }
>  
> -
>  static int ina2xx_remove(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> @@ -717,7 +716,6 @@ static int ina2xx_remove(struct i2c_client *client)
>  				  INA2XX_MODE_MASK, 0);
>  }
>  
> -
>  static const struct i2c_device_id ina2xx_id[] = {
>  	{"ina219", ina219},
>  	{"ina220", ina219},
> @@ -726,7 +724,6 @@ static const struct i2c_device_id ina2xx_id[] = {
>  	{"ina231", ina226},
>  	{}
>  };
> -
>  MODULE_DEVICE_TABLE(i2c, ina2xx_id);
>  
>  static struct i2c_driver ina2xx_driver = {
> @@ -737,7 +734,6 @@ static struct i2c_driver ina2xx_driver = {
>  	.remove = ina2xx_remove,
>  	.id_table = ina2xx_id,
>  };
> -
>  module_i2c_driver(ina2xx_driver);
>  
>  MODULE_AUTHOR("Marc Titinger <marc.titinger@baylibre.com>");
> 

