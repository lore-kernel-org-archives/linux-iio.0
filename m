Return-Path: <SRS0=kSSO=ZE=pmeerw.net=pmeerw@kernel.org>
Date: Sun, 22 Jan 2017 10:19:06 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Manivannan Sadhasivam <manivannanece23@gmail.com>
cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] iio:temperature:Add irq and threshold events support
 for TI TMP007 sensor
In-Reply-To: <20170121150147.GA7781@gmail.com>
Message-ID: <alpine.DEB.2.02.1701221002030.31271@pmeerw.net>
References: <20170121150147.GA7781@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


I'd prefer subject "iio:temperature:tmp007: Add irq and threshold events support"

> This patch adds support for ALERT irq and limit threshold events for TI TMP007 - 16 bit IR thermopile sensor
> with integrated math engine.
> 
> Following threshold events are supported:
> 1. TObj high limit
> 2. TObj low limit
> 3. TDie high limit
> 4. TDie low limit

comments below
I suggest to separate clearup from actually adding events support, so two 
patches
it would be nice if the driver can operate without irq also (irq is 
optional in DT...)

> Signed-off-by: Manivannan Sadhasivam <manivannanece23@gmail.com>
> ---

note: this applies on top of patch...

>  .../devicetree/bindings/iio/temperature/tmp007.txt |   8 +
>  drivers/iio/temperature/tmp007.c                   | 334 ++++++++++++++++++---
>  2 files changed, 304 insertions(+), 38 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/tmp007.txt b/Documentation/devicetree/bindings/iio/temperature/tmp007.txt
> index 3b8f41f..07c1658 100644
> --- a/Documentation/devicetree/bindings/iio/temperature/tmp007.txt
> +++ b/Documentation/devicetree/bindings/iio/temperature/tmp007.txt
> @@ -18,10 +18,18 @@ Required properties:
>  		   1	 SDA	   0x46
>  		   1     SCL       0x47
>  
> +Optional properties:
> +
> +  - interrupt-parent: should be the phandle for the interrupt controller
> +
> +  - interrupts: interrupt mapping for GPIO IRQ
> +
>  Example:
>  
>  tmp007@40 {
>          compatible = "ti,tmp007";
>          reg = <0x40>;
> +        interrupt-parent = <&gpio0>;
> +        interrupts = <5 8>;

why are there two GPIOs?

>  };
>  
> diff --git a/drivers/iio/temperature/tmp007.c b/drivers/iio/temperature/tmp007.c
> index 24c6c16..73b5b8d 100644
> --- a/drivers/iio/temperature/tmp007.c
> +++ b/drivers/iio/temperature/tmp007.c
> @@ -11,9 +11,10 @@
>   *
>   * (7-bit I2C slave address (0x40 - 0x47), changeable via ADR pins)
>   *
> - * Note: This driver assumes that the sensor has been calibrated beforehand
> - *
> - * TODO: ALERT irq, limit threshold events
> + * Note:
> + * 1. This driver assumes that the sensor has been calibrated beforehand
> + * 2. Limit threshold events are enabled at the start
> + * 3. Operating mode: INT
>   *
>   */
>  
> @@ -24,35 +25,49 @@
>  #include <linux/pm.h>
>  #include <linux/bitops.h>
>  #include <linux/of.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> -
> -#define TMP007_TDIE 0x01
> -#define TMP007_CONFIG 0x02
> -#define TMP007_TOBJECT 0x03
> -#define TMP007_STATUS 0x04
> -#define TMP007_STATUS_MASK 0x05
> -#define TMP007_MANUFACTURER_ID 0x1e
> -#define TMP007_DEVICE_ID 0x1f
> -
> -#define TMP007_CONFIG_CONV_EN BIT(12)
> -#define TMP007_CONFIG_COMP_EN BIT(5)
> -#define TMP007_CONFIG_TC_EN BIT(6)
> -#define TMP007_CONFIG_CR_MASK GENMASK(11, 9)
> -#define TMP007_CONFIG_CR_SHIFT 9
> -
> -#define TMP007_STATUS_CONV_READY BIT(14)
> -#define TMP007_STATUS_DATA_VALID BIT(9)
> -
> -#define TMP007_MANUFACTURER_MAGIC 0x5449
> -#define TMP007_DEVICE_MAGIC 0x0078
> -
> -#define TMP007_TEMP_SHIFT 2
> +#include <linux/iio/events.h>
> +
> +#define TMP007_TDIE			0x01

this has a lot of clutter; the patch also reformats the #defines by adding 
whitespace; don't do this in the same patch

