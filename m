Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F023C0A02;
	Fri, 11 Sep 2026 08:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114487; cv=none; b=CrqgmyJ+Okmfn21vXhNqXWzfdKlwpJntkqEwqBo3Agaur8bvp2JpFSNV4lqCGnsO1EeUonTugQ6rTvqTYZAjG9F+J51C8an+XJlUG6hjHrcdaNrdigae2r239zsEkkqlmSQvzFjM7IIJ478UURZHmpnfeGK0yk1vDbjL+znwAYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114487; c=relaxed/simple;
	bh=mZlnIj9gOocKHDaCVSDe4W8UqmwRLsxQZTIQm1y7hLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URV1nAoTrZvUjcQaOvYD2BS04PNsu4BDWfRGI1v6MKjiuCHBh4xKfCoqmrMmAflu32q/YtiH2b+b9ePZZqdvhwnUJTdgVotpRcj0Ialb+FItW/Rjx1uNiukNGSGu8RrJ6e9FaDnCr/QXHoZjN4Icq5Lh8/5yZ2xPMKTUCeuJC0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ew/Vk7AU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ew/Vk7AU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789114486; x=1820650486;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mZlnIj9gOocKHDaCVSDe4W8UqmwRLsxQZTIQm1y7hLA=;
  b=Ew/Vk7AUYBq8LNpidxL1dnDOW9VaMtrRRRLaAMf+ksKi5dfGYwsyIbKA
   Bzk4kDoJ3RfXi+T/NUA/71QcepnfAPUNCzgb5NMuzjWPUpnjwUfdfFURs
   /oR1ESXB/AVjJfLARQfGTS6ybaJhQmZrasoEGldOe4XpI5eiP+OVfCcZZ
   +GAmLDma6x4WoN+osGyMNoesH2tXwfUd7AvYAA+Iiy5hn8TYfADvrR9rq
   zoYhTmV66ZSgRWOHVCYolXace6bnZJI1lDhOV1Qt0UkPCefXwV8RdeiR0
   DczWXAZfucX6Bf/WCCH2BbOgIZzwnjji8tIKrpPjutMqv6UYkhSr5+7Ot
   w==;
X-CSE-ConnectionGUID: Jy0l7rkSS8uCu7YFq87r1A==
X-CSE-MsgGUID: nLVgXKykSfm9d5i79eSwEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="100171017"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="100171017"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 01:14:45 -0700
X-CSE-ConnectionGUID: jmRHDAo2TFql/jdrWXmvjw==
X-CSE-MsgGUID: oEfWFbkRTM6Y2myujI0dsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="158257"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 01:14:40 -0700
Date: Fri, 11 Sep 2026 11:14:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Michael Walle <mwalle@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, jananisunil.dev@gmail.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v7 05/17] iio: adc: Add AD7768 and AD7768-4 core support
Message-ID: <aqO4bj8L6FDB_-2F@ashevche-desk.local>
References: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
 <20260910-ad7768-driver-v7-5-7f70b07627e1@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260910-ad7768-driver-v7-5-7f70b07627e1@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 10, 2026 at 07:36:23PM +0200, Janani Sunil wrote:
> Add core support for the AD7768 and AD7768-4 simultaneous sampling ADCs.
> Configure supplies, clock and reset, use a custom regmap bus for the SPI
> protocol, and parse the enabled channels and input buffer settings from
> devicetree.
> 
> Connect the converter to an IIO backend for buffered capture with CRC,
> provide a fixed safe wideband sampling configuration and add runtime
> power management.

...

> +static const struct regmap_config ad7768_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = AD7768_REG_CHOP_CTRL,
> +	/*
> +	 * Regmap bulk transfers use one starting address, while each register
> +	 * access requires a separate 16-bit SPI frame and reads use an off-frame
> +	 * response. Split bulk transfers into individual register accesses.
> +	 */

Here, or in additional place it might be good to mention why no cache is used.

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
> +	 * response. Split bulk transfers into individual register accesses.
> +	 */

Ditto.

> +	.use_single_read = true,
> +	.use_single_write = true,
> +	.readable_reg = ad7768_4_readable_reg,
> +};

...

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

