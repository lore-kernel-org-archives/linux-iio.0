Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8AA3A1CEB;
	Wed,  4 Feb 2026 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770214184; cv=none; b=hqhGWBEkYe2Cz5jhOQnDaT0SIsKTK54UROMaK10R0D0JBwkZVMb9AyHBLoQ4q+0XCqjOUDT2+69yg6kZa55ezZD5PC9JEvV2xdM/qhEkB45XVkQoKNX5qpzT1CQWJMKIGt2BIkN0kUAxnRBXG7GICdvGRwgWQRip+cVHjuuZST4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770214184; c=relaxed/simple;
	bh=KIWkeam0eVrzwnPACNuvK1vugsFP4/l06fFEwGYNzIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1n++PNGS+lvsowWYqGgmut6CGsEQbOBe0Ctt5QYbKVerj2scddFdca8aK0cIVbGtPfpLtHN6VPnYxgEMgWaL5NQdD8D9RPFk8ytD2F6GXkZIAx+jL6+zznCO7tnTiiJEmorBwJdOJnUFlvdKss7D4A9P0G8Xmsf7F0b8TnwWY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k4USNcj/; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k4USNcj/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770214183; x=1801750183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KIWkeam0eVrzwnPACNuvK1vugsFP4/l06fFEwGYNzIA=;
  b=k4USNcj/MuU68xxg8C9C63MdnJnVBl61BeQ8CvNosTQFqTOvLwVjlXYk
   dVyAebL3x3IAskvpJr9/pDclXz9Nz0PprxSAoLr+dC9Ky/MoiWdAJ2boS
   eiY0Du4tNOkK/yggVYyWjPgkIYz1dvfbXquZtnpYX4fTYM6stYDpaLKLB
   N+VqcmLl41xJtahhCEXLouPFIoVXdOZbFR1UhWTA91YN5JhyL+0hVtKwt
   Rf+Ze6sTAST8T0FJ3VqRAmixa9igTejwafzMETxjA7OHNoLjITcO58pY0
   egAtyHTFkUe74yfgehePkd4fpdRXLkECHapxpYehtMDrkly/LJLmn6ewH
   Q==;
X-CSE-ConnectionGUID: pqwrioNgS1eHlb/Cipj6YQ==
X-CSE-MsgGUID: awKyp+/RSCyi+gHO51O3tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71492705"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="71492705"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 06:09:42 -0800
X-CSE-ConnectionGUID: faJMOsx7SxObhClXaQBFIA==
X-CSE-MsgGUID: 8qk8Zhj3RDOt0J/na/0jOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="210209737"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.188])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 06:09:35 -0800
Date: Wed, 4 Feb 2026 16:09:33 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael.Hennerich@analog.com, lars@metafoo.de, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH 3/3] iio: adc: ad7768-1: add support for SPI offload
Message-ID: <aYNTHZmSVdP5_L2T@smile.fi.intel.com>
References: <cover.1769889074.git.Jonathan.Santos@analog.com>
 <9f9aedbe374461e48f1f1e64d5487b5b6c1fc992.1769889074.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f9aedbe374461e48f1f1e64d5487b5b6c1fc992.1769889074.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jan 31, 2026 at 10:35:39PM -0300, Jonathan Santos wrote:
> The AD7768-1 family supports sampling rates up to 1 MSPS, which exceeds
> the capabilities of conventional triggered buffer operations due to SPI
> transaction overhead and interrupt latency.
> 
> Add SPI offload support to enable hardware-accelerated data acquisition
> that bypasses software SPI transactions using continuous data streaming.

...

> +	if (st->offload_en)
> +		return st->oversampling_ratio == 8 ?
> +			AD7768_SCAN_TYPE_OFFLOAD_HIGH_SPEED : AD7768_SCAN_TYPE_OFFLOAD_NORMAL;

Wrong indentation.

...

> +	ret = spi_offload_trigger_enable(st->offload,
> +					 st->offload_trigger,
> +					 &config);

One of the parameters can be moved to the previous line (either 2nd or 3rd).

> +	if (ret) {
> +		spi_unoptimize_message(&st->offload_msg);

> +		return ret;
> +	}

