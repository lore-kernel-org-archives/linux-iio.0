Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54196202C5C;
	Mon, 23 Feb 2026 13:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854392; cv=none; b=oB9D/nxtTMUql1Z1sSIknfdEQjtw1f/pqhbOtxO6xUuOj1c5CMDuivFsT8gPc/zPxxJg21GFivyeNASP71L2AQf+aaEYNaTWgBNzchEZBRmGtJA+iYIpPWgK7mLLIbskQcDzN8Pb7StjwLHO1HXA1ShgeTazp1j0S04qpAR5TVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854392; c=relaxed/simple;
	bh=w3fiFsoz/3KZ9DznmTx/GEGTSUWphSa+dZl1zTnIhtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQxg/1BpHo+u0lAI8+D2y0jf/uOGzcMYwDMdTgGAiItoBoruCwYapTOEsEAJHDDsuuSmsqIR71C6lfblVNljs9lp9CDXuzqAdhNMoLyQSt89rFbWVb5ez5aQUHO4qApZ6B29ebe4so20d8KgDNpuc76csBOLL5XKnQZYgC6kiPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d/RJcHjJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d/RJcHjJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771854390; x=1803390390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w3fiFsoz/3KZ9DznmTx/GEGTSUWphSa+dZl1zTnIhtA=;
  b=d/RJcHjJ8WvwmetqXUUpAGbdQh65/PADdG+DfvsB5XAHd52kRIDCm0CQ
   TTt+Td/7lAAjLb+KhdhUs2Bm+e5PIlEj0VWD92wcoXkrO25uFJB9G63Ve
   rKbVlqdcmPSr9XIQ46e9mOwvLhpFEDsVy4ilHmxdWwZckf3ojg+KfSqN3
   Nysn/aTLXGeOmZ93Ge9tH6h3ciEhu3gMizhDk4I7eKlGn3lurUEP4vset
   Ndt5DeI6AUBeeEBW+c1fjj+MUy2I+QwhgAaO5twFu89nAeGDReUae9AlI
   I5CqYCyHp0GqpXt79aJnsaz1s4jHQo/GaQcYDtJ/fKiVNSBBVfvrPb2fR
   A==;
X-CSE-ConnectionGUID: OTDP8KIbTp2TvlJ9kNUzyw==
X-CSE-MsgGUID: Pn41XHvPRKCwMHwK9SdGZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="76677640"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="76677640"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 05:46:29 -0800
X-CSE-ConnectionGUID: ueP7KvA4QBaj7+1kcqU+Gw==
X-CSE-MsgGUID: i1jO36H0SBaySwi/7j8l4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="238537106"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 05:46:26 -0800
Date: Mon, 23 Feb 2026 15:46:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	jonath4nns@gmail.com
Subject: Re: [PATCH v2 4/4] iio: adc: ad7768-1: add support for SPI offload
Message-ID: <aZxaMPWtxwCvmtdd@smile.fi.intel.com>
References: <cover.1771362939.git.Jonathan.Santos@analog.com>
 <79e1004bd9e618f9376a9ed40389510066b91d1c.1771362939.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79e1004bd9e618f9376a9ed40389510066b91d1c.1771362939.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 08:59:53AM -0300, Jonathan Santos wrote:
> The AD7768-1 family supports sampling rates up to 1 MSPS, which exceeds
> the capabilities of conventional triggered buffer operations due to SPI
> transaction overhead and interrupt latency.
> 
> Add SPI offload support to enable hardware-accelerated data acquisition
> that bypasses software SPI transactions using continuous data streaming.

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
> +		return dev_err_probe(dev, ret,  "failed to register offload trigger\n");

Double space...
(do not resend just for addressing this)

> +	st->offload_trigger = devm_spi_offload_trigger_get(dev, st->offload,
> +							   SPI_OFFLOAD_TRIGGER_DATA_READY);
> +	if (IS_ERR(st->offload_trigger))
> +		return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
> +				     "failed to get offload trigger\n");
> +
> +	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
> +	if (IS_ERR(rx_dma))
> +		return dev_err_probe(dev, PTR_ERR(rx_dma), "failed to get offload RX DMA\n");
> +
> +	ret = devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
> +							  IIO_BUFFER_DIRECTION_IN);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to setup offload RX DMA\n");
> +
> +	indio_dev->setup_ops = &ad7768_offload_buffer_ops;
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


