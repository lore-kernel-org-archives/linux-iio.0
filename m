Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40122 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbbDSQIR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Apr 2015 12:08:17 -0400
Message-ID: <5533D2EF.7050304@kernel.org>
Date: Sun, 19 Apr 2015 17:08:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Tiberiu Breana <tiberiu.a.breana@intel.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: light: Add threshold interrupt support for STK3310
References: <1429003962-13922-1-git-send-email-tiberiu.a.breana@intel.com> <1429003962-13922-4-git-send-email-tiberiu.a.breana@intel.com>
In-Reply-To: <1429003962-13922-4-git-send-email-tiberiu.a.breana@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/04/15 10:32, Tiberiu Breana wrote:
> Added interrupt support for proximity threshold events
> to the stk3310 driver.
> 
> Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
A few bits inline.

I'd definitely advise you to look at regmap.  Using the caching built
into that will mean you can just avoid the various local caches
and 'read' from the device ever time.

Anyhow, all in all a pretty clean driver.  Thanks,
Looking forward to the updated version.

Jonathan

> ---
>  drivers/iio/light/stk3310.c | 285 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 285 insertions(+)
> 
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index bc09304..0059dba 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -11,15 +11,22 @@
>   */
>  
>  #include <linux/acpi.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
> +#include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
>  #define STK3310_REG_STATE			0x00
>  #define STK3310_REG_PSCTRL			0x01
>  #define STK3310_REG_ALSCTRL			0x02
> +#define STK3310_REG_INT				0x04
> +#define STK3310_REG_THDH1_PS			0x06
> +#define STK3310_REG_THDL1_PS			0x08
> +#define STK3310_REG_FLAG			0x10
>  #define STK3310_REG_PS_DATA_MSB			0x11
>  #define STK3310_REG_ALS_DATA_MSB		0x13
>  #define STK3310_REG_PDT_ID			0x3E
> @@ -31,6 +38,9 @@
>  
>  #define STK3310_GAIN_MASK			0x30
>  #define STK3310_IT_MASK				0x0F
> +#define STK3310_PSINT_MASK			0x10
> +#define STK3310_PSINT_EN			0x01
> +#define STK3310_INT_PS_MASK			0x07
>  #define STK3310_GAIN_SHIFT			4
>  #define STK3310_IT_SHIFT			0
>  
> @@ -40,10 +50,13 @@
>  #define STK3310_GAIN_MAX			3
>  #define STK3310_IT_MAX				15
>  #define STK3310_PS_MAX_VAL			0xffff
> +#define STK3310_THRESH_MAX			0xffff
>  
>  #define STK3310_SCALE_AVAILABLE			"6.4 1.6 0.4 0.1"
>  
>  #define STK3310_DRIVER_NAME			"stk3310"
> +#define STK3310_EVENT				"stk3310_event"
> +#define STK3310_GPIO				"stk3310_gpio"
>  
>  /*
>   * Maximum PS values with regard to scale. Used to export the 'inverse'
> @@ -76,6 +89,8 @@ enum stk3310_data_type {
>  enum stk3310_config_type {
>  	STK3310_GAIN,
>  	STK3310_IT,
> +	STK3310_LOW_TH,
> +	STK3310_HIGH_TH,
>  	STK3310_TYPE_COUNT
>  };
>  
> @@ -84,10 +99,29 @@ struct stk3310_data {
>  	struct mutex lock;
>  	int als_enabled;
>  	int ps_enabled;
> +	int events_enabled;
> +	s64 timestamp;
>  	/* Cache table for storing config values */
>  	int cache[2][STK3310_TYPE_COUNT];
>  };
>  
> +static const struct iio_event_spec stk3310_events[] = {
> +	/* Proximity event */
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	/* Out-of-proximity event */
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
>  static const struct iio_chan_spec stk3310_channels[] = {
>  	{
>  		.channel = 0,
> @@ -104,6 +138,8 @@ static const struct iio_chan_spec stk3310_channels[] = {
>  			BIT(IIO_CHAN_INFO_RAW) |
>  			BIT(IIO_CHAN_INFO_SCALE) |
>  			BIT(IIO_CHAN_INFO_INT_TIME),
> +		.event_spec = stk3310_events,
> +		.num_event_specs = ARRAY_SIZE(stk3310_events),
>  	}
>  };
>  
> @@ -213,6 +249,124 @@ static int stk3310_set_cfg(struct stk3310_data *data,
>  	return ret;
>  }
>  
> +static int stk3310_read_event(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       enum iio_event_type type,
> +			       enum iio_event_direction dir,
> +			       enum iio_event_info info,
> +			       int *val, int *val2)
> +{
> +	struct stk3310_data *data = iio_priv(indio_dev);
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		*val = data->cache[STK3310_PS][STK3310_HIGH_TH];
> +		break;
> +	case IIO_EV_DIR_FALLING:
> +		*val = data->cache[STK3310_PS][STK3310_LOW_TH];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int stk3310_write_event(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       enum iio_event_type type,
> +			       enum iio_event_direction dir,
> +			       enum iio_event_info info,
> +			       int val, int val2)
> +{
> +	int ret;
> +	int ps_max;
> +	int *cache_val;
> +	u8 reg;
> +	struct stk3310_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +
> +	ps_max = stk3310_ps_max[data->cache[STK3310_PS][STK3310_GAIN]];
> +	if (val > ps_max)
> +		return -EINVAL;
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		reg = STK3310_REG_THDL1_PS;
> +		cache_val = &data->cache[STK3310_PS][STK3310_HIGH_TH];
> +		break;
> +	case IIO_EV_DIR_FALLING:
> +		reg = STK3310_REG_THDH1_PS;
> +		cache_val = &data->cache[STK3310_PS][STK3310_LOW_TH];
Regmap is looking like a better idea as I read through this.

> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = i2c_smbus_write_word_swapped(data->client, reg, ps_max - val);
> +	if (ret < 0)
> +		dev_err(&client->dev, "failed to set PS threshold!\n");
> +	else
> +		*cache_val = val;
> +
> +	return ret;
> +}
> +
> +static int stk3310_read_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir)
> +{
> +	struct stk3310_data *data = iio_priv(indio_dev);
> +
> +	if (chan->type != IIO_PROXIMITY || type != IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	return data->events_enabled;
> +}
> +
> +static int stk3310_write_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     int state)
> +{
> +	int ret;
> +	u8 masked_reg;
> +	struct stk3310_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +
> +	if (chan->type != IIO_PROXIMITY || type != IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	if (state == data->events_enabled)
> +		return 0;
> +
> +	/* Set INT_PS value */
> +	mutex_lock(&data->lock);
> +	ret = i2c_smbus_read_byte_data(data->client, STK3310_REG_INT);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "failed to read register\n");
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +	masked_reg = ret & (~STK3310_INT_PS_MASK);
> +	masked_reg |= state;
> +	ret = i2c_smbus_write_byte_data(data->client,
> +			STK3310_REG_INT, masked_reg);
> +	if (ret < 0)
> +		dev_err(&client->dev, "failed to set interrupt mode\n");
> +	else
> +		data->events_enabled = state;
> +
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
> +
>  static int stk3310_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int *val, int *val2, long mask)
> @@ -325,6 +479,10 @@ static const struct iio_info stk3310_info = {
>  	.read_raw		= stk3310_read_raw,
>  	.write_raw		= stk3310_write_raw,
>  	.attrs			= &stk3310_attribute_group,
> +	.read_event_value	= stk3310_read_event,
> +	.write_event_value	= stk3310_write_event,
> +	.read_event_config	= stk3310_read_event_config,
> +	.write_event_config	= stk3310_write_event_config,
>  };
>  
>  static int stk3310_cache_store(struct stk3310_data *data)
> @@ -355,6 +513,32 @@ static int stk3310_cache_store(struct stk3310_data *data)
>  			(ret & STK3310_GAIN_MASK) >> STK3310_GAIN_SHIFT;
>  	data->cache[STK3310_PS][STK3310_IT] =
>  			(ret & STK3310_IT_MASK) >> STK3310_IT_SHIFT;
> +
> +	/*
> +	 * Only proximity interrupts are implemented at the moment.
> +	 * Since we're inverting proximity values, the sensor's 'high'
> +	 * threshold will become our 'low' threshold, associated with
> +	 * 'near' events. Similarly, the sensor's 'low' threshold will
> +	 * be our 'high' threshold, associated with 'far' events.
> +	 */
> +	ret = i2c_smbus_read_word_swapped(data->client, STK3310_REG_THDH1_PS);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "register read failed\n");
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +	data->cache[STK3310_PS][STK3310_LOW_TH] =
> +		stk3310_ps_max[data->cache[STK3310_PS][STK3310_GAIN]] - ret;
> +
> +	ret = i2c_smbus_read_word_swapped(data->client, STK3310_REG_THDL1_PS);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "register read failed\n");
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +	data->cache[STK3310_PS][STK3310_HIGH_TH] =
> +		stk3310_ps_max[data->cache[STK3310_PS][STK3310_GAIN]] - ret;
> +
>  	mutex_unlock(&data->lock);
>  
>  	return ret;
> @@ -417,10 +601,94 @@ static int stk3310_init(struct iio_dev *indio_dev)
>  		return ret;
>  	}
>  
> +	/* Enable PS interrupts */
> +	ret = i2c_smbus_write_byte_data(data->client,
> +			STK3310_REG_INT, STK3310_PSINT_EN);
> +	if (ret < 0)
> +		dev_err(&client->dev, "failed to enable interrupts!\n");
> +	else
> +		data->events_enabled = 1;
> +
>  	/* Cache the initial configuration values */
>  	return stk3310_cache_store(data);
>  }
>  
> +static int stk3310_gpio_probe(struct i2c_client *client)
> +{
Gah, I hate seeing another copy of this.  I wonder what happened
to the attempt to handle this stuff nicely in ACPI?

Anyhow, not your fault and nothing that will stop this driver
being merged.
> +	struct device *dev;
> +	struct gpio_desc *gpio;
> +	int ret;
> +
> +	if (!client)
> +		return -EINVAL;
> +
> +	dev = &client->dev;
> +
> +	/* gpio interrupt pin */
> +	gpio = devm_gpiod_get_index(dev, STK3310_GPIO, 0);
> +	if (IS_ERR(gpio)) {
> +		dev_err(dev, "acpi gpio get index failed\n");
> +		return PTR_ERR(gpio);
> +	}
> +
> +	ret = gpiod_direction_input(gpio);
> +	if (ret)
> +		return ret;
> +
> +	ret = gpiod_to_irq(gpio);
> +
> +	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
> +
> +	return ret;
> +}
> +
> +static int stk3310_reset_psint(struct stk3310_data *data)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, STK3310_REG_FLAG);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "register read failed\n");
> +		return ret;
> +	}
I'd b roll this into it's call site as you then won't need this
additional read of REG_FLAG.