Yep, this is clearer.

...

> +static int ad7768_parse_config(struct iio_dev *indio_dev,
> +			       struct device *dev)
> +{
> +	struct ad7768_precharge_config precharge_cfg[AD7768_MAX_CHANNEL] = { };
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	const unsigned int *available_datalines;
> +	bool datalines_valid = false;
> +	struct iio_chan_spec *chan;
> +	unsigned int num_channels;
> +	unsigned long standby_mask;
> +	unsigned int len;
> +	int chan_idx = 0;
> +	int ret;
> +
> +	num_channels = device_get_named_child_node_count(dev, "channel");

> +

Unneeded blank line.

> +	if (num_channels == 0)
> +		return dev_err_probe(dev, -ENOENT, "No channel specified\n");
> +
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
> +
> +	/*
> +	 * Crystal excitation requires channel 4 on AD7768 or channel 2 on
> +	 * AD7768-4 to remain active.
> +	 */
> +	if (st->clock_source == AD7768_CLOCK_SOURCE_XTAL)
> +		__clear_bit(st->chip_info->num_channels / 2, &standby_mask);

Hmm... I have a déjà vu feeling that I have seen already the same / similar.
If I'm right, this piece can be moved to a helper.

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
> +			fwnode_property_read_bool(child,
> +						  "adi,prechargebuf-pos-enable");
> +		precharge_cfg[channel].prebufn_en =
> +			fwnode_property_read_bool(child,
> +						  "adi,prechargebuf-neg-enable");
> +		precharge_cfg[channel].refbufp =
> +			fwnode_property_read_bool(child,
> +						  "adi,refbuf-pos-enable");
> +		precharge_cfg[channel].refbufn =
> +			fwnode_property_read_bool(child,
> +						  "adi,refbuf-neg-enable");
> +
> +		chan[chan_idx] = (struct iio_chan_spec) {
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
> +		chan_idx++;
> +	}
> +
> +	ret = ad7768_configure_precharge_buffers(indio_dev, precharge_cfg);
> +	if (ret)
> +		return ret;
> +
> +	available_datalines = st->chip_info->available_datalines;
> +	len = st->chip_info->num_datalines;

You also can

	const char *propname;
	...
	propname = "adi,data-lines-number";

> +	if (device_property_present(dev, "adi,data-lines-number")) {

	if (device_property_present(dev, propname)) {

> +		ret = device_property_read_u32(dev, "adi,data-lines-number",
> +					       &st->datalines);

		ret = device_property_read_u32(dev, propname, &st->datalines);

> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Invalid adi,data-lines-number property\n");

			return dev_err_probe(dev, ret, "Invalid %s property\n", propname);

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
> +				     "Invalid data-lines-number %d for %s\n",
> +				     st->datalines, st->chip_info->name);

And even here

				     "Invalid %s %d for %s\n", propname,
				     st->datalines, st->chip_info->name);

> +	return ad7768_configure_capture(st);
> +}

...

> +static void ad7768_power_off(void *data)
> +{
> +	struct ad7768_state *st = data;
> +	struct device *dev;
> +	int ret;
> +
> +	dev = regmap_get_device(st->regmap);

Can be assigned directly above

	struct device *dev = regmap_get_device(st->regmap);

> +	ret = ad7768_enter_sleep(st);
> +	if (ret)
> +		dev_err(dev, "Failed to put device to sleep\n");
> +}

...

> +	ret = devm_regulator_get_enable_optional(dev, "avss");
> +	if (ret == -ENODEV) {
> +		/* AVSS may be tied directly to ground instead of a regulator. */

tied --> wired / connected / ...?

> +	} else if (ret) {
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable AVSS supply\n");

Fine to be on a single line.

> +	}

...

> +static const struct spi_device_id ad7768_spi_id[] = {
> +	{ "ad7768", (kernel_ulong_t)&ad7768_chip_info },
> +	{ "ad7768-4", (kernel_ulong_t)&ad7768_4_chip_info },
> +	{ }

C99 initialisers.

> +};
> +MODULE_DEVICE_TABLE(spi, ad7768_spi_id);

-- 
With Best Regards,
Andy Shevchenko