> +	return 0;

	if (ret)
		spi_unoptimize_message(&st->offload_msg);

	return ret;

?

...

> +static bool ad7768_offload_trigger_match(struct spi_offload_trigger *trigger,
> +					 enum spi_offload_trigger_type type,
> +					 u64 *args, u32 nargs)
> +{
> +	if (type != SPI_OFFLOAD_TRIGGER_DATA_READY)
> +		return false;
> +
> +	/* Requires 1 arg to indicate the trigger output signal */

^^^ for the context to below remark.

> +	if (nargs != 1 || args[0] != AD7768_TRIGGER_SOURCE_DRDY)
> +		return false;
> +
> +	return true;
> +}
> +
> +static int ad7768_offload_trigger_request(struct spi_offload_trigger *trigger,
> +					  enum spi_offload_trigger_type type,
> +					  u64 *args, u32 nargs)
> +{
> +	/* Should already be validated by match, but just in case. */

Please, be consistent with a style for one-line comments (pay attention
to the period at the end and capitalisation of the sentence). Choose one
(whatever you prefer or which one is already used) style and follow it
everywhere.

> +	if (nargs != 1)
> +		return -EINVAL;
> +
> +	return 0;
> +}

...

> +static const struct spi_offload_config ad7768_spi_offload_config = {
> +	.capability_flags = SPI_OFFLOAD_CAP_TRIGGER |
> +			    SPI_OFFLOAD_CAP_RX_STREAM_DMA,

It can be one line out of 84 characters.

> +};

...

> +static int ad7768_spi_offload_probe(struct iio_dev *indio_dev,
> +				    struct ad7768_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	struct spi_offload_trigger_info trigger_info = {
> +		.fwnode = dev_fwnode(dev),
> +		.ops = &ad7768_offload_trigger_ops,
> +		.priv = st,
> +	};
> +	struct dma_chan *rx_dma;
> +	int ret;
> +
> +	ret = devm_spi_offload_trigger_register(dev, &trigger_info);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to register offload trigger\n");

Can be one line, checkpatch for more than 10 years do not complain on
the long string literals (even in --strict mode). Yes, not all lines
can follow this, I pointed out this one, because it's okay balance between
80 limit and the overhead.

> +
> +	st->offload_trigger = devm_spi_offload_trigger_get(dev, st->offload,
> +		SPI_OFFLOAD_TRIGGER_DATA_READY);

Something wrong with the indentation at least second time. Please, review
the code and make sure it indents accordingly.

> +	if (IS_ERR(st->offload_trigger))
> +		return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
> +				     "failed to get offload trigger\n");
> +
> +	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
> +	if (IS_ERR(rx_dma))
> +		return dev_err_probe(dev, PTR_ERR(rx_dma),
> +				     "failed to get offload RX DMA\n");
> +
> +	ret = devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev,
> +		rx_dma, IIO_BUFFER_DIRECTION_IN);

Indentation.

> +	if (ret)
> +		return dev_err_probe(dev, PTR_ERR(rx_dma),
> +				     "failed to setup offload RX DMA\n");
> +
> +	indio_dev->setup_ops = &ad7768_offload_buffer_ops;
> +	st->offload_en = true;
> +
> +	return 0;
> +}

...

> +	st->offload = devm_spi_offload_get(&spi->dev, spi, &ad7768_spi_offload_config);
> +	ret = PTR_ERR_OR_ZERO(st->offload);
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(&spi->dev, ret, "failed to get SPI offload\n");

Add

	struct device *dev = &spi->dev;

at the top of the function and make some lines shorter and easier to follow.

> +	/* If not using SPI offload, fall back to low speed usage. */
> +	if (ret == -ENODEV) {

No need to check for ENODEV twice.

	if (ret == -ENODEV) {
		...
	} else if (ret) {
		return dev_err_probe(...);
	} else {
		...
	}

> +		ret = ad7768_triggered_buffer_alloc(indio_dev);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = ad7768_spi_offload_probe(indio_dev, st);
> +		if (ret)
> +			return ret;
> +	}

-- 
With Best Regards,
Andy Shevchenko