> +#define TMP007_CONFIG			0x02
> +#define TMP007_TOBJECT			0x03
> +#define TMP007_STATUS			0x04
> +#define TMP007_STATUS_MASK		0x05
> +#define TMP007_TOBJ_HIGH_LIMIT		0x06
> +#define TMP007_TOBJ_LOW_LIMIT		0x07
> +#define TMP007_TDIE_HIGH_LIMIT		0x08
> +#define TMP007_TDIE_LOW_LIMIT		0x09
> +#define TMP007_MANUFACTURER_ID		0x1e
> +#define TMP007_DEVICE_ID		0x1f
> +
> +#define TMP007_CONFIG_CONV_EN		BIT(12)
> +#define TMP007_CONFIG_TC_EN		BIT(6)
> +#define TMP007_CONFIG_CR_MASK		GENMASK(11, 9)
> +#define TMP007_CONFIG_ALERT_EN		BIT(8)
> +#define TMP007_CONFIG_CR_SHIFT		9
> +
> +/* Status register flags */
> +#define TMP007_STATUS_ALERT	BIT(15)
> +#define TMP007_STATUS_CONV_READY	BIT(14)
> +#define TMP007_STATUS_OHF		BIT(13)
> +#define TMP007_STATUS_OLF		BIT(12)
> +#define TMP007_STATUS_LHF		BIT(11)
> +#define TMP007_STATUS_LLF		BIT(10)
> +#define TMP007_STATUS_DATA_VALID	BIT(9)
> +
> +#define TMP007_MANUFACTURER_MAGIC	0x5449
> +#define TMP007_DEVICE_MAGIC		0x0078
> +
> +#define TMP007_TEMP_SHIFT		2
>  
>  struct tmp007_data {
>  	struct i2c_client *client;
>  	u16 config;
> +	u16 status_mask;
>  };
>  
>  static const int tmp007_avgs[5][2] = { {4, 0}, {2, 0}, {1, 0},
> @@ -70,7 +85,7 @@ static int tmp007_read_temperature(struct tmp007_data *data, u8 reg)
>  			return ret;
>  		if ((ret & TMP007_STATUS_CONV_READY) &&
>  			!(ret & TMP007_STATUS_DATA_VALID))
> -				break;

another unrelated cleanup

> +			break;
>  		msleep(100);
>  	}
>  
> @@ -156,6 +171,185 @@ static int tmp007_write_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> +static irqreturn_t tmp007_interrupt_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct tmp007_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = i2c_smbus_read_word_swapped(data->client, TMP007_STATUS);
> +	if (ret < 0)

|| !(ret & (_STATUSS_OHF | STATUS_OLF | ..))

