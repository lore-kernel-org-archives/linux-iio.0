Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46171 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbbEGXdl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 May 2015 19:33:41 -0400
Message-ID: <554B3F05.1010600@kernel.org>
Date: Thu, 07 May 2015 11:31:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Tiberiu Breana <tiberiu.a.breana@intel.com>,
	linux-iio@vger.kernel.org
CC: Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 2/2] iio: light: Add threshold interrupt support for
 STK3310
References: <1430148841-30947-1-git-send-email-tiberiu.a.breana@intel.com> <1430148841-30947-3-git-send-email-tiberiu.a.breana@intel.com>
In-Reply-To: <1430148841-30947-3-git-send-email-tiberiu.a.breana@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/04/15 16:34, Tiberiu Breana wrote:
> Added interrupt support for proximity threshold events
> to the stk3310 driver.
I've not objection to the split, but also wouldn't have minded having
this in the original driver split (just in case you are doing it to make
reviewing easier - in this sort of thing it makes little difference!)
> 
> Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
Again, nice patch.  My only comment below is about the fact I should
find out what happened to the thoughts about moving the gpio/interrupt
setup code into ACPI to avoid having the same 10 lines in every driver.

Anyhow, applied to the togreg branch of iio.git, pushed out as testing
when you least expect it ;)

Thanks,

