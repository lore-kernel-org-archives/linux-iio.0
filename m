Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5186423D295;
	Mon, 14 Sep 2026 00:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789345499; cv=none; b=Dep6tSzrEG6s2V+pdgb/rhMhwuL/hLkf4YCpW4IrGZDQcGSQfUhw/7kdiTkxWSw2WMOPeyT0IfkCfHjyeSS+aKHpmJZ5OB06wtEYgQl6z7HVfR5UjiW+Fjjp/udzITTaiyklN2eO+/YLAMpfKWPVuUY9Ec8xQX3K9raghSHCXCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789345499; c=relaxed/simple;
	bh=ZZDckdZQufNfz7OQGOgfqCpdbTEo/Vr5DJjtpearVvo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABbu+NkVkxFsUV2WOpr4APVNKeZLeUiHIrcUqUS6vgBepVtu2C7te0fV6OlFm1fpjf/gBsjBlKIANVFPW5vdHMURULgKjyZH36lp3a4cK3xOrDYOyVjd6TlZu0+CmEezUb/s6r5+VXezzKXDfJX2K5DmWR/wbV7apyyGLyQGvd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1GvFMjQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1GvFMjQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713851F000FF;
	Mon, 14 Sep 2026 00:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789345496;
	bh=sMp4OlxMubDm15/O1egPO7x6gi2SBim6wJVLfxemPt0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=P1GvFMjQDkq8XR8ZtQH5igQks7LO2esgJ1K1turIrUD4wXsZGj8MFrCdvkH7deeeh
	 e/o4NIu6IVqn5MZqB5ShvD6joF94ARdBe5ZZsb0bQRKTnvr+jUc1KFzAFFssw3Rdw4
	 3V3zxiHxoXBguvZNS9nvLSXuI70jqvVYUpu44k6GP5goN/fPiuYnGpFCOtU+6w2Q0g
	 34PTzvROTyuicV7XmxkVCIxSjhTVufR8cElsAPQtRLmmshY53BaKAwPDZWITwpcLBL
	 6PiGq7qCsGD6Bq6f87wxwh5UefocbIdVx9orM+N3ZdYD9Y8pJ87dPvTnqBrsPRIW/r
	 2pp1WgFCJW20w==
Date: Mon, 14 Sep 2026 01:24:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Guenter Roeck <linux@roeck-us.net>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: adc: add support for PAC1711
Message-ID: <20260914012448.15b14540@jic23-hlaptop>
In-Reply-To: <20260909-pac1711-v3-2-dff81003b82f@microchip.com>
References: <20260909-pac1711-v3-0-dff81003b82f@microchip.com>
	<20260909-pac1711-v3-2-dff81003b82f@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Sep 2026 15:23:35 +0300
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> This is the iio driver for Microchip PAC1711, PAC1721, PAC1811 and
> PAC1821 single-channel power monitors with accumulator. The PAC1711 and
> PAC1721 devices use 12-bit resolution for voltage and current measurements
> and 24 bits for power calculations, while PAC1811 and PAC1821 have 16-bit
> resolution and use 32 bits for power calculations. The 56-bit accumulator
> register accumulates power (energy) or current (Coulomb counter).
> 
> PAC1711 and PAC1811 measure up to 42V Full-Scale Range, respectively 9V for
> PAC1721 and PAC1821.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
sashiko has quite a bit to say. Please take a look.
https://sashiko.dev/#/patchset/20260909-pac1711-v3-0-dff81003b82f%40microchip.com

Not sure if I missed it on previous but the way you have
features structures in here has missed the aim of that design
pattern.  If you see any use of chip ids outside of the actual
match then you have stuff as code that should be const data.

Jonathan

