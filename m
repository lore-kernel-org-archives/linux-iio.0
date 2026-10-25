Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792963475;
	b=e2S7au+uzeZQLPS+eInMh19eoob0ipIaaQqYYy7m4TO05WtGMCEEi5o36H9acb3ne+gE
	 yOSJVeVAfoQWl7pkkiQiRxizellUrpc6NKIvTG8BL7JJD3J68bjWpkTc4qtUGRpu0pAaX
	 xbl7VhV6JZhpGHLKO+G3/Sv1j+IMKwoK6YMmeXTwaR6PMvR//vPyVoH9bRzLzUoDhfjbe
	 Y9GBAAJgd76p9dqnSwh3Lz7hIp+iCoQKDcRhvqwAd3kGCsmdjUxhc/TIUWBPZVx/m49L2
	 varDDmiLobkwxPj1BHKypABZdB9J9lkpHLtJSKTT/wcWNjoegcwrg8PCubKq0EpF84Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792963475;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=ZdiX0Id6lWpfL1DTDyTXD0CNO/aLhglVewmKyLJH0Oc=;
	b=3VVFSCV5Y0QRxQ2hTRw+GQppL5AsZfJWHVFN1JsVDY2j7rpccxZ9cfjFhdzXwGudbgfA
	 9C/OmV8GEWvcaEmoOoXZ9uq1wuXcLpG5xnl+ue6GGrlnqttz89API3fR+rcnqYh986SPA
	 xqtWANkUBgLRDhWCLa147g1r8MgMhevG2P1ZEcqC8mw2mvxja/3Xu/bn/SwQAdhmXtFPN
	 VgAyfYyTIVAyr9NPIhIZjstgnijivcLrJ80C55Io+io5URHLybD5OcV/f1TEPCqot89t3
	 MQ/t/QT6cKdZLBUcjsvdNPU2ybZ8tDNeS7948M/F7K3AZuIdw2VFf7PkodvBkZsH6jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=En5bwBeF;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9F9606A31A;
	Sun, 25 Oct 2026 21:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E9F9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=En5bwBeF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792963473; x=1824499473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nmTvRV+QRXARAQimWUiywwsOm0Svuuny40qmfdU/hMk=;
  b=En5bwBeFLiAhMwFBxwqLHgX8jKzI9z6dqn7LjotIRPFcUNnZQd+0xwnZ
   umpSjRmSqyhvjxo5eq2XgZm71xlfXGnQGhseaRawGY/9S+ZbMtzdnKdOC
   jz/QG7JkQYZj4oobJ9QglESGEW3utM5Hg5CgFBB7EsWesPdbNh2h1j1Md
   O9pIdFCw3qLCS89TxLmTZpqLbz9r3bJxX6qM8hHRk8C87PwoO/KqjKVxu
   9Zmz5NLRHs6LSUbUJKcGWPSs71z7ty3/+z0w7DaGH+F3EQ3vv21+NRMMm
   7Lg2QZFYQ/O2+HTrjzNaS7Dbc5VYmYL6XE64kNuVT72QfcKcyN4a8lFvT
   Q==;
X-CSE-ConnectionGUID: 0KQ3vg2/R4KTREXvdvFjwg==
X-CSE-MsgGUID: llqEVL+AQbKgahiyUWPSgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1719018"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1719018"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 14:24:32 -0700
X-CSE-ConnectionGUID: 5aIUVeNVSXmp8dqh/XFaWQ==
X-CSE-MsgGUID: XZSgQN5OQ6+XslaO2BiVGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4001127"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 14:24:30 -0700
Date: Sun, 25 Oct 2026 23:24:27 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <at5zi4U2dktAOM7n@ashevche-desk.local>
References: <SN1PR12MB2528DD1E6067CC4C0B76746FA5622@SN1PR12MB2528.namprd12.prod.outlook.com>
 <SN1PR12MB25285E05ADA7EBA8B7010292A5622@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN1PR12MB25285E05ADA7EBA8B7010292A5622@SN1PR12MB2528.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 25, 2026 at 12:48:06AM -0500, Victor Chernyakin wrote:
> The FDC1004 is a high-precision 4-channel capacitive sensor that talks
> over I2C. It can report the values of each of its 4 channels individually,
> as well as the difference between any two of them.
> 
> This initial driver allows performing single reads and configuring
> the sensor's various settings (sample frequency, calibration
> gain/offset, etc.). It could be extended with support for triggered
> buffers, repeated measurement mode, and/or power management.

...

> +/*
> + * OFFSET_CAL_CINn: 16 bits, signed. Format: IIO_VAL_DECIMAL64_FEMTO.
> + * 1 step = 1/(2^11) pF = 1/(1000 * 2^11) nF = 0.000000488281250 nF.
> + */
> +static const s64 fdc1004_calibbias[] = {
> +	-0x8000 * 488281250UL, /* min */
> +	+0x0001 * 488281250UL, /* step */
> +	+0x7FFF * 488281250UL, /* max */
> +};

Can you explain the negative capacitance meaning? Does it mean some vector
(direction) in the physical world?

