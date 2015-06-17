Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:47204 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753116AbbFQNlj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 17 Jun 2015 09:41:39 -0400
Date: Wed, 17 Jun 2015 15:41:37 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Tiberiu Breana <tiberiu.a.breana@intel.com>
cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: accel: Add trigger support for STK8BA50
In-Reply-To: <1434545412-16871-2-git-send-email-tiberiu.a.breana@intel.com>
Message-ID: <alpine.DEB.2.02.1506171529380.2489@pmeerw.net>
References: <1434545412-16871-1-git-send-email-tiberiu.a.breana@intel.com> <1434545412-16871-2-git-send-email-tiberiu.a.breana@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> Add data-ready interrupts and trigger support for STK8BA50.
> 
> Additional changes:
> - read_accel now returns raw acceleration data instead of the
>   sign_extend32 value
> - read_raw will now enable/disable the sensor with each reading

comments below

> Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
> ---
>  drivers/iio/accel/stk8ba50.c | 281 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 256 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
> index 9836880..dd4f0da 100644
> --- a/drivers/iio/accel/stk8ba50.c
> +++ b/drivers/iio/accel/stk8ba50.c
> @@ -11,11 +11,17 @@
>   */
>  
>  #include <linux/acpi.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
> +#include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
>  
>  #define STK8BA50_REG_XOUT			0x02
>  #define STK8BA50_REG_YOUT			0x04
> @@ -24,6 +30,8 @@
>  #define STK8BA50_REG_BWSEL			0x10
>  #define STK8BA50_REG_POWMODE			0x11
>  #define STK8BA50_REG_SWRST			0x14
> +#define STK8BA50_REG_INTEN2			0x17
> +#define STK8BA50_REG_INTMAP2			0x1A
>  
>  #define STK8BA50_MODE_NORMAL			0
>  #define STK8BA50_MODE_SUSPEND			1
> @@ -31,8 +39,12 @@
>  #define STK8BA50_DATA_SHIFT			6
>  #define STK8BA50_RESET_CMD			0xB6
>  #define STK8BA50_SR_1792HZ_IDX			7
> +#define STK8BA50_DREADY_INT_MASK		0x10
> +#define STK8BA50_DREADY_INT_MAP			0x81
>  
>  #define STK8BA50_DRIVER_NAME			"stk8ba50"
> +#define STK8BA50_GPIO				"stk8ba50_gpio"
> +#define STK8BA50_IRQ_NAME			"stk8ba50_event"
>  
>  #define STK8BA50_SCALE_AVAIL			"0.0384 0.0767 0.1534 0.3069"
>  
> @@ -73,9 +85,17 @@ struct stk8ba50_data {
>  	struct mutex lock;
>  	int range;
>  	u8 sample_rate_idx;
> +	struct iio_trigger *dready_trig;
> +	bool dready_trigger_on;
> +	/*
> +	 * 3 x 16-bit channels (10-bit data, 6-bit padding) +
> +	 * 1 x 16 padding +
> +	 * 4 x 16 64-bit timestamp
> +	 */
> +	s16 buffer[8];
>  };
>  
> -#define STK8BA50_ACCEL_CHANNEL(reg, axis) {				\
> +#define STK8BA50_ACCEL_CHANNEL(index, reg, axis) {			\
>  	.type = IIO_ACCEL,						\
>  	.address = reg,							\
>  	.modified = 1,							\
> @@ -83,12 +103,20 @@ struct stk8ba50_data {
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
>  				    BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.scan_index = index,						\
> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.realbits = 10,						\
> +		.storagebits = 16,					\

there is a .shift field which might be useful!

> +		.endianness = IIO_CPU,					\
> +	},								\
>  }
>  
>  static const struct iio_chan_spec stk8ba50_channels[] = {
> -	STK8BA50_ACCEL_CHANNEL(STK8BA50_REG_XOUT, X),
> -	STK8BA50_ACCEL_CHANNEL(STK8BA50_REG_YOUT, Y),
> -	STK8BA50_ACCEL_CHANNEL(STK8BA50_REG_ZOUT, Z),
> +	STK8BA50_ACCEL_CHANNEL(0, STK8BA50_REG_XOUT, X),
> +	STK8BA50_ACCEL_CHANNEL(1, STK8BA50_REG_YOUT, Y),
> +	STK8BA50_ACCEL_CHANNEL(2, STK8BA50_REG_ZOUT, Z),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
>  
>  static IIO_CONST_ATTR(in_accel_scale_available, STK8BA50_SCALE_AVAIL);
> @@ -116,7 +144,61 @@ static int stk8ba50_read_accel(struct stk8ba50_data *data, u8 reg)
>  		return ret;
>  	}
>  
> -	return sign_extend32(ret >> STK8BA50_DATA_SHIFT, 9);
> +	return ret >> STK8BA50_DATA_SHIFT;

I think this should be done in _read_raw() only, not here;
this allows to use _read_accel() in the trigger handler without 
manipulating the data (+ using .shift)