> ---
>  .../ABI/testing/sysfs-bus-iio-adc-pac1711          |   24 +
>  MAINTAINERS                                        |    2 +
>  drivers/iio/adc/Kconfig                            |   11 +
>  drivers/iio/adc/Makefile                           |    1 +
>  drivers/iio/adc/pac1711.c                          | 1304 ++++++++++++++++++++
>  5 files changed, 1342 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1711 b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1711
> new file mode 100644
> index 0000000000000000000000000000000000000000..679b331e455624f493d7c326843cbbe4a129e924
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1711
> @@ -0,0 +1,24 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_coulomb_counter_raw
> +KernelVersion:	7.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute is used to read the accumulated voltage
> +		measured on the shunt resistor (Coulomb counter). Units
> +		after application of scale are milliCoulombs. X is the IIO index
> +		of the device.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_coulomb_counter_scale
> +KernelVersion:	7.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		If known for a device, scale to be applied to
> +		in_coulomb_counter_raw in order to obtain the measured
> +		value in milliCoulombs. X is the IIO index of the device.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_coulomb_counter_en
> +KernelVersion:	7.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute, if available, is used to enable digital
> +		accumulation of VSENSE measurements. X is the IIO index of
> +		the device.

Why are treating these 3 as custom?  The look like a standard thing we
might want to measure.  Look instead to add a new channel type and
handle them that way.

> diff --git a/drivers/iio/adc/pac1711.c b/drivers/iio/adc/pac1711.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..f23d08205952f9eda16bf88826a740120de55988
> --- /dev/null
> +++ b/drivers/iio/adc/pac1711.c
...

> +
> +/**
> + * struct pac1711_features - features of a pac1711 instance
> + * @name: chip's name
> + * @prod_id: hardware ID

This misses the point of having features type structures.
They must contain everything that is specific to that device and
typically do not contain a product_id.  Take a look at the many
other drivers in tree that have structures called things like chip_info.
This should include things like whether it is capable of 16 bits.
The only code that ever uses the product ID should be the function
you have that goes from what is read from the register to the relevant
instance of the _features structure.

> + */
> +struct pac1711_features {
> +	const char *name;
> +	u8 prod_id;
> +};
> +
> +static const struct pac1711_features pac1711_chip_features = {
> +	.name = "pac1711",
> +	.prod_id = PAC1711_PRODUCT_ID_1711,
> +};
...

> +/**
> + * struct pac1711_chip_info - information about the chip
> + * @chip_reg_data:		measurement/control/accumulator output device registers
> + * @iio_info:			device information
> + * @client:			the I2C client attached to the device
> + * @work_chip_refresh:		work queue used for refresh commands
> + * @lock:			synchronize access to driver's state members
> + * @shunt:			shunt resistor value
> + * @vbus_mode:			Full Scale Range (FSR) mode for VBus
> + * @vsense_mode:		Full Scale Range (FSR) mode for VSense
> + * @accumulation_mode:		accumulation mode for hardware accumulator
> + * @sample_rate_idx:		sampling frequency index
> + * @chip_variant:		chip variant
> + * @voltage_range_idx:		Voltage range based on part number
> + * @enable_acc:			true means that accumulation channel is enabled
> + * @has_16bit_resolution:	true if device is part of the PAC18x1 family
> + */
> +struct pac1711_chip_info {
> +	struct reg_data		chip_reg_data;
> +	struct iio_info		iio_info;
> +	struct i2c_client	*client;
> +	struct delayed_work	work_chip_refresh;
> +	/* Prevents concurrent writes into control, voltage measurement or accumulator registers. */
> +	struct mutex		lock;
> +	u32			shunt;
> +	u8			vbus_mode;
> +	u8			vsense_mode;
> +	u8			accumulation_mode;
> +	u8			sample_rate_idx;
> +	u8			chip_variant;

If you are storing the chip id after probe the driver is not correctly
doing the whole chip_info / features selection of structure pattern.
So this needs to go.

What you want to end up with is a pointer to const structure with
all the stuff in it that you are deriving from this variant.

> +	u8			voltage_range_idx;
> +	bool			enable_acc;
> +	bool			has_16bit_resolution;
> +};


