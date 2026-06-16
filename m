Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60DE29346F;
	Tue, 16 Jun 2026 08:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781599013; cv=none; b=rYrT0uf+l7Z0VL7V+Sw0e50XCtZjo7iBxwS78ZQ4KsxixnZ/P5Wkis2pLWsa0ZKuZ9zr41EYgJxNIbP1nLvllvr7VsKC5pqXaU6VqhKGmHDZgusR4hPvsDXvGUhy3umBXW8+QW/Y7a2dmTcpunw4BQr+0E7Fo4DnWw8Kxdp6OLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781599013; c=relaxed/simple;
	bh=rCS4bzSYozHmyxajgR4yfN2ZlRwalgccsJhMLts4DWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kazTNywwHhrA3s55kqiTOozAZ7egjIA7pIlz+gHoQn/uLd/QN3GnIkZPzcKGiRjw2N6fWPcCXsKOO3q9GBqFiWqUqeZ8cjn4CTjKL6s9/8E9xdI0DyPRwfw+105O68EW5mojZxOhlBUO+n0MwfsxN7GBMT7zMJFBlWsQb0GcsQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gyP1R3iR; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gyP1R3iR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781599011; x=1813135011;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rCS4bzSYozHmyxajgR4yfN2ZlRwalgccsJhMLts4DWE=;
  b=gyP1R3iRXRy5GutdNqJq492X+kmgx9DvEXgSXbfUq+qpAgue9dDrwYeY
   ERzXK0mAvdGCfBcWOyl0VfqI75cyOaHOPmtq0P5aAjxpsIQQuP0LnJ1pm
   H+UU6IUWACxzCsAi9DLF8dheGwob0IuwRLKA8CfSEMlPsrW4+f9ZE1ijD
   UKjJCxgRw316LPvD0slYnExSej6zwRiAriGL/Coo4KUS7+SsMvNiwXiri
   drpKKnD+uMdwxSOzo4tmlQAeQKuEBO/QrlqZSHiUz2RynhQrwor/f18JI
   VX+ewXjeSx6P7BRzUQk/cW1xP7VKpKm08VzAX/vXMobqCN+359Oj1cUQg
   g==;
X-CSE-ConnectionGUID: CFc+Ojb3RJOkwNXWOqBmQg==
X-CSE-MsgGUID: t0Zz7JCmRmW2vKUmlk0viA==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82462029"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="82462029"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 01:36:49 -0700
X-CSE-ConnectionGUID: Rgg0GD4uQ3uEEHEK8Osuvg==
X-CSE-MsgGUID: eROkFS8YRD68BVaBFgVMeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="249597319"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 01:36:45 -0700
Date: Tue, 16 Jun 2026 11:36:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kurt Borja <kuurtb@gmail.com>,
	Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: adc: ti-ads112c14: add measurement channel
 support
Message-ID: <ajELGxonxsQp-Ut2@ashevche-desk.local>
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
 <20260615-iio-adc-ti-ads122c14-v1-4-e6bdadf7cb2b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-iio-adc-ti-ads122c14-v1-4-e6bdadf7cb2b@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 15, 2026 at 05:00:02PM -0500, David Lechner (TI) wrote:
> Add support for parsing devicetree properties for measurement channels
> and doing direct reads on these.
> 
> There are quite a lot of conditions that have to be met for each
> measurement to be made, so quite a bit of state and algorithms are
> required to handle it.
> 
> Channels are created dynamically since the number of possibilities is
> unreasonably large.

...

> +struct ads112c14_measurement {
> +	const char *label;
> +	u32 vref_source;
> +	u32 idac_current_uA;
> +	u8 iadc_count;
> +	u8 idac1_mux;
> +	u8 idac2_mux;
> +	bool current_chop;
> +	bool bipolar;
> +	u8 gain_val;

Hmm... Can we group u8:s for a better visual?

> +	int scale_available[ARRAY_SIZE(ads112c14_pga_gains_x10)][2];
> +};

...

>  struct ads112c14_data {
>  	const struct ads112c14_chip_info *chip_info;
>  	struct i2c_client *client;
>  	struct regmap *regmap;
> +	u32 avdd_uV;
> +	u32 ext_ref_uV;
> +	bool refp_is_avdd;
> +	bool refn_is_gnd;
> +	u32 ext_ref_ohms;
> +	struct ads112c14_measurement *measurements;
> +	u32 num_measurements;
>  	u8 sys_mon_chan_short_gain_val;

If you run `pahole` you will see a gap that can be easily avoided.

>  	int sys_mon_chan_short_scale_available[ARRAY_SIZE(ads112c14_pga_gains_x10)][2];
>  };

...


