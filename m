Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4923377556;
	Tue, 24 Feb 2026 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771928698; cv=none; b=SEbJpxHTywS2hhqMYf0NBVfQPfOs4jZyoDX1npIR7SVpSSq5z8XQ5bUXw9cG+Mq4hWsPSs9BzyZ4BEltmrrsyXtdIxzfgs/qU0QmCAMv1qKH602Z2fd5Sg8DHuMCVipUHa7q1Ng1CNWqV9A+cQpt2ZemRayxHbaKG6bUAMCrMrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771928698; c=relaxed/simple;
	bh=rN6bOSsyonJiEFKFzW6StaJ9I+cOMBZ+XopFVnwO9Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bi14nkNdlNjMd+Hqv6QSaF9q43tcXw1f/FC2o2rkYSfyKfqElec2QX+tRYHjQw/NlhZp8XO5Qy1O5JgbGO6KGNqttFv2pCmXTi/u90WQHQkgaOptIiYw/+CdmQU1LGfdrUOrjrv4NhHG7YBE2fa/CkZyO5D+Ebgi5cHuMYAgd+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XiuIMyb8; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XiuIMyb8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771928697; x=1803464697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rN6bOSsyonJiEFKFzW6StaJ9I+cOMBZ+XopFVnwO9Hg=;
  b=XiuIMyb88odydvXw2I8YFdflwnP/6QRJy+pvMYFl9h8v/B+HN4H2zUC6
   5n7eESVZvv0YAp8gYn2HO5oJ/Nld6YlmcXd31bPwmOYM3WUAS3+Ouc0Qh
   HKrQ/6+HD+yZpIM9fZ6gCvXoq7PDEus3GIbqpirVeesyJFNnAoIZmDxZv
   rsdY+2lOYN1iLd+boKVUt/iN8w/EepxY2KREm0rR+8rQqUrUDIQ4SB4GQ
   h9D5/txMwtJvroACdpQrwT+Xm7y0xVeN+BOL4Yx906cYSa+QhagcANsiY
   Z4xLrmcCfzVZi5oP+1/bre3ZRqDWDSSViHkq1buiybRSWpNTLDZ3gSIR9
   Q==;
X-CSE-ConnectionGUID: BydyrjkQR/qD+tevQpX0JQ==
X-CSE-MsgGUID: ZZcFd1bGTZysYO/rE5eoUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="95554646"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="95554646"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 02:24:57 -0800
X-CSE-ConnectionGUID: 87JvPVP8Qo2/kbxVj8XchA==
X-CSE-MsgGUID: cw7/m4ZqRFC3mFKaRvcDpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="216025581"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 02:24:53 -0800
Date: Tue, 24 Feb 2026 12:24:49 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Mark Brown <broonie@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 5/5] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Message-ID: <aZ18cWyJ0KtcoU4B@smile.fi.intel.com>
References: <20260223162110.156746-1-antoniu.miclaus@analog.com>
 <20260223162110.156746-6-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223162110.156746-6-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 06:21:04PM +0200, Antoniu Miclaus wrote:
> Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC with
> integrated fully differential amplifiers (FDA).
> 
> The AD4880 has two independent ADC channels, each with its own SPI
> configuration interface. The driver uses spi_new_ancillary_device() to
> create an additional SPI device for the second channel, allowing both
> channels to share the same SPI bus with different chip selects.

...

> +static int ad4880_update_scan_mode(struct iio_dev *indio_dev,
> +				   const unsigned long *scan_mask)
> +{
> +	struct ad4080_state *st = iio_priv(indio_dev);
> +	unsigned int ch;

Not used outside of the loop, hence

> +	int ret;
> +
> +	for (ch = 0; ch < st->info->num_channels; ch++) {

	for (unsigned int ch = 0; ch < st->info->num_channels; ch++) {

should suffice.

> +		/*
> +		 * Each backend has a single channel (channel 0 from the
> +		 * backend's perspective), so always use channel index 0.
> +		 */
> +		if (test_bit(ch, scan_mask))
> +			ret = iio_backend_chan_enable(st->back[ch], 0);
> +		else
> +			ret = iio_backend_chan_disable(st->back[ch], 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

...

> +static int ad4080_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad4080_state *st = iio_priv(indio_dev);
> +	unsigned int ch;
> +	int ret;
> +
> +	for (ch = 0; ch < st->info->num_channels; ch++) {

Same.

> +		ret = ad4080_setup_channel(st, ch);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
>  }

...

> +	/* Setup ancillary SPI devices for additional channels */

> +	if (st->info->num_channels > 1) {

Isn't this an exact check the for-loop performs the first?

> +		for (int i = 1; i < st->info->num_channels; i++) {

Why is 'i' signed? And why not name it 'ch'?

> +			st->spi[i] = devm_spi_new_ancillary_device(spi,
> +					spi_get_chipselect(spi, i));
> +			if (IS_ERR(st->spi[i]))
> +				return dev_err_probe(dev, PTR_ERR(st->spi[i]),
> +						     "failed to register ancillary device\n");
> +
> +			st->regmap[i] = devm_regmap_init_spi(st->spi[i],
> +							     &ad4080_regmap_config);
> +			if (IS_ERR(st->regmap[i]))
> +				return PTR_ERR(st->regmap[i]);
> +		}
> +	}

...

> +	/* Get backends for all channels */
> +	for (ch = 0; ch < st->info->num_channels; ch++) {

	for (unsigned int ch = 0; ch < st->info->num_channels; ch++) {

?

> +		st->back[ch] = devm_iio_backend_get_by_index(dev, ch);
> +		if (IS_ERR(st->back[ch]))
> +			return PTR_ERR(st->back[ch]);
>  
> +		ret = devm_iio_backend_enable(dev, st->back[ch]);
> +		if (ret)
> +			return ret;
> +	}

-- 
With Best Regards,
Andy Shevchenko