> +
> +static int pac1711_get_samp_rate_idx(u32 new_samp_rate)
> +{
> +	int cnt;
> +
> +	for (cnt = 0; cnt < ARRAY_SIZE(pac1711_samp_rate_map_tbl); cnt++)
	for (unsigned int cnt = 0; ...

> +		if (new_samp_rate == pac1711_samp_rate_map_tbl[cnt])
> +			return cnt;
> +
> +	return -EINVAL;
> +}

> +
> +static IIO_DEVICE_ATTR(in_coulomb_counter_raw, 0444,
> +		       pac1711_in_coulomb_counter_raw_show, NULL, 0);
> +
> +static IIO_DEVICE_ATTR(in_coulomb_counter_scale, 0444,
> +		       pac1711_in_coulomb_counter_scale_show, NULL, 0);
> +
> +static IIO_DEVICE_ATTR(in_coulomb_counter_en, 0644,
> +		       pac1711_in_enable_acc_show, pac1711_in_enable_acc_store, 0);
> +
> +static struct attribute *pac1711_coulomb_counter_attr[] = {
> +	PAC1711_DEV_ATTR(in_coulomb_counter_raw),
> +	PAC1711_DEV_ATTR(in_coulomb_counter_scale),
> +	PAC1711_DEV_ATTR(in_coulomb_counter_en),

Why aren't we adding a standard channel type? Seems like that would make more
sense given these attributes.


> +	NULL
> +};
> +
> +static const struct attribute_group pac1711_coulomb_counter_group = {
> +	.attrs = pac1711_coulomb_counter_attr,
> +};
> +
> +/*
> + * The value of the shunt resistor may be known only at runtime and set by a client
> + * application. This attribute allows to set its value in micro-ohms. Y is the channel
> + * number. The value is used to calculate current, power and accumulated energy or
> + * Coulomb counter.
> + */
> +static ssize_t pac1711_write_shunt_resistor(struct iio_dev *indio_dev, uintptr_t private,
> +					    const struct iio_chan_spec *ch, const char *buf,
> +					    size_t len)
> +{
> +	struct pac1711_chip_info *info = iio_priv(indio_dev);
> +	struct device *dev = &info->client->dev;
> +	unsigned int sh_val;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 10, &sh_val);
> +	if (ret) {
> +		dev_err(dev, "Shunt value is not valid\n");
> +		return ret;
> +	}
> +
> +	if (sh_val == 0)
> +		return -EINVAL;
> +
> +	scoped_guard(mutex, &info->lock)

Can just use a guard()

> +		info->shunt = sh_val;
> +
> +	return len;
> +}
> +
> +static const struct iio_chan_spec_ext_info pac1711_ext_info[] = {
> +	{
> +		.name = "in_shunt_resistor",
> +		.read = pac1711_read_shunt_resistor,
> +		.write = pac1711_write_shunt_resistor,
> +		.shared = IIO_SHARED_BY_ALL,
> +	},
> +	{ }
> +};
> +
> +#define TO_PAC1711_CHIP_INFO(d) container_of(d, struct pac1711_chip_info, work_chip_refresh)

This is only used once. I'd not bother with the define.


> +
> +static int pac1711_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct pac1711_chip_info *info = iio_priv(indio_dev);
> +	int ret;
> +	u64 tmp = 0;