> +	ret &= ~STK3310_PSINT_MASK;
> +	ret = i2c_smbus_write_byte_data(data->client, STK3310_REG_FLAG, ret);
> +	if (ret < 0)
> +		dev_err(&data->client->dev, "failed to reset interrupts\n");
> +
> +	return ret;
> +}
> +
> +static irqreturn_t stk3310_irq_event_handler(int irq, void *private)
> +{
> +	int ret;
> +	int dir;
> +	u64 event;
> +	struct iio_dev *indio_dev = private;
> +	struct stk3310_data *data = iio_priv(indio_dev);
> +
> +	data->timestamp = iio_get_time_ns();
I'd be tempted to have a top half handler that stashes the timestamp.
Gets it nearer the actual event time.
For that matter, if you are going to read it here, why have the
storage in stk3310_data?

> +	/* Read FLAG_NF to figure out what threshold has been met. */
> +	mutex_lock(&data->lock);
> +	ret = i2c_smbus_read_byte_data(data->client,
> +			STK3310_REG_FLAG);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "register read failed\n");
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +	dir = (ret & 0x01) ? IIO_EV_DIR_RISING : IIO_EV_DIR_FALLING;
> +	event = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY,
> +				     1,
> +				     IIO_EV_TYPE_THRESH,
> +				     dir);
> +	iio_push_event(indio_dev, event, data->timestamp);
> +	stk3310_reset_psint(data);
> +	mutex_unlock(&data->lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int stk3310_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> @@ -458,6 +726,23 @@ static int stk3310_probe(struct i2c_client *client,
>  		stk3310_set_state(data, STK3310_STATE_STANDBY);
>  	}
>  
> +	if (client->irq <= 0)
> +		client->irq = stk3310_gpio_probe(client);
> +
> +	if (client->irq >= 0) {
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +						NULL,
> +						stk3310_irq_event_handler,
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT,
> +						STK3310_EVENT, indio_dev);
> +		if (ret < 0) {
> +			dev_err(&client->dev, "request irq %d failed\n",
> +				client->irq);
skip the return ret here. Covered by the below one.  Some tools will
moan about this...
> +			return ret;
> +		}
> +	}
> +
>  	return ret;
>  }
>  
> 

