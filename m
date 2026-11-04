Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759436;
	b=UwjzPCjvWKxbC3WnZzjjuO/28dnXIGse30D0AUuH6LYQ+0Zri+6b8T+4hxPZx4YhQVTL
	 3BqPdVSMXRXp13/PTZC034lDt4O5cfATJYMqQMrEJbQzLWE//qklURLJePC7UU2OHD3ra
	 oAzNxqdpeJHp6t8bvBuBbmgfWe8sZndLpxPu94k3iNPtghBbgHJ26JR475BCy8krBZy3F
	 LBJN0YeyawpJUD9NnxY50lnUEB/z9Matin2HP0rdccGeSzKUfzeCVsz/qEFnbqrX5uBA5
	 Inxf6KChZuWonZoRfKZPTBz6YT++F3yd/RRkngth75zH58i2PUoP7Hkoju5QuMIu/tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759436;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/VTpplJVn4EIticjLNBtstxtOGlJSsZ7VaIs8mVEQYo=;
	b=NU3tU9XoLM63EhhqImGVqxoC5I5bSkQoG2+4KwbDTUmCs5LjdTxVfj+hlcfi+22E+mln
	 Bf4Qcl0i6Oz71jesAAfdenDVaSL9jATedwSiUZQXOhZfmXtvn+9gpLlKEhH2bBIGvjztG
	 KHx/jl0WaLFtYT9JHMLQ7nGb1S34j0GaV7tCjbyEVX0E46UvXungTZdUe0p3wlQ4G+XHU
	 IwtrKEEsIYXHriNZdg7eZaRTSaBoXlzOP57YorO1iriZwel6Z3PVZSdxQcln3yMjn6l6I
	 Jxswv7rTdlmfndlW/v79TsTn5UNvsZTmZmRpndZniPtQAsfKtrWuyZkU+ygBAimt6nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aly6RPlZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF139606A32C;
	Wed,  4 Nov 2026 02:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aly6RPlZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3841F000C1;
	Wed,  4 Nov 2026 02:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793759435;
	bh=/VTpplJVn4EIticjLNBtstxtOGlJSsZ7VaIs8mVEQYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aly6RPlZn1FhrDosrjt8AmZQQRqhhOB6BBgjurjomusOB1iTSaixn7vzMijgD+mI0
	 aIzPA+r5TQLutXr6RK2XJR0YEEZ8NDSGCXO76O9Le9R5Mh/6OaIpjayJ0BZHMacFEc
	 ts3Lfbv/YRqFF4VoVgZPgWdxSwFUMmU+jf/BspXpS3ScJtKzgi/AaktQdEz9jKGI9S
	 6Vpz8Z1Zqju0v9PBBGwZDmZjpgLG2kpNzZjL4tNo7Tlc1oOKPffS2yNX9llh0q4bWT
	 7mSrZ9zlXkKZ1JXxP9zA+bsE+AwP9g69gCE00qI3tDz0i4qIg2TOoi3/YDBzDI8wvr
	 rEQfc529Jbvsw==
Date: Wed, 4 Nov 2026 02:30:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux@analog.com
Subject: Re: [PATCH v5 3/3] iio: adc: add driver for the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
Message-ID: <20261104023032.0a21da0d@jic23-hlaptop>
In-Reply-To: <20261102-topic-sm8x50-iio-max34417-adc-v5-3-0ffa5e5f2d5c@linaro.org>
References: <20261102-topic-sm8x50-iio-max34417-adc-v5-0-0ffa5e5f2d5c@linaro.org>
	<20261102-topic-sm8x50-iio-max34417-adc-v5-3-0ffa5e5f2d5c@linaro.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 02 Nov 2026 15:49:06 +0100
Neil Armstrong <neil.armstrong@linaro.org> wrote:

> The MAX34417 is a specialized current and voltage monitor used to
> determine power consumption of portable systems. The driver support
> getting the channels voltage, average power, accumulated average
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

The use of the regmap_noinc stuff to deal with the variable
size 'registers' is novel.  Might be worth just adding a little
commentary on that to somewhere. Perhaps the regmap_config as a comment.

Other than that, just a question about why we need the postfixes
for the labels. That seems superfluous.

Thanks,

Jonathan


> diff --git a/drivers/iio/adc/max34417.c b/drivers/iio/adc/max34417.c
> new file mode 100644
> index 000000000000..e679cf142141
> --- /dev/null
> +++ b/drivers/iio/adc/max34417.c

> +
> +static const struct regmap_config max34417_regmap_config = {
> +	.reg_bits	= 8,
> +	.val_bits	= 8,
As noted above. This isn't really true.  You are just use noinc
reads to pretend it is.  Those are normally only used for
fifo registers so I think we should have a comment here talking
about that choice.

It is pretty neat so I'm not against it but it might rather
surprise anyone looking at the datasheet!



> +	.max_register	= MAX34417_BULK_VOLTAGE_READOUT_REG,
> +	.writeable_reg	= max34417_writeable_reg,
> +	.readable_reg	= max34417_readable_reg,
> +	.volatile_reg	= max34417_volatile_reg,
> +	/* No cache since the only non-volatile register is read-only */
> +};



> +
> +static int max34417_read_label(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       char *label)
> +{
> +	struct max34417_data *max34417 = iio_priv(indio_dev);
> +	const char *input_label = max34417->input_label[chan->channel];
> +
> +	if (input_label) {
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			return sysfs_emit(label, "%s-voltage\n", input_label);

Why add the postfix? The channel type will turn up in the file name anyway.
I don't think anything prevents us having the same label for channels of
different types.  Is this a copy of something elsewhere?


> +		case IIO_POWER:
> +			return sysfs_emit(label, "%s-power\n", input_label);
> +		case IIO_ENERGY:
> +			return sysfs_emit(label, "%s-energy\n", input_label);
> +		default:
> +			return 0;
> +		}
> +	}
> +
> +	switch (chan->type) {
> +	case IIO_VOLTAGE:
> +		return sysfs_emit(label, "channel%d-voltage\n", chan->channel);
Same applies here.  The postfix seems excessive.
> +	case IIO_POWER:
> +		return sysfs_emit(label, "channel%d-power\n", chan->channel);
> +	case IIO_ENERGY:
> +		return sysfs_emit(label, "channel%d-energy\n", chan->channel);
> +	default:
> +		return 0;
> +	}
> +}

> +
> +static int max34417_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct max34417_data *max34417;
> +	struct iio_dev *indio_dev;
> +	struct regmap *map;
> +	int rc;
> +
> +	map = devm_regmap_init_i2c(client, &max34417_regmap_config);
> +	if (IS_ERR(map))
> +		return dev_err_probe(dev, PTR_ERR(map), "regmap_init failed\n");
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
> +	max34417->regmap = map;
> +	max34417->indio_dev = indio_dev;
> +
> +	rc = devm_mutex_init(dev, &max34417->lock);
> +	if (rc)
> +		return rc;
> +
> +	/* Set default input correction for all channels */
> +	for (int i = 0; i < MAX34417_CHANNEL_COUNT; i++)
> +		max34417->input_correction[i] =
> +			max34417_calc_input_correction(MAX34417_DEFAULT_RSENSE);
> +
> +	device_for_each_child_node_scoped(dev, node) {
> +		u32 rsense_uOhm, index;
> +
> +		rc = fwnode_property_read_u32(node, "reg", &index);
> +		if (rc)
> +			return dev_err_probe(dev, rc, "failure reading reg property of %pfwP\n",
> +					     node);
> +
> +		if (index >= MAX34417_CHANNEL_COUNT)
> +			return dev_err_probe(dev, -ECHRNG, "invalid reg %d of %pfwP\n",
> +					     index, node);
> +
> +		if (fwnode_property_present(node, "label")) {
> +			rc = fwnode_property_read_string(node, "label",
> +							 &max34417->input_label[index]);
> +			if (rc)
> +				return dev_err_probe(dev, rc,
> +						"failure reading label property of %pfwP\n",

Don't worry about going a bit longer - stcik to aligning after (
Or.. Maybe use a helper function for the per channel parsing.


> +						node);
> +		}
> +
> +		if (fwnode_property_present(node, "shunt-resistor-micro-ohms")) {
> +			rc = fwnode_property_read_u32(node, "shunt-resistor-micro-ohms",
> +						      &rsense_uOhm);
> +			if (rc)
> +				return dev_err_probe(dev, rc,
> +						"failure reading shunt property of %pfwP\n",
> +						node);
> +
> +			if (rsense_uOhm < MAX34417_MIN_RSENSE ||
> +			    rsense_uOhm > MAX34417_MAX_RSENSE)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "invalid shunt value %d of %pfwP\n",
> +						     rsense_uOhm, node);
> +
> +			max34417->input_correction[index] =
> +				max34417_calc_input_correction(rsense_uOhm);
> +		}
> +	}