...

> +static int fdc1004_read_raw(struct iio_dev *indio_dev,
> +			    const struct iio_chan_spec *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct fdc1004_data *data = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	u16 reg_vals[2];
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		iio_val_s64_decompose(fdc1004_scale, val, val2);
> +		return IIO_VAL_DECIMAL64_YOCTO;
> +	case IIO_CHAN_INFO_RAW: {
> +		guard(mutex)(&data->lock);
> +
> +		/* Configure the measurement we want. */
> +		reg_val = FIELD_PREP(FDC1004_CONF_MEAS_CHA_MASK, chan->channel);
> +		reg_val |= FIELD_PREP(FDC1004_CONF_MEAS_CHB_MASK, chan->channel2);
> +		reg_val |= FIELD_PREP(FDC1004_CONF_MEAS_CAPDAC_MASK,
> +				      data->offsets[chan->channel]);
> +		ret = regmap_write(data->regmap, FDC1004_REG_CONF_MEASn(0), reg_val);

You can make a lot of lines to fit 80 characters limit with a simple trick,
id est add a local variable.

	struct regmap *map = data->regmap;
	...
		ret = regmap_write(map, FDC1004_REG_CONF_MEASn(0), reg_val);
	...

> +		if (ret)
> +			return ret;
> +
> +		/* Start the measurement. */
> +		reg_val = FDC1004_FDC_CONF_MEAS_n_MASK(0);
> +		/* "+ 1" because the chip wants a 1-indexed value. */
> +		reg_val |= FIELD_PREP(FDC1004_FDC_CONF_RATE_MASK,
> +				      data->samp_freq_index + 1);

Make it a single assignment (just multi-line).
Same for the rest of the similar cases.

> +		ret = regmap_write(data->regmap, FDC1004_REG_FDC_CONF, reg_val);
> +		if (ret)
> +			return ret;

> +		/*
> +		 * Wait for the measurement to complete.
> +		 * The slowest sampling frequency the chip supports is 100 SPS,
> +		 * i.e. 1 sample every 10 ms, so our timeout can't be shorter than
> +		 * that. Go with 40 ms to be safe.
> +		 */
> +		ret = regmap_read_poll_timeout(
> +			data->regmap, FDC1004_REG_FDC_CONF, reg_val,
> +			reg_val & FDC1004_FDC_CONF_DONE_n_MASK(0),
> +			1 * USEC_PER_MSEC, 40 * USEC_PER_MSEC);

The indentation is broken.

> +		if (ret)
> +			return ret;
> +
> +		/* The datasheet says to read MSB first, LSB second. */
> +		ret = regmap_bulk_read(data->regmap, FDC1004_REG_MEASn_MSB(0),
> +				       reg_vals, ARRAY_SIZE(reg_vals));
> +		if (ret)
> +			return ret;
> +
> +		*val = (sign_extend32(reg_vals[0], 15) << 8) | (reg_vals[1] >> 8);


So, why the value is not marked as __be32 with the respective conversion?

> +		return IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		guard(mutex)(&data->lock);
> +
> +		*val = fdc1004_samp_freqs[data->samp_freq_index];
> +		return IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_OFFSET: {
> +		guard(mutex)(&data->lock);
> +
> +		*val = data->offsets[chan->channel] * fdc1004_offset[1];
> +		return IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		ret = regmap_read(data->regmap,
> +				  FDC1004_REG_OFFSET_CAL_CINn(chan->channel),
> +				  &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		iio_val_s64_decompose(sign_extend64(reg_val, 15) *
> +				      fdc1004_calibbias[1], val, val2);
> +		return IIO_VAL_DECIMAL64_FEMTO;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		ret = regmap_read(data->regmap,
> +				  FDC1004_REG_GAIN_CAL_CINn(chan->channel),
> +				  &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		iio_val_s64_decompose(reg_val * fdc1004_calibscale[1], val, val2);
> +		return IIO_VAL_DECIMAL64_FEMTO;
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static const int fdc1004_calibbias_decomposed[] = {
> +	lower_32_bits(fdc1004_calibbias[0]), upper_32_bits(fdc1004_calibbias[0]),
> +	lower_32_bits(fdc1004_calibbias[1]), upper_32_bits(fdc1004_calibbias[1]),
> +	lower_32_bits(fdc1004_calibbias[2]), upper_32_bits(fdc1004_calibbias[2]),
> +};
> +
> +static const int fdc1004_calibscale_decomposed[] = {
> +	lower_32_bits(fdc1004_calibscale[0]), upper_32_bits(fdc1004_calibscale[0]),
> +	lower_32_bits(fdc1004_calibscale[1]), upper_32_bits(fdc1004_calibscale[1]),
> +	lower_32_bits(fdc1004_calibscale[2]), upper_32_bits(fdc1004_calibscale[2]),
> +};

Why do we need these tables while already having them just in different
format? Perhaps you can always keep the decomposed variant and otherwise
join them at run-time?

-- 
With Best Regards,
Andy Shevchenko