> +static int ads112c14_prepare_measurement_channel(struct ads112c14_data *data,
> +						 const struct iio_chan_spec *chan)
> +{
> +	struct ads112c14_measurement *measurement = &data->measurements[chan->scan_index];

> +	bool iunit = measurement->idac_current_uA > 100;
> +	u32 idac1_val = measurement->iadc_count > 0 ?
> +		measurement->idac_current_uA / (iunit ? 100 : 10) : 0;
> +	u32 idac2_val = measurement->iadc_count > 1 ? idac1_val : 0;

These three will look much better when decoupled from the definitions.

> +	u32 refp_buf_en, refn_buf_en;
> +	u32 ref_val, ref_sel;
> +	int ret;

	iunit = measurement->idac_current_uA > 100;
	if (measurement->iadc_count > 0)
		idac1_val = measurement->idac_current_uA / (iunit ? 100 : 10);
	else
		idac1_val = 0;
	idac2_val = measurement->iadc_count > 1 ? idac1_val : 0;

> +	ret = regmap_write(data->regmap, ADS112C14_REG_MUX_CFG,
> +			   FIELD_PREP(ADS112C14_MUX_CFG_AINP, chan->channel) |
> +			   FIELD_PREP(ADS112C14_MUX_CFG_AINN, chan->channel2));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(data->regmap, ADS112C14_REG_DIGITAL_CFG,
> +				 ADS112C14_DIGITAL_CFG_CODING,
> +				 FIELD_PREP(ADS112C14_DIGITAL_CFG_CODING,
> +					    measurement->bipolar ? 0 : 1));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(data->regmap, ADS112C14_REG_GAIN_CFG,
> +				 ADS112C14_GAIN_CFG_SYS_MON | ADS112C14_GAIN_CFG_GAIN,
> +				 FIELD_PREP(ADS112C14_GAIN_CFG_SYS_MON, 0) |
> +				 FIELD_PREP(ADS112C14_GAIN_CFG_GAIN,
> +					    measurement->gain_val));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, ADS112C14_REG_IDAC_MAG_CFG,
> +			   FIELD_PREP(ADS112C14_IDAC_MAG_CFG_I2MAG, idac2_val) |
> +			   FIELD_PREP(ADS112C14_IDAC_MAG_CFG_I1MAG, idac1_val));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, ADS112C14_REG_IDAC_MUX_CFG,
> +			   (iunit ? ADS112C14_IDAC_MUX_CFG_IUNIT : 0) |
> +			   FIELD_PREP(ADS112C14_IDAC_MUX_CFG_I2MUX,
> +				      measurement->idac2_mux) |
> +			   FIELD_PREP(ADS112C14_IDAC_MUX_CFG_I1MUX,
> +				      measurement->idac1_mux));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(data->regmap, ADS112C14_REG_DATA_RATE_CFG,
> +				 ADS112C14_DATA_RATE_CFG_GC_EN,
> +				 FIELD_PREP(ADS112C14_DATA_RATE_CFG_GC_EN,
> +					    measurement->current_chop));
> +	if (ret)
> +		return ret;
> +
> +	refp_buf_en = !data->refp_is_avdd &&
> +		      measurement->vref_source == ADS112C14_VREF_SOURCE_EXTERNAL;
> +	refn_buf_en = !data->refn_is_gnd &&
> +		      measurement->vref_source == ADS112C14_VREF_SOURCE_EXTERNAL;
> +
> +	ref_val = measurement->vref_source == ADS112C14_VREF_SOURCE_INTERNAL_2_5V;
> +
> +	switch (measurement->vref_source) {
> +	case ADS112C14_VREF_SOURCE_AVDD:
> +		ref_sel = ADS112C14_REFERENCE_CFG_REF_SEL_AVDD;
> +		break;
> +	case ADS112C14_VREF_SOURCE_EXTERNAL:
> +		ref_sel = ADS112C14_REFERENCE_CFG_REF_SEL_EXTERNAL;
> +		break;
> +	default:
> +		ref_sel = ADS112C14_REFERENCE_CFG_REF_SEL_INTERNAL;
> +		break;
> +	}
> +
> +	return regmap_update_bits(data->regmap, ADS112C14_REG_REFERENCE_CFG,
> +				  ADS112C14_REFERENCE_CFG_REFP_BUF_EN |
> +				  ADS112C14_REFERENCE_CFG_REFN_BUF_EN |
> +				  ADS112C14_REFERENCE_CFG_REF_VAL |
> +				  ADS112C14_REFERENCE_CFG_REF_SEL,
> +				  FIELD_PREP(ADS112C14_REFERENCE_CFG_REFP_BUF_EN,
> +					     refp_buf_en) |
> +				  FIELD_PREP(ADS112C14_REFERENCE_CFG_REFN_BUF_EN,
> +					     refn_buf_en) |
> +				  FIELD_PREP(ADS112C14_REFERENCE_CFG_REF_VAL,
> +					     ref_val) |
> +				  FIELD_PREP(ADS112C14_REFERENCE_CFG_REF_SEL,
> +					     ref_sel));
> +}