> +}
> +
> +static int stk8ba50_data_rdy_trigger_set_state(struct iio_trigger *trig,
> +					       bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct stk8ba50_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (state)
> +		ret = i2c_smbus_write_byte_data(data->client,
> +			STK8BA50_REG_INTEN2, STK8BA50_DREADY_INT_MASK);
> +	else
> +		ret = i2c_smbus_write_byte_data(data->client,
> +			STK8BA50_REG_INTEN2, 0x00);
> +
> +	if (ret < 0)
> +		dev_err(&data->client->dev, "failed to set trigger state\n");
> +	else
> +		data->dready_trigger_on = state;
> +
> +	return ret;
> +}
> +
> +static const struct iio_trigger_ops stk8ba50_trigger_ops = {
> +	.set_trigger_state = stk8ba50_data_rdy_trigger_set_state,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int stk8ba50_set_power(struct stk8ba50_data *data, bool mode)
> +{
> +	int ret;
> +	u8 masked_reg;
> +	struct i2c_client *client = data->client;
> +
> +	ret = i2c_smbus_read_byte_data(client, STK8BA50_REG_POWMODE);
> +	if (ret < 0)
> +		goto exit_err;
> +
> +	if (mode)
> +		masked_reg = ret | STK8BA50_MODE_POWERBIT;
> +	else
> +		masked_reg = ret & (~STK8BA50_MODE_POWERBIT);
> +
> +	ret = i2c_smbus_write_byte_data(client, STK8BA50_REG_POWMODE,
> +					masked_reg);
> +	if (ret < 0)
> +		goto exit_err;
> +
> +	return ret;
> +
> +exit_err:
> +	dev_err(&client->dev, "failed to change sensor mode\n");
> +	return ret;
>  }
>  
>  static int stk8ba50_read_raw(struct iio_dev *indio_dev,
> @@ -124,11 +206,26 @@ static int stk8ba50_read_raw(struct iio_dev *indio_dev,
>  			     int *val, int *val2, long mask)
>  {
>  	struct stk8ba50_data *data = iio_priv(indio_dev);
> +	int ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> +		if (iio_buffer_enabled(indio_dev))
> +			return -EBUSY;
>  		mutex_lock(&data->lock);
> -		*val = stk8ba50_read_accel(data, chan->address);
> +		ret = stk8ba50_set_power(data, STK8BA50_MODE_NORMAL);
> +		if (ret < 0) {
> +			mutex_unlock(&data->lock);
> +			return -EINVAL;
> +		}
> +		ret = stk8ba50_read_accel(data, chan->address);
> +		if (ret < 0) {
> +			stk8ba50_set_power(data, STK8BA50_MODE_SUSPEND);
> +			mutex_unlock(&data->lock);
> +			return -EINVAL;
> +		}
> +		*val = sign_extend32(ret, 9);

let's do the shifting here as well...

> +		stk8ba50_set_power(data, STK8BA50_MODE_SUSPEND);
>  		mutex_unlock(&data->lock);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> @@ -208,30 +305,98 @@ static const struct iio_info stk8ba50_info = {
>  	.attrs			= &stk8ba50_attribute_group,
>  };
>  
> -static int stk8ba50_set_power(struct stk8ba50_data *data, bool mode)
> +static irqreturn_t stk8ba50_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct stk8ba50_data *data = iio_priv(indio_dev);
> +	int bit, ret, i = 0;
> +

perhaps it is possible to optimize for the likely case of reading all 
three channels at once?

> +	mutex_lock(&data->lock);
> +	for_each_set_bit(bit, indio_dev->active_scan_mask,
> +			 indio_dev->masklength) {
> +		switch (bit) {
> +		case 0:
> +			ret = stk8ba50_read_accel(data, STK8BA50_REG_XOUT);
> +			break;
> +		case 1:
> +			ret = stk8ba50_read_accel(data, STK8BA50_REG_YOUT);
> +			break;
> +		case 2:
> +			ret = stk8ba50_read_accel(data, STK8BA50_REG_ZOUT);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		if (ret < 0) {
> +			mutex_unlock(&data->lock);
> +			goto err;
> +		}
> +		data->buffer[i++] = ret;
> +	}
> +	mutex_unlock(&data->lock);
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> +					   pf->timestamp);
> +err:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t stk8ba50_data_rdy_trig_poll(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct stk8ba50_data *data = iio_priv(indio_dev);
> +
> +	if (data->dready_trigger_on)
> +		iio_trigger_poll(data->dready_trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int stk8ba50_buffer_preenable(struct iio_dev *indio_dev)
>  {
> +	struct stk8ba50_data *data = iio_priv(indio_dev);
> +
> +	return stk8ba50_set_power(data, STK8BA50_MODE_NORMAL);
> +}
> +
> +static int stk8ba50_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct stk8ba50_data *data = iio_priv(indio_dev);
> +
> +	return stk8ba50_set_power(data, STK8BA50_MODE_SUSPEND);
> +}
> +
> +static const struct iio_buffer_setup_ops stk8ba50_buffer_setup_ops = {
> +	.preenable   = stk8ba50_buffer_preenable,
> +	.postenable  = iio_triggered_buffer_postenable,
> +	.predisable  = iio_triggered_buffer_predisable,
> +	.postdisable = stk8ba50_buffer_postdisable,
> +};
> +
> +static int stk8ba50_gpio_probe(struct i2c_client *client)
> +{
> +	struct device *dev;
> +	struct gpio_desc *gpio;
>  	int ret;
> -	u8 masked_reg;
> -	struct i2c_client *client = data->client;
>  
> -	ret = i2c_smbus_read_byte_data(client, STK8BA50_REG_POWMODE);
> -	if (ret < 0)
> -		goto exit_err;
> +	if (!client)
> +		return -EINVAL;
>  
> -	if (mode)
> -		masked_reg = ret | STK8BA50_MODE_POWERBIT;
> -	else
> -		masked_reg = ret & (~STK8BA50_MODE_POWERBIT);
> +	dev = &client->dev;
>  
> -	ret = i2c_smbus_write_byte_data(client, STK8BA50_REG_POWMODE,
> -					masked_reg);
> -	if (ret < 0)
> -		goto exit_err;
> +	/* data ready gpio interrupt pin */
> +	gpio = devm_gpiod_get_index(dev, STK8BA50_GPIO, 0, GPIOD_IN);
> +	if (IS_ERR(gpio)) {
> +		dev_err(dev, "acpi gpio get index failed\n");
> +		return PTR_ERR(gpio);
> +	}
>  
> -	return ret;
> +	ret = gpiod_to_irq(gpio);
> +	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
>  
> -exit_err:
> -	dev_err(&client->dev, "failed to change sensor mode\n");
>  	return ret;
>  }
>  
> @@ -274,14 +439,74 @@ static int stk8ba50_probe(struct i2c_client *client,
>  	/* The default sampling rate is 1792 Hz (maximum) */
>  	data->sample_rate_idx = STK8BA50_SR_1792HZ_IDX;
>  
> +	/* Set up interrupts */
> +	ret = i2c_smbus_write_byte_data(client,
> +			STK8BA50_REG_INTEN2, STK8BA50_DREADY_INT_MASK);
> +	ret = i2c_smbus_write_byte_data(client,
> +			STK8BA50_REG_INTMAP2, STK8BA50_DREADY_INT_MAP);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "failed to set up interrupts\n");
> +		goto err_power_off;
> +	}
> +
> +	if (client->irq < 0)
> +		client->irq = stk8ba50_gpio_probe(client);
> +
> +	if (client->irq >= 0) {
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +						stk8ba50_data_rdy_trig_poll,
> +						NULL,
> +						IRQF_TRIGGER_RISING |
> +						IRQF_ONESHOT,
> +						STK8BA50_IRQ_NAME,
> +						indio_dev);
> +		if (ret < 0) {
> +			dev_err(&client->dev, "request irq %d failed\n",
> +				client->irq);
> +			goto err_power_off;
> +		}
> +
> +		data->dready_trig = devm_iio_trigger_alloc(&client->dev,
> +							   "%s-dev%d",
> +							   indio_dev->name,
> +							   indio_dev->id);
> +		if (!data->dready_trig) {
> +			ret = -ENOMEM;
> +			goto err_power_off;
> +		}
> +
> +		data->dready_trig->dev.parent = &client->dev;
> +		data->dready_trig->ops = &stk8ba50_trigger_ops;
> +		iio_trigger_set_drvdata(data->dready_trig, indio_dev);
> +		ret = iio_trigger_register(data->dready_trig);
> +		if (ret) {
> +			dev_err(&client->dev, "iio trigger register failed\n");
> +			goto err_power_off;
> +		}
> +	}
> +
> +	ret = iio_triggered_buffer_setup(indio_dev,
> +					 iio_pollfunc_store_time,
> +					 stk8ba50_trigger_handler,
> +					 &stk8ba50_buffer_setup_ops);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "iio triggered buffer setup failed\n");
> +		goto err_trigger_unregister;
> +	}
> +
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "device_register failed\n");
> -		goto err_power_off;
> +		goto err_buffer_cleanup;
>  	}
>  
>  	return ret;
>  
> +err_buffer_cleanup:
> +	iio_triggered_buffer_cleanup(indio_dev);
> +err_trigger_unregister:
> +	if (data->dready_trig)
> +		iio_trigger_unregister(data->dready_trig);
>  err_power_off:
>  	stk8ba50_set_power(data, STK8BA50_MODE_SUSPEND);
>  	return ret;
> @@ -290,10 +515,16 @@ err_power_off:
>  static int stk8ba50_remove(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct stk8ba50_data *data = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
>  
> -	return stk8ba50_set_power(iio_priv(indio_dev), STK8BA50_MODE_SUSPEND);
> +	if (data->dready_trig) {
> +		iio_triggered_buffer_cleanup(indio_dev);
> +		iio_trigger_unregister(data->dready_trig);
> +	}
> +
> +	return stk8ba50_set_power(data, STK8BA50_MODE_SUSPEND);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
