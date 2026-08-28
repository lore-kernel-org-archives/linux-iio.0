Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C223921F0;
	Fri, 28 Aug 2026 07:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787902731; cv=none; b=OzL1KG/R9z+y3ghiDOxNn7T1kWltIJpTeIdFrLOYHZDZzGGruztO8q1wR9o/JPhZqDnCzhVH37fDmubm93VzO3PFyr2WyVQGUEZyEd2aUrY67rgW0C8r941UIg5Y3W7+8eypip6X1hg4760B83Z2yRUixi0+xwqLfBAaGLsWa4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787902731; c=relaxed/simple;
	bh=SLz/Dg4K02+jKR44dBXppCb8+VQ0oze8qnhCEK4tZ9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6c1NjF6JTuKdAz+iKstVuYarj4yANkN1U5Hp4b6mDoAQcczDX9Qrqm+su4rTgAMeDMypCo2vEQetSLrZ+AZvm7CP/ECzBdCPbvNXDKywCk3tlCE3gI1d3dIXW+g1037zRAayjpNIkpPdAk8LQxPkPv+KWEwZloU2+NHJIw5rN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n2qKXZIR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n2qKXZIR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787902730; x=1819438730;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SLz/Dg4K02+jKR44dBXppCb8+VQ0oze8qnhCEK4tZ9I=;
  b=n2qKXZIRXaVqTpSWm4UQsZB3bdtwoAHTFVQJyDWmoLZjw81hngSOiUdB
   cBAKp3u3F5IFFKg1W7CY7bsy6LSYrsIx8Yi6uhbo95WPb1moJ0BtX9Lwy
   K8x1sm7olPwu4pnG4CP4Z996OZvDXZ94xTxMNEjwyeDjxVKjoBPbkOxkD
   n+XD2WWLpdpZWpWFIotoojtPQoIyObzTb8a+SU/z//04lGJLf8CMKO1UT
   oN5X6JvjJHd9K6b9I4Fs1lz0n+e/A4YRsYN/svz+052HTo3dBLWQnDBuu
   rJbA70wqG3BdjsK9PsP+yxGl3lf4B5uAKBmaKTUXfPSIRUIYyZiW6Ah5l
   g==;
X-CSE-ConnectionGUID: 5RWa7M84RAuUa4VjXIsUgw==
X-CSE-MsgGUID: AIijXRhrRA6K2tjTiqNuqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88173457"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="88173457"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 00:38:49 -0700
X-CSE-ConnectionGUID: CXnFHEbHT4ODaNDcS+SLbQ==
X-CSE-MsgGUID: EzJ5IBiLSA+R2Joo2SHs2w==
X-ExtLoop1: 1
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.34])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 00:38:47 -0700
Date: Fri, 28 Aug 2026 10:38:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Chris Hall <c-hall@ti.com>,
	Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: adc: ti-ads112c14: add burnout current
 support
Message-ID: <apE7BEGrIzJd1_zx@ashevche-desk.local>
References: <20260827-iio-adc-ti-ads112c14-burnout-v2-0-00a1fab9e2d1@baylibre.com>
 <20260827-iio-adc-ti-ads112c14-burnout-v2-1-00a1fab9e2d1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827-iio-adc-ti-ads112c14-burnout-v2-1-00a1fab9e2d1@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 27, 2026 at 05:27:02PM -0500, David Lechner (TI) wrote:
> Add a custom attribute via ext_info when a channel has a burnout current
> specified in the devicetree. This adds an in_{voltageY,resistanceY,
> voltageY-voltageX}_burnoutraw sysfs attribute for the channel that
> performs a single conversion (same as _raw attribute) except that it
> enables the burnout current. The chip also has a restriction that input
> chopping cannot be enabled when burnout current is enabled, so we also
> disable input chopping when burnout current is active.

...

>  	ret = regmap_update_bits(data->regmap, ADS112C14_REG_DATA_RATE_CFG,
>  				 ADS112C14_DATA_RATE_CFG_GC_EN,
>  				 FIELD_PREP(ADS112C14_DATA_RATE_CFG_GC_EN,
> -					    measurement->global_chop));
> +					    measurement->global_chop && !en_burnout));

