Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C8E3EB7E1;
	Tue, 24 Mar 2026 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352567; cv=none; b=OuX/bwWxWtIVBju0VnFcnoJB5y4jnfdNSWyf18JoWrysjNqnqalk/NhSqndLJ73mz0O9JvAq/7pAp+usyq6sImUBJo2cyCtuIAVtDgCJUcPorXhoa34r1x7fadKZg1yzutSIyIkas/ICC22Gi48g/s2f5rJass9pw+d28yyTiSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352567; c=relaxed/simple;
	bh=ewLrFNXko579lPFxTpHb/bJJkc532D3wUoO0A6AjydM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiB2B+BnRnJuIxlx20nnlJRPgiJf+yMUG7ZaMyVxrh9xPrK9j4l48Llsw+r0el+4hQ+8mX2+JKwF13+gajcqcuvsUKtkrD/z5mD4epVpyiF4UIfjON1BuG4G9x0vS4mlKnsWr8h7v7m5zTSU2Q/G/1rfUgrrSxwtAMWjUulQ9AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l3mCqnE/; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3mCqnE/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774352565; x=1805888565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ewLrFNXko579lPFxTpHb/bJJkc532D3wUoO0A6AjydM=;
  b=l3mCqnE/u6icQMk2eFnVWZtLWpaGH8Fso2z0LCWmVaDINV2BvvKAeHXG
   rbJWNcGDOYYi3WPE2LNTwdBFT920fKrZdxKDRjTBOZSVUOAkXlgOjqdx3
   xoemPSECYNDNfmkJPnFty4tE2zNbEgui2bCtcC7wptptJiRAcDSLt0Z4k
   s0MZ+MIgMZ8N5y0aJAiFhLsBOMcAQ4rxcl/XmnIgP3FIqYc90AxMLaJ0m
   uByrL44d8reyBpRuCZ+OMT9XCqU+XW7Y9o/hqDwksNGaqkkIQBedRDNXQ
   bCOuwJfwW3qRv62Z8w3ktPbpnSDlctABfLyibx2t0kcZ06pnUwAX8rV05
   w==;
X-CSE-ConnectionGUID: n9somfa4RDy/OhCGVPnMKA==
X-CSE-MsgGUID: DOydjm6sTTSs09eMQaCAqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="74548812"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="74548812"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 04:42:44 -0700
X-CSE-ConnectionGUID: GFRmKw5mRbWg5QwMFGbxCA==
X-CSE-MsgGUID: EPDdMtJAQlql6HV95MDouQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="247406068"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.214])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 04:42:42 -0700
Date: Tue, 24 Mar 2026 13:42:40 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gabriel Rondon <grondon@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads8688: use read_avail for available
 attributes
Message-ID: <acJ4sPoX_UqorDXS@ashevche-desk.local>
References: <20260323215633.8140-1-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323215633.8140-1-grondon@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 23, 2026 at 09:56:33PM +0000, Gabriel Rondon wrote:
> Convert the in_voltage_scale_available and in_voltage_offset_available
> attributes from legacy IIO_DEVICE_ATTR with custom show functions to the
> IIO framework's read_avail callback. This uses the framework's built-in
> support for _available attributes, removing the need for manual sysfs
> formatting.
> 
> Precompute the available scale values at probe time since they depend on
> the reference voltage which does not change after initialization.

...

> +static const int ads8688_offset_avail[] = {
> +	-(1 << (ADS8688_REALBITS - 1)),

This is fragile code (however it probably won't be exposed IRL)
if ADS8688_REALBITS == 32 this is UB in accordance with C standard.

Also the trick with -BIT(x) is harder to read than simple GENMASK().
If ADS8688_REALBITS == 1, this becomes -1 (all ones), is it correct?

> +	0,

Do not add trailing comma to a terminator.

>  };

...

> static const struct attribute_group ads8688_attribute_group = {

>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)		\
>  			      | BIT(IIO_CHAN_INFO_SCALE)	\
>  			      | BIT(IIO_CHAN_INFO_OFFSET),	\
> +	.info_mask_shared_by_type_available =			\
> +			      BIT(IIO_CHAN_INFO_SCALE)		\
> +			      | BIT(IIO_CHAN_INFO_OFFSET),	\

This is actually slightly different style to what is put in the above.
Ideally should be unified, but probably matter for another change
(if even needed).

>  	.scan_index = index,					\
>  	.scan_type = {						\
>  		.sign = 'u',					\

>  }

...

> -	int ret;
> +	int ret, i;

Why is 'i' signed?

...


> +	for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++) {

	for (unsigned int i = 0; i < ARRAY_SIZE(st->scale_avail); i++) {

should be good.

> +		st->scale_avail[i][0] = 0;

> +		st->scale_avail[i][1] = ads8688_range_def[i].scale *
> +					st->vref_mv;

I would leave this on a single line (it's only 81 characters).

> +	}

-- 
With Best Regards,
Andy Shevchenko


