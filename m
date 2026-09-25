Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017DB14A8B;
	Fri, 25 Sep 2026 03:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790306825; cv=none; b=hN8AiA8mvMXb761BAXu4J9KQVTl5RD18Nv0Yt2/V0Oe1f0F5EWx9XTegnYZTO4G/cTh8A50v0eBIEvKQnAqnNMQ2sdT+zjfO0MNhueRdXSqILujThcgi4Whai1aXnetorafqdaaThAmZv4O96ok0XVRVz7KAzQJp+axKF+LAe8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790306825; c=relaxed/simple;
	bh=P9t97RDKLEnkJ1lCsiACK03Bg1WxQ/XDLM3PZPcveKc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+m6afgNWNW8Ne6imiTMqzpCG9q4rpuY9Atzf9/ebRlnErW5GPhhhybJwr6e+nvhKS8Qo8ErSWSSy7FbaQ8SX+BXsYDQ3z3HFY5C4Qcua9ORyauz+44VWuVdzgw7Z/+ngO7PUsaQAw5tlchCxK93KS021/wItml3iST+B7WoRUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6NE/FwI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6NE/FwI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF1E1F000FF;
	Fri, 25 Sep 2026 03:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790306823;
	bh=iJP8603el2jv5SU6ykeH/cSRwUgsLtwGRNh0RSceOUI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=a6NE/FwIHq+Ap4WVXXysp5UPKopj+Uyx9+bOj0DGDCvnaXh1PRtGDhlG49wunzfoP
	 EW+maVS3rDVTmT1FfyF6aYzDBjtfgwimwiiFrUNEwm5B/GMFdv4OZPNzY3icA2UIPd
	 BXUh2YOTKzdvQJP4WGhpV4cJ4GGB6vstKh0mO6RFSQ+Gfyg+KLmQaTluHXnLVgeNmB
	 Td8wP4OF1AfP2T+xZgj3fg+g/Sj6k2bDUFuiR0kQGyVi+Vt4zx+kyS9wZGwasCb36m
	 rMFOhFsfwB5HNPg5MSLn1EhnTVmEXx5ZYQZBsdOnFx5UiUHd7UykPWBv//FVr7BFAP
	 I/Tj2kLOydwPQ==
Date: Fri, 25 Sep 2026 04:26:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: add driver for the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
Message-ID: <20260925042653.15608e9b@jic23-hlaptop>
In-Reply-To: <20260924-topic-sm8x50-iio-max34417-adc-v2-2-9a0609e72f5c@linaro.org>
References: <20260924-topic-sm8x50-iio-max34417-adc-v2-0-9a0609e72f5c@linaro.org>
	<20260924-topic-sm8x50-iio-max34417-adc-v2-2-9a0609e72f5c@linaro.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 15:14:16 +0200
Neil Armstrong <neil.armstrong@linaro.org> wrote:

> The MAX34417 is a specialized current and voltage monitor used to
> determine power consumption of portable systems. The driver support
> getting the channels voltage and accumulated average power over an
> I2C/SMBUS serial interface.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

A few comments inline.  For a new driver I'd wait a week before sending an
update. Whilst you've gotten quite a few reviews already it is good to make
sure any discussion has died down before moving on to the next version.


Thanks,

Jonathan

> diff --git a/drivers/iio/adc/max34417.c b/drivers/iio/adc/max34417.c
> new file mode 100644
> index 000000000000..98d961c5ecee
> --- /dev/null
> +++ b/drivers/iio/adc/max34417.c
> @@ -0,0 +1,374 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * IIO driver for Maxim MAX34417 ADC, 4-Channels High Dynamic Range Power Accumulator
> + *
> + * Datasheet: https://www.analog.com/en/products/max34417.html
> + *
> + * TODO: Slow Mode, Continuous Accumulate Mode, Park Feature, Bulk Update, Perr_Verr Correction
> + */

