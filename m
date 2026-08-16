Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E79823BCED;
	Sun, 16 Aug 2026 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786915836; cv=none; b=PKpx+REFPbHgp19lh/6sIuUC8c0tDUdBc6NrAres0VA8BraD1iqq+l8iJeJY9aEWjp45912IKcdgXVnWnxDMxMRmr5OwhGLzOxTPr4PY8A+hScivmvz5qC6H/ns3oJw1HNfclQaIumTqOscVt4/3KXHZjOkLYUsnFGpUrCPGthw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786915836; c=relaxed/simple;
	bh=HH18tP5z/IbG73zBiPErtkWASp4GviBXjtzlnopdjXc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUO4+5SwRUSpRShZFWMeYOXvc+u2q4Y7VKvyskTBmhrmc4+9U1lsEpsKr93ENiK9KQ39rLrsjAYj2MzzBiyZbgmqfeA8dDK6Pap2uIUVcD0NKe9Lps6/KqAl7ARYMFoIxiWmmHP2edhEMd7Xk2JY+B2i2wH6zN2OwJyPEDTGhVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpfhDm0D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpfhDm0D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F811F000E9;
	Sun, 16 Aug 2026 21:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786915835;
	bh=dSwn+PTu97ggwJQMA8KStr+hEo7B/+YPs00L2veUs8o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZpfhDm0D1h35zu4xwvEWaIk1vkO15WdXwLAovSxH9PtYkZV79w7PwHJNQQIS/uu9S
	 3AKeWQMYY7kW9qqKG+lN2ScHZYMrv8arNMtY0by597tU9bzFH3NKHaomoqiP6QDKHh
	 5p3Wrsi8WMUDnOVUk7Fan5FqmZUMWrZfULYCDxuEkYDWQ8icC+zX9SsgutSDAxT6d7
	 aMI0AkWRwtPdKSgPwlTqqUfNwDRr49jVlBccY7K44ZbWCxmQORIh2/jLtpw3JoBpjC
	 GRieM0hmul4LrNOKr2ypG9s+Oz0QAx1thKAXsrpeF2n/wqV+DPwZOX8S4GOS2GBfpd
	 lsu8fdhWIOA4A==
Date: Sun, 16 Aug 2026 22:30:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 2/9] iio: adc: add the ti-ads1262 driver
Message-ID: <20260816223029.0da04d1e@jic23-huawei>
In-Reply-To: <20260807-ads126x-v3-2-f89925d72792@gmail.com>
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
	<20260807-ads126x-v3-2-f89925d72792@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 07 Aug 2026 22:58:24 -0500
Kurt Borja <kuurtb@gmail.com> wrote:

> Add the ti-ads1262 driver with initial support for the primary ADC
> (ADC1). The ADS1263 auxiliary ADC (ADC2) is handled by a separate driver
> and interoperability considerations were taken into account.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Hi Kurt,

Just a few trivial things from me.

Jonathan

> diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
> new file mode 100644
> index 000000000000..d78e5e3ae13e
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads1262.c

> +enum {
> +	ADS1262_RUNMODE_CONTINUOUS,
> +	ADS1262_RUNMODE_PULSE,
> +};
> +
> +enum {
> +	ADS1262_FILTER_SINC1,
> +	ADS1262_FILTER_SINC2,
> +	ADS1262_FILTER_SINC3,
> +	ADS1262_FILTER_SINC4,
> +	ADS1262_FILTER_FIR,
Where the values align with register field values, better
to assign them explicitly as easier to compare with datasheets
etc. 
> +};


