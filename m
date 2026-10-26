Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793045624;
	b=1nPe62vAyUBk3audvSqW0/F2dEHkUVgIWCLvQ+TiiS5zHzhZJJXiG6pg06tjNoxoo638
	 JG21KlGMoKpYwi5sqFvzMonewsgbeXgHCCgGWNTzdkxeFGSyOTJmrdJjbsW0emxmf1Wku
	 jMxAwZ43+1rj6Ehogs37Mt5XOzuSstfGExfY5/UuGjp8S32/EwRUTHX9nl0b6qZu9WjX7
	 uCcXIZOxmn8g64DawEcoA0VCqdv1owERVAXpTjDfLhpaiFn+Q5H6VOG23lx9ySG0gdIK7
	 dITEWoiyo+g//P/BQj6nyX4LtiYVTy7WXx6UlcYWIwpfBnVNkF6fsnyCNP94Ro+yX1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793045624;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=kNy67E0ovLt8TzLvMy++WQEgiPFH7FIGj23FzpCowmk=;
	b=UeC24sZ40M6JoKe21DbVjt+g1QX1erwQJ6C7A4wUntBXAInUNYncSp94P5RhCcsg6OHL
	 djOjwfBi5OYrwrhFDDhCgoUio0YSJPcPJxxVBV+6LNpL6hBX9CAglP8P00V/DfxpSJA4g
	 1RbGoZHG30NSTjZ9OmVCp7rLV/EfOA7MknQ+HOfJ0lP88+TX9CPY3lviqlSlpID3vPTQx
	 1cfQiqnL8Mvgf/MTuDZ3YMx4Wqzsm3kR8rqiEUuQ6BkazXNR2fE+eijss5ChcF3YrYFV5
	 1PZ3dmNxbFSfjk9aqUDGk3C6e/ixjbcCWgHnW5TbjmZArFPGPJVNX/lPN5fpxbp6e0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ClTBrJB7;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8318E606A323;
	Mon, 26 Oct 2026 20:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8318E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ClTBrJB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793045623; x=1824581623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fY6/ucNuO0SnDJMQGPu88RMx9ffrdOcwr4EHZtee2B4=;
  b=ClTBrJB7qcyl/ZN9s5pUTQCFbmifZ8JJcwuRJ+XZB3CwrbXWfi0V8brg
   yXrc/shK46Bu2HdhJhK6uI4vwSFu36juvE7pHVvHG/mpI0oBojDeYBsnP
   Tw0rKKH18iE/M6CWBuzFMQYLr2U1Wg9/qwXlLjFN+IxYMlOFOoguRP/rj
   pagQuV9oxRR0eNdFUcNad42vOHSt3ckhf8jNsosE4tNJh+lOPsMdAP6rU
   c9j6FobO5MNI7QfpWiyr9gtKA/D5r0gnoOO/Xhjyb1WO5ln5xC44Ir7jK
   g09ShNvqCLGINd9CoPP1GtTIl5wOG2qL9jciQQzYxxeBNQZfdg5vxBFde
   g==;
X-CSE-ConnectionGUID: OGcxCygyT/W0rLcSEfv/sA==
X-CSE-MsgGUID: /KW1lquXS8GsR2j5d/Zpig==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1745022"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1745022"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 13:13:42 -0700
X-CSE-ConnectionGUID: DXPwm/T8SWCi+oFe6kcQhw==
X-CSE-MsgGUID: pvvSMQkSShmg8Xd3guMmdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4311673"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 13:13:40 -0700
Date: Mon, 26 Oct 2026 22:13:37 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <at-0cXiBV0RM-Att@ashevche-desk.local>
References: <SN1PR12MB252882C0E885BF3368E036E5A5612@SN1PR12MB2528.namprd12.prod.outlook.com>
 <SN1PR12MB2528DB8EE8ACEBF9551ED52EA5612@SN1PR12MB2528.namprd12.prod.outlook.com>
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
In-Reply-To: <SN1PR12MB2528DB8EE8ACEBF9551ED52EA5612@SN1PR12MB2528.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 11:51:14AM -0500, Victor Chernyakin wrote:
> The FDC1004 is a high-precision 4-channel capacitive sensor that talks
> over I2C. It can report the values of each of its 4 channels individually,
> as well as the difference between any two of them.
> 
> This initial driver allows performing single reads and configuring
> the sensor's various settings (sample frequency, calibration
> gain/offset, etc.). It could be extended with support for triggered
> buffers, repeated measurement mode, and/or power management.

...