> +#define MAX34417_CHANNEL(_index, _v_address, _power_address)	\
> +	{							\
> +		.type = IIO_VOLTAGE,				\
> +		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) | \
> +					  BIT(IIO_CHAN_INFO_SCALE), \
> +		.channel = (_index),				\
> +		.address = (_v_address),			\
> +		.indexed = 1,					\
> +	},							\
> +	{							\
> +		.type = IIO_POWER,				\

As below. This smells like it might not be an actual power channel if it
is accumulated on a fixed frequency.  It'll be some sort of scaled IIO_ENERGY
channel.  If you want to present it as power (which may make sense) then
it may need a little maths.

> +		.info_mask_separate	= BIT(IIO_CHAN_INFO_AVERAGE_RAW) | \
> +					  BIT(IIO_CHAN_INFO_SCALE), \
> +		.channel = (_index),				\
> +		.address = (_power_address),			\
> +		.indexed = 1,					\
> +	}
> +
> +static const struct iio_chan_spec max34417_channels[] = {
> +	MAX34417_CHANNEL(0, MAX34417_V_CH1_REG, MAX34417_PWR_ACC_1_REG),
> +	MAX34417_CHANNEL(1, MAX34417_V_CH2_REG, MAX34417_PWR_ACC_2_REG),
> +	MAX34417_CHANNEL(2, MAX34417_V_CH3_REG, MAX34417_PWR_ACC_3_REG),
> +	MAX34417_CHANNEL(3, MAX34417_V_CH4_REG, MAX34417_PWR_ACC_4_REG),
> +};
> +
> +/* TODO Implement trigger to update accumulator once and get all channels at once */
> +
> +static int max34417_accumulator_update(struct max34417_data *max34417)
> +{
> +	int rc;
> +
> +	rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
> +	if (rc) {
> +		dev_err(max34417->dev, "Error (%d) writing update register\n", rc);
> +		return rc;
> +	}
> +
> +	/* Wait for accumulator update */
> +	fsleep(1000);
> +
> +	return 0;
> +}
> +
> +static int max34417_read_voltage(struct max34417_data *max34417,
> +				 const struct iio_chan_spec *chan, int *val)
> +{
> +	uint16_t voltage;
> +	uint8_t buf[3];
> +	int rc;
> +
> +	guard(mutex)(&max34417->lock);
> +
> +	rc = max34417_accumulator_update(max34417);
> +	if (rc)
> +		return rc;
> +
> +	rc = regmap_noinc_read(max34417->regmap, chan->address, &buf, 3);
> +	if (rc)
> +		return rc;
> +
> +	voltage = buf[2] | ((uint64_t)buf[1] << 8);

get_unaligned_be16();

> +	voltage >>= 2;
> +
> +	*val = voltage;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int max34417_read_power(struct max34417_data *max34417,
> +			       const struct iio_chan_spec *chan,
> +			       int *val, int *val2)
> +{
> +	uint32_t acc_count;
> +	uint64_t power;
> +	uint8_t buf[8];
Kernel types so u32, u64, u8

> +	int rc;
> +
> +	guard(mutex)(&max34417->lock);
> +
> +	rc = max34417_accumulator_update(max34417);
> +	if (rc)
> +		return rc;
> +
> +	rc = regmap_noinc_read(max34417->regmap, MAX34417_ACC_COUNT_REG,
> +			       &buf, 4);
> +	if (rc)
> +		return rc;
> +
> +	acc_count = buf[3] | ((uint64_t)buf[2] << 8) | ((uint64_t)buf[1] << 16);

get_unaligned_be24(buf);

> +	if (!acc_count)
> +		return -EIO;
> +
> +	rc = regmap_noinc_read(max34417->regmap, chan->address, &buf, 8);
> +	if (rc)
> +		return rc;
> +
> +	power = buf[7];
> +	power |= ((uint64_t)buf[6] << 8UL);
> +	power |= ((uint64_t)buf[5] << 16UL);
> +	power |= ((uint64_t)buf[4] << 24UL);
> +	power |= ((uint64_t)buf[3] << 32UL);
> +	power |= ((uint64_t)buf[2] << 40UL);
> +	power |= ((uint64_t)buf[1] << 48UL);

Hmm. i think this is the second 56 bit endian reader we've had
recently.  Time to add get_unaligned_be56()

> +
> +	power = div_u64(power, acc_count);
> +
> +	*val = FIELD_GET(GENMASK_ULL(31, 0), power);
> +	*val2 = FIELD_GET(GENMASK_ULL(55, 32), power);
> +
> +	return IIO_VAL_INT_64;
> +}
> +
> +static int max34417_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct max34417_data *max34417 = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->type == IIO_VOLTAGE)
To reduce indent I'd flip it
		if (chan->type != IIO_VOLTAGE)
			return -EINVAL;

