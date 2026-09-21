Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A7C1B808;
	Mon, 21 Sep 2026 00:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789950707; cv=none; b=UdLa6K0aU9d/7wwp4qEEPFTtOq8vbFa611WWnQmGHImapVo4MQnGlB4s2ZkArOlVAayjGNByAkww7CUeN8nViKVb8Pnv0daw2QT08QtQghLav8JYhIzR9C07Tnh50FYMBHNQ7FDWGneGB/3E3OeUtISEY/9NEqxSXwZKoibz/vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789950707; c=relaxed/simple;
	bh=dHECnUTuHGHwg6JVO/YnMBRntZC4KwmPB63czyIHsdc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qx+rl2s/VlwTz6HClthbprVOBWAPDnS1dPWHOM4G1J++YjbrwhXacp4krewO3WVJC5Xnl5gqBzXWw6uODdUsZNyZpLe5kKClZDgovVjMwbSKH7YIoC3Vk15Lzc81PjNmwBv++SsF3wEA1nnk53XfY8jAP52WxCRrhMybLQsB3ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNkrkSdJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNkrkSdJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1121F000FF;
	Mon, 21 Sep 2026 00:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789950704;
	bh=cZK4CKZ+jSV63Qgz/olanOa3DWg0lGExJZdApBck2gk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YNkrkSdJ2nj8nYOy7f4dh55VlokdOTvdEO1S8F+++s+WUuANdtLrQTqGSjgtWCvLU
	 Zj9R+NN0hfM3iXLid+koOzevBeA8N7rG83hGHSnZFi+jNqVFvovu0VPTr8JAJt0ZCD
	 rsXhAc8q1eBkMXuXiJnwrJ5ZDUHX3BDp8DieE+6zPonXxLhgAtJNX1l5ofsEVOFQFC
	 UYjXC8RzLr6xJuzNFcKSk7E3ui1cqWqbltDE9pKufsZasrHg8JYQ+epNYf0KCWwCA7
	 WFsdgzHSgwALM7C9vUwHg0tp1KHv2Hhye5ULeLJ+rjnlN5uJDLqAoQ1Xd4O76Tmk7s
	 FIIsVnjpC1pUA==
Date: Mon, 21 Sep 2026 01:31:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, "Rob Herring" <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>, Philipp
 Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>, Randy
 Dunlap <rdunlap@infradead.org>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <jananisunil.dev@gmail.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v8 05/17] iio: adc: Add AD7768 and AD7768-4 core support
Message-ID: <20260921013136.057791a9@jic23-hlaptop>
In-Reply-To: <20260916-ad7768-driver-v8-5-27aa24db5225@analog.com>
References: <20260916-ad7768-driver-v8-0-27aa24db5225@analog.com>
	<20260916-ad7768-driver-v8-5-27aa24db5225@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 13:13:54 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> Add core support for the AD7768 and AD7768-4 simultaneous sampling ADCs.
> Configure supplies, clock and reset, use a custom regmap bus for the SPI
> protocol, and parse the enabled channels and input buffer settings from
> devicetree.
> 
> Connect the converter to an IIO backend for buffered capture with CRC,
> provide a fixed safe wideband sampling configuration and add runtime
> power management.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
Hi Janani,

Just one follow up on changes in v8.  I'm not understanding the
reasonsing in the comment on not using regcache.

Jonathan

> diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
> new file mode 100644
> index 000000000000..2c5d0657edf9
> --- /dev/null
> +++ b/drivers/iio/adc/ad7768.c

