Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE940324B24;
	Tue, 16 Jun 2026 10:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781606143; cv=none; b=fj6QdO9bIWkEIvx09sRDeNNCd8b007gJCwDTorIMLFanRK7CGZIMUQ3ZJMaPYc4dPPvKpI7MlOp3Gk8w9Helv4SnDuxHmOYrcQ0gWGqFPKQy/U6c4Lz0Ry/IoQlSAaI1m1vbVB/tu1GA7CZB3FDGlDFB4xXvA+txnctUgeIsy1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781606143; c=relaxed/simple;
	bh=RrvLdLZu3GFrFPT3uX1TJpnRFfeh1m+RqTONIDJfqjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ir/Ertn4m0mzOpZkpLzlOscPPLC+IDgkuh9tmjJLEstD96t+zFeVw//dyl7wp6v1a+O15HiFrG1DV0dpFMchg0mSiQqFhJJnQMFTYPCO4UCiGP00lyxWGRIQk8E6g1aH9WtopMMLyQPfHPtAVdhsMrSAzI4OgsrAtgEh2TXuz/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kpbkOK6u; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kpbkOK6u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781606142; x=1813142142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RrvLdLZu3GFrFPT3uX1TJpnRFfeh1m+RqTONIDJfqjQ=;
  b=kpbkOK6uct4uyGwWV8XVr5hGVIEbtaaiX3iDpX6iOPSS9NoLwFG6iNly
   O7mpNjpOkCynPZKzlqUoIwlsKreiQ59Qpl6MU6VEHYkBk7upDNlpB6Zyr
   Fb5Pv7rzm43l3mhgog+MBTrn2Py5cDGeHOHoObluRZjl1wi0VPqIEDuyu
   KD49NfwiIuse7omCYxWd5Pvm5zAeI3AfFAFNsyOBPNSxl96OSaMlnoQpP
   s0MUdc9YwUB5klBQzo5TTp/SVlIUAuwKQyy/ZLK3tIdrUdRGf+gAzrySE
   3/BwDM5Yk7NMsRzVyaco+Ae43JWdl99UB8I8BtgkdRpxcS67q/8Jxbfk4
   w==;
X-CSE-ConnectionGUID: lBAYJKMJTEOiSQmxTny8EA==
X-CSE-MsgGUID: onolzUvFQ1Gwfb1iU3d0aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="93749189"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="93749189"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 03:35:41 -0700
X-CSE-ConnectionGUID: 492sFYdIRNC5fiNhrqV7Aw==
X-CSE-MsgGUID: YmEeLmg7RBCQu5khqS5zpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="247800144"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 03:35:38 -0700
Date: Tue, 16 Jun 2026 13:35:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v3 09/12] iio: dac: ad5686: implement new sync() op for
 the spi bus
Message-ID: <ajEm98mDJNrzJHD_@ashevche-desk.local>
References: <20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com>
 <20260616-ad5686-new-features-v3-9-f829fb7e9262@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616-ad5686-new-features-v3-9-f829fb7e9262@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 09:21:15AM +0100, Rodrigo Alencar via B4 Relay wrote:

> Use of local SPI bus data to manage a collection of SPI transfers and
> flush them to the SPI platform driver with the sync() operation. This
> allows for faster handling of multiple channel DAC writes, avoiding kernel
> overhead per spi_sync() call, which will be helpful when enabling
> triggered buffer support.

...

>  static int ad5686_spi_probe(struct spi_device *spi)
>  {
> -	return ad5686_probe(&spi->dev, spi_get_device_match_data(spi),
> -			    spi->modalias, &ad5686_spi_ops);
> +	const struct ad5686_chip_info *info = spi_get_device_match_data(spi);

Sashiko might still complain on driver_override case, which means we need to
add a NULL check (or is NULL fine?).

> +	struct ad5686_spi_data *bus_data;
> +	struct device *dev = &spi->dev;
> +	unsigned int capacity;
> +
> +	/* read operation requires at least 2 transfers */
> +	capacity = max(info->num_channels, 2);
> +	bus_data = devm_kzalloc(dev, struct_size(bus_data, xfers, capacity),
> +				GFP_KERNEL);
> +	if (!bus_data)
> +		return -ENOMEM;
> +
> +	bus_data->capacity = capacity;
> +
> +	return ad5686_probe(dev, info, spi->modalias, &ad5686_spi_ops, bus_data);
>  }

-- 
With Best Regards,
Andy Shevchenko


