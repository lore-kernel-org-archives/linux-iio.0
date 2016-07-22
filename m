Return-Path: <amsfield22@gmail.com>
Date: Fri, 22 Jul 2016 08:17:13 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: mranostay@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: humidity: hdc100x: add triggered buffer support
 for HDC100X
Message-ID: <20160722151712.GA5877@d830.WORKGROUP>
References: <20160722053133.GA27798@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160722053133.GA27798@d830.WORKGROUP>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Jul 21, 2016 at 10:31:46PM -0700, Alison Schofield wrote:
> Triggered buffer support uses the HDC100X's dual acquisition mode
> to read both humidity and temperature in one shot.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> ---

Reviewing myself, changes coming in v3
- don't need to do that overwrite in handler.
  .scan_index will be used to grab correct data from correct
   position in buffer.
- rm unused #define HDC100X_ALL_CHANNEL_MASK
- what else?

> Changes in v2:  
>  Thanks for the review Peter
>  - switched endianness from IIO_CPU to IIO_BE
>  - use only one buffer in the handler
>  - simplify selection of temp &/or humidity to push to buffer
> 
>  drivers/iio/humidity/Kconfig   |   2 +
>  drivers/iio/humidity/hdc100x.c | 135 +++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 131 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
> index 738a86d..4883ce1 100644
> --- a/drivers/iio/humidity/Kconfig
> +++ b/drivers/iio/humidity/Kconfig
> @@ -25,6 +25,8 @@ config DHT11
>  config HDC100X
>  	tristate "TI HDC100x relative humidity and temperature sensor"
>  	depends on I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	 Say yes here to build support for the TI HDC100x series of
>  	 relative humidity and temperature sensors.
> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> index a03832a..9f41bb5 100644
> --- a/drivers/iio/humidity/hdc100x.c
> +++ b/drivers/iio/humidity/hdc100x.c
> @@ -22,13 +22,19 @@
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  
>  #define HDC100X_REG_TEMP			0x00
>  #define HDC100X_REG_HUMIDITY			0x01
>  
>  #define HDC100X_REG_CONFIG			0x02
> +#define HDC100X_REG_CONFIG_ACQ_MODE		BIT(12)
>  #define HDC100X_REG_CONFIG_HEATER_EN		BIT(13)
>  
> +#define HDC100X_ALL_CHANNEL_MASK		GENMASK(1, 0)
> +
>  struct hdc100x_data {
>  	struct i2c_client *client;
>  	struct mutex lock;
> @@ -87,20 +93,36 @@ static const struct iio_chan_spec hdc100x_channels[] = {
>  			BIT(IIO_CHAN_INFO_SCALE) |
>  			BIT(IIO_CHAN_INFO_INT_TIME) |
>  			BIT(IIO_CHAN_INFO_OFFSET),
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_BE,
> +		},
>  	},
>  	{
>  		.type = IIO_HUMIDITYRELATIVE,
>  		.address = HDC100X_REG_HUMIDITY,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  			BIT(IIO_CHAN_INFO_SCALE) |
> -			BIT(IIO_CHAN_INFO_INT_TIME)
> +			BIT(IIO_CHAN_INFO_INT_TIME),
> +		.scan_index = 1,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_BE,
> +		},
>  	},
>  	{
>  		.type = IIO_CURRENT,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  		.extend_name = "heater",
>  		.output = 1,
> +		.scan_index = -1,
>  	},
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
>  
>  static int hdc100x_update_config(struct hdc100x_data *data, int mask, int val)
> @@ -191,18 +213,21 @@ static int hdc100x_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_RAW: {
>  		int ret;
>  
> -		mutex_lock(&data->lock);
>  		if (chan->type == IIO_CURRENT) {
>  			*val = hdc100x_get_heater_status(data);
>  			ret = IIO_VAL_INT;
>  		} else {
> +			ret = iio_device_claim_direct_mode(indio_dev);
> +			if (ret)
> +				return ret;
> +
>  			ret = hdc100x_get_measurement(data, chan);
> +			iio_device_release_direct_mode(indio_dev);
>  			if (ret >= 0) {
>  				*val = ret;
>  				ret = IIO_VAL_INT;
>  			}
>  		}
> -		mutex_unlock(&data->lock);
>  		return ret;
>  	}
>  	case IIO_CHAN_INFO_INT_TIME:
> @@ -259,6 +284,80 @@ static int hdc100x_write_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int hdc100x_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct hdc100x_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	/* Buffer is enabled. First set ACQ Mode, then attach poll func */
> +	mutex_lock(&data->lock);
> +	ret = hdc100x_update_config(data, HDC100X_REG_CONFIG_ACQ_MODE,
> +				    HDC100X_REG_CONFIG_ACQ_MODE);
> +	mutex_unlock(&data->lock);
> +	if (ret)
> +		return ret;
> +
> +	return iio_triggered_buffer_postenable(indio_dev);
> +}
> +
> +static int hdc100x_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct hdc100x_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	/* First detach poll func, then reset ACQ mode. OK to disable buffer */
> +	ret = iio_triggered_buffer_predisable(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&data->lock);
> +	ret = hdc100x_update_config(data, HDC100X_REG_CONFIG_ACQ_MODE, 0);
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
> +static const struct iio_buffer_setup_ops hdc_buffer_setup_ops = {
> +	.preenable   = NULL,
> +	.postenable  = hdc100x_buffer_postenable,
> +	.predisable  = hdc100x_buffer_predisable,
> +	.postdisable = NULL,
> +};
> +
> +static irqreturn_t hdc100x_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct hdc100x_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	int delay = data->adc_int_us[0] + data->adc_int_us[1];
> +	int ret;
> +	s16 buf[8];  /* 2x s16 + padding + 8 byte timestamp */
> +
> +	/* dual read starts at temp register */
> +	ret = i2c_smbus_write_byte(client, HDC100X_REG_TEMP);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "cannot start measurement\n");
> +		goto err;
> +	}
> +	usleep_range(delay, delay + 1000);
> +
> +	ret = i2c_master_recv(client, (u8 *)buf, 4);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "cannot read sensor data\n");
> +		goto err;
> +	}
> +	/* overwrite unwanted temp data with humid data */
> +	if (!test_bit(0, indio_dev->active_scan_mask))
> +		buf[0] = buf[1];
don't need to do this. humid data will be plucked from it's position
defined in .scan_index.

> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, buf,
> +					   iio_get_time_ns(indio_dev));
> +err:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static const struct iio_info hdc100x_info = {
>  	.read_raw = hdc100x_read_raw,
>  	.write_raw = hdc100x_write_raw,
> @@ -271,9 +370,10 @@ static int hdc100x_probe(struct i2c_client *client,
>  {
>  	struct iio_dev *indio_dev;
>  	struct hdc100x_data *data;
> +	int ret;
>  
> -	if (!i2c_check_functionality(client->adapter,
> -				I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_BYTE))
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA |
> +				     I2C_FUNC_SMBUS_BYTE | I2C_FUNC_I2C))
>  		return -EOPNOTSUPP;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> @@ -296,8 +396,30 @@ static int hdc100x_probe(struct i2c_client *client,
>  	/* be sure we are in a known state */
>  	hdc100x_set_it_time(data, 0, hdc100x_int_time[0][0]);
>  	hdc100x_set_it_time(data, 1, hdc100x_int_time[1][0]);
> +	hdc100x_update_config(data, HDC100X_REG_CONFIG_ACQ_MODE, 0);
> +
> +	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> +					 hdc100x_trigger_handler,
> +					 &hdc_buffer_setup_ops);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "iio triggered buffer setup failed\n");
> +		return ret;
> +	}
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0)
> +		iio_triggered_buffer_cleanup(indio_dev);
> +
> +	return ret;
> +}
> +
> +static int hdc100x_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +	iio_device_unregister(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
>  
> -	return devm_iio_device_register(&client->dev, indio_dev);
> +	return 0;
>  }
>  
>  static const struct i2c_device_id hdc100x_id[] = {
> @@ -311,6 +433,7 @@ static struct i2c_driver hdc100x_driver = {
>  		.name	= "hdc100x",
>  	},
>  	.probe = hdc100x_probe,
> +	.remove = hdc100x_remove,
>  	.id_table = hdc100x_id,
>  };
>  module_i2c_driver(hdc100x_driver);
> -- 
> 2.1.4
> 