> +
> +static const struct regmap_config ad7768_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = AD7768_REG_CHOP_CTRL,
> +	/*
> +	 * Regmap bulk transfers use one starting address, while each register
> +	 * access requires a separate 16-bit SPI frame and reads use an off-frame
> +	 * response. Split bulk transfers into individual register accesses. Do
> +	 * not use a register cache because some readable registers report live
> +	 * hardware state.

Why isn't volatile_regs enough to cover that one?

> +	 */
> +	.use_single_read = true,
> +	.use_single_write = true,
> +	.readable_reg = ad7768_readable_reg,
> +};
> +
> +static const struct regmap_config ad7768_4_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = AD7768_REG_CHOP_CTRL,
> +	/*
> +	 * Regmap bulk transfers use one starting address, while each register
> +	 * access requires a separate 16-bit SPI frame and reads use an off-frame
> +	 * response. Split bulk transfers into individual register accesses. Do
> +	 * not use a register cache because some readable registers report live
> +	 * hardware state.

Likewise.

> +	 */
> +	.use_single_read = true,
> +	.use_single_write = true,
> +	.readable_reg = ad7768_4_readable_reg,
> +};
> +
> +static int ad7768_reg_access(struct iio_dev *indio_dev,
> +			     unsigned int reg,
> +			     unsigned int writeval,
> +			     unsigned int *readval)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(regmap_get_device(st->regmap), pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	if (readval)
> +		return regmap_read(st->regmap, reg, readval);
> +
> +	return regmap_write(st->regmap, reg, writeval);
> +}
> +
> +static int ad7768_sync(struct ad7768_state *st)
> +{
> +	int ret;
> +
> +	ret = regmap_clear_bits(st->regmap, AD7768_REG_DATA_CONTROL,
> +				AD7768_DATA_CONTROL_SPI_SYNC);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_set_bits(st->regmap, AD7768_REG_DATA_CONTROL,
> +			       AD7768_DATA_CONTROL_SPI_SYNC);
> +}
> +
> +static int ad7768_set_clk_divs(struct ad7768_state *st)
> +{
> +	unsigned int dclk_div_reg;
> +	unsigned int dclk_div;
> +
> +	/*
> +	 * DCLK(min) is ODR * channels per DOUTx * 32. With fast mode
> +	 * (fMOD = MCLK / 4) and x64 decimation, this gives:
> +	 * MCLK / DCLK = 8 * data lines / channels.
> +	 */
> +	dclk_div = 8 * st->datalines / st->chip_info->num_channels;
> +	switch (dclk_div) {
> +	case 1:
> +		dclk_div_reg = AD7768_INTERFACE_CFG_DCLK_DIV_1;
> +		break;
> +	case 2:
> +		dclk_div_reg = AD7768_INTERFACE_CFG_DCLK_DIV_2;
> +		break;
> +	case 4:
> +		dclk_div_reg = AD7768_INTERFACE_CFG_DCLK_DIV_4;
> +		break;
> +	case 8:
> +		dclk_div_reg = AD7768_INTERFACE_CFG_DCLK_DIV_8;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return regmap_update_bits(st->regmap, AD7768_REG_INTERFACE_CFG,
> +				  AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
> +				  FIELD_PREP(AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
> +					     dclk_div_reg));
> +}
> +
> +static int ad7768_update_scan_mode(struct iio_dev *indio_dev,
> +				   const unsigned long *scan_mask)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	unsigned long channel_mask;
> +	unsigned long standby_mask;
> +	int ret;
> +
> +	channel_mask = ad7768_all_standby_mask(st);
> +	standby_mask = channel_mask & ~*scan_mask;
> +	ad7768_keep_xtal_channel_active(st, &standby_mask);
> +
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_CH_STANDBY,
> +				 channel_mask, standby_mask);
> +	if (ret)
> +		return ret;
> +
> +	for (unsigned int ch = 0; ch < st->chip_info->num_channels; ch++) {
> +		if (test_bit(ch, scan_mask))
> +			ret = iio_backend_chan_enable(st->back, ch);
> +		else
> +			ret = iio_backend_chan_disable(st->back, ch);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct ad7768_chip_info ad7768_chip_info = {
> +	.name = "ad7768",
> +	.num_channels = 8,
> +	.regmap_config = &ad7768_regmap_config,
> +	.available_datalines = ad7768_available_datalines,
> +	.num_datalines = ARRAY_SIZE(ad7768_available_datalines),
> +	.chan_map = ad7768_chan_map,
> +	.prebuf_split = 8,
> +};
> +
> +static const struct ad7768_chip_info ad7768_4_chip_info = {
> +	.name = "ad7768-4",
> +	.num_channels = 4,
> +	.regmap_config = &ad7768_4_regmap_config,
> +	.available_datalines = ad7768_4_available_datalines,
> +	.num_datalines = ARRAY_SIZE(ad7768_4_available_datalines),
> +	.chan_map = ad7768_4_chan_map,
> +	.prebuf_split = 4,
> +};
> +
> +static int ad7768_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +
> +	return pm_runtime_resume_and_get(regmap_get_device(st->regmap));
> +}
> +
> +static int ad7768_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +
> +	pm_runtime_put_autosuspend(regmap_get_device(st->regmap));
> +
> +	return 0;
> +}
> +
> +static const struct iio_buffer_setup_ops ad7768_buffer_ops = {
> +	.preenable = ad7768_buffer_preenable,
> +	.postdisable = ad7768_buffer_postdisable,
> +};
> +
> +static int ad7768_read_scale(struct ad7768_state *st,
> +			     const struct iio_chan_spec *chan,
> +			     int *val, int *val2)
> +{
> +	unsigned int vref_idx;
> +
> +	vref_idx = chan->channel >= st->chip_info->num_channels / 2;
> +	*val = 2 * st->vref_uV[vref_idx] / (MICRO / MILLI);
> +	*val2 = chan->scan_type.realbits;
> +
> +	return IIO_VAL_FRACTIONAL_LOG2;
> +}
> +
> +static int ad7768_read_raw(struct iio_dev *indio_dev,
> +			   const struct iio_chan_spec *chan,
> +			   int *val, int *val2, long info)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return ad7768_read_scale(st, chan, val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info ad7768_info = {
> +	.debugfs_reg_access = ad7768_reg_access,
> +	.read_raw = ad7768_read_raw,
> +	.update_scan_mode = ad7768_update_scan_mode,
> +};
> +
> +static int ad7768_configure_precharge_buffers(struct iio_dev *indio_dev,
> +					      struct ad7768_precharge_config *precharge_cfg)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	u8 prebuf1_val, prebuf2_val;
> +	u16 prebuf_mask = 0;
> +	u8 refbufp_val = 0;
> +	u8 refbufn_val = 0;
> +	int ret;
> +
> +	for (unsigned int ch = 0; ch < indio_dev->num_channels; ch++) {
> +		u8 channel = indio_dev->channels[ch].channel;
> +
> +		if (precharge_cfg[channel].prebufp_en)
> +			prebuf_mask |= AD7768_PREBUF_POS_EN(channel);
> +
> +		if (precharge_cfg[channel].prebufn_en)
> +			prebuf_mask |= AD7768_PREBUF_NEG_EN(channel);
> +
> +		if (precharge_cfg[channel].refbufp)
> +			refbufp_val |= ad7768_channel_mask(st, channel);
> +
> +		if (precharge_cfg[channel].refbufn)
> +			refbufn_val |= ad7768_channel_mask(st, channel);
> +	}
> +
> +	prebuf1_val = ad7768_precharge_buf1_mask(st, ~prebuf_mask);
> +	prebuf2_val = ad7768_precharge_buf2_mask(st, ~prebuf_mask);
> +
> +	ret = regmap_write(st->regmap, AD7768_REG_PRECHARGE_BUF1, prebuf1_val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD7768_REG_PRECHARGE_BUF2, prebuf2_val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD7768_REG_REFP_BUF, refbufp_val);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, AD7768_REG_REFN_BUF, refbufn_val);
> +}
> +
> +static int ad7768_configure_capture(struct ad7768_state *st)
> +{
> +	unsigned int mode_config;
> +	int ret;
> +
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_POWER_MODE,
> +				 AD7768_POWER_MODE_POWER_MODE_MSK |
> +				 AD7768_POWER_MODE_MCLK_DIV_MSK,
> +				 FIELD_PREP(AD7768_POWER_MODE_POWER_MODE_MSK,
> +					    AD7768_POWER_MODE_POWER_MODE_FAST) |
> +				 FIELD_PREP(AD7768_POWER_MODE_MCLK_DIV_MSK,
> +					    AD7768_POWER_MODE_POWER_MODE_FAST));
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Start with the wideband filter and a decimation rate of 64. This
> +	 * supports every valid data-line configuration at the maximum MCLK.
> +	 */
> +	mode_config = FIELD_PREP(AD7768_CH_MODE_FILTER_TYPE_MSK,
> +				 AD7768_CH_MODE_FILTER_TYPE_WIDEBAND) |
> +		      FIELD_PREP(AD7768_CH_MODE_DEC_RATE_MSK,
> +				 AD7768_CH_MODE_DEC_RATE_64);
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_CH_MODE(0),
> +				 AD7768_CH_MODE_FILTER_TYPE_MSK |
> +				 AD7768_CH_MODE_DEC_RATE_MSK,
> +				 mode_config);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD7768_REG_CH_MODE_SEL, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7768_set_clk_divs(st);
> +	if (ret)
> +		return ret;
> +
> +	return ad7768_sync(st);
> +}
> +
> +static int ad7768_parse_config(struct iio_dev *indio_dev,
> +			       struct device *dev)
> +{
> +	struct ad7768_precharge_config precharge_cfg[AD7768_MAX_CHANNEL] = { };
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	const unsigned int *available_datalines;
> +	const char *propname;
> +	bool datalines_valid = false;
> +	struct iio_chan_spec *chan;
> +	unsigned int num_channels;
> +	unsigned long standby_mask;
> +	unsigned int len;
> +	int chan_idx = 0;
> +	int ret;
> +
> +	propname = "adi,data-lines-number";
> +	num_channels = device_get_named_child_node_count(dev, "channel");
> +	if (num_channels == 0)
> +		return dev_err_probe(dev, -ENOENT, "No channel specified\n");
> +	if (num_channels > st->chip_info->num_channels)
> +		return dev_err_probe(dev, -ENOSPC, "Invalid number of channels\n");
> +
> +	chan = devm_kcalloc(dev, num_channels, sizeof(*chan), GFP_KERNEL);
> +	if (!chan)
> +		return -ENOMEM;
> +
> +	indio_dev->channels = chan;
> +	indio_dev->num_channels = num_channels;
> +
> +	standby_mask = ad7768_all_standby_mask(st);
> +	ad7768_keep_xtal_channel_active(st, &standby_mask);
> +
> +	ret = regmap_write(st->regmap, AD7768_REG_CH_STANDBY, standby_mask);
> +	if (ret)
> +		return ret;
> +
> +	device_for_each_named_child_node_scoped(dev, child, "channel") {
> +		u32 channel;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &channel);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to parse reg of %pfwP\n",
> +					     child);
> +
> +		if (channel >= st->chip_info->num_channels)
> +			return dev_err_probe(dev, -ECHRNG,
> +					     "Invalid channel %u in firmware\n",
> +					     channel);
> +
> +		ret = regmap_clear_bits(st->regmap, AD7768_REG_CH_STANDBY,
> +					BIT(channel));
> +		if (ret)
> +			return ret;
> +
> +		precharge_cfg[channel].prebufp_en =
> +			fwnode_property_read_bool(child, "adi,prechargebuf-pos-enable");
> +		precharge_cfg[channel].prebufn_en =
> +			fwnode_property_read_bool(child, "adi,prechargebuf-neg-enable");
> +		precharge_cfg[channel].refbufp =
> +			fwnode_property_read_bool(child, "adi,refbuf-pos-enable");
> +		precharge_cfg[channel].refbufn =
> +			fwnode_property_read_bool(child, "adi,refbuf-neg-enable");
> +
> +		chan[chan_idx++] = (struct iio_chan_spec) {
> +			.type = IIO_VOLTAGE,
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE),
> +			.indexed = 1,
> +			.channel = channel,
> +			.scan_index = channel,
> +			.scan_type = {
> +				.sign = 's',
> +				.realbits = 24,
> +				.storagebits = 32,
> +			},
> +		};
> +	}
> +
> +	ret = ad7768_configure_precharge_buffers(indio_dev, precharge_cfg);
> +	if (ret)
> +		return ret;
> +
> +	available_datalines = st->chip_info->available_datalines;
> +	len = st->chip_info->num_datalines;
> +	if (device_property_present(dev, propname)) {
> +		ret = device_property_read_u32(dev, propname, &st->datalines);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Invalid %s property\n",
> +					     propname);
> +	} else {
> +		st->datalines = available_datalines[len - 1];
> +	}
> +
> +	for (unsigned int i = 0; i < len; i++) {
> +		if (available_datalines[i] == st->datalines) {
> +			datalines_valid = true;
> +			break;
> +		}
> +	}
> +
> +	if (!datalines_valid)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid %s %u for %s\n", propname,
> +				     st->datalines, st->chip_info->name);
> +
> +	return ad7768_configure_capture(st);
> +}
> +
> +static int ad7768_reset(struct ad7768_state *st)
> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	struct reset_control *reset_ctrl;
> +	unsigned long reset_low_us;
> +	unsigned long mclk;
> +	int ret;
> +
> +	reset_ctrl = devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(reset_ctrl))
> +		return PTR_ERR(reset_ctrl);
> +
> +	if (reset_ctrl) {
> +		mclk = clk_get_rate(st->mclk);
> +		if (!mclk)
> +			return -EINVAL;
> +
> +		/*
> +		 * Minimum RESET low pulse width: 2 x tMCLK
> +		 * (datasheet Table 1).
> +		 */
> +		reset_low_us = DIV_ROUND_UP_ULL(2ULL * USEC_PER_SEC, mclk);
> +
> +		ret = reset_control_assert(reset_ctrl);
> +		if (ret)
> +			return ret;
> +
> +		fsleep(max(1UL, reset_low_us));
> +
> +		ret = reset_control_deassert(reset_ctrl);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = regmap_write(st->regmap, AD7768_REG_DATA_CONTROL,
> +				   AD7768_DATA_CONTROL_SPI_RESET_1);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(st->regmap, AD7768_REG_DATA_CONTROL,
> +				   AD7768_DATA_CONTROL_SPI_RESET_2);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* ADC start-up time after reset: 1.66 ms max (datasheet Table 1) */
> +	fsleep(1660);
> +
> +	return 0;
> +}
> +
> +static void ad7768_disable_clk(void *clk)
> +{
> +	clk_disable_unprepare(clk);
> +}
> +
> +static int ad7768_configure_xtal_clock(struct ad7768_state *st)
> +{
> +	int ret;
> +
> +	ret = regmap_set_bits(st->regmap, AD7768_REG_GPIO_WRITE, BIT(4));
> +	if (ret)
> +		return ret;
> +
> +	return regmap_set_bits(st->regmap, AD7768_REG_GPIO_CONTROL,
> +			       AD7768_GPIO_UGPIO_ENABLE |
> +			       AD7768_GPIO4_OUTPUT_ENABLE);
> +}
> +
> +static int ad7768_enable_lvds_clock(struct ad7768_state *st)
> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	int ret;
> +
> +	ret = regmap_clear_bits(st->regmap, AD7768_REG_GPIO_WRITE, BIT(4));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(st->regmap, AD7768_REG_GPIO_CONTROL,
> +			      AD7768_GPIO_UGPIO_ENABLE |
> +			      AD7768_GPIO4_OUTPUT_ENABLE);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(st->regmap, AD7768_REG_POWER_MODE,
> +			      AD7768_POWER_MODE_LVDS_ENABLE);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(st->mclk);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, ad7768_disable_clk, st->mclk);
> +}
> +
> +static int ad7768_get_enable_vref(struct device *dev, unsigned int index)
> +{
> +	const char * const *supply = ad7768_vref_supply_names[index];
> +	int refp_uV;
> +	int refn_uV;
> +
> +	refp_uV = devm_regulator_get_enable_read_voltage(dev, supply[0]);
> +	if (refp_uV < 0)
> +		return dev_err_probe(dev, refp_uV,
> +				     "Failed to get %s supply voltage\n", supply[0]);
> +
> +	refn_uV = devm_regulator_get_enable_read_voltage(dev, supply[1]);
> +	if (refn_uV == -ENODEV)
> +		refn_uV = 0;
> +	else if (refn_uV < 0)
> +		return dev_err_probe(dev, refn_uV,
> +				     "Failed to get %s supply voltage\n", supply[1]);
> +
> +	if (refp_uV <= refn_uV)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid reference %u voltage\n", index + 1);
> +
> +	return refp_uV - refn_uV;
> +}
> +
> +static int ad7768_enter_sleep(struct ad7768_state *st)
> +{
> +	return regmap_set_bits(st->regmap, AD7768_REG_POWER_MODE,
> +			       AD7768_SLEEP_MODE_MSK);
> +}
> +
> +static void ad7768_power_off(void *data)
> +{
> +	struct ad7768_state *st = data;
> +	struct device *dev = regmap_get_device(st->regmap);
> +	int ret;
> +
> +	ret = ad7768_enter_sleep(st);
> +	if (ret)
> +		dev_err(dev, "Failed to put device to sleep\n");
> +}
> +
> +static int ad7768_probe(struct spi_device *spi)
> +{
> +	unsigned int spi_readback, rev_id;
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad7768_state *st;
> +	const char *clock_name;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	spi_set_drvdata(spi, st);
> +
> +	st->chip_info = spi_get_device_match_data(spi);
> +	if (!st->chip_info)
> +		return dev_err_probe(dev, -ENODATA, "Failed to get match data\n");
> +
> +	ret = devm_regulator_get_enable_optional(dev, "avss");
> +	if (ret == -ENODEV) {
> +		/* AVSS may be connected directly to ground instead of a regulator. */
> +	} else if (ret) {
> +		return dev_err_probe(dev, ret, "Failed to enable AVSS supply\n");
> +	}
> +
> +	ret = devm_regulator_get_enable(dev, "avdd1");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable AVDD1 supply\n");
> +
> +	ret = devm_regulator_bulk_get_enable(dev,
> +					     ARRAY_SIZE(ad7768_supply_names),
> +					     ad7768_supply_names);
> +	if (ret)
> +		return ret;
> +
> +	for (unsigned int i = 0; i < ARRAY_SIZE(ad7768_vref_supply_names); i++) {
> +		ret = ad7768_get_enable_vref(dev, i);
> +		if (ret < 0)
> +			return ret;
> +
> +		st->vref_uV[i] = ret;
> +	}
> +
> +	ret = device_property_match_property_string(dev, "clock-names",
> +						    ad7768_clock_names,
> +						    ARRAY_SIZE(ad7768_clock_names));
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Invalid clock source\n");
> +
> +	st->clock_source = ret;
> +	clock_name = ad7768_clock_names[st->clock_source];
> +
> +	/*
> +	 * The device must start on its internal clock. Keep the LVDS clock
> +	 * disabled until GPIO4 is driven low and the LVDS input is enabled in
> +	 * the power mode register.
> +	 */
> +	switch (st->clock_source) {
> +	case AD7768_CLOCK_SOURCE_MCLK:
> +	case AD7768_CLOCK_SOURCE_XTAL:
> +		st->mclk = devm_clk_get_enabled(dev, clock_name);
> +		break;
> +	case AD7768_CLOCK_SOURCE_LVDS:
> +		st->mclk = devm_clk_get(dev, clock_name);
> +		break;
> +	}
> +
> +	if (IS_ERR(st->mclk))
> +		return dev_err_probe(dev, PTR_ERR(st->mclk),
> +				     "Failed to get master clock\n");
> +
> +	st->regmap = devm_regmap_init(dev, &ad7768_regmap_bus, spi,
> +				      st->chip_info->regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return PTR_ERR(st->regmap);
> +
> +	ret = ad7768_reset(st);
> +	if (ret)
> +		return ret;
> +
> +	/* Discard the reset response with a dummy SPI register read. */
> +	ret = regmap_read(st->regmap, AD7768_REG_REV_ID, &spi_readback);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD7768_REG_REV_ID, &rev_id);
> +	if (ret)
> +		return ret;
> +
> +	if (rev_id != AD7768_REV_ID_VAL)
> +		dev_info(dev, "Unexpected revision ID 0x%02x\n", rev_id);
> +
> +	switch (st->clock_source) {
> +	case AD7768_CLOCK_SOURCE_MCLK:
> +		break;
> +	case AD7768_CLOCK_SOURCE_XTAL:
> +		ret = ad7768_configure_xtal_clock(st);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to configure crystal clock\n");
> +		break;
> +	case AD7768_CLOCK_SOURCE_LVDS:
> +		ret = ad7768_enable_lvds_clock(st);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to enable LVDS clock\n");
> +		break;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, ad7768_power_off, st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7768_parse_config(indio_dev, dev);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Hardware supports CRC every 4 or 16 samples; the backend supports only
> +	 * 4-sample CRC.
> +	 */
> +	ret = regmap_update_bits(st->regmap, AD7768_REG_INTERFACE_CFG,
> +				 AD7768_INTERFACE_CFG_CRC_SELECT_MSK,
> +				 FIELD_PREP(AD7768_INTERFACE_CFG_CRC_SELECT_MSK,
> +					    AD7768_INTERFACE_CFG_CRC_SELECT_4));
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = st->chip_info->name;
> +	indio_dev->info = &ad7768_info;
> +	indio_dev->setup_ops = &ad7768_buffer_ops;
> +
> +	st->back = devm_iio_backend_get(dev, NULL);
> +	if (IS_ERR(st->back))
> +		return PTR_ERR(st->back);
> +
> +	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_backend_num_lanes_set(st->back, st->datalines);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_backend_crc_enable(st->back);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_backend_enable(dev, st->back);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_set_autosuspend_delay(dev, 2000);
> +	pm_runtime_use_autosuspend(dev);
> +	ret = devm_pm_runtime_set_active_enabled(dev);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static int ad7768_runtime_suspend(struct device *dev)
> +{
> +	struct ad7768_state *st = dev_get_drvdata(dev);
> +
> +	return ad7768_enter_sleep(st);
> +}
> +
> +static int ad7768_runtime_resume(struct device *dev)
> +{
> +	struct ad7768_state *st = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = regmap_clear_bits(st->regmap, AD7768_REG_POWER_MODE,
> +				AD7768_SLEEP_MODE_MSK);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The datasheet does not specify a wake-up time. Allow 20 ms for the
> +	 * ADC and digital clocks to restart.
> +	 */
> +	fsleep(20 * USEC_PER_MSEC);
> +
> +	return 0;
> +}
> +
> +static DEFINE_RUNTIME_DEV_PM_OPS(ad7768_pm_ops, ad7768_runtime_suspend,
> +				 ad7768_runtime_resume, NULL);
> +
> +static const struct of_device_id ad7768_of_match[] = {
> +	{ .compatible = "adi,ad7768", .data = &ad7768_chip_info },
> +	{ .compatible = "adi,ad7768-4", .data = &ad7768_4_chip_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad7768_of_match);
> +
> +static const struct spi_device_id ad7768_spi_id[] = {
> +	{ .name = "ad7768", .driver_data = (kernel_ulong_t)&ad7768_chip_info },
> +	{ .name = "ad7768-4", .driver_data = (kernel_ulong_t)&ad7768_4_chip_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ad7768_spi_id);
> +
> +static struct spi_driver ad7768_driver = {
> +	.probe = ad7768_probe,
> +	.driver = {
> +		.name = "ad7768",
> +		.of_match_table = ad7768_of_match,
> +		.pm = pm_ptr(&ad7768_pm_ops),
> +	},
> +	.id_table = ad7768_spi_id,
> +};
> +module_spi_driver(ad7768_driver);
> +
> +MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
> +MODULE_AUTHOR("Janani Sunil <janani.sunil@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD7768 ADC driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_BACKEND");
> 