Jonathan
> ---
>  drivers/iio/light/stk3310.c | 255 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 253 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index 0f8c450..e79b9d8 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -12,15 +12,22 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/i2c.h>
> +#include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
>  #define STK3310_REG_STATE			0x00
>  #define STK3310_REG_PSCTRL			0x01
>  #define STK3310_REG_ALSCTRL			0x02
> +#define STK3310_REG_INT				0x04
> +#define STK3310_REG_THDH_PS			0x06
> +#define STK3310_REG_THDL_PS			0x08
> +#define STK3310_REG_FLAG			0x10
>  #define STK3310_REG_PS_DATA_MSB			0x11
>  #define STK3310_REG_PS_DATA_LSB			0x12
>  #define STK3310_REG_ALS_DATA_MSB		0x13
> @@ -34,10 +41,14 @@
>  
>  #define STK3310_CHIP_ID_VAL			0x13
>  #define STK3311_CHIP_ID_VAL			0x1D
> +#define STK3310_PSINT_EN			0x01
>  #define STK3310_PS_MAX_VAL			0xFFFF
> +#define STK3310_THRESH_MAX			0xFFFF
>  
>  #define STK3310_DRIVER_NAME			"stk3310"
>  #define STK3310_REGMAP_NAME			"stk3310_regmap"
> +#define STK3310_EVENT				"stk3310_event"
> +#define STK3310_GPIO				"stk3310_gpio"
>  
>  #define STK3310_SCALE_AVAILABLE			"6.4 1.6 0.4 0.1"
>  
> @@ -67,7 +78,12 @@ static const struct reg_field stk3310_reg_field_als_it =
>  				REG_FIELD(STK3310_REG_ALSCTRL, 0, 3);
>  static const struct reg_field stk3310_reg_field_ps_it =
>  				REG_FIELD(STK3310_REG_PSCTRL, 0, 3);
> -
> +static const struct reg_field stk3310_reg_field_int_ps =
> +				REG_FIELD(STK3310_REG_INT, 0, 2);
> +static const struct reg_field stk3310_reg_field_flag_psint =
> +				REG_FIELD(STK3310_REG_FLAG, 4, 4);
> +static const struct reg_field stk3310_reg_field_flag_nf =
> +				REG_FIELD(STK3310_REG_FLAG, 0, 0);
>  /*
>   * Maximum PS values with regard to scale. Used to export the 'inverse'
>   * PS value (high values for far objects, low values for near objects).
> @@ -96,12 +112,33 @@ struct stk3310_data {
>  	struct mutex lock;
>  	bool als_enabled;
>  	bool ps_enabled;
> +	u64 timestamp;
>  	struct regmap *regmap;
>  	struct regmap_field *reg_state;
>  	struct regmap_field *reg_als_gain;
>  	struct regmap_field *reg_ps_gain;
>  	struct regmap_field *reg_als_it;
>  	struct regmap_field *reg_ps_it;
> +	struct regmap_field *reg_int_ps;
> +	struct regmap_field *reg_flag_psint;
> +	struct regmap_field *reg_flag_nf;
> +};
> +
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
>  };
>  
>  static const struct iio_chan_spec stk3310_channels[] = {
> @@ -118,6 +155,8 @@ static const struct iio_chan_spec stk3310_channels[] = {
>  			BIT(IIO_CHAN_INFO_RAW) |
>  			BIT(IIO_CHAN_INFO_SCALE) |
>  			BIT(IIO_CHAN_INFO_INT_TIME),
> +		.event_spec = stk3310_events,
> +		.num_event_specs = ARRAY_SIZE(stk3310_events),
>  	}
>  };
>  
> @@ -156,6 +195,118 @@ static int stk3310_get_index(const int table[][2], int table_size,
>  	return -EINVAL;
>  }
>  
> +static int stk3310_read_event(struct iio_dev *indio_dev,
> +			      const struct iio_chan_spec *chan,
> +			      enum iio_event_type type,
> +			      enum iio_event_direction dir,
> +			      enum iio_event_info info,
> +			      int *val, int *val2)
> +{
> +	u8 reg;
> +	u16 buf;
> +	int ret;
> +	unsigned int index;
> +	struct stk3310_data *data = iio_priv(indio_dev);
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	/*
> +	 * Only proximity interrupts are implemented at the moment.
> +	 * Since we're inverting proximity values, the sensor's 'high'
> +	 * threshold will become our 'low' threshold, associated with
> +	 * 'near' events. Similarly, the sensor's 'low' threshold will
> +	 * be our 'high' threshold, associated with 'far' events.
> +	 */
> +	if (dir == IIO_EV_DIR_RISING)
> +		reg = STK3310_REG_THDL_PS;
> +	else if (dir == IIO_EV_DIR_FALLING)
> +		reg = STK3310_REG_THDH_PS;
> +	else
> +		return -EINVAL;
> +
> +	mutex_lock(&data->lock);
> +	ret = regmap_bulk_read(data->regmap, reg, &buf, 2);
> +	mutex_unlock(&data->lock);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "register read failed\n");
> +		return ret;
> +	}
> +	regmap_field_read(data->reg_ps_gain, &index);
> +	*val = swab16(stk3310_ps_max[index] - buf);
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
> +	u8 reg;
> +	u16 buf;
> +	int ret;
> +	unsigned int index;
> +	struct stk3310_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +
> +	regmap_field_read(data->reg_ps_gain, &index);
> +	if (val > stk3310_ps_max[index])
> +		return -EINVAL;
> +
> +	if (dir == IIO_EV_DIR_RISING)
> +		reg = STK3310_REG_THDL_PS;
> +	else if (dir == IIO_EV_DIR_FALLING)
> +		reg = STK3310_REG_THDH_PS;
> +	else
> +		return -EINVAL;
> +
> +	buf = swab16(stk3310_ps_max[index] - val);
> +	ret = regmap_bulk_write(data->regmap, reg, &buf, 2);
> +	if (ret < 0)
> +		dev_err(&client->dev, "failed to set PS threshold!\n");
> +
> +	return ret;
> +}
> +
> +static int stk3310_read_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir)
> +{
> +	unsigned int event_val;
> +	struct stk3310_data *data = iio_priv(indio_dev);
> +
> +	regmap_field_read(data->reg_int_ps, &event_val);
> +
> +	return event_val;
> +}
> +
> +static int stk3310_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir,
> +				      int state)
> +{
> +	int ret;
> +	struct stk3310_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +
> +	if (state < 0 || state > 7)
> +		return -EINVAL;
> +
> +	/* Set INT_PS value */
> +	mutex_lock(&data->lock);
> +	ret = regmap_field_write(data->reg_int_ps, state);
> +	if (ret < 0)
> +		dev_err(&client->dev, "failed to set interrupt mode\n");
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
> +
>  static int stk3310_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int *val, int *val2, long mask)
> @@ -266,6 +417,10 @@ static const struct iio_info stk3310_info = {
>  	.read_raw		= stk3310_read_raw,
>  	.write_raw		= stk3310_write_raw,
>  	.attrs			= &stk3310_attribute_group,
> +	.read_event_value	= stk3310_read_event,
> +	.write_event_value	= stk3310_write_event,
> +	.read_event_config	= stk3310_read_event_config,
> +	.write_event_config	= stk3310_write_event_config,
>  };
>  
>  static int stk3310_set_state(struct stk3310_data *data, u8 state)
> @@ -308,8 +463,43 @@ static int stk3310_init(struct iio_dev *indio_dev)
>  
>  	state = STK3310_STATE_EN_ALS | STK3310_STATE_EN_PS;
>  	ret = stk3310_set_state(data, state);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		dev_err(&client->dev, "failed to enable sensor");
> +		return ret;
> +	}
> +
> +	/* Enable PS interrupts */
> +	ret = regmap_field_write(data->reg_int_ps, STK3310_PSINT_EN);
> +	if (ret < 0)
> +		dev_err(&client->dev, "failed to enable interrupts!\n");
> +
> +	return ret;
> +}
> +
> +static int stk3310_gpio_probe(struct i2c_client *client)
> +{
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
> +	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
>  
>  	return ret;
>  }
> @@ -321,6 +511,7 @@ static bool stk3310_is_volatile_reg(struct device *dev, unsigned int reg)
>  	case STK3310_REG_ALS_DATA_LSB:
>  	case STK3310_REG_PS_DATA_LSB:
>  	case STK3310_REG_PS_DATA_MSB:
> +	case STK3310_REG_FLAG:
>  		return true;
>  	default:
>  		return false;
> @@ -354,10 +545,55 @@ static int stk3310_regmap_init(struct stk3310_data *data)
>  	STK3310_REGFIELD(ps_gain);
>  	STK3310_REGFIELD(als_it);
>  	STK3310_REGFIELD(ps_it);
> +	STK3310_REGFIELD(int_ps);
> +	STK3310_REGFIELD(flag_psint);
> +	STK3310_REGFIELD(flag_nf);
>  
>  	return 0;
>  }
>  
> +static irqreturn_t stk3310_irq_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct stk3310_data *data = iio_priv(indio_dev);
> +
> +	data->timestamp = iio_get_time_ns();
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t stk3310_irq_event_handler(int irq, void *private)
> +{
> +	int ret;
> +	unsigned int dir;
> +	u64 event;
> +
> +	struct iio_dev *indio_dev = private;
> +	struct stk3310_data *data = iio_priv(indio_dev);
> +
> +	/* Read FLAG_NF to figure out what threshold has been met. */
> +	mutex_lock(&data->lock);
> +	ret = regmap_field_read(data->reg_flag_nf, &dir);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "register read failed\n");
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +	event = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 1,
> +				     IIO_EV_TYPE_THRESH,
> +				     (dir ? IIO_EV_DIR_RISING :
> +					    IIO_EV_DIR_FALLING));
> +	iio_push_event(indio_dev, event, data->timestamp);
> +
> +	/* Reset the interrupt flag */
> +	ret = regmap_field_write(data->reg_flag_psint, 0);
> +	if (ret < 0)
> +		dev_err(&data->client->dev, "failed to reset interrupts\n");
> +	mutex_unlock(&data->lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int stk3310_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> @@ -397,6 +633,21 @@ static int stk3310_probe(struct i2c_client *client,
>  		stk3310_set_state(data, STK3310_STATE_STANDBY);
>  	}
>  
> +	if (client->irq <= 0)
> +		client->irq = stk3310_gpio_probe(client);
GAH, Another one of these.  I must chase up what is going on with
trying to get this mess into the ACPI core!
> +
> +	if (client->irq >= 0) {
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +						stk3310_irq_handler,
> +						stk3310_irq_event_handler,
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT,
> +						STK3310_EVENT, indio_dev);
> +		if (ret < 0)
> +			dev_err(&client->dev, "request irq %d failed\n",
> +					client->irq);
> +	}
> +
>  	return ret;
>  }
>  
> 

