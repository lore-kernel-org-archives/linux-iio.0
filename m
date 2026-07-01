Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFF83B637F;
	Wed,  1 Jul 2026 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895933; cv=none; b=PvgmnEoN+bfW3ji2YhXJBkeuDmjoGldYnRwlExxKpW2266PUzuANaWEUAzBR6xnCOsMoHMXdLUsx1dbESWOWfatyEYj2/+b/7T5FREqpFKq6GR9/f4opOGvwvsvpRhk6xlhBnM5jtpMO63QXdPVE3Jjz1YkCLekTHa+3K88sanQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895933; c=relaxed/simple;
	bh=wI+t0SS55P6zBsipXVAE6Fyben0f1zJlLRevi5LlLbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXlj20lmRkvl7peFgFG8Ww+NT24YrAv3l00PYBZAnjp4Mcsa9O2k8K8rOuaWVKgzPm4IX5pX7KB5yVA9EJbB3pGT1E7YibSClaPCdrEGayGdwy7VupT4Zx3tEoF6ervBA2tBkyBkaIBcNB/6WsB4g5n3oxCPtEZYX13s042qwUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jAx4UBP9; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jAx4UBP9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782895932; x=1814431932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wI+t0SS55P6zBsipXVAE6Fyben0f1zJlLRevi5LlLbA=;
  b=jAx4UBP9j8uFRewZlwVuRkacHN84ShM4LljZnIP47RzlRsEYy1ubGerg
   6YwNLUMDA3OGqq9XKyBvPdq5plM4vPCbBvX8ne2rR1di3FSshavbMknw6
   jSGBkfGib6o2iRleKwsb0qaHw2l8TOQzTO4c+3xkYyGWpNeu62RVYU/Wf
   GrawiIiJH3SttfTKFaYgccggYc6/13pawNk/KMGkXHg6QtanoN7FfhUnR
   N/UJA5DeOaCTxeNLNG+ERFmmD5RTDHj4kUFbNvn4jh6USmfC65wLOfZrE
   uybMgJ9dtD0WIBpYZj2mwcGcHVcbwPm4grHXQSzEnk63EkpSm3LwZ3sBm
   g==;
X-CSE-ConnectionGUID: twp07gUkQxCgfSyM4bFM2Q==
X-CSE-MsgGUID: fkCsOXM3Ql6kKV9gLVrUbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="93979153"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="93979153"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 01:52:10 -0700
X-CSE-ConnectionGUID: 9Y9gcNg6Qfi0vA4IwhNkWg==
X-CSE-MsgGUID: QLc7dBC7T/+vr9wwTRjizg==
X-ExtLoop1: 1
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.65])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 01:52:07 -0700
Date: Wed, 1 Jul 2026 11:52:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mike.looijmans@topic.nl,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ti-ads1298: add ADS1299 EEG ADC family
 support
Message-ID: <akTVNZL6Efmi1yCL@ashevche-desk.local>
References: <20260630140311.1473031-1-shofiqtest@gmail.com>
 <20260630140311.1473031-2-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630140311.1473031-2-shofiqtest@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 30, 2026 at 05:03:11PM +0300, Md Shofiqul Islam wrote:
> The ADS1299, ADS1299-4 and ADS1299-6 are 8/4/6-channel, 24-bit
> biopotential (EEG) ADCs from Texas Instruments.  They share the same
> SPI interface, command set and register map as the ADS1298 ECG family,
> making it straightforward to support them in this driver.
> 
> Key differences from the ADS1298:
> - PGA gain range is 1/2/4/6/8/12/24 (vs 6/1/2/3/4/8/12 for ADS1298)
> - Internal voltage reference is always 2.4V (no 4V option)
> - Channel count is encoded differently in the ID register: bits [4:3]
>   identify the ADS1299 family (both bits set), bits [1:0] encode the
>   channel count as (bits + 2) * 2
> 
> Detect the chip family in ads1298_init() by checking bits [4:3] of
> the ID register.  Store the result in the is_ads1299 flag and use it
> to select the correct PGA table in ads1298_get_scale() and to skip
> the 4V reference option in the CONFIG3 initialisation.

...

> -/* TI ADS1298 chip family driver
> +/* TI ADS1298/ADS1299 biopotential ADC driver

Consider updating Kconfig help text as well.

...

>  struct ads1298_private {
>  	const struct ads1298_chip_info *chip_info;
>  	struct spi_device *spi;
> +	bool is_ads1299;
>  	struct regulator *reg_avdd;
>  	struct regulator *reg_vref;
>  	struct clk *clk;

When add a new member or create a new data structure always consult with
`pahole` tool on the layout.

>  }

...

> -MODULE_DESCRIPTION("TI ADS1298 ADC");
> +MODULE_DESCRIPTION("TI ADS1298/ADS1299 biopotential ADC");


This doesn't scale, rephrase here and in top comment in the file (and probably
in the Kconfig title) to make it stretchy. See the history of the last few
months of IIO subsystem development, you will find examples on how to achieve
that,

-- 
With Best Regards,
Andy Shevchenko


