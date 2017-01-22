Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35682 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750889AbdAVPJi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Jan 2017 10:09:38 -0500
Date: Sun, 22 Jan 2017 20:39:11 +0530
In-Reply-To: <alpine.DEB.2.02.1701221002030.31271@pmeerw.net>
References: <20170121150147.GA7781@gmail.com> <alpine.DEB.2.02.1701221002030.31271@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH] iio:temperature:Add irq and threshold events support for TI TMP007 sensor
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC: jic23@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
From: Mani Sadhasivam <manivannanece23@gmail.com>
Message-ID: <4FBC7656-470E-4E79-9376-995D645BD020@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Thanks Peter for your suggestions=2E

On January 22, 2017 2:49:06 PM GMT+05:30, Peter Meerwald-Stadler <pmeerw@p=
meerw=2Enet> wrote:
>
>I'd prefer subject "iio:temperature:tmp007: Add irq and threshold
>events support"
>
ACK
>> This patch adds support for ALERT irq and limit threshold events for
>TI TMP007 - 16 bit IR thermopile sensor
>> with integrated math engine=2E
>>=20
>> Following threshold events are supported:
>> 1=2E TObj high limit
>> 2=2E TObj low limit
>> 3=2E TDie high limit
>> 4=2E TDie low limit
>
>comments below
>I suggest to separate clearup from actually adding events support, so
>two=20
>patches
Sure=2E I'll create a separate patch for cleanup later on=2E=20
>it would be nice if the driver can operate without irq also (irq is=20
>optional in DT=2E=2E=2E)
>
I think the driver can work without interrupt=2E=20
>> Signed-off-by: Manivannan Sadhasivam <manivannanece23@gmail=2Ecom>
>> ---
>
>note: this applies on top of patch=2E=2E=2E
>
>>  =2E=2E=2E/devicetree/bindings/iio/temperature/tmp007=2Etxt |   8 +
>>  drivers/iio/temperature/tmp007=2Ec                   | 334
>++++++++++++++++++---
>>  2 files changed, 304 insertions(+), 38 deletions(-)
>>=20
>> diff --git
>a/Documentation/devicetree/bindings/iio/temperature/tmp007=2Etxt
>b/Documentation/devicetree/bindings/iio/temperature/tmp007=2Etxt
>> index 3b8f41f=2E=2E07c1658 100644
>> --- a/Documentation/devicetree/bindings/iio/temperature/tmp007=2Etxt
>> +++ b/Documentation/devicetree/bindings/iio/temperature/tmp007=2Etxt
>> @@ -18,10 +18,18 @@ Required properties:
>>  		   1	 SDA	   0x46
>>  		   1     SCL       0x47
>> =20
>> +Optional properties:
>> +
>> +  - interrupt-parent: should be the phandle for the interrupt
>controller
>> +
>> +  - interrupts: interrupt mapping for GPIO IRQ
>> +
>>  Example:
>> =20
>>  tmp007@40 {
>>          compatible =3D "ti,tmp007";
>>          reg =3D <0x40>;
>> +        interrupt-parent =3D <&gpio0>;
>> +        interrupts =3D <5 8>;
>
>why are there two GPIOs?
>
Ahh=2E  I wanted to specify level triggering there=2E  But not needed as i=
t is being specified in probe itself=2E=20
Acked=2E=20
>>  };
>> =20
>> diff --git a/drivers/iio/temperature/tmp007=2Ec
>b/drivers/iio/temperature/tmp007=2Ec
>> index 24c6c16=2E=2E73b5b8d 100644
>> --- a/drivers/iio/temperature/tmp007=2Ec
>> +++ b/drivers/iio/temperature/tmp007=2Ec
>> @@ -11,9 +11,10 @@
>>   *
>>   * (7-bit I2C slave address (0x40 - 0x47), changeable via ADR pins)
>>   *
>> - * Note: This driver assumes that the sensor has been calibrated
>beforehand
>> - *
>> - * TODO: ALERT irq, limit threshold events
>> + * Note:
>> + * 1=2E This driver assumes that the sensor has been calibrated
>beforehand
>> + * 2=2E Limit threshold events are enabled at the start
>> + * 3=2E Operating mode: INT
>>   *
>>   */
>> =20
>> @@ -24,35 +25,49 @@
>>  #include <linux/pm=2Eh>
>>  #include <linux/bitops=2Eh>
>>  #include <linux/of=2Eh>
>> +#include <linux/irq=2Eh>
>> +#include <linux/interrupt=2Eh>
>> =20
>>  #include <linux/iio/iio=2Eh>
>>  #include <linux/iio/sysfs=2Eh>
>> -
>> -#define TMP007_TDIE 0x01
>> -#define TMP007_CONFIG 0x02
>> -#define TMP007_TOBJECT 0x03
>> -#define TMP007_STATUS 0x04
>> -#define TMP007_STATUS_MASK 0x05
>> -#define TMP007_MANUFACTURER_ID 0x1e
>> -#define TMP007_DEVICE_ID 0x1f
>> -
>> -#define TMP007_CONFIG_CONV_EN BIT(12)
>> -#define TMP007_CONFIG_COMP_EN BIT(5)
>> -#define TMP007_CONFIG_TC_EN BIT(6)
>> -#define TMP007_CONFIG_CR_MASK GENMASK(11, 9)
>> -#define TMP007_CONFIG_CR_SHIFT 9
>> -
>> -#define TMP007_STATUS_CONV_READY BIT(14)
>> -#define TMP007_STATUS_DATA_VALID BIT(9)
>> -
>> -#define TMP007_MANUFACTURER_MAGIC 0x5449
>> -#define TMP007_DEVICE_MAGIC 0x0078
>> -
>> -#define TMP007_TEMP_SHIFT 2
>> +#include <linux/iio/events=2Eh>
>> +
>> +#define TMP007_TDIE			0x01
>
>this has a lot of clutter; the patch also reformats the #defines by
>adding=20
>whitespace; don't do this in the same patch
>
Ack
>> +#define TMP007_CONFIG			0x02
>> +#define TMP007_TOBJECT			0x03
>> +#define TMP007_STATUS			0x04
>> +#define TMP007_STATUS_MASK		0x05
>> +#define TMP007_TOBJ_HIGH_LIMIT		0x06
>> +#define TMP007_TOBJ_LOW_LIMIT		0x07
>> +#define TMP007_TDIE_HIGH_LIMIT		0x08
>> +#define TMP007_TDIE_LOW_LIMIT		0x09
>> +#define TMP007_MANUFACTURER_ID		0x1e
>> +#define TMP007_DEVICE_ID		0x1f
>> +
>> +#define TMP007_CONFIG_CONV_EN		BIT(12)
>> +#define TMP007_CONFIG_TC_EN		BIT(6)
>> +#define TMP007_CONFIG_CR_MASK		GENMASK(11, 9)
>> +#define TMP007_CONFIG_ALERT_EN		BIT(8)
>> +#define TMP007_CONFIG_CR_SHIFT		9
>> +
>> +/* Status register flags */
>> +#define TMP007_STATUS_ALERT	BIT(15)
>> +#define TMP007_STATUS_CONV_READY	BIT(14)
>> +#define TMP007_STATUS_OHF		BIT(13)
>> +#define TMP007_STATUS_OLF		BIT(12)
>> +#define TMP007_STATUS_LHF		BIT(11)
>> +#define TMP007_STATUS_LLF		BIT(10)
>> +#define TMP007_STATUS_DATA_VALID	BIT(9)
>> +
>> +#define TMP007_MANUFACTURER_MAGIC	0x5449
>> +#define TMP007_DEVICE_MAGIC		0x0078
>> +
>> +#define TMP007_TEMP_SHIFT		2
>> =20
>>  struct tmp007_data {
>>  	struct i2c_client *client;
>>  	u16 config;
>> +	u16 status_mask;
>>  };
>> =20
>>  static const int tmp007_avgs[5][2] =3D { {4, 0}, {2, 0}, {1, 0},
>> @@ -70,7 +85,7 @@ static int tmp007_read_temperature(struct
>tmp007_data *data, u8 reg)
>>  			return ret;
>>  		if ((ret & TMP007_STATUS_CONV_READY) &&
>>  			!(ret & TMP007_STATUS_DATA_VALID))
>> -				break;
>
>another unrelated cleanup
Ack
>
>> +			break;
>>  		msleep(100);
>>  	}
>> =20
>> @@ -156,6 +171,185 @@ static int tmp007_write_raw(struct iio_dev
>*indio_dev,
>>  	return -EINVAL;
>>  }
>> =20
>> +static irqreturn_t tmp007_interrupt_handler(int irq, void *private)
>> +{
>> +	struct iio_dev *indio_dev =3D private;
>> +	struct tmp007_data *data =3D iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	ret =3D i2c_smbus_read_word_swapped(data->client, TMP007_STATUS);
>> +	if (ret < 0)
>
>|| !(ret & (_STATUSS_OHF | STATUS_OLF | =2E=2E))
>
Ack
>> +		return IRQ_NONE;
>> +
>> +	if (ret & TMP007_STATUS_OHF)
>> +		iio_push_event(indio_dev,
>> +				IIO_MOD_EVENT_CODE(IIO_TEMP, 0,
>> +					IIO_MOD_TEMP_OBJECT,
>> +					IIO_EV_TYPE_THRESH,
>> +					IIO_EV_DIR_RISING),
>> +				iio_get_time_ns(indio_dev));
>> +
>> +	if (ret & TMP007_STATUS_OLF)
>> +		iio_push_event(indio_dev,
>> +				IIO_MOD_EVENT_CODE(IIO_TEMP, 0,
>> +					IIO_MOD_TEMP_OBJECT,
>> +					IIO_EV_TYPE_THRESH,
>> +					IIO_EV_DIR_FALLING),
>> +				iio_get_time_ns(indio_dev));
>> +
>> +	if (ret & TMP007_STATUS_LHF)
>> +		iio_push_event(indio_dev,
>> +				IIO_MOD_EVENT_CODE(IIO_TEMP, 0,
>> +					IIO_MOD_TEMP_AMBIENT,
>> +					IIO_EV_TYPE_THRESH,
>> +					IIO_EV_DIR_RISING),
>> +				iio_get_time_ns(indio_dev));
>> +
>> +	if (ret & TMP007_STATUS_LLF)
>> +		iio_push_event(indio_dev,
>> +				IIO_MOD_EVENT_CODE(IIO_TEMP, 0,
>> +					IIO_MOD_TEMP_AMBIENT,
>> +					IIO_EV_TYPE_THRESH,
>> +					IIO_EV_DIR_FALLING),
>> +				iio_get_time_ns(indio_dev));
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int tmp007_write_event_config(struct iio_dev *indio_dev,
>> +		const struct iio_chan_spec *chan, enum iio_event_type type,
>> +		enum iio_event_direction dir, int state)
>> +{
>> +	struct tmp007_data *data =3D iio_priv(indio_dev);
>> +	unsigned int status_mask;
>> +	int ret;
>> +
>> +	switch (chan->channel2) {
>> +	case IIO_MOD_TEMP_AMBIENT:
>> +		if (dir =3D=3D IIO_EV_DIR_RISING)
>> +			status_mask =3D TMP007_STATUS_LHF;
>> +		else
>> +			status_mask =3D TMP007_STATUS_LLF;
>> +		break;
>> +	case IIO_MOD_TEMP_OBJECT:
>> +		if (dir =3D=3D IIO_EV_DIR_RISING)
>> +			status_mask =3D TMP007_STATUS_OHF;
>> +		else
>> +			status_mask =3D TMP007_STATUS_OLF;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>
>mutex around this?
Ack
>
>> +	ret =3D i2c_smbus_read_word_swapped(data->client,
>TMP007_STATUS_MASK);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (state)
>> +		ret |=3D status_mask;
>> +	else
>> +		ret &=3D ~status_mask;
>> +
>> +	return i2c_smbus_write_word_swapped(data->client,
>TMP007_STATUS_MASK,
>> +					data->status_mask =3D ret);
>> +}
>> +
>> +static int tmp007_read_event_config(struct iio_dev *indio_dev,
>> +		const struct iio_chan_spec *chan, enum iio_event_type type,
>> +		enum iio_event_direction dir)
>> +{
>> +	struct tmp007_data *data =3D iio_priv(indio_dev);
>> +	unsigned int mask;
>> +
>> +	switch (chan->channel2) {
>> +	case IIO_MOD_TEMP_AMBIENT:
>> +		if (dir =3D=3D IIO_EV_DIR_RISING)
>> +			mask =3D TMP007_STATUS_LHF;
>> +		else
>> +			mask =3D TMP007_STATUS_LLF;
>> +		break;
>> +	case IIO_MOD_TEMP_OBJECT:
>> +		if (dir =3D=3D IIO_EV_DIR_RISING)
>> +			mask =3D TMP007_STATUS_OHF;
>> +		else
>> +			mask =3D TMP007_STATUS_OLF;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return (bool)(data->status_mask & mask);
>
>return type is int, maybe use !! to force to 0/1
>
>return !!(data->status_mask & mask);
Ack
>
>> +}
>> +
>> +static int tmp007_read_thresh(struct iio_dev *indio_dev,
>> +		const struct iio_chan_spec *chan, enum iio_event_type type,
>> +		enum iio_event_direction dir, enum iio_event_info info,
>> +		int *val, int *val2)
>> +{
>> +	struct tmp007_data *data =3D iio_priv(indio_dev);
>> +	int ret;
>> +	u8 reg;
>> +
>> +	switch (chan->channel2) {
>> +	case IIO_MOD_TEMP_AMBIENT: /* LSB: 0=2E5 degree Celsius */
>> +		if (dir =3D=3D IIO_EV_DIR_RISING)
>> +			reg =3D TMP007_TDIE_HIGH_LIMIT;
>> +		else
>> +			reg =3D TMP007_TDIE_LOW_LIMIT;
>> +		break;
>> +	case IIO_MOD_TEMP_OBJECT:
>> +		if (dir =3D=3D IIO_EV_DIR_RISING)
>> +			reg =3D TMP007_TOBJ_HIGH_LIMIT;
>> +		else
>> +			reg =3D TMP007_TOBJ_LOW_LIMIT;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret =3D i2c_smbus_read_word_swapped(data->client, reg);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* Shift length 7 bits =3D 6(15:6) + 1(0=2E5 LSB) */
>> +	*val =3D sign_extend32(ret, 15) >> 7;
>> +
>> +	return IIO_VAL_INT;
>> +}
>> +
>> +static int tmp007_write_thresh(struct iio_dev *indio_dev,
>> +		const struct iio_chan_spec *chan, enum iio_event_type type,
>> +		enum iio_event_direction dir, enum iio_event_info info,
>> +		int val, int val2)
>> +{
>> +	struct tmp007_data *data =3D iio_priv(indio_dev);
>> +	u8 reg;
>> +
>> +	switch (chan->channel2) {
>> +	case IIO_MOD_TEMP_AMBIENT:
>> +		if (dir =3D=3D IIO_EV_DIR_RISING)
>> +			reg =3D TMP007_TDIE_HIGH_LIMIT;
>> +		else
>> +			reg =3D TMP007_TDIE_LOW_LIMIT;
>> +		break;
>> +	case IIO_MOD_TEMP_OBJECT:
>> +		if (dir =3D=3D IIO_EV_DIR_RISING)
>> +			reg =3D TMP007_TOBJ_HIGH_LIMIT;
>> +		else
>> +			reg =3D TMP007_TOBJ_LOW_LIMIT;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Full scale value is +/- 256 degree Celsius */
>
>I guess we want to specify milli degree Celsius according to
>sysfs-bus-iio=20
>for in_temp_raw
>
I didn't get what your are suggesting=2E Could you please explain?=20
>> +	if (val < -256 || val > 255)
>> +		return -EINVAL;
>> +
>> +	/* Shift length 7 bits =3D 6(15:6) + 1(0=2E5 LSB) */
>> +	return i2c_smbus_write_word_swapped(data->client, reg, (val << 7));
>> +}
>> +
>>  static IIO_CONST_ATTR(sampling_frequency_available, "4 2 1 0=2E5
>0=2E25");
>> =20
>>  static struct attribute *tmp007_attributes[] =3D {
>> @@ -167,6 +361,36 @@ static const struct attribute_group
>tmp007_attribute_group =3D {
>>  	=2Eattrs =3D tmp007_attributes,
>>  };
>> =20
>> +static const struct iio_event_spec tmp007_obj_event[] =3D {
>> +	{
>> +		=2Etype =3D IIO_EV_TYPE_THRESH,
>> +		=2Edir =3D IIO_EV_DIR_RISING,
>> +		=2Emask_separate =3D BIT(IIO_EV_INFO_VALUE) |
>> +			BIT(IIO_EV_INFO_ENABLE),
>> +	},
>> +	{
>> +		=2Etype =3D IIO_EV_TYPE_THRESH,
>> +		=2Edir =3D IIO_EV_DIR_FALLING,
>> +		=2Emask_separate =3D BIT(IIO_EV_INFO_VALUE) |
>> +			BIT(IIO_EV_INFO_ENABLE),
>> +	},
>> +};
>> +
>> +static const struct iio_event_spec tmp007_die_event[] =3D {
>> +	{
>> +		=2Etype =3D IIO_EV_TYPE_THRESH,
>> +		=2Edir =3D IIO_EV_DIR_RISING,
>> +		=2Emask_separate =3D BIT(IIO_EV_INFO_VALUE) |
>> +			BIT(IIO_EV_INFO_ENABLE),
>> +	},
>> +	{
>> +		=2Etype =3D IIO_EV_TYPE_THRESH,
>> +		=2Edir =3D IIO_EV_DIR_FALLING,
>> +		=2Emask_separate =3D BIT(IIO_EV_INFO_VALUE) |
>> +			BIT(IIO_EV_INFO_ENABLE),
>> +	},
>> +};
>> +
>>  static const struct iio_chan_spec tmp007_channels[] =3D {
>>  	{
>>  		=2Etype =3D IIO_TEMP,
>> @@ -175,6 +399,8 @@ static const struct iio_chan_spec
>tmp007_channels[] =3D {
>>  		=2Einfo_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
>>  				BIT(IIO_CHAN_INFO_SCALE),
>>  		=2Einfo_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +		=2Eevent_spec =3D tmp007_die_event,
>> +		=2Enum_event_specs =3D ARRAY_SIZE(tmp007_die_event),
>>  	},
>>  	{
>>  		=2Etype =3D IIO_TEMP,
>> @@ -183,12 +409,18 @@ static const struct iio_chan_spec
>tmp007_channels[] =3D {
>>  		=2Einfo_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
>>  				BIT(IIO_CHAN_INFO_SCALE),
>>  		=2Einfo_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> -	}
>> +		=2Eevent_spec =3D tmp007_obj_event,
>> +		=2Enum_event_specs =3D ARRAY_SIZE(tmp007_obj_event),
>> +	},
>>  };
>> =20
>>  static const struct iio_info tmp007_info =3D {
>> -	=2Eread_raw =3D tmp007_read_raw,
>> -	=2Ewrite_raw =3D tmp007_write_raw,
>> +	=2Eread_raw =3D &tmp007_read_raw,
>> +	=2Ewrite_raw =3D &tmp007_write_raw,
>
>unrelated change, no need for & for a function
Ack
>
>> +	=2Eread_event_config =3D &tmp007_read_event_config,
>> +	=2Ewrite_event_config =3D &tmp007_write_event_config,
>> +	=2Eread_event_value =3D &tmp007_read_thresh,
>> +	=2Ewrite_event_value =3D &tmp007_write_thresh,
>>  	=2Eattrs =3D &tmp007_attribute_group,
>>  	=2Edriver_module =3D THIS_MODULE,
>>  };
>> @@ -214,7 +446,6 @@ static int tmp007_probe(struct i2c_client
>*client,
>>  	struct tmp007_data *data;
>>  	struct iio_dev *indio_dev;
>>  	int ret;
>> -	u16  status;
>> =20
>>  	if (!i2c_check_functionality(client->adapter,
>I2C_FUNC_SMBUS_WORD_DATA))
>>  		return -EOPNOTSUPP;
>> @@ -243,8 +474,8 @@ static int tmp007_probe(struct i2c_client
>*client,
>>  	/*
>>  	 * Set Configuration register:
>>  	 * 1=2E Conversion ON
>> -	 * 2=2E Comparator mode
>> -	 * 3=2E Transient correction enable
>> +	 * 2=2E Transient correction enable
>> +	 * 3=2E ALERT enable
>>  	 */
>> =20
>>  	ret =3D i2c_smbus_read_word_swapped(data->client, TMP007_CONFIG);
>> @@ -252,7 +483,7 @@ static int tmp007_probe(struct i2c_client
>*client,
>>  		return ret;
>> =20
>>  	data->config =3D ret;
>> -	data->config |=3D (TMP007_CONFIG_CONV_EN | TMP007_CONFIG_COMP_EN |
>TMP007_CONFIG_TC_EN);
>> +	data->config |=3D (TMP007_CONFIG_CONV_EN | TMP007_CONFIG_TC_EN |
>TMP007_CONFIG_ALERT_EN);
>> =20
>>  	ret =3D i2c_smbus_write_word_swapped(data->client, TMP007_CONFIG,
>>  					data->config);
>> @@ -260,22 +491,39 @@ static int tmp007_probe(struct i2c_client
>*client,
>>  		return ret;
>> =20
>>  	/*
>> +	 * Only the following flags can activate ALERT pin=2E Data
>conversion/validity flags
>> +	 * flags can still be polled for getting temperature data
>> +	 *
>>  	 * Set Status Mask register:
>> -	 * 1=2E Conversion ready enable
>> -	 * 2=2E Data valid enable
>> +	 * 1=2E Object temperature high limit enable
>> +	 * 2=2E Object temperature low limit enable
>> +	 * 3=2E TDIE temperature high limit enable
>> +	 * 4=2E TDIE temperature low limit enable
>>  	 */
>> =20
>>  	ret =3D i2c_smbus_read_word_swapped(data->client,
>TMP007_STATUS_MASK);
>>  	if (ret < 0)
>>  		goto error_powerdown;
>> =20
>> -	status =3D ret;
>> -	status |=3D (TMP007_STATUS_CONV_READY | TMP007_STATUS_DATA_VALID);
>> +	data->status_mask =3D ret;
>> +	data->status_mask |=3D (TMP007_STATUS_OHF | TMP007_STATUS_OLF
>> +				| TMP007_STATUS_LHF | TMP007_STATUS_LLF);
>> =20
>> -	ret =3D i2c_smbus_write_word_swapped(data->client,
>TMP007_STATUS_MASK, status);
>> +	ret =3D i2c_smbus_write_word_swapped(data->client,
>TMP007_STATUS_MASK, data->status_mask);
>>  	if (ret < 0)
>>  		goto error_powerdown;
>> =20
>> +	if (client->irq) {
>> +		ret =3D devm_request_threaded_irq(&client->dev, client->irq,
>> +				NULL, tmp007_interrupt_handler,
>> +				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>> +				tmp007_id->name, indio_dev);
>> +		if (ret) {
>> +			dev_err(&client->dev, "irq request error %d\n", -ret);
>> +			goto error_powerdown;
>> +		}
>> +	}
>
>what happens when there is no IRQ? it would be nice to still use the=20
>driver (without event capability)
>
I guess if (client->irq) checks for it=2E  And believe it works without in=
terrupt as well=2E  Correct me if I'm wrong=2E=20
>> +
>>  	return iio_device_register(indio_dev);
>> =20
>>  error_powerdown:
>> @@ -312,6 +560,16 @@ static int tmp007_resume(struct device *dev)
>>  	return i2c_smbus_write_word_swapped(data->client, TMP007_CONFIG,
>>  			data->config | TMP007_CONFIG_CONV_EN);
>>  }
>> +#else
>
>this seems to be unrelated to the patch
>
Ack
>> +static int tmp007_suspend(struct device *dev)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int tmp007_resume(struct device *dev)
>> +{
>> +	return 0;
>> +}
>>  #endif
>> =20
>>  static SIMPLE_DEV_PM_OPS(tmp007_pm_ops, tmp007_suspend,
>tmp007_resume);
>>=20

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