> +static int fdc1004_soft_reset(struct fdc1004_data *data)
> +{
> +	int ret;
> +	unsigned int val;

Try to keep all of them in the reversed xmas tree order.

> +	ret = regmap_write(data->regmap, FDC1004_REG_FDC_CONF,
> +			   FDC1004_FDC_CONF_RST_MASK);

	struct regmap *map = data->regmap;
	...

	ret = regmap_write(map, FDC1004_REG_FDC_CONF, FDC1004_FDC_CONF_RST_MASK);

(yes, it's fine to have 81 characters here)

> +	if (ret)
> +		return ret;
> +
> +	return regmap_read_poll_timeout(data->regmap, FDC1004_REG_FDC_CONF, val,
> +					!(ret & FDC1004_FDC_CONF_RST_MASK),
> +					1 * USEC_PER_MSEC, 200 * USEC_PER_MSEC);
> +}

...

> +static int fdc1004_read_raw(struct iio_dev *indio_dev,
> +			    const struct iio_chan_spec *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct fdc1004_data *data = iio_priv(indio_dev);
> +	struct regmap *map = data->regmap;
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
> +		reg_val = FIELD_PREP(FDC1004_CONF_MEAS_CHA_MASK, chan->channel)
> +			| FIELD_PREP(FDC1004_CONF_MEAS_CHB_MASK, chan->channel2)
> +			| FIELD_PREP(FDC1004_CONF_MEAS_CAPDAC_MASK,
> +				      data->offsets[chan->channel]);

We don't practice this style in IIO.

		reg_val = FIELD_PREP(FDC1004_CONF_MEAS_CHA_MASK, chan->channel) |
			  FIELD_PREP(FDC1004_CONF_MEAS_CHB_MASK, chan->channel2) |
			  FIELD_PREP(FDC1004_CONF_MEAS_CAPDAC_MASK,
				      data->offsets[chan->channel]);

> +		ret = regmap_write(map, FDC1004_REG_CONF_MEASn(0), reg_val);
> +		if (ret)
> +			return ret;
> +
> +		/* Start the measurement. */
> +		reg_val = FDC1004_FDC_CONF_MEAS_n_MASK(0)
> +			/* "+ 1" because the chip wants a 1-indexed value. */

Move comment on top of the assignment.

> +			| FIELD_PREP(FDC1004_FDC_CONF_RATE_MASK,
> +				     data->samp_freq_index + 1);

Same about the style.

> +		ret = regmap_write(map, FDC1004_REG_FDC_CONF, reg_val);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * Wait for the measurement to complete.
> +		 * The slowest sampling frequency the chip supports is 100 SPS,
> +		 * i.e. 1 sample every 10 ms, so our timeout can't be shorter
> +		 * than that. Go with 40 ms to be safe.
> +		 */
> +		ret = regmap_read_poll_timeout(map, FDC1004_REG_FDC_CONF, reg_val,
> +					       reg_val & FDC1004_FDC_CONF_DONE_n_MASK(0),
> +					       1 * USEC_PER_MSEC, 40 * USEC_PER_MSEC);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * Now read the two registers making up the measurement.
> +		 * The datasheet says to read MSB first, LSB second.
> +		 */
> +		ret = regmap_bulk_read(map, FDC1004_REG_MEASn_MSB(0),
> +				       reg_vals, ARRAY_SIZE(reg_vals));
> +		if (ret)
> +			return ret;
> +
> +		*val = (sign_extend32(reg_vals[0], 15) << 8) | (reg_vals[1] >> 8);

We still have two shift operators, so it might be not a bad idea after all to
have a combined variable with wordswap done in case of LITTLE_ENDIAN
architecture. Jonathan, what do you think about this? Reading the whole set as
32-bit value and convert it if required

		// also note in this case we don't need to have _MSB in the name
		ret = regmap_bulk_read(map, FDC1004_REG_MEASn(0), reg_val, sizeof(reg_val));
		if (ret)
			return ret;

#ifdef __LITTLE_ENDIAN
		reg_val = swahw32(reg_val);
#endif

		*val = sign_extend32(reg_val >> 8, 23);

		// I assume the following is also possible in this case
		// *val = (int)reg_val >> 8;
		// but usually we use sign_extend32() in IIO even when simple
		// casting is okay

This also reduces stack usage.

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
> +		ret = regmap_read(map, FDC1004_REG_OFFSET_CAL_CINn(chan->channel),
> +				  &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		iio_val_s64_decompose(sign_extend64(reg_val, 15) *
> +				      fdc1004_calibbias[1], val, val2);
> +		return IIO_VAL_DECIMAL64_FEMTO;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		ret = regmap_read(map, FDC1004_REG_GAIN_CAL_CINn(chan->channel),
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

We still haven't decided on this one. I think the 2D array is better for these.
And with the above we effectively have a duplication of the tables.

...

> +#define FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(_chan1, _chan2)         \
> +	{                                                                \
> +		.type = IIO_CAPACITANCE,                                 \
> +		.indexed = true,                                         \
> +		.differential = true,                                    \
> +		.channel = _chan1,                                       \
> +		.channel2 = _chan2,                                      \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),            \
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),    \
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +		.info_mask_shared_by_all_available =                     \
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),                    \
> +	}

Please, use tab for indenting the \ slashes (and only spaces at the end if you
want to shorten that a bit).

-- 
With Best Regards,
Andy Shevchenko