Strictly speaking the argument for FIELD_PREP should be integer and not boolean.

>  	if (ret)
>  		return ret;

...

> +static ssize_t ads112c14_read_burnout_raw(struct iio_dev *indio_dev,
> +					  uintptr_t private,
> +					  struct iio_chan_spec const *chan,
> +					  char *buf)
> +{
> +	struct ads112c14_data *data = iio_priv(indio_dev);
> +	struct ads112c14_measurement *measurement;
> +	int ret, ret2, val;
> +	u8 raw_buf[3];
> +
> +	if (chan->channel >= ADS112C14_SYS_MON_CHANNEL_BASE)
> +		return -EINVAL;
> +
> +	measurement = &data->measurements[chan->scan_index];

> +

Unneeded blank line.

> +	if (!measurement->burnout)
> +		return -EINVAL;
> +
> +	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +	if (IIO_DEV_ACQUIRE_FAILED(claim))
> +		return -EBUSY;
> +
> +	ret = regmap_update_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
> +				 ADS112C14_DEVICE_CFG_BOCS,
> +				 FIELD_PREP(ADS112C14_DEVICE_CFG_BOCS,
> +					    measurement->burnout));
> +	if (ret)
> +		return ret;
> +
> +	ret = ads112c14_single_conversion(data, chan, raw_buf, true, false);
> +
> +	/*
> +	 * Important to always turn off burnout current even if the conversion
> +	 * fails so that it does not affect subsequent measurements. This error
> +	 * also takes precedence over the conversion error since the device may
> +	 * be left in a bad state.
> +	 */
> +	ret2 = regmap_update_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
> +				  ADS112C14_DEVICE_CFG_BOCS,
> +				  FIELD_PREP(ADS112C14_DEVICE_CFG_BOCS,
> +					     ADS112C14_DEVICE_CFG_BOCS_DISABLED));
> +	if (ret2)
> +		return ret2;

What we will get of sharing this error code instead of 'ret' in case of single
conversion failure? I think there is no recovery mechanism involved, right?

> +	if (ret < 0)
> +		return ret;

> +	switch (data->chip_info->resolution_bits) {
> +	case 16:
> +		val = get_unaligned_be16(raw_buf);
> +		break;
> +	case 24:
> +		val = get_unaligned_be24(raw_buf);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (measurement->bipolar)
> +		val = sign_extend32(val, data->chip_info->resolution_bits - 1);
> +
> +	return sysfs_emit(buf, "%d\n", val);
> +}

And this is after all a user space interaction, so whatever error code is
returned, user space will know it. I assume you are telling that the restoring
the "burnout current" setting is important, but how will user space distinguish
that case from the single conversion failure?

...

With

	const char *propname;
	...
		propname = "burn-out-current-nanoamp";

> +		if (fwnode_property_present(child, "burn-out-current-nanoamp")) {
> +			u32 burnout_nA;
> +
> +			ret = fwnode_property_read_u32(child, "burn-out-current-nanoamp",
> +						       &burnout_nA);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "failed to read burn-out-current-nanoamp property\n");

This can be shortened as well as the other message below.

> +			switch (burnout_nA) {
> +			case 200:
> +				measurement->burnout = ADS112C14_DEVICE_CFG_BOCS_200_nA;
> +				break;
> +			case 1000:
> +				measurement->burnout = ADS112C14_DEVICE_CFG_BOCS_1_uA;
> +				break;
> +			case 10000:
> +				measurement->burnout = ADS112C14_DEVICE_CFG_BOCS_10_uA;
> +				break;
> +			default:
> +				return dev_err_probe(dev, -EINVAL,

I would use different error code, EINVAL is abused and overloaded a lot in the
kernel, and basically errors like ENODEV and EINVAL are synonyms to "*an* error"
happened. Unfortunately, reading the errno*.h I haven't found anything better.

> +						     "invalid burn-out-current-nanoamp value\n");
> +			}
> +
> +			if (measurement->burnout)
> +				spec->ext_info = ads112c14_ext_info_burnout;
> +		}

-- 
With Best Regards,
Andy Shevchenko


