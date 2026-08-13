Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1661C3E5A29;
	Thu, 13 Aug 2026 06:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786604370; cv=none; b=XOHKhgAaAgTvtnPOhD/OmxlpkArHJ3wkUhEsjbloqbM7FusvSXkn7+/sX0/zVnz1DDbqNufoxNb7KShe7EzEg43ovMBRczXwJuFBwGKZf9Tas5gBtLBmNJLjz0u5+OzNb+7zLvUhS78paX43pp2OKcf//ZOQeopSvsglAH+zBxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786604370; c=relaxed/simple;
	bh=teJmDmEcHm4gisD3OSpydc89jKU+y92MTgR8a0F0XDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tax0KEYszdzZTDUIooSgETJwRflqSEgEoIDG5+XlTO7tR9SFaFZm0i82ksuRCKIZe+M8FIfaZyYAIn8O8oIT18WqUur3RGVdGj7y70x/P2aGmBcsuvTrEViceeldAweN27W7kIF70e+V3IGmDRqp/FDvye87qOTc5nwyECiWwNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UkDq/Zmj; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UkDq/Zmj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786604368; x=1818140368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=teJmDmEcHm4gisD3OSpydc89jKU+y92MTgR8a0F0XDo=;
  b=UkDq/ZmjZOtUPnUE9xPKcapHSB2w5+aZtIanvdtHPG8oyQhJr89IanwX
   NYJOF7lTv5kYH8U2pnwhYfOdY/PfgAzvgdBSWKjIUbSSwB8xmlOGFJEX/
   RPa9kXH3OH1WWwgNBuxXLr7Ogc4EbRuH0iRTtQRjdtdwX5Op5kdCkKJVJ
   D32/aRZQZoLlAnTodXgnlspMknK87Ek4yM4DF9oaSSgzVlVdjk0Y1WMa1
   3v2uE+bQAa+37cfWqDazfQXOTty5MrNHhFKkmg0dc5zLErUPI1Tc7Lf1D
   W0yG9Q2q916QOpF1e5ZXsuh3sXFYPumHbhGSWa3G4hQWq787A9cF4C7pa
   g==;
X-CSE-ConnectionGUID: jqs8XgZXQTGffRRpRlQG5Q==
X-CSE-MsgGUID: p8NG7vCkQ+awiqQc1mJPfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="86290219"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="86290219"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 23:59:25 -0700
X-CSE-ConnectionGUID: 2LN5ztgeQq27oCWX6Tt5wg==
X-CSE-MsgGUID: Ft63cPx3ToKZzdhKzvP+Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="265841924"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.250])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 23:59:22 -0700
Date: Thu, 13 Aug 2026 09:59:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] iio: light: add support for veml6031x00 ALS series
Message-ID: <an1rR07iJd_XLSPr@ashevche-desk.local>
References: <20260812-veml6031x00-v6-0-7eef6e4ce290@gmail.com>
 <20260812-veml6031x00-v6-2-7eef6e4ce290@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812-veml6031x00-v6-2-7eef6e4ce290@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 12, 2026 at 10:27:41PM +0200, Javier Carrasco wrote:
> These sensors provide two light channels (ALS and IR), I2C communication
> and a multiplexed interrupt line to signal data ready and configurable
> threshold alarms.

> This first implementation provides basic functionality (measurement
> configuration, raw reads and ID validation) and defines the different
> register regions in preparation for extended features in the subsequent
> patches of the series.

This paragraph needs to be rephrased. In the current form it suits cover letter
and not the commit message. Here, just list the features supported.

The "the subsequent patches of the series." in the commit message is very
ambiguous. What patch series? Which patches? Are they landed in the upstream?
If yes, which commit IDs? If not, when if ever? Et cetera! Usually it can be
simply said "The other features may be implemented later on."

The basic hint (one of) when writing a commit message is to put yourself in
the shoes of the unprepared reader who sees it in the Git history for the first
time in their life. What will your message give to them?

Besides the above some comments in the ->probe() to be addressed and other
minor style issues all over, but in general this looks very good and on track
(for v7.4).

...

> +/*
> + * The shutdown bits (SD and ALS_IR_SD) are in different registers, and both
> + * must be updated when changing the device power state.
> + */
> +static int veml6031x00_set_power(struct veml6031x00_data *data, bool state)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
> +				 VEML6031X00_CONF0_SD,
> +				 state ? 0 : VEML6031X00_CONF0_SD);

_assign_bits()?

> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(data->regmap, VEML6031X00_REG_CONF1,
> +				  VEML6031X00_CONF1_IR_SD,
> +				  state ? 0 : VEML6031X00_CONF1_IR_SD);

Ditto.

> +}

...

> +static int veml6031x00_set_it(struct iio_dev *iio, int val, int val2)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	int ret, gain_sel, new_gain, prev_gain, prev_it;
> +	unsigned int gain_reg, it_idx, pd_div4;
> +	bool gain_in_range;
> +
> +	if (val || !iio_gts_valid_time(&data->gts, val2))
> +		return -EINVAL;
> +
> +	guard(mutex)(&data->scale_lock);
> +
> +	ret = regmap_field_read(data->rf.it, &it_idx);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_field_read(data->rf.gain, &gain_reg);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_field_read(data->rf.pd_div4, &pd_div4);
> +	if (ret)
> +		return ret;
> +
> +	prev_it = iio_gts_find_int_time_by_sel(&data->gts, it_idx);
> +	if (prev_it < 0)
> +		return prev_it;
> +
> +	if (prev_it == val2)
> +		return 0;
> +
> +	prev_gain = iio_gts_find_gain_by_sel(&data->gts,
> +					     VEML6031X00_GAIN_SEL(pd_div4, gain_reg));

