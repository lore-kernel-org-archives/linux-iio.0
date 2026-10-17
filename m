Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85ED3A7D82;
	Sat, 17 Oct 2026 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792277273; cv=none; b=CTxi99Zkt09gGu3yhX1z71KuRdhJ3qpxlGK4UuNdsKowGWTxPN52kfykQQd9/SPGteb0u16N3qWpIQwGtxI6wYLTW4NFMZPGQOmCbBOAVAC3Aq3JSykimlm87T7/wYy4rEEvMYqCcLqWFg05TpUXpcYqCwFWd5KvG+n84WEn/7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792277273; c=relaxed/simple;
	bh=1R0dc0z9e8kqb7Jc23e4ZGOhaYmv8gQcbTVK/UCreUY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UfoyrU+tfhfG4Rkg1POtBlZciPUQSpKyufZFUYa0CJ0x9X0ZLtJS4LGwhtLz9YsnzsTdJeEwDKvTA0rNZY8aobA59Bv22D7ThTLK6+sNAb0tyoR9l98lEnln4SgBv5cw1rEHbqtjYyGD3Xx1IvmGHuzUCiKuAZEn8ymIYgSVBsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5gBLm9b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5gBLm9b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C323D1F000C4;
	Sat, 17 Oct 2026 22:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792277271;
	bh=Z3LvxrDURZwrtPkb5eP+Ohc+mQiogSpY4hH5g0DvOmw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=H5gBLm9bBQrxOtYXVBC6ZF3CRwuL51CIdx9hZd8N/iYv8xTk3ryPsIM5XpzYXlIGy
	 PKKSFBUnm5q5/h9zD8SOxqKNC8MwIgi5vuw1Sm0nKbJrPvuFgAyNfb2a+0w8uvss55
	 KdsIsR2y41rtbM6Y1FN817ie8KOoTjiNBdRb9cBk6cLxKk8ZWtrrQ44m3rY7iUHLyg
	 H5inWfDpnDUiey/Euold9l6Jf7LwYqhe/bubyNmit16yf71JTn8huHFNU7dNS40MuQ
	 tL4Yb0GUhPKQA/w95YbS4P5enKcT/yvDYhYbXvRZ7LPIDAOAPbD/VXlPr76c6tIP+7
	 /jyXz5BtzQ76A==
Date: Sat, 17 Oct 2026 23:47:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: adc: add driver for the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
Message-ID: <20261017234746.4af7b7f6@jic23-hlaptop>
In-Reply-To: <20261013-topic-sm8x50-iio-max34417-adc-v3-3-d3604ae4a229@linaro.org>
References: <20261013-topic-sm8x50-iio-max34417-adc-v3-0-d3604ae4a229@linaro.org>
	<20261013-topic-sm8x50-iio-max34417-adc-v3-3-d3604ae4a229@linaro.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 16:07:13 +0200
Neil Armstrong <neil.armstrong@linaro.org> wrote:

> The MAX34417 is a specialized current and voltage monitor used to
> determine power consumption of portable systems. The driver support
> getting the channels voltage, average power and accumulated average
> power and energy over an I2C/SMBUS serial interface.
> 
> The MAX34417 datasheet only specified on how to calculate the
> accumulated average power, but with the Sample Per Second rate
> we can easily get accumulated Energy in mJ.
> 
> By default the IIO driver only supports single-shot Voltage
> and Power sensing, but the accumulation can be enabled by
> enabling the Energy IIO channel which then enables the
> Continuous Accumulation Mode.
> 
> The counter is common to all channels, so when reading a single
> channel we will copy all accumulators to registers, so in order
> to permit reading individual channels we must accumulate the
> other channels in the driver when Continuous Accumulation Mode
> is enabled.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reminder to check sashiko.  I haven't looked at whether they
are right this time.
https://sashiko.dev/#/patchset/20261013-topic-sm8x50-iio-max34417-adc-v3-0-d3604ae4a229%40linaro.org

> diff --git a/drivers/iio/adc/max34417.c b/drivers/iio/adc/max34417.c
> new file mode 100644
> index 000000000000..00d7f20cd953
> --- /dev/null
> +++ b/drivers/iio/adc/max34417.c

> +/* TODO Implement trigger to update accumulator once and get all channels at once */
> +
> +static int max34417_reset_smm(struct max34417_data *max34417)
> +{
> +	u32 control;
> +	int rc;
> +
> +	rc = regmap_read(max34417->regmap, MAX34417_CONTROL_REG, &control);
> +	if (rc)
> +		return rc;
> +
> +	/* Set SMM=0 to re-init the SMM mode */
> +	control &= ~(MAX34417_CONTROL_SMM);
> +	rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG, control);
> +	if (rc)
> +		return rc;
> +
> +	/* Reset accumulators after setting SMM=0 */
> +	rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
return regmap_write()

Might as well save a few lines.

> +	if (rc)
> +		return rc;
> +
> +	return 0;
> +}


> +
> +static int max34417_check_ovf(struct max34417_data *max34417)
> +{
> +	u32 control;
> +	int rc;
> +
> +	/* Check for overflow */

Given function name and the check below, not seeing value in this comment.

> +	rc = regmap_read(max34417->regmap, MAX34417_CONTROL_REG, &control);
> +	if (rc)
> +		return rc;
> +
> +	if (control & MAX34417_CONTROL_OVF) {
> +		rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG,
> +				  control & ~MAX34417_CONTROL_OVF);
> +		if (rc)
> +			return rc;
> +
> +		rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Save all power accumulators and counter after each UPDATE command
> + * since it will reset the internal registers for ALL channels,
> + * so in order to not loose any captured data we retrieve all registers
> + * and accumulate them in the context variables.
> + * When user gets either power or energy, those variables content
> + * will be returned and zero-ed to return the power accumulated
> + * since last read for each separate channel.
> + */
> +static int max34417_save_accumulators(struct max34417_data *max34417)
> +{
> +	unsigned int i;
> +	u64 acc_power;
> +	u32 acc_count;
> +	int rc;
> +
> +	rc = max34417_read_acc_count(max34417, &acc_count);
> +	if (rc)
> +		return rc;
> +
> +	for (i = 0; i < MAX34417_CHANNEL_COUNT; ++i) {
> +		rc = max34417_read_acc_power(max34417, MAX34417_PWR_ACC_1_REG + i,
> +					     &acc_power);
> +		if (rc)
> +			return rc;
> +
> +		max34417->acc_power[i] += acc_power;
> +		max34417->acc_count[i] += acc_count;
> +	}
> +
> +	/* Check for overflow */
> +	rc = max34417_check_ovf(max34417);

return max34417_..

> +	if (rc)
> +		return rc;
> +
> +	return 0;
> +}


> +
> +static int max34417_setup_cam_mode(struct max34417_data *max34417, int val)
> +{
> +	u32 control;
> +	int rc, i;
> +
> +	guard(mutex)(&max34417->lock);
> +
> +	rc = regmap_read(max34417->regmap, MAX34417_CONTROL_REG, &control);
> +	if (rc)
> +		return rc;
> +
> +	if (max34417->cam_mode && !val) {
> +		/* SMM and CAM modes should not be enabled at the same time */
> +		control &= ~(MAX34417_CONTROL_CAM | MAX34417_CONTROL_SMM);

The comment doesn't makes sense given neither are enabled.

> +		rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG, control);

Feels like it would be cleaner as an update_bits() here and below rather than
sharing that read above.

> +		if (rc)
> +			return rc;
> +
> +		/*
> +		 * If CAM mode must be set, the Control byte must be set to
> +		 * desired values with CAM = 0, then followed by an UPDATE
> +		 */
> +		rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
> +		if (rc)
> +			return rc;
> +	} else if (!max34417->cam_mode && val) {
> +		/*
> +		 * After this, the CAM mode bit can be set and another
> +		 * UPDATE must be sent.
> +		 */
> +		control |= MAX34417_CONTROL_CAM;
> +		/* SMM and CAM modes should not be enabled at the same time */
> +		control &= ~(MAX34417_CONTROL_SMM);

As above, perhaps an update_bits is simpler?

> +		rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG, control);
> +		if (rc)
> +			return rc;
> +
> +		rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
> +		if (rc)
> +			return rc;
> +
> +		/* Reset counters and accumulators */
> +		for (i = 0; i < MAX34417_CHANNEL_COUNT; ++i) {
> +			max34417->acc_power[i] = 0;
> +			max34417->acc_count[i] = 0;
> +		}
> +	}
> +
> +	max34417->cam_mode = val;
> +
> +	return 0;
> +}



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
> +	max34417->indio_dev = indio_dev;
> +	mutex_init(&max34417->lock);
> +
> +	/* Set default input correction for all channels */
> +	for (i = 0; i < MAX34417_CHANNEL_COUNT; ++i)
> +		max34417->input_correction[i] =
> +			max34417_calc_input_correction(MAX34417_DEFAULT_RSENSE);
> +
> +	device_for_each_child_node_scoped(dev, node) {
> +		u32 rsense, index;
> +
> +		if (!fwnode_property_present(node, "reg"))
> +			return dev_err_probe(dev, -EINVAL, "missing reg property of %pfwP\n",
> +					     node);

Bit unusual to check for a property that must be there.
We tend to use present checks for optional properties. Is the
following failure path not enough?

> +
> +		rc = fwnode_property_read_u32(node, "reg", &index);
> +		if (rc)
> +			return dev_err_probe(dev, rc, "failure reading reg property of %pfwP\n",
> +					     node);
> +
> +		if (index >= MAX34417_CHANNEL_COUNT)
> +			return dev_err_probe(dev, -EINVAL, "invalid reg %d of %pfwP\n",
> +					     index, node);
> +
> +		if (fwnode_property_present(node, "label")) {
> +			rc = fwnode_property_read_string(node, "label",
> +							 &max34417->input_label[index]);
> +			if (rc)
> +				return dev_err_probe(dev, rc,
> +						"failure reading label property of %pfwP\n",
> +						node);
> +		}
> +
> +		if (fwnode_property_present(node, "shunt-resistor-micro-ohms")) {
> +			rc = fwnode_property_read_u32(node, "shunt-resistor-micro-ohms",
> +						      &rsense);
> +			if (rc)
> +				return dev_err_probe(dev, rc,
> +						"failure reading shunt property of %pfwP\n",
> +						node);
> +
> +			if (!rsense || rsense < MAX34417_MIN_RSENSE ||

Is !rsense useful given that is less than min?

> +			    rsense > MAX34417_MAX_RSENSE)
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
> +	rc = devm_iio_device_register(dev, indio_dev);
> +	if (rc)
> +		return rc;
> +
> +	/* Reset mode and set accumulator width to Wide */

The docs refer to this as choosing between the max34417 and the max34407.
Any idea what that is going on about?  Is it that the setting this to 0 would
make the device look just like the part with small accumulator?
Seems like an easy win if you fancy adding support for that part as well as
this would be the main difference I think (it's reserved on that part to 0)

Anyhow, just made me curious rather than a request to change anything!

> +	rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG, MAX34417_CONTROL_MODE);
> +	if (rc)
> +		return dev_err_probe(max34417->dev, rc, "Error writing control register\n");
> +
> +	/* Reset the accumulators */
> +	rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);

return regmap_write();

Though I'm not sure why you'd do these two after setting up the userspace
interface (iio_device_register). Is there no potential race where something
related to the accumulators gets read before they are reset?  Seems that would look
a little more odd than the other way around where they aren't quite
zero when they first become readable.

> +	if (rc)
> +		return rc;
> +
> +	return 0;
> +}


