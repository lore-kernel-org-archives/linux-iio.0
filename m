Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44379 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbbCIPjh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2015 11:39:37 -0400
Message-ID: <54FDBEB7.8030403@kernel.org>
Date: Mon, 09 Mar 2015 15:39:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: =?UTF-8?B?Vmlhbm5leSBsZSBDbMOpbWVudCBkZSBTYWludC1NYXJjcQ==?=
	<vianney.leclement@essensium.com>, linux-iio@vger.kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>, devicetree@vger.kernel.org
CC: "Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>,
	Linux I2C <linux-i2c@vger.kernel.org>,
	Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 6/7] iio: mlx90614: Add power management
References: <1424879712-28304-1-git-send-email-vianney.leclement@essensium.com> <1424879712-28304-7-git-send-email-vianney.leclement@essensium.com>
In-Reply-To: <1424879712-28304-7-git-send-email-vianney.leclement@essensium.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/02/15 15:55, Vianney le Clément de Saint-Marcq wrote:
> Add support for system sleep and runtime power management.
> 
> To wake up the device, the SDA line should be held low for at least 33ms
> while SCL is high.  As this is not possible using the i2c API (and not
> supported by all i2c adapters), a GPIO connected to the SDA line is
> needed.  The GPIO is named "wakeup" and can be specified in a device
> tree with the "wakeup-gpios" binding.
Needs some i2c specialist input on this!  As you mentioned it is liable
to be controversial.  Wolfram, is this a one off special or do
any other devices do this sort of magic?
> 
> If the wake-up GPIO is not given, disable power management for the
> device.  Entering sleep requires an SMBus byte access, hence power
> management is also disabled if byte access is not supported by the
> adapter.
> 
> Signed-off-by: Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
> Cc: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>
> 
> ---
> 
> The default autosleep delay (5s) is chosen arbitrarily, trying to take
> into account the long startup time (250ms).  Feel free to change it to
> another value if you think it is saner.
> ---
>  .../bindings/iio/temperature/mlx90614.txt          |  24 ++
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  drivers/iio/temperature/mlx90614.c                 | 244 ++++++++++++++++++++-
>  3 files changed, 267 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/mlx90614.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt b/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt
> new file mode 100644
> index 0000000..9be57b0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt
> @@ -0,0 +1,24 @@
> +* Melexis MLX90614 contactless IR temperature sensor
> +
> +http://melexis.com/Infrared-Thermometer-Sensors/Infrared-Thermometer-Sensors/MLX90614-615.aspx
> +
> +Required properties:
> +
> +  - compatible: should be "melexis,mlx90614"
> +  - reg: the I2C address of the sensor
> +
> +Optional properties:
> +
> +  - wakeup-gpios: device tree identifier of the GPIO connected to the SDA line
> +      to hold low in order to wake up the device.  In normal operation, the
> +      GPIO is set as input and will not interfere in I2C communication.  There
> +      is no need for a GPIO driving the SCL line.  If no GPIO is given, power
> +      management is disabled.
> +
> +Example:
> +
> +mlx90614@5a {
> +	compatible = "melexis,mlx90614";
> +	reg = <0x5a>;
> +	wakeup-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
> +};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 389ca13..ceacc40 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -108,6 +108,7 @@ lltc	Linear Technology Corporation
>  marvell	Marvell Technology Group Ltd.
>  maxim	Maxim Integrated Products
>  mediatek	MediaTek Inc.
> +melexis	Melexis N.V.
>  merrii	Merrii Technology Co., Ltd.
>  micrel	Micrel Inc.
>  microchip	Microchip Technology Inc.
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> index ab98fb6..49c517a 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -12,13 +12,22 @@
>   *
>   * (7-bit I2C slave address 0x5a, 100KHz bus speed only!)
>   *
> - * TODO: sleep mode
> + * To wake up from sleep mode, the SDA line must be held low while SCL is high
> + * for at least 33ms.  This is achieved with an extra GPIO that can be connected
> + * directly to the SDA line.  In normal operation, the GPIO is set as input and
> + * will not interfere in I2C communication.  While the GPIO is driven low, the
> + * i2c adapter is locked since it cannot be used by other clients.  The SCL line
> + * always has a pull-up so we do not need an extra GPIO to drive it high.  If
> + * the "wakeup" GPIO is not given, power management will be disabled.
>   */
>  
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/delay.h>
> +#include <linux/jiffies.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/pm_runtime.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -53,9 +62,13 @@
>  #define MLX90614_TIMING_WAKEUP 34 /* time to hold SDA low for wake-up */
>  #define MLX90614_TIMING_STARTUP 250 /* time before first data after wake-up */
>  
> +#define MLX90614_AUTOSLEEP_DELAY 5000 /* default autosleep delay */
> +
>  struct mlx90614_data {
>  	struct i2c_client *client;
>  	struct mutex lock; /* for EEPROM access only */
> +	struct gpio_desc *wakeup_gpio; /* NULL to disable sleep/wake-up */
> +	unsigned long ready_timestamp; /* in jiffies */
>  };
>  
>  /*
> @@ -96,6 +109,52 @@ static s32 mlx90614_write_word(const struct i2c_client *client, u8 command,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_PM
> +/*
> + * If @startup is true, make sure MLX90614_TIMING_STARTUP ms have elapsed since
> + * the last wake-up.  This is normally only needed to get a valid temperature
> + * reading.  EEPROM access does not need such delay.
> + */
> +static void mlx90614_power_get(struct mlx90614_data *data, bool startup)
> +{
> +	unsigned long now;
> +
> +	if (!data->wakeup_gpio)
> +		return;
> +
> +	pm_runtime_get_sync(&data->client->dev);
> +
> +	if (startup) {
> +		/*
> +		 * If the process requesting the temperature gets killed when
> +		 * waiting here, it does not matter whether the reading is
> +		 * valid.  Hence, the sleep is interruptible.
> +		 */
> +		now = jiffies;
> +		if (time_before(now, data->ready_timestamp))
> +			msleep_interruptible(jiffies_to_msecs(
> +						data->ready_timestamp - now));
> +	}
> +}
> +
> +static void mlx90614_power_put(struct mlx90614_data *data)
> +{
> +	if (!data->wakeup_gpio)
> +		return;
> +
> +	pm_runtime_mark_last_busy(&data->client->dev);
> +	pm_runtime_put_autosuspend(&data->client->dev);
> +}
> +#else
> +static inline void mlx90614_power_get(struct mlx90614_data *data, bool startup)
> +{
> +}
> +
> +static inline void mlx90614_power_put(struct mlx90614_data *data)
> +{
> +}
> +#endif
> +
>  static int mlx90614_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *channel, int *val,
>  			    int *val2, long mask)
> @@ -127,7 +186,10 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  		}
>  
> +		mlx90614_power_get(data, true);
>  		ret = i2c_smbus_read_word_data(data->client, cmd);
> +		mlx90614_power_put(data);
> +
>  		if (ret < 0)
>  			return ret;
>  
> @@ -160,9 +222,11 @@ static ssize_t mlx90614_show_emissivity(struct device *dev,
>  	struct mlx90614_data *data = iio_priv(indio_dev);
>  	s32 ret;
>  
> +	mlx90614_power_get(data, false);
>  	mutex_lock(&data->lock);
>  	ret = i2c_smbus_read_word_data(data->client, MLX90614_EMISSIVITY);
>  	mutex_unlock(&data->lock);
> +	mlx90614_power_put(data);
>  
>  	if (ret < 0)
>  		return ret;
> @@ -182,9 +246,11 @@ static ssize_t mlx90614_store_emissivity(struct device *dev,
>  	if (kstrtou16(buf, 0, &val))
>  		return -EINVAL;
>  
> +	mlx90614_power_get(data, false);
>  	mutex_lock(&data->lock);
>  	ret = mlx90614_write_word(data->client, MLX90614_EMISSIVITY, val);
>  	mutex_unlock(&data->lock);
> +	mlx90614_power_put(data);
>  
>  	if (ret < 0)
>  		return ret;
> @@ -203,9 +269,11 @@ static ssize_t mlx90614_show_config(struct device *dev,
>  	u16 shift = indio_attr->address >> 16;
>  	s32 ret;
>  
> +	mlx90614_power_get(data, false);
>  	mutex_lock(&data->lock);
>  	ret = i2c_smbus_read_word_data(data->client, MLX90614_CONFIG);
>  	mutex_unlock(&data->lock);
> +	mlx90614_power_put(data);
>  
>  	if (ret < 0)
>  		return ret;
> @@ -230,6 +298,7 @@ static ssize_t mlx90614_store_config(struct device *dev,
>  	if (kstrtou16(buf, 0, &val) || val != (val & (mask >> shift)))
>  		return -EINVAL;
>  
> +	mlx90614_power_get(data, false);
>  	mutex_lock(&data->lock);
>  
>  	ret = i2c_smbus_read_word_data(data->client, MLX90614_CONFIG);
> @@ -241,6 +310,7 @@ static ssize_t mlx90614_store_config(struct device *dev,
>  
>  out:
>  	mutex_unlock(&data->lock);
> +	mlx90614_power_put(data);
>  
>  	if (ret < 0)
>  		return ret;
> @@ -320,6 +390,98 @@ static const struct iio_info mlx90614_info = {
>  	.driver_module = THIS_MODULE,
>  };
>  
> +#ifdef CONFIG_PM
> +static int mlx90614_sleep(struct mlx90614_data *data)
> +{
> +	s32 ret;
> +
> +	if (!data->wakeup_gpio) {
> +		dev_dbg(&data->client->dev, "Sleep disabled");
> +		return -ENOSYS;
> +	}
> +
> +	dev_dbg(&data->client->dev, "Requesting sleep");
> +
> +	mutex_lock(&data->lock);
> +	ret = i2c_smbus_xfer(data->client->adapter, data->client->addr,
> +			     data->client->flags | I2C_CLIENT_PEC,
> +			     I2C_SMBUS_WRITE, MLX90614_OP_SLEEP,
> +			     I2C_SMBUS_BYTE, NULL);
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
> +
> +static int mlx90614_wakeup(struct mlx90614_data *data)
> +{
> +	if (!data->wakeup_gpio) {
> +		dev_dbg(&data->client->dev, "Wake-up disabled");
> +		return -ENOSYS;
> +	}
> +
> +	dev_dbg(&data->client->dev, "Requesting wake-up");
> +
> +	i2c_lock_adapter(data->client->adapter);
> +	gpiod_direction_output(data->wakeup_gpio, 0);
> +	msleep(MLX90614_TIMING_WAKEUP);
> +	gpiod_direction_input(data->wakeup_gpio);
> +	i2c_unlock_adapter(data->client->adapter);
> +
> +	data->ready_timestamp = jiffies +
> +			msecs_to_jiffies(MLX90614_TIMING_STARTUP);
> +
> +	/*
> +	 * Quirk: the i2c controller may get confused right after the
> +	 * wake-up signal has been sent.  As a workaround, do a dummy read.
> +	 * If the read fails, the controller will probably be reset so that
> +	 * further reads will work.
> +	 */
> +	i2c_smbus_read_word_data(data->client, MLX90614_CONFIG);
> +
> +	return 0;
> +}
> +
> +/* Return wake-up GPIO or NULL if sleep functionality should be disabled. */
> +static struct gpio_desc *mlx90614_probe_wakeup(struct i2c_client *client)
> +{
> +	struct gpio_desc *gpio;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +						I2C_FUNC_SMBUS_WRITE_BYTE)) {
> +		dev_info(&client->dev,
> +			 "i2c adapter does not support SMBUS_WRITE_BYTE, sleep disabled");
> +		return NULL;
> +	}
> +
> +	gpio = devm_gpiod_get_optional(&client->dev, "wakeup", GPIOD_IN);
> +
> +	if (IS_ERR(gpio)) {
> +		dev_warn(&client->dev,
> +			 "gpio acquisition failed with error %ld, sleep disabled",
> +			 PTR_ERR(gpio));
> +		return NULL;
> +	} else if (!gpio) {
> +		dev_info(&client->dev,
> +			 "wakeup-gpio not found, sleep disabled");
> +	}
> +
> +	return gpio;
> +}
> +#else
> +static inline int mlx90614_sleep(struct mlx90614_data *data)
> +{
> +	return -ENOSYS;
> +}
> +static inline int mlx90614_wakeup(struct mlx90614_data *data)
> +{
> +	return -ENOSYS;
> +}
> +static inline struct gpio_desc *mlx90614_probe_wakeup(struct i2c_client *client)
> +{
> +	return NULL;
> +}
> +#endif
> +
>  /* Return 0 for single sensor, 1 for dual sensor, <0 on error. */
>  static int mlx90614_probe_model(struct i2c_client *client)
>  {
> @@ -351,6 +513,9 @@ static int mlx90614_probe(struct i2c_client *client,
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
>  	mutex_init(&data->lock);
> +	data->wakeup_gpio = mlx90614_probe_wakeup(client);
> +
> +	mlx90614_wakeup(data);
>  
>  	indio_dev->dev.parent = &client->dev;
>  	indio_dev->name = id->name;
> @@ -373,12 +538,30 @@ static int mlx90614_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> +	if (data->wakeup_gpio) {
> +		pm_runtime_set_autosuspend_delay(&client->dev,
> +						 MLX90614_AUTOSLEEP_DELAY);
> +		pm_runtime_use_autosuspend(&client->dev);
> +		pm_runtime_set_active(&client->dev);
> +		pm_runtime_enable(&client->dev);
> +	}
> +
>  	return iio_device_register(indio_dev);
>  }
>  
>  static int mlx90614_remove(struct i2c_client *client)
>  {
> -	iio_device_unregister(i2c_get_clientdata(client));
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct mlx90614_data *data = iio_priv(indio_dev);
> +
> +	if (data->wakeup_gpio) {
> +		pm_runtime_disable(&client->dev);
> +		if (!pm_runtime_status_suspended(&client->dev))
> +			mlx90614_sleep(data);
> +		pm_runtime_set_suspended(&client->dev);
> +	}
> +
> +	iio_device_unregister(indio_dev);
>  
>  	return 0;
>  }
> @@ -389,10 +572,67 @@ static const struct i2c_device_id mlx90614_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, mlx90614_id);
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int mlx90614_pm_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct mlx90614_data *data = iio_priv(indio_dev);
> +
> +	if (data->wakeup_gpio && pm_runtime_active(dev))
> +		return mlx90614_sleep(data);
> +
> +	return 0;
> +}
> +
> +static int mlx90614_pm_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct mlx90614_data *data = iio_priv(indio_dev);
> +	int err;
> +
> +	if (data->wakeup_gpio) {
> +		err = mlx90614_wakeup(data);
> +		if (err < 0)
> +			return err;
> +
> +		pm_runtime_disable(dev);
> +		pm_runtime_set_active(dev);
> +		pm_runtime_enable(dev);
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
> +#ifdef CONFIG_PM
> +static int mlx90614_pm_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct mlx90614_data *data = iio_priv(indio_dev);
> +
> +	return mlx90614_sleep(data);
> +}
> +
> +static int mlx90614_pm_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct mlx90614_data *data = iio_priv(indio_dev);
> +
> +	return mlx90614_wakeup(data);
> +}
> +#endif
> +
> +static const struct dev_pm_ops mlx90614_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(mlx90614_pm_suspend, mlx90614_pm_resume)
> +	SET_RUNTIME_PM_OPS(mlx90614_pm_runtime_suspend,
> +			   mlx90614_pm_runtime_resume, NULL)
> +};
> +
>  static struct i2c_driver mlx90614_driver = {
>  	.driver = {
>  		.name	= "mlx90614",
>  		.owner	= THIS_MODULE,
> +		.pm	= &mlx90614_pm_ops,
>  	},
>  	.probe = mlx90614_probe,
>  	.remove = mlx90614_remove,
> 