> +			return max34417_read_voltage(max34417, chan, val);
> +
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_AVERAGE_RAW:
> +		if (chan->type == IIO_POWER)
> +			return max34417_read_power(max34417, chan, val, val2);
> +
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_VOLTAGE) {
> +			/* Scale to mA */

On a voltage channel?  That is unlikely to be correct.

> +			*val = MAX34417_VOLTAGE_CORRECTION_SCALE * MILLI;
> +			*val2 = MAX34417_VOLTAGE_FULL_SCALE_BITS;
> +
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		} else if (chan->type == IIO_POWER) {

Actually power or accumulated power (otherwise known as energy!)

> +			/* Scale to mW */
> +			*val = max34417->input_correction[chan->channel] * MILLI;
> +			*val2 = MAX34417_PWR_AVG_FULL_SCALE_BITS;
> +
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		}
> +
> +		return -EINVAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}


> +
> +static unsigned int max34417_calc_input_correction(u32 rsense)
> +{
> +	/* (100 milliOhm / rsense) * MAX34417_PWR_CORRECTION_SCALE */
> +	return (100 * MILLI * MAX34417_PWR_CORRECTION_SCALE) / rsense;
> +}
> +
> +static int max34417_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct max34417_data *max34417;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	int rc, i;
> +
> +	regmap = devm_regmap_init_i2c(client, &max34417_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap), "regmap_init failed\n");
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*max34417));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	rc = devm_regulator_get_enable(dev, "vdd");
> +	if (rc)
> +		return dev_err_probe(dev, rc, "failed to get vdd regulator\n");
> +
> +	rc = devm_regulator_get_enable(dev, "vio");
> +	if (rc)
> +		return dev_err_probe(dev, rc, "failed to get vio regulator\n");
> +
> +	max34417 = iio_priv(indio_dev);
> +	max34417->regmap = regmap;
> +	max34417->dev = dev;
> +	mutex_init(&max34417->lock);
For new code
	ret = devm_mutex_init(...)
	if (ret)
		return ret;

Brings some debug logic in which might be a little bit useful to someone
and it's cheap to do.

> +
> +	/* Set default input correction for all channels */
> +	for (i = 0; i < MAX34417_CHANNEL_COUNT; ++i)
	for (unsigned int i = 0; .... i++)

> +		max34417->input_correction[i] =
> +			max34417_calc_input_correction(MAX34417_DEFAULT_RSENSE);
> +
> +	device_for_each_child_node_scoped(dev, node) {
> +		u32 rsense, index;
> +
> +		if (fwnode_property_read_u32(node, "reg", &index))
> +			return dev_err_probe(dev, -EINVAL, "missing reg property of %pfwP\n",
> +					     node);

returned, so no need to chase with an else.

> +		else if (index >= MAX34417_CHANNEL_COUNT)
> +			return dev_err_probe(dev, -EINVAL, "invalid reg %d of %pfwP\n",
> +					     index, node);
> +
> +		fwnode_property_read_string(node, "label", &max34417->input_label[index]);
> +
> +		rc = fwnode_property_read_u32(node, "shunt-resistor-micro-ohms", &rsense);
For optional properties, we generally now check for them first then if the property is
there can make errors reasons to fail

		if (fwnode_property_present()) {
			rc = fwnode_property_read_u32();
			if (rc)
				return dev_err_probe();

etc

> +		if (!rc) {
> +			if (!rsense || rsense < 1000 || rsense > 100000)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "invalid shunt value %d of %pfwP\n",
> +						     rsense, node);
> +
> +			max34417->input_correction[index] =
> +				max34417_calc_input_correction(rsense);
> +		}
> +	}
> +
> +	indio_dev->channels = max34417_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(max34417_channels);
> +	indio_dev->name = "max34417";
> +	indio_dev->info = &max34417_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	/* Set as default Manual Mode & Wide ADC */
> +	rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG, MAX34417_DEFAULT_CMM_WIDE);
> +	if (rc)
> +		return dev_err_probe(max34417->dev, rc, "Error writing control register\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}