> +		return IRQ_NONE;
> +
> +	if (ret & TMP007_STATUS_OHF)
> +		iio_push_event(indio_dev,
> +				IIO_MOD_EVENT_CODE(IIO_TEMP, 0,
> +					IIO_MOD_TEMP_OBJECT,
> +					IIO_EV_TYPE_THRESH,
> +					IIO_EV_DIR_RISING),
> +				iio_get_time_ns(indio_dev));
> +
> +	if (ret & TMP007_STATUS_OLF)
> +		iio_push_event(indio_dev,
> +				IIO_MOD_EVENT_CODE(IIO_TEMP, 0,
> +					IIO_MOD_TEMP_OBJECT,
> +					IIO_EV_TYPE_THRESH,
> +					IIO_EV_DIR_FALLING),
> +				iio_get_time_ns(indio_dev));
> +
> +	if (ret & TMP007_STATUS_LHF)
> +		iio_push_event(indio_dev,
> +				IIO_MOD_EVENT_CODE(IIO_TEMP, 0,
> +					IIO_MOD_TEMP_AMBIENT,
> +					IIO_EV_TYPE_THRESH,
> +					IIO_EV_DIR_RISING),
> +				iio_get_time_ns(indio_dev));
> +
> +	if (ret & TMP007_STATUS_LLF)
> +		iio_push_event(indio_dev,
> +				IIO_MOD_EVENT_CODE(IIO_TEMP, 0,
> +					IIO_MOD_TEMP_AMBIENT,
> +					IIO_EV_TYPE_THRESH,
> +					IIO_EV_DIR_FALLING),
> +				iio_get_time_ns(indio_dev));
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int tmp007_write_event_config(struct iio_dev *indio_dev,
> +		const struct iio_chan_spec *chan, enum iio_event_type type,
> +		enum iio_event_direction dir, int state)
> +{
> +	struct tmp007_data *data = iio_priv(indio_dev);
> +	unsigned int status_mask;
> +	int ret;
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_TEMP_AMBIENT:
> +		if (dir == IIO_EV_DIR_RISING)
> +			status_mask = TMP007_STATUS_LHF;
> +		else
> +			status_mask = TMP007_STATUS_LLF;
> +		break;
> +	case IIO_MOD_TEMP_OBJECT:
> +		if (dir == IIO_EV_DIR_RISING)
> +			status_mask = TMP007_STATUS_OHF;
> +		else
> +			status_mask = TMP007_STATUS_OLF;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +

mutex around this?

> +	ret = i2c_smbus_read_word_swapped(data->client, TMP007_STATUS_MASK);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (state)
> +		ret |= status_mask;
> +	else
> +		ret &= ~status_mask;
> +
> +	return i2c_smbus_write_word_swapped(data->client, TMP007_STATUS_MASK,
> +					data->status_mask = ret);
> +}
> +
> +static int tmp007_read_event_config(struct iio_dev *indio_dev,
> +		const struct iio_chan_spec *chan, enum iio_event_type type,
> +		enum iio_event_direction dir)
> +{
> +	struct tmp007_data *data = iio_priv(indio_dev);
> +	unsigned int mask;
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_TEMP_AMBIENT:
> +		if (dir == IIO_EV_DIR_RISING)
> +			mask = TMP007_STATUS_LHF;
> +		else
> +			mask = TMP007_STATUS_LLF;
> +		break;
> +	case IIO_MOD_TEMP_OBJECT:
> +		if (dir == IIO_EV_DIR_RISING)
> +			mask = TMP007_STATUS_OHF;
> +		else
> +			mask = TMP007_STATUS_OLF;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return (bool)(data->status_mask & mask);

return type is int, maybe use !! to force to 0/1

return !!(data->status_mask & mask);

> +}
> +
> +static int tmp007_read_thresh(struct iio_dev *indio_dev,
> +		const struct iio_chan_spec *chan, enum iio_event_type type,
> +		enum iio_event_direction dir, enum iio_event_info info,
> +		int *val, int *val2)
> +{
> +	struct tmp007_data *data = iio_priv(indio_dev);
> +	int ret;
> +	u8 reg;
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_TEMP_AMBIENT: /* LSB: 0.5 degree Celsius */
> +		if (dir == IIO_EV_DIR_RISING)
> +			reg = TMP007_TDIE_HIGH_LIMIT;
> +		else
> +			reg = TMP007_TDIE_LOW_LIMIT;
> +		break;
> +	case IIO_MOD_TEMP_OBJECT:
> +		if (dir == IIO_EV_DIR_RISING)
> +			reg = TMP007_TOBJ_HIGH_LIMIT;
> +		else
> +			reg = TMP007_TOBJ_LOW_LIMIT;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = i2c_smbus_read_word_swapped(data->client, reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Shift length 7 bits = 6(15:6) + 1(0.5 LSB) */
> +	*val = sign_extend32(ret, 15) >> 7;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int tmp007_write_thresh(struct iio_dev *indio_dev,
> +		const struct iio_chan_spec *chan, enum iio_event_type type,
> +		enum iio_event_direction dir, enum iio_event_info info,
> +		int val, int val2)
> +{
> +	struct tmp007_data *data = iio_priv(indio_dev);
> +	u8 reg;
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_TEMP_AMBIENT:
> +		if (dir == IIO_EV_DIR_RISING)
> +			reg = TMP007_TDIE_HIGH_LIMIT;
> +		else
> +			reg = TMP007_TDIE_LOW_LIMIT;
> +		break;
> +	case IIO_MOD_TEMP_OBJECT:
> +		if (dir == IIO_EV_DIR_RISING)
> +			reg = TMP007_TOBJ_HIGH_LIMIT;
> +		else
> +			reg = TMP007_TOBJ_LOW_LIMIT;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* Full scale value is +/- 256 degree Celsius */

I guess we want to specify milli degree Celsius according to sysfs-bus-iio 
for in_temp_raw

> +	if (val < -256 || val > 255)
> +		return -EINVAL;
> +
> +	/* Shift length 7 bits = 6(15:6) + 1(0.5 LSB) */
> +	return i2c_smbus_write_word_swapped(data->client, reg, (val << 7));
> +}
> +
>  static IIO_CONST_ATTR(sampling_frequency_available, "4 2 1 0.5 0.25");
>  
>  static struct attribute *tmp007_attributes[] = {
> @@ -167,6 +361,36 @@ static const struct attribute_group tmp007_attribute_group = {
>  	.attrs = tmp007_attributes,
>  };
>  
> +static const struct iio_event_spec tmp007_obj_event[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +			BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +			BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +static const struct iio_event_spec tmp007_die_event[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +			BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +			BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
>  static const struct iio_chan_spec tmp007_channels[] = {
>  	{
>  		.type = IIO_TEMP,
> @@ -175,6 +399,8 @@ static const struct iio_chan_spec tmp007_channels[] = {
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				BIT(IIO_CHAN_INFO_SCALE),
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.event_spec = tmp007_die_event,
> +		.num_event_specs = ARRAY_SIZE(tmp007_die_event),
>  	},
>  	{
>  		.type = IIO_TEMP,
> @@ -183,12 +409,18 @@ static const struct iio_chan_spec tmp007_channels[] = {
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				BIT(IIO_CHAN_INFO_SCALE),
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -	}
> +		.event_spec = tmp007_obj_event,
> +		.num_event_specs = ARRAY_SIZE(tmp007_obj_event),
> +	},
>  };
>  
>  static const struct iio_info tmp007_info = {
> -	.read_raw = tmp007_read_raw,
> -	.write_raw = tmp007_write_raw,
> +	.read_raw = &tmp007_read_raw,
> +	.write_raw = &tmp007_write_raw,

unrelated change, no need for & for a function

> +	.read_event_config = &tmp007_read_event_config,
> +	.write_event_config = &tmp007_write_event_config,
> +	.read_event_value = &tmp007_read_thresh,
> +	.write_event_value = &tmp007_write_thresh,
>  	.attrs = &tmp007_attribute_group,
>  	.driver_module = THIS_MODULE,
>  };
> @@ -214,7 +446,6 @@ static int tmp007_probe(struct i2c_client *client,
>  	struct tmp007_data *data;
>  	struct iio_dev *indio_dev;
>  	int ret;
> -	u16  status;
>  
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
>  		return -EOPNOTSUPP;
> @@ -243,8 +474,8 @@ static int tmp007_probe(struct i2c_client *client,
>  	/*
>  	 * Set Configuration register:
>  	 * 1. Conversion ON
> -	 * 2. Comparator mode
> -	 * 3. Transient correction enable
> +	 * 2. Transient correction enable
> +	 * 3. ALERT enable
>  	 */
>  
>  	ret = i2c_smbus_read_word_swapped(data->client, TMP007_CONFIG);
> @@ -252,7 +483,7 @@ static int tmp007_probe(struct i2c_client *client,
>  		return ret;
>  
>  	data->config = ret;
> -	data->config |= (TMP007_CONFIG_CONV_EN | TMP007_CONFIG_COMP_EN | TMP007_CONFIG_TC_EN);
> +	data->config |= (TMP007_CONFIG_CONV_EN | TMP007_CONFIG_TC_EN | TMP007_CONFIG_ALERT_EN);
>  
>  	ret = i2c_smbus_write_word_swapped(data->client, TMP007_CONFIG,
>  					data->config);
> @@ -260,22 +491,39 @@ static int tmp007_probe(struct i2c_client *client,
>  		return ret;
>  
>  	/*
> +	 * Only the following flags can activate ALERT pin. Data conversion/validity flags
> +	 * flags can still be polled for getting temperature data
> +	 *
>  	 * Set Status Mask register:
> -	 * 1. Conversion ready enable
> -	 * 2. Data valid enable
> +	 * 1. Object temperature high limit enable
> +	 * 2. Object temperature low limit enable
> +	 * 3. TDIE temperature high limit enable
> +	 * 4. TDIE temperature low limit enable
>  	 */
>  
>  	ret = i2c_smbus_read_word_swapped(data->client, TMP007_STATUS_MASK);
>  	if (ret < 0)
>  		goto error_powerdown;
>  
> -	status = ret;
> -	status |= (TMP007_STATUS_CONV_READY | TMP007_STATUS_DATA_VALID);
> +	data->status_mask = ret;
> +	data->status_mask |= (TMP007_STATUS_OHF | TMP007_STATUS_OLF
> +				| TMP007_STATUS_LHF | TMP007_STATUS_LLF);
>  
> -	ret = i2c_smbus_write_word_swapped(data->client, TMP007_STATUS_MASK, status);
> +	ret = i2c_smbus_write_word_swapped(data->client, TMP007_STATUS_MASK, data->status_mask);
>  	if (ret < 0)
>  		goto error_powerdown;
>  
> +	if (client->irq) {
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +				NULL, tmp007_interrupt_handler,
> +				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +				tmp007_id->name, indio_dev);
> +		if (ret) {
> +			dev_err(&client->dev, "irq request error %d\n", -ret);
> +			goto error_powerdown;
> +		}
> +	}

what happens when there is no IRQ? it would be nice to still use the 
driver (without event capability)

> +
>  	return iio_device_register(indio_dev);
>  
>  error_powerdown:
> @@ -312,6 +560,16 @@ static int tmp007_resume(struct device *dev)
>  	return i2c_smbus_write_word_swapped(data->client, TMP007_CONFIG,
>  			data->config | TMP007_CONFIG_CONV_EN);
>  }
> +#else

this seems to be unrelated to the patch

> +static int tmp007_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int tmp007_resume(struct device *dev)
> +{
> +	return 0;
> +}
>  #endif
>  
>  static SIMPLE_DEV_PM_OPS(tmp007_pm_ops, tmp007_suspend, tmp007_resume);
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
