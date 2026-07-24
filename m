Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F1944C501;
	Fri, 24 Jul 2026 22:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784932025; cv=none; b=NtpL0Oab39sPoxYNmJbZZB+Aq9WAyKqzZOTxnWprAiilXlrkRQkxCe4BHw/u5OVhNs2liLyK/pqO7Oh/+catQ2fxN/s7Q0ZCWwqFH53vTcvmWyzFwz3Bj88/hvYfUJ1iuFismowNGdnSt7UC4Z6gTm811dG4jgtO0z7vNTKrlgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784932025; c=relaxed/simple;
	bh=sXl0vebus2XO0pQbP8drp0KnwP48Z5bgVC8rhClq5do=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BO1XmsqbT+yVZ5Qzt2+dfKotZyGI3wFIFN8z3AgZEiNNdf55Wh6v3L11USv00x7D+PkyykURsnwJwLAgnv6sR2/inTvGI77DU8OJTAW33WNHZadAvX2Sw1pMz4IiYSEH5NBF1yQNeEwa8K3A4LYjq5CsztQO8Q659uiF/5QXzbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4NtOhkS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4NtOhkS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81981F000E9;
	Fri, 24 Jul 2026 22:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784932023;
	bh=QwUFzzEL6vroDHDfM3iwOx8IvIyxwNbiilbafOLWhW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=E4NtOhkSRVWpY9YwcRon0ehNZ7PEIoy4gYIHyFI4es+/ocWVp4zmfnvzWEqbfHHkV
	 H7pAPHaH1bjltqeHZdFJXW1oLeozNWMqVXxn+0DRZDysBDTiPN3TsPDDQChmHpHBHG
	 dnQKO+NAQXkNM2rA60vzvczt4BOyHNeFr36F70NY+k23uEb5wau1ND+NQfQmki9CRO
	 qLNj5O5sYstiR/E8CMtW21Kg6AH1WoJlXcrRXKi7DsWQNSTgdLk5yg6m3BPkZK6r3D
	 gf/wkAaE4GKCnhjhoxkmgKugVvHEFjm8y/VFhbuyfw4h7rlUpwntgxjNT0j9IXXjir
	 9LKezjpjX+2kw==
Date: Fri, 24 Jul 2026 23:26:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Philipp Zabel" <p.zabel@pengutronix.de>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux@analog.com>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] iio: dac: ad3530r: add support for
 AD5710R/AD5711R
Message-ID: <20260724232659.269b610a@jic23-huawei>
In-Reply-To: <20260721-iio-ad5710r-upstream-v2-4-324949dc72da@analog.com>
References: <20260721-iio-ad5710r-upstream-v2-0-324949dc72da@analog.com>
	<20260721-iio-ad5710r-upstream-v2-4-324949dc72da@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 16:47:13 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> Add support for the AD5710R/AD5711R, 8-channel 16-/12-bit configurable
> IDAC/VDAC parts. They share the AD3530R register map and access model,
> so fold them into this driver.
> 
> Each channel is configured as voltage or current output from its DT
> channel@N node via adi,ch-func, building the iio_chan_spec dynamically.
> Voltage channels enable VMODE_EN and report the reference-derived scale,
> current channels report the 50 mA internal Iref scale. The powerdown
> mode is read-only and derived from the channel's configured type.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
Hi,

A few minor things inline.

Thanks,

Jonathan

> diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
> index 97483534f8c3..935b3a832d8e 100644
> --- a/drivers/iio/dac/ad3530r.c
> +++ b/drivers/iio/dac/ad3530r.c


> @@ -277,6 +313,54 @@ static ssize_t ad3532r_set_dac_powerdown(struct iio_dev *indio_dev,
>  	return len;
>  }
>  
> +static ssize_t ad5710r_get_dac_powerdown(struct iio_dev *indio_dev,
> +					 uintptr_t private,
> +					 const struct iio_chan_spec *chan,
> +					 char *buf)
> +{
> +	struct ad3530r_state *st = iio_priv(indio_dev);
> +	unsigned int reg_offset, ch_in_reg, reg, mode, mask;
> +	int ret;
> +
> +	reg_offset = chan->channel / AD3530R_CH_PER_REG;
> +	ch_in_reg = chan->channel % AD3530R_CH_PER_REG;
> +	reg = AD3530R_OUTPUT_OPERATING_MODE_0 + reg_offset;
> +	mask = AD3530R_OP_MODE_CHAN_MSK(ch_in_reg);
> +
> +	ret = regmap_read(st->regmap, reg, &mode);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%d\n", !!(mode & mask));

For consistency with the prep below, perhaps field_get() is appropriate here
rather than !! trickery.

> +}
> +
> +static ssize_t ad5710r_set_dac_powerdown(struct iio_dev *indio_dev,
> +					 uintptr_t private,
> +					 const struct iio_chan_spec *chan,
> +					 const char *buf, size_t len)
> +{
> +	struct ad3530r_state *st = iio_priv(indio_dev);
> +	unsigned int reg_offset, ch_in_reg, reg, mask, val;
> +	bool powerdown;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &powerdown);
> +	if (ret)
> +		return ret;
> +
> +	reg_offset = chan->channel / AD3530R_CH_PER_REG;
> +	ch_in_reg = chan->channel % AD3530R_CH_PER_REG;
> +	reg = AD3530R_OUTPUT_OPERATING_MODE_0 + reg_offset;
> +	mask = AD3530R_OP_MODE_CHAN_MSK(ch_in_reg);
> +	val = field_prep(mask, powerdown);
> +
> +	ret = regmap_update_bits(st->regmap, reg, mask, val);
> +	if (ret)
> +		return ret;
See below. This code is duplicated - factor it out.

