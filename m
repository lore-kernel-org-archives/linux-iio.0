Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1514375AA4;
	Mon,  2 Mar 2026 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772455171; cv=none; b=ECK3E3DOavQFWhHsKOIAX6eBV6b7iNjwhP5cXkcWPmkiBI/6OR9+5AnSQmkxdMe0BawDvAdymy9KTi5ftlz1GnD1fYfPArlS3T5qZqEWkgsUtOHly59P6JB5BuMuFrP+kfYLIc6LlmpzjY6enfTXTjuL1Y5kir6E//6rKlPqRTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772455171; c=relaxed/simple;
	bh=wQtBUVEjmTFQe3aCNAe8/7P77SU+bAjJmfQ2jBNS7Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ac95/v5LPiIByU7sq+bF+QdpERzyGPHA6y7IglPXrPKcLjHVoiTjpvKeMGvVyn6ehFVdYUw76YMfs+doAL4RGGk96DV/c2AA/ZuAGW3VB2/tNLTYFpq7AvdvRCuicoy6ZcLzgDWNyy0bsi14PN3HNZjK39rOMsWfWPSN9kurTmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YMRVXY3A; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YMRVXY3A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772455170; x=1803991170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wQtBUVEjmTFQe3aCNAe8/7P77SU+bAjJmfQ2jBNS7Tw=;
  b=YMRVXY3AGrwtM4xHe0vSQuUJDfEiezlDxoxziRRyfgF+ngoDVeeGL+Up
   FWoQASBVr7O9svtMSD3ipUe2uz4kSj0ZZy3Ddt+OZBOz0yAK4qwPc8zZH
   5T3tQx/lFgovREOKQz2JPmQgCryNqnIqIoUQKlnFa+uC04KFFOUGUz8xl
   Iq/s3xaPUhF2ddpQV40b9m+/uiVMWMAu4A3/YOFCOOaSIGEA6axK6z3DG
   Qvsfyj/giHghwixVG21usHJtaKtMJU2mscN7J5ZCmgaIGGX2HsqirL3mB
   um0vUdfTpePeGhGAKYiVgV3fnAMqHgHHJbxknfsbG8kmH42oGHB9zQJo+
   Q==;
X-CSE-ConnectionGUID: pvMWrIDrRNmQOlXHs4t5AQ==
X-CSE-MsgGUID: dlnOycLuRTShrQVO9BBZow==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="84099223"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="84099223"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 04:39:29 -0800
X-CSE-ConnectionGUID: vo4mMbdFQzCtcoREQnSNAQ==
X-CSE-MsgGUID: IHYCtB5KS1aZFGH7ksQZYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="217665585"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 04:39:25 -0800
Date: Mon, 2 Mar 2026 14:39:23 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, cosmin.tanislav@analog.com,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 2/3] iio: adc: ad4130: introduce chip info for future
 multidevice support
Message-ID: <aaWE-0WSaS6UNcSb@ashevche-desk.local>
References: <cover.1772078999.git.Jonathan.Santos@analog.com>
 <b95a029f836a1d2d125f5beccf5290cfcf32c725.1772078999.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b95a029f836a1d2d125f5beccf5290cfcf32c725.1772078999.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Feb 28, 2026 at 09:38:53AM -0300, Jonathan Santos wrote:
> Introduce a chip_info structure to abstract device-specific parameters
> and prepare the driver for supporting multiple AD4130 family variants.

...

> +struct ad4130_chip_info {
> +	const char *name;
> +	unsigned int max_analog_pins;
> +	const struct iio_info *info;
> +	const unsigned int *reg_size;
> +	const unsigned int reg_size_length;
> +};

Is `pahole` okay with the chosen layout?

...

>  static const struct of_device_id ad4130_of_match[] = {
> -	{
> -		.compatible = "adi,ad4130",
> -	},
> +	{ .compatible = "adi,ad4130", .data = &ad4130_8_chip_info },

Why touching the rest? Isn't just fine to add

		.data = ...,

?

>  	{ }
>  };

...

> +static const struct spi_device_id ad4130_id_table[] = {
> +	{ "ad4130", (kernel_ulong_t)&ad4130_8_chip_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ad4130_id_table);

> +	.id_table = ad4130_id_table,

Strictly speaking this can be a precursor change, while here you just add a
driver_data to it.


-- 
With Best Regards,
Andy Shevchenko