...

> -	if (chan->channel >= 100) {
> -		ret = ads112c14_prepare_sys_mon_channel(data, chan);
> +	if (chan->channel < 100) {
> +		ret = ads112c14_prepare_measurement_channel(data, chan);
>  		if (ret)
>  			return ret;
>  	} else {
> -		/* Not implemented yet. */
> -		return -EINVAL;
> +		ret = ads112c14_prepare_sys_mon_channel(data, chan);
> +		if (ret)
> +			return ret;
>  	}

Why ping-ponging this? Leave the condition as is. Or start with the < 100 in
the previous patch.

...

> +	if (chan->channel < 100) {

For the consistency's sake keep it the similar to the above.

> +		measurement = &data->measurements[chan->scan_index];
> +		fsr_bits = data->chip_info->resolution_bits - measurement->bipolar;
> +	} else {
> +		/* All SYS_MON channels are using signed coding. */
> +		fsr_bits = data->chip_info->resolution_bits - 1;
> +	}

...

>  		if (chan->channel == ADS112C14_SYS_MON_CHANNEL_SHORT) {
> -			int *scale_avail = data->sys_mon_chan_short_scale_available[
> +			scale_avail = data->sys_mon_chan_short_scale_available[
>  				data->sys_mon_chan_short_gain_val
>  			];

Oh, can we simply move the index to the temporary variable and make this look
better?

...

> -		for (u32 i = 0; i < ARRAY_SIZE(data->sys_mon_chan_short_scale_available); i++) {
> -			if (val == data->sys_mon_chan_short_scale_available[i][0] &&
> -			    val2 == data->sys_mon_chan_short_scale_available[i][1]) {
> -				data->sys_mon_chan_short_gain_val = i;
> -				return 0;
> -			}
> +	for (u32 i = 0; i < ARRAY_SIZE(ads112c14_pga_gains_x10); i++) {
> +		if (val == scale_avail[i][0] && val2 == scale_avail[i][1]) {
> +			*gain_val = i;
> +			return 0;
>  		}
> -		return -EINVAL;
> -	}

Can this be written in a better form initially to make less churn here?

...

> +	/* measurement channels */
> +	if (chan->channel < 100) {
> +		struct ads112c14_measurement *measurement =
> +			&data->measurements[chan->scan_index];

> +		if (!measurement->label)
> +			return -EINVAL;

Hmm... Can it be true?

> +		return sysfs_emit(label, "%s\n", measurement->label);
> +	}

...

> +static int ads112c14_parse_channels(struct iio_dev *indio_dev,
> +				    bool *need_avdd_ref, bool *need_ext_ref)
> +{
> +	struct ads112c14_data *data = iio_priv(indio_dev);
> +	struct device *dev = &data->client->dev;
> +	struct iio_chan_spec *channels;
> +	u32 pair[2];

> +	int i = 0;

Why signed? Also decouple assignment from definition.

> +	int ret;
> +
> +	*need_avdd_ref = false;
> +	*need_ext_ref = false;
> +
> +	data->num_measurements = device_get_named_child_node_count(dev, "channel");

> +	data->measurements = devm_kcalloc(dev, data->num_measurements,
> +					  sizeof(*data->measurements), GFP_KERNEL);
> +	if (!data->measurements)
> +		return -ENOMEM;
> +
> +	data->num_measurements += ARRAY_SIZE(ads112c14_sys_mon_channels);
> +
> +	channels = devm_kcalloc(dev, data->num_measurements +
> +				ARRAY_SIZE(ads112c14_sys_mon_channels),

size_add()? But here you add it twice, why?

> +				sizeof(*channels), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	device_for_each_named_child_node_scoped(dev, child, "channel") {
> +		struct ads112c14_measurement *measurement = &data->measurements[i];
> +		struct iio_chan_spec *spec = &channels[i];
> +
> +		if (!fwnode_device_is_available(child))
> +			continue;
> +
> +		spec->type = IIO_VOLTAGE;
> +		spec->indexed = 1;
> +		spec->scan_index = i;
> +		measurement->gain_val = 1;
> +
> +		fwnode_property_read_string(child, "label", &measurement->label);

> +		if (fwnode_property_present(child, "single-channel")) {
> +			ret = fwnode_property_read_u32(child, "single-channel", &spec->channel);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "failed to read single-channel property\n");
> +
> +			if (spec->channel >= 8)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "single-channel value must be between 0 and 7\n");
> +		} else if (fwnode_property_present(child, "diff-channels")) {
> +			ret = fwnode_property_read_u32_array(child, "diff-channels", pair, ARRAY_SIZE(pair));
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "failed to read diff-channels property\n");
> +
> +			if (pair[0] >= 8 || pair[1] >= 8)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "diff-channels values must be between 0 and 7\n");
> +
> +			spec->channel = pair[0];
> +			spec->channel2 = pair[1];
> +			spec->differential = 1;
> +		} else {
> +			return dev_err_probe(dev, -EINVAL,
> +					     "channel node missing channel type property\n");
> +		}

Looking how it's going to spread (I mean the above pattern), perhaps it's a time to introduce bunch of

	fwnode_property_read_*_optional()

and the respective device_property_read_*_optional()?

Let's start from u32 case only, as it will be most used anyway.

> +		if (fwnode_property_present(child, "excitation-channels")) {
> +			ret = fwnode_property_count_u32(child, "excitation-channels");
> +			if (ret < 0)
> +				return dev_err_probe(dev, ret,
> +						     "failed to read excitation-channels property\n");
> +
> +			if (ret < 1 || ret > 2)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "excitation-channels property must have 1 or 2 values\n");
> +
> +			measurement->iadc_count = ret;
> +			pair[1] = 0;
> +
> +			ret = fwnode_property_read_u32_array(child, "excitation-channels", pair, measurement->iadc_count);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "failed to read excitation-channels property\n");
> +
> +			if (pair[0] >= 8 || pair[1] >= 8)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "excitation-channels values must be between 0 and 7\n");
> +
> +			measurement->idac1_mux = pair[0];
> +			measurement->idac2_mux = measurement->iadc_count > 1 ? pair[1] : 0;
> +
> +			ret = fwnode_property_read_u32(child, "excitation-current-microamp",
> +						       &measurement->idac_current_uA);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "failed to read excitation-current-microamp property\n");
> +
> +			measurement->current_chop = fwnode_property_read_bool(child, "current-chopping");
> +		}
> +
> +		measurement->bipolar = fwnode_property_read_bool(child, "bipolar");
> +
> +		fwnode_property_read_u32(child, "ti,vref-source", &measurement->vref_source);
> +		if (measurement->vref_source > ADS112C14_VREF_SOURCE_AVDD)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "invalid vref-source value\n");
> +
> +		if (measurement->vref_source == ADS112C14_VREF_SOURCE_AVDD)
> +			*need_avdd_ref = true;
> +		if (measurement->vref_source == ADS112C14_VREF_SOURCE_EXTERNAL)
> +			*need_ext_ref = true;
> +
> +		spec->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE);
> +		spec->info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE);
> +
> +		i++;
> +	}
> +
> +	memcpy(channels + i, ads112c14_sys_mon_channels, sizeof(ads112c14_sys_mon_channels));
> +
> +	indio_dev->channels = channels;
> +	indio_dev->num_channels = i + ARRAY_SIZE(ads112c14_sys_mon_channels);
> +
> +	return 0;
> +}