> +
> +	return len;

> +static int ad3530r_parse_channel_cfg(struct ad3530r_state *st)
> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	struct iio_chan_spec *channels;
> +	int ret, num_chan;
> +	int i = 0;
> +	u32 reg;
> +
> +	num_chan = device_get_child_node_count(dev);
> +	if (!num_chan)
> +		return dev_err_probe(dev, -ENODEV, "No channels configured\n");
> +
> +	channels = devm_kcalloc(dev, num_chan, sizeof(*channels), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		unsigned int reg_offset, ch_in_reg, mode_reg, mode_mask, ch_func;
> +		enum iio_chan_type chan_type;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to read reg property of %pfwP\n",
> +					     child);
> +
> +		if (reg >= AD5710R_NUM_CHANNELS)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "reg out of range in %pfwP\n",
> +					     child);
> +
> +		ret = fwnode_property_read_u32(child, "adi,ch-func", &ch_func);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Missing adi,ch-func property for %pfwP\n",
> +					     child);
> +
> +		switch (ch_func) {
> +		case CH_FUNC_VOLTAGE_OUTPUT:
> +			ret = regmap_set_bits(st->regmap, AD5710R_CHN_VMODE_EN,
> +					      AD5710R_CHN_VMODE_EN_BIT(reg));
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "Failed to set voltage output for %pfwP\n",
> +						     child);
> +
> +			chan_type = IIO_VOLTAGE;
> +			break;
> +		case CH_FUNC_CURRENT_OUTPUT:
> +			chan_type = IIO_CURRENT;
> +			break;
> +		default:
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Invalid adi,ch-func %u for %pfwP\n",
> +					     ch_func, child);
> +		}
> +
> +		channels[i] = ad5710r_channels[reg];
> +		channels[i].type = chan_type;
> +		i++;
> +
> +		reg_offset = reg / AD3530R_CH_PER_REG;

This block of code is duplicating the code in the set_dac_powerdown() above.
Factor out a little helper to use in both places.

> +		ch_in_reg = reg % AD3530R_CH_PER_REG;
> +		mode_reg = AD3530R_OUTPUT_OPERATING_MODE_0 + reg_offset;
> +		mode_mask = AD3530R_OP_MODE_CHAN_MSK(ch_in_reg);
> +
> +		/* Enable the channel in normal operation mode */
> +		ret = regmap_update_bits(st->regmap, mode_reg, mode_mask,
> +					 field_prep(mode_mask, AD3530R_NORMAL_OP));
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to set normal operating mode for %pfwP\n",
> +					     child);
> +	}
> +
> +	st->channels = channels;
> +	st->num_channels = num_chan;

I don't think anything is stopping you passing in iio_dev and directly setting
iio_dev->channels and num_channels here.  That saves on having another copy of
pointer and count.

> +
> +	return 0;
> +}
> +
>  static int ad3530r_set_reg_bank_bits(const struct ad3530r_state *st,
>  				     const unsigned int *regs,
>  				     unsigned int num_regs,
> @@ -707,19 +943,29 @@ static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)

To assign the iio_dev channels / num_channels directly you'd need to pass it
in here, but that seems reasonable to me.

>  		st->vref_mV = range_multiplier * AD3530R_INTERNAL_VREF_mV;
>  	}
>  
> -	/* Set normal operating mode for all channels */
> -	val = FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(0), AD3530R_NORMAL_OP) |
> -	      FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(1), AD3530R_NORMAL_OP) |
> -	      FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(2), AD3530R_NORMAL_OP) |
> -	      FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(3), AD3530R_NORMAL_OP);
> +	if (chip_info->channel_configurable) {
> +		/* Channels and their operating mode are configured from DT */
> +		ret = ad3530r_parse_channel_cfg(st);
> +		if (ret)
> +			return ret;
> +	} else {
> +		/* Set normal operating mode for all channels */
> +		val = FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(0), AD3530R_NORMAL_OP) |
> +		      FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(1), AD3530R_NORMAL_OP) |
> +		      FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(2), AD3530R_NORMAL_OP) |
> +		      FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(3), AD3530R_NORMAL_OP);
> +
> +		ret = ad3530r_write_reg_banks(st, chip_info->op_mode,
> +					      chip_info->num_op_mode_regs, val);
> +		if (ret)
> +			return ret;
>  
> -	ret = ad3530r_write_reg_banks(st, st->chip_info->op_mode,
> -				      st->chip_info->num_op_mode_regs, val);
> -	if (ret)
> -		return ret;
> +		for (unsigned int i = 0; i < chip_info->num_channels; i++)
> +			st->chan[i].powerdown_mode = AD3530R_POWERDOWN_32K;
>  
> -	for (unsigned int i = 0; i < st->chip_info->num_channels; i++)
> -		st->chan[i].powerdown_mode = AD3530R_POWERDOWN_32K;
> +		st->channels = chip_info->channels;
> +		st->num_channels = chip_info->num_channels;

As above. I would assign the iio_dev elements directly here.

> +	}
>  
>  	st->ldac_gpio = devm_gpiod_get_optional(dev, "ldac", GPIOD_OUT_LOW);
>  	if (IS_ERR(st->ldac_gpio))
> @@ -784,8 +1030,8 @@ static int ad3530r_probe(struct spi_device *spi)
>  	indio_dev->name = st->chip_info->name;
>  	indio_dev->info = &ad3530r_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = st->chip_info->channels;
> -	indio_dev->num_channels = st->chip_info->num_channels;
> +	indio_dev->channels = st->channels;
> +	indio_dev->num_channels = st->num_channels;

