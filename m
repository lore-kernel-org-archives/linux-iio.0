Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB7E30C15B;
	Sun,  7 Jun 2026 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780818667; cv=none; b=cTnkcVTUKFZ1cMtcOcuT8YSENpxnqC5cbTnI79L+9TGtDmhG0AXZHxkE21XV0a+vi/dI8tPpTLIswcPA0Wpxmg/dvATYiuVpXXN5ZaQAM/VSKT+jW++1FEbLSllv55Xe1aAGfixhH+3s41tku5SSLFlLp41gqgEBGe4u+mXzDlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780818667; c=relaxed/simple;
	bh=3EoaFqFWLkw78nDWAjaX4Kvn0ZR7t+FdtaPh+P+Fm3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iU2OLFA21HQCsE5alUJnXmksYPI8oe7kcYYdnMaDVPGNwjF2jamQls4R4UuGBSQtBxhqk0QukU8Ckopk4pSM/PuzGfkhtdFQuOyM2Ye+7nVyHrGQtzB8lXapm4QpeSzNu4yJQodX60XVU9xD+d3kQewhldb7Rc0fQlj9hgLUWho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0LfopZ8; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0LfopZ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780818665; x=1812354665;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3EoaFqFWLkw78nDWAjaX4Kvn0ZR7t+FdtaPh+P+Fm3k=;
  b=d0LfopZ84DR6KFg0HkjaPfcaSoX9CQUTtHnp9BDnhv1gnohj+5hJ1Jxf
   XyTC8tENT5VRbYJFpALPwyWs8aeRcL/Vrs8TMyGQY8lQCIyVFPXOhgKeJ
   Aqt/BucScMV+8xDw4oS6YCuDQW45iv5UeJjGPUb9vL/YHGDOsK2BCSkpU
   t4elOFnI98KrK48BgQFfpuk7PY72iJs7IuCxIH689pKyU70QITcRvEzRb
   AY4HH4R68mZhVVKmtJ7/pRkmvT0nPYRbQVnAZQnEChQuANMbXdjlLkpXH
   EHI+pCgJd5ATqrM06AaQ5+Plh0jYmWbF5zHRDNW7ZEJIaX4oQljI9qXlp
   w==;
X-CSE-ConnectionGUID: iV9pMWxqRGOCUBDt+DMQ1w==
X-CSE-MsgGUID: oyvshZ9ZTGKMsWTd6GoFLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11809"; a="85471947"
X-IronPort-AV: E=Sophos;i="6.24,192,1774335600"; 
   d="scan'208";a="85471947"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 00:51:05 -0700
X-CSE-ConnectionGUID: jcPKl7ctSRC4bKawQIij6Q==
X-CSE-MsgGUID: ybz6hVnlRmeut1xA05yncA==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.86])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 00:51:01 -0700
Date: Sun, 7 Jun 2026 10:50:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salih Erim <salih.erim@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Salih Erim <erimsalih@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] iio: adc: versal-sysmon: add oversampling support
Message-ID: <aiUi4jRd2C8kczkt@ashevche-desk.local>
References: <20260606051707.535281-1-salih.erim@amd.com>
 <20260606051707.535281-6-salih.erim@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606051707.535281-6-salih.erim@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jun 06, 2026 at 06:17:07AM +0100, Salih Erim wrote:
> Add support for reading and writing the oversampling ratio through
> the IIO oversampling_ratio attribute. The hardware supports averaging
> 2, 4, 8, or 16 samples, plus a ratio of 1 (no averaging).
> 
> Temperature and supply channels share oversampling configuration at
> the type level (all temperature channels share one ratio, all supply
> channels share another), exposed through info_mask_shared_by_type.
> 
> The hardware encoding uses sample_count / 2 in a 4-bit field within
> the CONFIG register. Per-channel averaging enable registers must also

...

> +static int sysmon_set_avg_enable(struct sysmon *sysmon,
> +				 u32 base, u32 count, u32 val)
> +{
> +	int ret;
> +
> +	for (unsigned int i = 0; i < count; i++) {
> +		ret = regmap_write(sysmon->regmap,
> +				   base + (i * SYSMON_REG_STRIDE), val);

Unneeded parentheses.

> +		if (ret)
> +			return ret;
> +	}

Also you can use temporary for regmap

	struct regmap *map = sysmon->regmap;
	int ret;

	for (unsigned int i = 0; i < count; i++) {
		ret = regmap_write(map, base + i * SYSMON_REG_STRIDE, val);
		if (ret)
			return ret;
	}

> +	return 0;
> +}

And use this trick in other places where appropriate, it makes code easier
to read.

...

> +static int sysmon_osr_write(struct sysmon *sysmon, int channel_type, int val)
> +{
> +	/*
> +	 * HW register encoding is sample_count / 2:
> +	 * 0=none, 1=2x, 2=4x, 4=8x, 8=16x (not log2-based).
> +	 */
> +	int hw_val = val >> 1;
> +	int ret;
> +
> +	if (channel_type == IIO_TEMP) {
> +		ret = regmap_update_bits(sysmon->regmap, SYSMON_CONFIG,
> +					SYSMON_CONFIG_TEMP_SAT_OSR,
> +					FIELD_PREP(SYSMON_CONFIG_TEMP_SAT_OSR,
> +						   hw_val));
> +		if (ret)
> +			return ret;
> +
> +		return sysmon_set_avg_enable(sysmon, SYSMON_TEMP_EN_AVG_BASE,
> +					     SYSMON_TEMP_EN_AVG_COUNT,
> +					     hw_val ? ~0U : 0);

> +	}
> +
> +	if (channel_type == IIO_VOLTAGE) {

Can channel_type be both TEMP and VOLTAGE here? No. Why do we check it twice?

> +		ret = regmap_update_bits(sysmon->regmap, SYSMON_CONFIG,
> +					SYSMON_CONFIG_SUPPLY_OSR,
> +					FIELD_PREP(SYSMON_CONFIG_SUPPLY_OSR,
> +						   hw_val));
> +		if (ret)
> +			return ret;
> +
> +		return sysmon_set_avg_enable(sysmon, SYSMON_SUPPLY_EN_AVG_BASE,
> +					     SYSMON_SUPPLY_EN_AVG_COUNT,
> +					     hw_val ? ~0U : 0);
> +	}
> +	return -EINVAL;
> +}

-- 
With Best Regards,
Andy Shevchenko


