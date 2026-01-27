Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003942DEA90;
	Tue, 27 Jan 2026 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769510780; cv=none; b=Dp9TuPPoJkBGt5YQe6/hvbi13G9tN0kTiI6glsrabkHQZUSan0KRvkvqdZUSsIKkxAATycIfopXntTxtDU4d5XUJSfdxRRBygrbqgPTyGpMJEEO3tSZ4CbkfcNwMpacaJAxhF15fm/LsKu+WCTKLLTKmaaTUL5XqvoMa+yw4M+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769510780; c=relaxed/simple;
	bh=bhw/C/0+qZF0EiCUgLPqLYQZGIV16H1a4k9jqPUVhx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/XP9/ypO9Y3KfNiYIakDbCvtxJQj9AhPpgnG6DBnvd1w5lT6ImkEYVE12touChxwY1+u0GpYhmp0EDuUyLuZa5hr7//K1n6MNPlHxHAHBKOkTsQYETlos07NaTyVamegrhYUWZ5b/IVGVtbzoNF1gGt7og9p3H5oFeo36qb1h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kTcqhsdv; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kTcqhsdv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769510779; x=1801046779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bhw/C/0+qZF0EiCUgLPqLYQZGIV16H1a4k9jqPUVhx4=;
  b=kTcqhsdvBw2T2r+ukixmev+WATR5qoN3NNvskcWIMv/bJFQ3GX+flGts
   arKsceQij1TirowA0Iej+t7woURBaExL3TRGEKORhdsRe9//5ais0IKKP
   QKPyBCGB/gsnysApS7sdSzBK8WCKjDUBYFiSfLiSmZlsmP9gh+8ziMkSU
   VqJzrJ4pVo2wU7P2+/S9xiulAYmXPH9E6tAPMEGX9GSC2AOzbnhF5TQ5x
   oL2cFQDwFQqn1DrxDWVeQILb2PIuAHqXnnwhU3uGBzrg4tlliY5jcU1Yr
   4hAeJL1QnA3S0Aom6hLG+FX8cCB6WggS4aczql4KxaYigIADay7pKCIWy
   A==;
X-CSE-ConnectionGUID: AQCwLFW7QsSwZPNqf54Jog==
X-CSE-MsgGUID: YzSEEdzTTB6m5E+iOzjZxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70421606"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="70421606"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 02:46:19 -0800
X-CSE-ConnectionGUID: jLtQ5K7KRpmVO97mibk9TQ==
X-CSE-MsgGUID: Woo3pmCiSh+07n/WTg0SHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="212805112"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.248])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 02:46:15 -0800
Date: Tue, 27 Jan 2026 12:46:13 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v2 7/8] iio: dac: ds4424: add Rfs-based scale and
 per-variant limits
Message-ID: <aXiXdVg6WuyiwBWa@smile.fi.intel.com>
References: <20260127060939.3914006-1-o.rempel@pengutronix.de>
 <20260127060939.3914006-8-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127060939.3914006-8-o.rempel@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 27, 2026 at 07:09:38AM +0100, Oleksij Rempel wrote:
> Parse optional maxim,rfs-ohms values to derive the per-channel output
> current scale (mA per step) for the IIO current ABI.
> 
> Select per-variant parameters to match the shared register map while
> handling different data widths and full-scale current calculations.
> 
> Behavior changes:
> - If maxim,rfs-ohms is present, IIO_CHAN_INFO_SCALE becomes available
>   and reports mA/step derived from Rfs.
> - If maxim,rfs-ohms is missing, SCALE is not exposed to keep older DTs
>   working without requiring updates.
> - RAW writes are now limited to the representable sign-magnitude range
>   of the detected variant to avoid silent truncation (e.g. +/-31 on
>   DS440x).

...

> +struct ds4424_chip_info {
> +	int vref_mv;

_mV ?

> +	int scale_denom;
> +	u8 result_mask;
> +};

...

> +static int ds4424_setup_channels(struct i2c_client *client,
> +				 struct ds4424_data *data,
> +				 struct iio_dev *indio_dev)
> +{
> +	struct iio_chan_spec *channels;
> +	size_t channels_size;
> +
> +	channels_size = indio_dev->num_channels * sizeof(ds4424_channels[0]);
> +	/* Use a local non-const pointer for modification */
> +	channels = devm_kmemdup(&client->dev, ds4424_channels, channels_size,
> +				GFP_KERNEL);

Why not devm_kmemdup_array()?

> +	if (!channels)
> +		return -ENOMEM;
> +
> +	if (data->has_rfs) {
> +		for (unsigned int i = 0; i < indio_dev->num_channels; i++)
> +			channels[i].info_mask_separate |=
> +				BIT(IIO_CHAN_INFO_SCALE);
> +	}
> +
> +	indio_dev->channels = channels;
> +
> +	return 0;
> +}

...

> +static int ds4424_parse_rfs(struct i2c_client *client,
> +			    struct ds4424_data *data,
> +			    struct iio_dev *indio_dev)
> +{
> +	struct device *dev = &client->dev;
> +	int count, ret;

Can count be negative?

> +	if (!device_property_present(dev, "maxim,rfs-ohms")) {
> +		dev_info_once(dev, "maxim,rfs-ohms missing, scale not supported\n");
> +		return 0;
> +	}
> +
> +	count = device_property_count_u32(dev, "maxim,rfs-ohms");
> +	if (count != indio_dev->num_channels)
> +		return dev_err_probe(dev, -EINVAL, "maxim,rfs-ohms must have %u entries\n",
> +				     indio_dev->num_channels);
> +
> +	ret = device_property_read_u32_array(dev, "maxim,rfs-ohms",
> +					     data->rfs_ohms,
> +					     indio_dev->num_channels);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read maxim,rfs-ohms property\n");
> +
> +	for (unsigned int i = 0; i < indio_dev->num_channels; i++) {
> +		if (!data->rfs_ohms[i])
> +			return dev_err_probe(dev, -EINVAL, "maxim,rfs-ohms entry %d is zero\n",

%u

> +					     i);

I would leave it on the same line.

> +	}
> +
> +	data->has_rfs = true;
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