What about temporary for &data->gts? Say you have local 'gts' variable, this becomes

	prev_gain = iio_gts_find_gain_by_sel(gts,VEML6031X00_GAIN_SEL(pd_div4, gain_reg));

> +	if (prev_gain < 0)
> +		return prev_gain;
> +
> +	ret = iio_gts_find_new_gain_by_gain_time_min(&data->gts, prev_gain, prev_it,
> +						     val2, &new_gain, &gain_in_range);

	ret = iio_gts_find_new_gain_by_gain_time_min(gts, prev_gain, prev_it, val2,
						     &new_gain, &gain_in_range);

> +	if (ret)
> +		return ret;
> +
> +	if (!gain_in_range)
> +		dev_dbg(regmap_get_device(data->regmap), "Optimal gain out of range\n");
> +
> +	ret = iio_gts_find_sel_by_int_time(&data->gts, val2);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_field_write(data->rf.it, ret);
> +	if (ret)
> +		return ret;
> +
> +	gain_sel = iio_gts_find_sel_by_gain(&data->gts, new_gain);
> +	if (gain_sel < 0)
> +		return gain_sel;
> +
> +	return veml6031x00_write_gain(data, gain_sel);
> +}
> +
> +static int veml6031x00_set_scale(struct iio_dev *iio, int val, int val2)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	int gain_sel, it_sel, ret;
> +
> +	ret = iio_gts_find_gain_time_sel_for_scale(&data->gts, val, val2,
> +						   &gain_sel, &it_sel);

In the similar way

	ret = iio_gts_find_gain_time_sel_for_scale(gts, val, val2, &gain_sel, &it_sel);

OR (for stricter limits)

	ret = iio_gts_find_gain_time_sel_for_scale(gts, val, val2,
						   &gain_sel, &it_sel);


> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&data->scale_lock);
> +
> +	ret = regmap_field_write(data->rf.it, it_sel);
> +	if (ret)
> +		return ret;
> +
> +	return veml6031x00_write_gain(data, gain_sel);
> +}

...

> +static int veml6031x00_get_scale(struct veml6031x00_data *data, int *val,
> +				 int *val2)

Split this logically

static int veml6031x00_get_scale(struct veml6031x00_data *data, int *val, int *val2)

OR

static int veml6031x00_get_scale(struct veml6031x00_data *data,
				 int *val, int *val2)

> +static int veml6031x00_validate_part_id(struct veml6031x00_data *data)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int part_id, ret;

Why is 'part_id' signed?

> +	__le16 regval;

> +	ret = regmap_bulk_read(data->regmap, VEML6031X00_REG_ID_L, &regval,
> +			       sizeof(regval));

With

	struct regmap *map = data->regmap;
	struct device *dev = regmap_get_device(map);
	unsigned int part_id;
	__le16 val;
	int ret;
	...

	ret = regmap_bulk_read(map, VEML6031X00_REG_ID_L, &val, sizeof(val));

Please, revisit the whole series for this type of improvements.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read ID\n");
> +
> +	part_id = le16_to_cpu(regval);
> +	if (part_id != data->chip->part_id)
> +		dev_info(dev, "Unknown ID %04x\n", part_id);
> +
> +	return 0;
> +}

...

> +static int veml6031x00_probe(struct i2c_client *i2c)
> +{
> +	struct device *dev = &i2c->dev;
> +	struct veml6031x00_data *data;
> +	struct iio_dev *iio;
> +	int ret;
> +
> +	iio = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!iio)
> +		return -ENOMEM;
> +
> +	data = iio_priv(iio);
> +	i2c_set_clientdata(i2c, iio);
> +
> +	data->chip = i2c_get_match_data(i2c);
> +	if (!data->chip)
> +		return dev_err_probe(dev, -EINVAL, "Failed to get chip data\n");

-ENODATA

> +	data->regmap = devm_regmap_init_i2c(i2c, &veml6031x00_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> +				     "Failed to set regmap\n");

Is debugfs access already enabled for regmap after this call? Perhaps you want
mutex to be initialised before that?

> +	iio->name = data->chip->name;
> +	iio->channels = veml6031x00_channels;
> +	iio->num_channels = ARRAY_SIZE(veml6031x00_channels);
> +	iio->modes = INDIO_DIRECT_MODE;
> +	iio->info = &veml6031x00_info;
> +
> +	ret = devm_mutex_init(dev, &data->scale_lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = veml6031x00_regfield_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to init regfield\n");
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
> +
> +	/* The device starts in power down mode by default */
> +	ret = veml6031x00_set_power(data, true);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to power on the device\n");
> +
> +	ret = devm_add_action_or_reset(dev, veml6031x00_als_shutdown_action, data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add shutdown action\n");
> +
> +	pm_runtime_set_autosuspend_delay(dev, 2000);
> +	pm_runtime_use_autosuspend(dev);
> +	ret = devm_pm_runtime_set_active_enabled(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
> +
> +	pm_runtime_get_noresume(dev);
> +
> +	ret = veml6031x00_validate_part_id(data);
> +	if (ret)
> +		goto err_pm_put;
> +
> +	ret = veml6031x00_hw_init(iio);
> +	if (ret)
> +		goto err_pm_put;
> +
> +	pm_runtime_put_autosuspend(dev);
> +
> +	ret = devm_iio_device_register(dev, iio);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register iio device\n");
> +
> +	return 0;

> +err_pm_put:
> +	pm_runtime_put_noidle(dev);

Hmm... This is usually a red flag to see a goto after devm_*() calls.

> +	return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko


