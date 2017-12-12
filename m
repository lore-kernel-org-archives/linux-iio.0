Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751813AbdLLUua (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 12 Dec 2017 15:50:30 -0500
Date: Tue, 12 Dec 2017 20:50:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Crt Mori <cmo@melexis.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: temperature: Adding support for MLX90632
Message-ID: <20171212205026.5cb3203f@archlinux>
In-Reply-To: <20171211091931.8575-1-cmo@melexis.com>
References: <20171211091931.8575-1-cmo@melexis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 11 Dec 2017 10:19:31 +0100
Crt Mori <cmo@melexis.com> wrote:

> Melexis has just released Infra Red temperature sensor MLX90632 used
> for contact-less temperature measurement. Driver provides basic
> functionality for reporting object (and ambient) temperature with
> support for object emissivity.
> 
> Signed-off-by: Crt Mori <cmo@melexis.com>

Out of curiosity, how are you testing runtime pm?  Normally I'd expect
this driver to be deliberately putting the hardware to sleep but it
isn't doing so that I can see.

A few minor comments inline.

Jonathan

> ---
>  MAINTAINERS                        |   7 +
>  drivers/iio/temperature/Kconfig    |  12 +
>  drivers/iio/temperature/Makefile   |   1 +
>  drivers/iio/temperature/mlx90632.c | 774 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 794 insertions(+)
>  create mode 100644 drivers/iio/temperature/mlx90632.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2d3d750b19c0..81aec02b08b8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8690,6 +8690,13 @@ W:	http://www.melexis.com
>  S:	Supported
>  F:	drivers/iio/temperature/mlx90614.c
>  
> +MELEXIS MLX90632 DRIVER
> +M:	Crt Mori <cmo@melexis.com>
> +L:	linux-iio@vger.kernel.org
> +W:	http://www.melexis.com
> +S:	Supported
> +F:	drivers/iio/temperature/mlx90632.c
> +
>  MELFAS MIP4 TOUCHSCREEN DRIVER
>  M:	Sangwon Jee <jeesw@melfas.com>
>  W:	http://www.melfas.com
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> index 5378976d6d27..82e4a62745e2 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -43,6 +43,18 @@ config MLX90614
>  	  This driver can also be built as a module. If so, the module will
>  	  be called mlx90614.
>  
> +config MLX90632
> +	tristate "MLX90632 contact-less infrared sensor with medical accuracy"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  If you say yes here you get support for the Melexis
> +	  MLX90632 contact-less infrared sensor with medical accuracy
> +	  connected with I2C.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called mlx90632.
> +
<snip>

> +static int mlx90632_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	struct iio_dev *indio_dev;
> +	struct mlx90632_data *mlx90632;
> +	struct regmap *regmap;
> +	int ret;
> +	unsigned int read;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*mlx90632));
> +	if (!indio_dev) {
> +		dev_err(&client->dev, "Failed to allocate device");
> +		return -ENOMEM;
> +	}
> +
> +	regmap = devm_regmap_init_i2c(client, &mlx90632_regmap);
> +	if (IS_ERR(regmap)) {
> +		ret = PTR_ERR(regmap);
> +		dev_err(&client->dev, "Failed to allocate regmap: %d\n", ret);
> +		return ret;
> +	}
> +
> +	mlx90632 = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	mlx90632->client = client;
> +	mlx90632->regmap = regmap;
> +
> +	mutex_init(&mlx90632->lock);
> +	mlx90632_wakeup(mlx90632);
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = id->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &mlx90632_info;
> +	indio_dev->channels = mlx90632_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(mlx90632_channels);
> +
> +	ret = regmap_read(mlx90632->regmap, MLX90632_EE_VERSION, &read);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "read of version failed: %d\n", ret);
> +		return ret;
> +	}
> +	if (read == MLX90632_ID_MEDICAL) {
> +		dev_dbg(&client->dev,
> +			"Detected Medical EEPROM calibration %x", read);
> +	} else if (read == MLX90632_ID_CONSUMER) {
> +		dev_dbg(&client->dev,
> +			"Detected Consumer EEPROM calibration %x", read);
> +	} else {
> +		dev_err(&client->dev,
> +			"Chip EEPROM version mismatch %x (expected %x or %x)",
> +			read, MLX90632_ID_CONSUMER, MLX90632_ID_MEDICAL);
> +		return -EPROTONOSUPPORT;
> +	}
> +
> +	mlx90632->emissivity = 1000;
> +
> +	return iio_device_register(indio_dev);
> +}
> +
> +static int mlx90632_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct mlx90632_data *data = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	pm_runtime_disable(&client->dev);
> +	if (!pm_runtime_status_suspended(&client->dev))
> +		mlx90632_sleep(data);
> +	pm_runtime_set_suspended(&client->dev);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id mlx90632_id[] = {
> +	{ "mlx90632", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, mlx90632_id);
> +
> +static const struct of_device_id mlx90632_of_match[] = {
> +	{ .compatible = "melexis,mlx90632" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mlx90632_of_match);
> +
> +static int __maybe_unused mlx90632_pm_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct mlx90632_data *data = iio_priv(indio_dev);
> +
> +	regcache_sync(data->regmap);

This could be syncing to a runtime sleeping device.  Also not
needed as the cache should be right anyway I think.

> +
> +	if (pm_runtime_active(dev))
> +		return mlx90632_sleep(data);

This prevents the device from sleeping twice, but nothing
stops it from coming up in resume if it was already in runtime pm.

> +
> +	return 0;
> +}
> +
> +static int __maybe_unused mlx90632_pm_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct mlx90632_data *data = iio_priv(indio_dev);
> +	int err;
> +
> +	regcache_mark_dirty(data->regmap);
> +	regcache_cache_only(data->regmap, false);
> +	err = regcache_sync(data->regmap);
> +	if (err < 0) {
> +		dev_err(dev, "Failed to sync regmap registers: %d\n", err);
> +		return err;
> +	}
> +
> +	err = mlx90632_wakeup(data);
> +	if (err < 0)
> +		return err;
> +
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused mlx90632_pm_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct mlx90632_data *mlx90632 = iio_priv(indio_dev);
> +
> +	regcache_sync(mlx90632->regmap);

Why sync here?  The cache should be in sync already.

> +
> +	return mlx90632_sleep(mlx90632);
> +}
> +
> +static int __maybe_unused mlx90632_pm_runtime_resume(struct device *dev)
> +{
> +	s32 ret;
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct mlx90632_data *mlx90632 = iio_priv(indio_dev);
> +
> +	regcache_mark_dirty(mlx90632->regmap);

Technically it doesn't matter much, but I think the convention is to
normally mark the cache dirty when it becomes possible for it to be dirty
- that is during suspend.

> +	regcache_cache_only(mlx90632->regmap, false);
> +	ret = regcache_sync(mlx90632->regmap);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to sync regmap registers: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return mlx90632_wakeup(mlx90632);

This doesn't look quite right.  What if the device was in runtime suspend
before full suspend?  Would expect it to return to that state on resume
but not runtime_resume.

> +}
> +
> +static const struct dev_pm_ops mlx90632_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(mlx90632_pm_suspend, mlx90632_pm_resume)
> +	SET_RUNTIME_PM_OPS(mlx90632_pm_runtime_suspend,
> +			   mlx90632_pm_runtime_resume, NULL)
> +};
> +
> +static struct i2c_driver mlx90632_driver = {
> +	.driver = {
> +		.name	= "mlx90632",
> +		.of_match_table = mlx90632_of_match,
> +		.pm	= &mlx90632_pm_ops,
> +	},
> +	.probe = mlx90632_probe,
> +	.remove = mlx90632_remove,
> +	.id_table = mlx90632_id,
> +};
> +module_i2c_driver(mlx90632_driver);
> +
> +MODULE_AUTHOR("Crt Mori <cmo@melexis.com>");
> +MODULE_DESCRIPTION("Melexis MLX90632 contactless Infra Red temperature sensor driver");
> +MODULE_LICENSE("GPL v2");