...

> +static void ads112c14_populate_scale_available(int scale_avail[][2],
> +					       u32 vref_uV, u32 fsr_bits)
> +{
> +	for (u32 i = 0; i < ARRAY_SIZE(ads112c14_pga_gains_x10); i++) {
> +		int *entry = scale_avail[i];
> +		u32 gain_x10 = ads112c14_pga_gains_x10[i];
> +
> +		entry[0] = div_u64_rem(div64_u64((u64)(NANO * 10 /
> +						       (MICRO / MILLI)) * vref_uV,
> +						 (u64)gain_x10 * BIT(fsr_bits)),

Hmm... This differs from the previous implementation. Why?

> +				       NANO, &entry[1]);
> +	}
> +}

...

> +	if (device_property_present(dev, "refp-refn-resistor-ohms")) {
> +		if (refp_uV != 0 || refn_uV != 0)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "refp-refn-resistor-ohms property should not be present when refp-supply or refn-supply is present\n");
> +
> +		ret = device_property_read_u32(dev, "refp-refn-resistor-ohms",
> +					       &data->ext_ref_ohms);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to read refp-refn-resistor-ohms property\n");

Using

	const char *propname;
	...
	propname = "refp-refn-resistor-ohms";

makes this

	if (device_property_present(dev, propname)) {
		if (refp_uV != 0 || refn_uV != 0)
			return dev_err_probe(dev, -EINVAL,
					     "%s property should not be present when refp-supply or refn-supply is present\n",
					     propname);

		ret = device_property_read_u32(dev, propname, &data->ext_ref_ohms);
		if (ret)
			return dev_err_probe(dev, ret, "failed to read %s property\n", propname);

Also the rest can be improved in the similar way.

> +	} else {
> +		if (need_ext_ref && data->ext_ref_uV == 0)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "external reference measurements require either refp-supply or refp-refn-resistor-ohms property\n");
> +	}

-- 
With Best Regards,
Andy Shevchenko