> +
> +static int ads1262_channel_enable(struct ads1262 *st,
> +				  const struct iio_chan_spec *spec)
> +{
> +	u8 val;
> +
> +	guard(mutex)(&st->xfer_lock);
> +	guard(mutex)(&st->chan_lock);
> +
> +	val = FIELD_PREP(ADS1262_INPMUX_MUXN_MASK, spec->channel2) |
> +	      FIELD_PREP(ADS1262_INPMUX_MUXP_MASK, spec->channel);
> +	return regmap_update_bits(st->regmap, ADS1262_INPMUX_REG,
> +				 ADS1262_INPMUX_MUXN_MASK |
> +				 ADS1262_INPMUX_MUXP_MASK, val);

I'd put val on next line.  Feel free to go longer on the lines
in place like this where it perhaps improves readability by
keeping masks and values in the same call.

	return regmap_update_bits(st->regmap, ADS1262_INPMUX_REG,
				 ADS1262_INPMUX_MUXN_MASK |
				 ADS1262_INPMUX_MUXP_MASK,
				 FIELD_PREP(ADS1262_INPMUX_MUXN_MASK, spec->channel2) |
			 	 FIELD_PREP(ADS1262_INPMUX_MUXP_MASK, spec->channel);

> +}
> +



> +static int ads1262_dev_configure(struct ads1262 *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	int ret;
> +
> +	ret = ads1262_dev_reset(st);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to reset device\n");
> +
> +	guard(mutex)(&st->xfer_lock);
> +
> +	ret = regmap_clear_bits(st->regmap, ADS1262_POWER_REG,
> +				ADS1262_POWER_RESET_MASK);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_clear_bits(st->regmap, ADS1262_INTERFACE_REG,
> +				ADS1262_INTERFACE_STATUS_MASK |
> +				ADS1262_INTERFACE_CRC_MASK);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

I don't think this gets modified later - if it doesn't
	return regmap_cear_bits()

> +}



> +
> +static const struct reg_default ads1262_reg_defaults[] = {
> +	{ ADS1262_INTERFACE_REG,
> +	  FIELD_PREP_CONST(ADS1262_INTERFACE_STATUS_MASK, true) |
> +	  FIELD_PREP_CONST(ADS1262_INTERFACE_CRC_MASK, true) },
> +	{ ADS1262_MODE0_REG,		0x00 },
> +	{ ADS1262_MODE1_REG,
> +	  FIELD_PREP_CONST(ADS1262_MODE1_FILTER_MASK, ADS1262_FILTER_FIR) },
> +	{ ADS1262_MODE2_REG,
> +	  FIELD_PREP_CONST(ADS1262_MODE2_DR_MASK, ADS1262_DR_20_SPS) },
> +	{ ADS1262_INPMUX_REG,
> +	  FIELD_PREP_CONST(ADS1262_INPMUX_MUXN_MASK, ADS1262_INPMUX_AIN1) },
> +	{ ADS1262_IDACMUX_REG,
> +	  FIELD_PREP_CONST(ADS1262_IDACMUX_MUX2_MASK, ADS1262_IDACMUX_NO_CONN) |
> +	  FIELD_PREP_CONST(ADS1262_IDACMUX_MUX1_MASK, ADS1262_IDACMUX_NO_CONN) },
> +	{ ADS1262_IDACMAG_REG,		0x00 },
> +	{ ADS1262_REFMUX_REG,		0x00 },
> +	{ ADS1262_TDACP_REG,		0x00 },
> +	{ ADS1262_TDACN_REG,		0x00 },
> +	{ ADS1262_GPIOCON_REG,		0x00 },
> +	{ ADS1262_GPIODIR_REG,		0x00 },
> +	{ ADS1262_ADC2CFG_REG,		0x00 },
> +	{ ADS1262_ADC2MUX_REG,
> +	  FIELD_PREP_CONST(ADS1262_ADC2MUX_MUXN2_MASK, ADS1262_INPMUX_AIN1) },
> +};
I'm not particularly keen on this formatting from a readability point of view.
Maybe using named intializers would help:

static const struct reg_default ads1262_reg_defaults[] = {
	{ 
		.reg = ADS1262_INTERFACE_REG,
		.def = FIELD_PREP_CONST(ADS1262_INTERFACE_STATUS_MASK, true) |
		       FIELD_PREP_CONST(ADS1262_INTERFACE_CRC_MASK, true),
//extra indent fine here for readability reasons if we end up with some long lines
	},
	{ .reg = ADS1262_MODE0_REG, .def = 0x00 },
etc or just maybe use the more open form of the first element for all of them.
burns a bunch of lines, but is easy to read. 




> +static int ads1262_regmap_read(void *context, const void *reg_buf,
> +			       size_t reg_size, void *val_buf, size_t val_size)
> +{
> +	struct ads1262 *st = context;
> +	u8 tx[2];
> +
> +	lockdep_assert_held(&st->xfer_lock);
> +
> +	/*
> +	 * The register read operation uses a two byte command header followed
> +	 * by the register data:
> +	 *
> +	 *	byte 0:   RREG opcode | register address
> +	 *	byte 1:   number of registers to transfer, minus one
> +	 *	byte 2..: register data
> +	 */
> +	memcpy(tx, reg_buf, 1);
> +	tx[0] |= ADS1262_OPCODE_RREG;

Similar to below. I think more readable without the memcpy()

> +	tx[1] = val_size - 1;
> +
> +	return spi_write_then_read(st->spi, tx, sizeof(tx), val_buf, val_size);
> +}
> +
> +static int ads1262_regmap_gather_write(void *context, const void *reg_buf,
> +				       size_t reg_size, const void *val_buf,
> +				       size_t val_size)
> +{
> +	struct ads1262 *st = context;
> +	u8 tx[ADS1262_MAX_REGMAP_WRITE + 2];
> +
> +	lockdep_assert_held(&st->xfer_lock);
> +
> +	/*
> +	 * The register write operation uses a two byte command header followed
> +	 * by the register data:
> +	 *
> +	 *	byte 0:   WREG opcode | register address
> +	 *	byte 1:   number of registers to transfer, minus one
> +	 *	byte 2..: register data
> +	 */
> +	memcpy(tx, reg_buf, 1);

This is odd and I guess there because you don't want to cast reg_buf.
Even so I'd either use a local variable or just cast it.

	tx[0] = *((u8 *)regbuf) | ADS1262_OPCODE_WREG;

> +	tx[0] |= ADS1262_OPCODE_WREG;
> +	tx[1] = val_size - 1;
> +	memcpy(&tx[2], val_buf, val_size);
> +
> +	return spi_write_then_read(st->spi, tx, 2 + val_size, NULL, 0);
> +}
> +
> +static int ads1262_regmap_write(void *context, const void *data, size_t count)
> +{
> +	return ads1262_regmap_gather_write(context, data, 1, data + 1,
> +					   count - 1);
> +}
> +
> +static const struct regmap_bus ads1262_regmap_bus = {
> +	.read = ads1262_regmap_read,
> +	.gather_write = ads1262_regmap_gather_write,
> +	.write = ads1262_regmap_write,
> +	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
> +	.val_format_endian_default = REGMAP_ENDIAN_BIG,
> +	.max_raw_write = ADS1262_MAX_REGMAP_WRITE,
> +};
> +
> +static int ads1262_gpio_setup(struct ads1262 *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +
> +	st->start_gpiod = devm_gpiod_get_optional(dev, "start", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->start_gpiod))
> +		return dev_err_probe(dev, PTR_ERR(st->start_gpiod),
> +				     "failed to get start GPIO\n");
> +
> +	st->reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->reset_gpiod))
> +		return dev_err_probe(dev, PTR_ERR(st->reset_gpiod),
> +				     "failed to get reset GPIO\n");
> +
> +	/*
> +	 * The power transition timing requirement is 65536 clock cycles, at the
> +	 * minimum clock frequency this is 65536 microseconds.
> +	 */
> +	fsleep(65536);
> +
> +	return 0;
> +}
> +
> +static int ads1262_parse_channel_node(struct ads1262 *st,
> +				      struct iio_chan_spec *spec,
> +				      struct fwnode_handle *node)
> +{
> +	struct device *dev = &st->spi->dev;
> +	u32 pins[2];
> +	int ret;
> +
> +	if (fwnode_property_present(node, "single-channel")) {
> +		ret = fwnode_property_read_u32(node, "single-channel", &pins[0]);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "%s: failed to read single-channel\n",
> +					     fwnode_get_name(node));
> +
> +		pins[1] = ADS1262_INPMUX_AINCOM;
> +		fwnode_property_read_u32(node, "common-mode-channel", &pins[1]);
> +	} else if (fwnode_property_present(node, "diff-channels")) {
> +		ret = fwnode_property_read_u32_array(node, "diff-channels", pins,
> +						     ARRAY_SIZE(pins));
> +		if (ret)
> +			return dev_err_probe(dev, ret, "%s: failed to read diff-channels\n",
> +					     fwnode_get_name(node));
> +
> +		if (pins[0] <= ADS1262_INPMUX_AINCOM || pins[1] <= ADS1262_INPMUX_AINCOM)
> +			spec->differential = true;
> +	} else {
> +		return dev_err_probe(dev, -ENXIO,
> +				     "%s: one of single-channel or diff-channels is required\n",
> +				     fwnode_get_name(node));
> +	}
> +
> +	if (pins[0] >= ADS1262_INPMUX_FLOAT || pins[1] >= ADS1262_INPMUX_FLOAT)
> +		return dev_err_probe(dev, -EINVAL, "%s: input channels not in range\n",
> +				     fwnode_get_name(node));
> +
> +	if ((pins[0] >= ADS1262_INPMUX_TEMP ||
> +	     pins[1] >= ADS1262_INPMUX_TEMP) && pins[0] != pins[1])
> +		return dev_err_probe(dev, -EINVAL,
> +				     "%s: monitor channels must be selected symmetrically\n",
> +				     fwnode_get_name(node));
> +
> +	spec->channel = pins[0];
> +	spec->channel2 = pins[1];
> +
> +	return 0;
> +}
> +
> +static int ads1262_parse_channels(struct iio_dev *indio_dev)
> +{
> +	struct ads1262 *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	struct iio_chan_spec *specs;
> +	unsigned long used_regs = 0;
> +	int num_specs;
> +	u32 reg;
> +	int ret;
> +
> +	st->num_channels = device_get_named_child_node_count(dev, "channel");
> +	if (!st->num_channels)
> +		return dev_err_probe(dev, -ENXIO, "no 'channel' nodes configured\n");
> +	if (st->num_channels > ADS1262_MAX_CHANNEL_COUNT)
> +		return dev_err_probe(dev, -EINVAL, "too many channels\n");
> +
> +	/* Account for the timestamp channel */
> +	num_specs = st->num_channels + 1;
> +	specs = devm_kcalloc(dev, num_specs, sizeof(*specs), GFP_KERNEL);
> +	if (!specs)
> +		return -ENOMEM;
> +
> +	device_for_each_named_child_node_scoped(dev, node, "channel") {
> +		ret = fwnode_property_read_u32(node, "reg", &reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "%s: failed to read channel reg\n",
> +					     fwnode_get_name(node));
> +		if (reg >= st->num_channels)
> +			return dev_err_probe(dev, -EINVAL, "%s: reg out of range\n",
> +					     fwnode_get_name(node));
> +
> +		static_assert(ADS1262_MAX_CHANNEL_COUNT < BITS_PER_LONG);
> +		if (__test_and_set_bit(reg, &used_regs))
> +			return dev_err_probe(dev, -EINVAL, "%s: duplicated channel reg\n",
> +					     fwnode_get_name(node));
> +
> +		specs[reg].scan_index = reg;
> +		specs[reg].scan_type = (struct iio_scan_type) {
> +			.format = IIO_SCAN_FORMAT_SIGNED_INT,
> +			.realbits = ADS1262_ADC1_RESOLUTION,
> +			.storagebits = 32,
> +			.endianness = IIO_BE,
> +		};
> +
> +		ret = ads1262_parse_channel_node(st, &specs[reg], node);
> +		if (ret)
> +			return ret;
> +
> +		if (specs[reg].channel == ADS1262_INPMUX_TEMP)
> +			specs[reg].type = IIO_TEMP;
> +		else
> +			specs[reg].type = IIO_VOLTAGE;
> +
> +		if (specs[reg].channel != ADS1262_INPMUX_TEMP)
> +			specs[reg].indexed = true;
> +
> +		specs[reg].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +	}
> +
> +	specs[num_specs - 1] = IIO_CHAN_SOFT_TIMESTAMP(num_specs - 1);
> +
> +	indio_dev->channels = specs;
> +	indio_dev->num_channels = num_specs;
> +
> +	return 0;
> +}
