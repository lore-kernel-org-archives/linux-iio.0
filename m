Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66F6331ED5;
	Tue,  9 Jun 2026 17:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027888; cv=none; b=AJGZxBPOLfd8/vAsbNMIGKc2gkeSP1CM63rku8IEVBVOZPzz9EMcWDmvbQl3ixz205SzcuHL3Ey+Yb+8RQieUGExT4Z3HjOzvzf9nZyTg8TJpaoZW9MEhMJauVFllT/xZK783LLzuqGiBYEKpUe+ytWQwyFaTWcgGD+D0YQQdoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027888; c=relaxed/simple;
	bh=jEgWJAR9As6CjTceuJw1x3fsOyVkWfAMviDOWSH4bYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jcom4ynj04TEhVUny6d7VUvfgmel6s5EgjnjDmuVeOUi2QPiqeapJxIdyRWB7pct+dxrr/wtuKzxnLaWxZXUijGGlllknyJunZ3AxnllbHs7VtHQc19AGXFs/BqxCEdv0jyKDMc9VMiQd/mhYWRlbePzBhKfngBXpEkORKoc4rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g3aTuVhr; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g3aTuVhr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781027886; x=1812563886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jEgWJAR9As6CjTceuJw1x3fsOyVkWfAMviDOWSH4bYw=;
  b=g3aTuVhrrWmyLJd76GHDd9SP/7E34L6LFzKzlJxdXnI6eVvEWNjBsapm
   hpqtsnMUalLRenST2Hg3asO2U1knJ/sYNv9ryRZjIgbSqeDQvS6O+8opO
   pRLe9DzzGNMVKlq/Nvb4ueMLfLYs6XbjbiZfns5gIYwWyiHTsyuuxJtiU
   Yv8rbA0VZYYzeOvjme8ZdJpwPp55TT7qGItZEPWnHVuin0wCEyE7CNmQ/
   yykdO1U8mIluqYyg8xhQHT8Iypf46YQDjpg4hx2LKsjR4USk2n4sijoOL
   P1lL4rYBGWkI7aQ4TN8eCZvEZf1Sn7rxlkeX365+9k74vCztM6PFTHp1v
   A==;
X-CSE-ConnectionGUID: nAqridF6TaOyFpobionTvQ==
X-CSE-MsgGUID: uwzwauvXQZeCnBx2jbzksA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="85425190"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="85425190"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 10:58:06 -0700
X-CSE-ConnectionGUID: IInaEmtORxiSsSDItLKC0Q==
X-CSE-MsgGUID: 726OpElvQiq+y3VzF08dtA==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.162])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 10:58:02 -0700
Date: Tue, 9 Jun 2026 20:57:59 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salih Erim <salih.erim@amd.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, conall.ogriofa@amd.com, michal.simek@amd.com,
	linux@roeck-us.net, erimsalih@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] iio: adc: versal-sysmon: add oversampling support
Message-ID: <aihUJ9D7BAQd6iGZ@ashevche-desk.local>
References: <20260608183801.1257051-1-salih.erim@amd.com>
 <20260608183801.1257051-6-salih.erim@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608183801.1257051-6-salih.erim@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 08, 2026 at 07:38:01PM +0100, Salih Erim wrote:
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
> be updated to activate or deactivate averaging.

...

> +static int sysmon_osr_write(struct sysmon *sysmon, int channel_type, int val)
> +{
> +	/*
> +	 * HW register encoding is sample_count / 2:
> +	 * 0=none, 1=2x, 2=4x, 4=8x, 8=16x (not log2-based).
> +	 */
> +	int hw_val = val >> 1;
> +	unsigned int readback;
> +	int ret;
> +
> +	switch (channel_type) {
> +	case IIO_TEMP:
> +		ret = regmap_update_bits(sysmon->regmap, SYSMON_CONFIG,
> +					SYSMON_CONFIG_TEMP_SAT_OSR,
> +					FIELD_PREP(SYSMON_CONFIG_TEMP_SAT_OSR,
> +						   hw_val));

Broken indentation.


> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * Readback fence: the SysMon CONFIG register resides in the
> +		 * PMC domain behind the NoC. A posted write may not reach the
> +		 * hardware before the next MMIO access. Reading the register
> +		 * back forces the interconnect to complete the write, preventing
> +		 * a bus hang on the subsequent access.
> +		 */
> +		regmap_read(sysmon->regmap, SYSMON_CONFIG, &readback);
> +
> +		return sysmon_set_avg_enable(sysmon, SYSMON_TEMP_EN_AVG_BASE,
> +					     SYSMON_TEMP_EN_AVG_COUNT,
> +					     hw_val ? ~0U : 0);
> +	case IIO_VOLTAGE:
> +		ret = regmap_update_bits(sysmon->regmap, SYSMON_CONFIG,
> +					SYSMON_CONFIG_SUPPLY_OSR,
> +					FIELD_PREP(SYSMON_CONFIG_SUPPLY_OSR,
> +						   hw_val));

Ditto.

> +		if (ret)
> +			return ret;
> +
> +		/* Readback fence -- see above */
> +		regmap_read(sysmon->regmap, SYSMON_CONFIG, &readback);
> +
> +		return sysmon_set_avg_enable(sysmon, SYSMON_SUPPLY_EN_AVG_BASE,
> +					     SYSMON_SUPPLY_EN_AVG_COUNT,
> +					     hw_val ? ~0U : 0);
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int sysmon_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	int i, ret;

Why is 'i' signed?

> +
> +	if (mask != IIO_CHAN_INFO_OVERSAMPLING_RATIO)
> +		return -EINVAL;
> +
> +	for (i = 0; i < ARRAY_SIZE(sysmon_oversampling_avail); i++) {
> +		if (val == sysmon_oversampling_avail[i])
> +			break;
> +	}
> +	if (i == ARRAY_SIZE(sysmon_oversampling_avail))
> +		return -EINVAL;
> +
> +	guard(mutex)(&sysmon->lock);
> +
> +	ret = sysmon_osr_write(sysmon, chan->type, val);
> +	if (ret)
> +		return ret;
> +
> +	if (chan->type == IIO_TEMP)
> +		sysmon->temp_oversampling = val;
> +	else
> +		sysmon->supply_oversampling = val;
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