reverse xmas when nothing prevents it.

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = pac1711_retrieve_data(info, PAC1711_MIN_UPDATE_WAIT_TIME_US);
> +		if (ret)
> +			return ret;
> +
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			*val = info->chip_reg_data.vbus;
> +			return IIO_VAL_INT;
> +		case IIO_CURRENT:
> +			*val = info->chip_reg_data.vsense;
> +			return IIO_VAL_INT;
> +		case IIO_POWER:
> +			*val = (u32)info->chip_reg_data.vpower;
> +			*val2 = (u32)(info->chip_reg_data.vpower >> 32);
> +			return IIO_VAL_INT_64;
> +		case IIO_ENERGY:
> +			*val = (u32)info->chip_reg_data.acc_val;
> +			*val2 = (u32)(info->chip_reg_data.acc_val >> 32);
> +			return IIO_VAL_INT_64;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->address) {
> +		case PAC1711_VBUS_REG_ADDR:
> +			/* Voltages - scale for millivolts */
> +			switch (info->chip_variant) {
> +			case PAC1711_PRODUCT_ID_1711:
> +			case PAC1711_PRODUCT_ID_1811:
> +				*val = PAC1711_VOLTAGE_MILLIVOLTS_MAX;
> +				break;
> +			case PAC1711_PRODUCT_ID_1721:
> +			case PAC1711_PRODUCT_ID_1821:
> +				*val = PAC1721_VOLTAGE_MILLIVOLTS_MAX;
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +
> +			*val2 = (info->vbus_mode == PAC1711_FULL_RANGE_BIPOLAR) ? 15 : 16;
> +
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		case PAC1711_VSENSE_REG_ADDR:
> +			/*
> +			 * Currents - scale for mA - depends on the channel's shunt value
> +			 * (100mV * 1000000) / (2^16 * shunt(uohm))
> +			 */
> +			*val = 1526;
> +			*val2 = info->shunt;
> +
> +			if (info->vsense_mode == PAC1711_FULL_RANGE_BIPOLAR)
> +				*val = *val << 1;
> +
> +			return IIO_VAL_FRACTIONAL;
> +		case PAC1711_VPOWER_REG_ADDR:
> +		case PAC1711_VACC_REG_ADDR:
> +			/*
> +			 * Power - uW - it will use the combined scale
> +			 * for current and voltage
> +			 * current(mA) * voltage(mV) = power (uW)
> +			 */
> +			switch (info->chip_variant) {
> +			case PAC1711_PRODUCT_ID_1711:
This stuff all needs to be data in the _features structure. Making this
sort of switch statement become a look up of a value in a
static const structure that we have a pointer to.

			tmp = info->features->voltage_pv_fsr;

> +			case PAC1711_PRODUCT_ID_1811:
> +				tmp = PAC1711_PRODUCT_VOLTAGE_PV_FSR;
> +				break;
> +			case PAC1711_PRODUCT_ID_1721:
> +			case PAC1711_PRODUCT_ID_1821:
> +				tmp = PAC1721_PRODUCT_VOLTAGE_PV_FSR;
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +
> +			do_div(tmp, info->shunt);
> +			*val = (int)tmp;
> +
> +			if (chan->type == IIO_ENERGY)
> +				*val2 = info->has_16bit_resolution ? 32 : 24;
> +			else
> +				*val2 = 32;
> +
> +			if (info->vsense_mode == PAC1711_FULL_RANGE_BIPOLAR)
> +				*val2 -= 1;
> +
> +			if (info->vbus_mode == PAC1711_FULL_RANGE_BIPOLAR)
> +				*val2 -= 1;
> +
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		scoped_guard(mutex, &info->lock) {
> +			*val = pac1711_samp_rate_map_tbl[info->sample_rate_idx];
> +		}
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_ENABLE:
> +		*val = info->enable_acc;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int pac1711_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct pac1711_chip_info *info = iio_priv(indio_dev);
> +	struct i2c_client *client = info->client;
> +	struct device *dev = &info->client->dev;
> +	s32 old_samp_rate;
> +	int new_idx, ret, refresh_time;

Where ordering doesn't matter for other reasons, use reverse xmas tree.

> +	__be16 val_be16;
> +	u16 val_u16;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		scoped_guard(mutex, &info->lock) {
> +			old_samp_rate = pac1711_samp_rate_map_tbl[info->sample_rate_idx];
> +			new_idx = pac1711_get_samp_rate_idx(val);
> +			if (new_idx < 0)
> +				return new_idx;
> +
> +			ret = i2c_smbus_read_i2c_block_data(client, PAC1711_CTRL_ACT_REG_ADDR,
> +							    sizeof(val_u16), (u8 *)&val_be16);
> +			if (ret != sizeof(val_u16)) {
> +				dev_err(&client->dev, "cannot read regs from 0x%02X\n",
> +					PAC1711_CTRL_ACT_REG_ADDR);
> +				return ret < 0 ? ret : -EIO;
> +			}
> +
> +			val_u16 = be16_to_cpu(val_be16);
> +			FIELD_MODIFY(PAC1711_CTRL_SAMPLE_MODE_MASK, &val_u16, new_idx);
> +			ret = i2c_smbus_write_i2c_block_data(client, PAC1711_CTRL_REG_ADDR,
> +							     sizeof(val_be16), (u8 *)&val_be16);

There was a sashiko query on this one for why you aren't writing back update value.
Perhaps a comment if that is intentional.

> +			if (ret) {
> +				dev_err(dev, "Failed to configure sampling mode in 0x%02X\n",
> +					PAC1711_CTRL_ACT_REG_ADDR);
> +				return ret;
> +			}
> +
> +			info->sample_rate_idx = new_idx;
> +			info->chip_reg_data.ctrl_act_reg = val_u16;
> +
> +			/* Force register snapshot and timestamp update with a refresh. */
> +			refresh_time = msecs_to_jiffies(PAC1711_MIN_POLLING_TIME_MS) - 1;
> +			info->chip_reg_data.jiffies_tstamp -= refresh_time;
> +		}
> +
> +		ret = pac1711_retrieve_data(info, ((1024 * 1000) / old_samp_rate));
> +		if (ret) {
> +			dev_err(dev, "%s - cannot snapshot ctrl and measurement regs\n", __func__);
> +			return ret;
> +		}
> +
> +		return 0;
> +	case IIO_CHAN_INFO_ENABLE:
> +		if (chan->type != IIO_ENERGY)
> +			return -EINVAL;
> +
> +		return pac1711_set_acc_enable(info, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static int pac1711_init_variant(struct iio_dev *indio_dev, struct pac1711_chip_info *info)
> +{
> +	switch (info->chip_variant) {
> +	case PAC1711_PRODUCT_ID_1711:

This has me confused. All data specific to a given part should be in the
pac1721_chip_features and similar structures. We should just be picking
between them based on the detected chip ID (and just using them if
using the dt fallback path).
This should look something like

static struct pac1711_get_features_from_id(u8 id)
{
	switch (id) {
		case PAC1711_PRODUCT_ID_1711:
			return &pac1711_features;
...
	default:
		return ERR_PTR(-ENODATA);
	}
}



> +		info->has_16bit_resolution = false;
> +		info->voltage_range_idx = PAC1711_VOLTAGE_RANGE_IDX;
> +		indio_dev->name = pac1711_chip_features.name;
> +		return 0;
> +	case PAC1711_PRODUCT_ID_1721:
> +		info->has_16bit_resolution = false;
> +		info->voltage_range_idx = PAC1721_VOLTAGE_RANGE_IDX;
> +		indio_dev->name = pac1721_chip_features.name;
> +		return 0;
> +	case PAC1711_PRODUCT_ID_1811:
> +		info->has_16bit_resolution = true;
> +		info->voltage_range_idx = PAC1711_VOLTAGE_RANGE_IDX;
> +		indio_dev->name = pac1811_chip_features.name;
> +		return 0;
> +	case PAC1711_PRODUCT_ID_1821:
> +		info->has_16bit_resolution = true;
> +		info->voltage_range_idx = PAC1721_VOLTAGE_RANGE_IDX;
> +		indio_dev->name = pac1821_chip_features.name;
> +		return 0;
> +	default:
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pac1711_chip_identify(struct iio_dev *indio_dev, struct pac1711_chip_info *info)
> +{
> +	struct i2c_client *client = info->client;
> +	struct device *dev = &client->dev;
> +	u8 chip_rev_info[3] = { 0 };

= { };

is the standard c way of doing that in newer versions of the standard and
works in old compilers (there are self tests to ensure that!)

> +	int ret;
> +
> +	ret = i2c_smbus_read_i2c_block_data(client, PAC1711_PID_REG_ADDR,
> +					    sizeof(chip_rev_info), chip_rev_info);
> +	if (ret != sizeof(chip_rev_info)) {
> +		ret = ret < 0 ? ret : -EIO;
> +		dev_err(dev, "product ID (0x%02X, 0x%02X, 0x%02X) not recognized %d\n",
> +			chip_rev_info[0], chip_rev_info[1], chip_rev_info[2], ret);
> +		return ret;

Only run in probe so use dev_err_probe()

> +	}
> +
> +	info->chip_variant = chip_rev_info[0];
> +
> +	return pac1711_init_variant(indio_dev, info);
> +}
> +
> +static int pac1711_check_range(struct device *dev, s32 *vals, bool is_vbus,
> +			       unsigned int voltage_range_idx)
> +{
> +	int num_ranges = ARRAY_SIZE(pac1711_vbus_range_tbl[PAC1711_VOLTAGE_RANGE_IDX]);
> +	const int (*ranges)[3][2];
> +	int i;
> +
> +	if (is_vbus)
> +		switch (voltage_range_idx) {
> +		case PAC1711_VOLTAGE_RANGE_IDX:
> +			ranges = &pac1711_vbus_range_tbl[PAC1711_VOLTAGE_RANGE_IDX];
> +			break;
> +		case PAC1721_VOLTAGE_RANGE_IDX:
> +			ranges = &pac1711_vbus_range_tbl[PAC1721_VOLTAGE_RANGE_IDX];
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	else
> +		ranges = &pac1711_vsense_range_tbl;
	if (is_vbus) {
		....
	} else {
		ranges = &pac1711_vsense_range_tbl;
	}
Whilst you could technically argue the switch is one statement
it is not easy to parse visually so the extra brackets should be there.

> +
> +	for (i = 0; i < num_ranges; i++) {
	for (int i = 0; ...

> +		if (vals[0] == (*ranges)[i][0] && vals[1] == (*ranges)[i][1])
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int pac1711_init_vbus_vsense_ranges(struct pac1711_chip_info *info, bool is_vbus)
> +{
> +	struct i2c_client *client = info->client;
> +	struct device *dev = &client->dev;
> +	const char *prop_name;
> +	u32 vals[2];
> +	int ret;
> +
> +	if (is_vbus)
> +		prop_name = "microchip,vbus-input-range-microvolt";
> +	else
> +		prop_name = "microchip,vsense-input-range-microvolt";
> +
> +	ret = device_property_read_u32_array(dev, prop_name, vals, 2);
> +	if (ret) {
> +		dev_dbg(dev, "%s property error %X\n", prop_name, ret);
> +		/* Set default range to PAC1711_FULL_RANGE_UNIPOLAR */
> +		ret = PAC1711_FULL_RANGE_UNIPOLAR;

There are different things here that should be handled. The normal
case is the property isn't present, the other is that it is but
we can't read it. Trick is to use a presence check to separate
the not present case at the start.


	if (device_property_present(dev, prop_name)) {
		ret = device_property_read_u32_array(dev, prop_name, vals, 2);
		if (ret)
			return dev_err_probe();
		
		ret = pac1711_check_range(dev, (s32 *)vals, is_vbus, info->voltage_range_idx);
		if (ret < 0)
			return dev_err_probe(dev, -EINVAL, "Invalid value %d, %d for prop %s\n",
					     vals[0], vals[1], prop_name);
	} else {
		dev_dbg(dev, "%s property error %X\n", prop_name, ret);
		/* Set default range to PAC1711_FULL_RANGE_UNIPOLAR */
		ret = PAC1711_FULL_RANGE_UNIPOLAR;
	}

I haven't checked to see if you have more places where this pattern would help.
Please see if you have and look to update them all. Note this is what is
considered best practice today, but in the past we did it like you had things
and there are a lot of drivers we haven't updated yet.

> +	} else {
> +		ret = pac1711_check_range(dev, (s32 *)vals, is_vbus, info->voltage_range_idx);
> +		if (ret < 0)
> +			return dev_err_probe(dev, -EINVAL, "Invalid value %d, %d for prop %s\n",
> +					     vals[0], vals[1], prop_name);
> +	}
> +
> +	if (is_vbus)
> +		info->vbus_mode = ret;
> +	else
> +		info->vsense_mode = ret;
> +
> +	return 0;
> +}
