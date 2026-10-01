Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3C1533D6;
	Thu,  1 Oct 2026 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790877278; cv=none; b=fc2Mxvv3M9c74wpKx+CChwH2zzAflUqQyb8+pht02lHr8mv8VrszqYK6mU+Rr6fHlV2ImNx9Oe1wUlgGsQiO7n3pIgeE6FzVVw1wGiXXRwVGx2E07urY8mkXehOcY67iu8XCnu2F6qy8jeXnnugncUgA+egN8SC9i+9NG5pFPZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790877278; c=relaxed/simple;
	bh=la9qHOo90ZXE4QAE7e1+jWOcwIBXtaaVWRjS7f5TWzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZot8MvPTxnuiZk1+XH+JVEkW9jVo77P+tiEvwN962t81oNQhJ1KH5ouA7VUsY1AiL7lFam7Sf+LFQ596zBkr1PR8+k/aTHeHW+TT3EByXsNGIh3qa65oNx7V8CXAICgEfo8u1FJECl9oy9K2aueTEYilaJLCl7p83fcomRT5Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R0W1E9bG; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R0W1E9bG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790877270; x=1822413270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=la9qHOo90ZXE4QAE7e1+jWOcwIBXtaaVWRjS7f5TWzQ=;
  b=R0W1E9bGVheX3p3yEigJ3aktEPV0TCilejZqYOdx7a+UkXjOgam0wIli
   wpPJaz8CWlkyaMP4baTD/m3QFseX1BO0fsNb8WwbfXSGYQv6bTv+461A+
   4/n8Ye2t+MHQoxjYhE8wQtjEqhLAd64aI5jFBIh4m1mZxEVWCkdnefMc2
   GcUDpNLsxVAGLVuqH1EIIMBN87Vrb84kD892PtJQuaYNRRJ55UGlDiI9Z
   ACjxyv7nuTSqGJorYgBR0BOYuT2k3Q/1sO8ZA1cy3BHXC1690FtCVz3bD
   SmkjJfmcvRtAtMiUCvHwf2vv4Jdx3ByQC5dpaJ7/6RzL1ZQg35u9E+AZe
   g==;
X-CSE-ConnectionGUID: X/lSccBxSRamThmfUPDzgQ==
X-CSE-MsgGUID: BAh1hMO8QeeTPWg9G5NqfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90546656"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="90546656"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 10:54:24 -0700
X-CSE-ConnectionGUID: 5sgnGtXFRx2YYtkdtROv/w==
X-CSE-MsgGUID: dTI9oM1aTxGiVHiqPC3iwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="279356611"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.27])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 10:54:23 -0700
Date: Thu, 1 Oct 2026 20:54:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
	nuno.sa@analog.com, u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/10] iio: adc: ti-ads1015: inline
 ads1015_set_conv_mode()
Message-ID: <ar6eTN422AoPkeV6@ashevche-desk.local>
References: <20260930171204.12863-1-architanant5@gmail.com>
 <20260930171204.12863-10-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930171204.12863-10-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 30, 2026 at 10:42:03PM +0530, Archit Anant wrote:
> The ads1015_set_conv_mode() helper function is a single-line wrapper
> around regmap_update_bits().
> 
> Since the function is simple and only called during initialization and
> power management state transitions, the wrapper is unnecessary. Remove
> it and inline the regmap_update_bits() logic directly at the call sites
> to improve code readability and traceabilty.
> 
> Where applicable, introduce a local 'map' pointer to keep the
> inlined function calls concise.

...

> -	ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG,
> +	ret = regmap_update_bits(map, ADS1015_CFG_REG,
>  				ADS1015_CFG_COMP_QUE_MASK,
>  				ADS1015_CFG_COMP_DISABLE <<
>  					ADS1015_CFG_COMP_QUE_SHIFT);

The indentation is broken even in the original code.

>  static void ads1015_power_down(void *p)
>  {
>  	struct ads1015_data *data = p;
> +	struct regmap *map = data->regmap;
>  	int ret;
>  
> -	ret = ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
> +	ret = regmap_update_bits(map, ADS1015_CFG_REG,
> +				 ADS1015_CFG_MOD_MASK,
> +				 ADS1015_SINGLESHOT << ADS1015_CFG_MOD_SHIFT);

>  	if (ret)
>  		dev_warn(regmap_get_device(data->regmap),

At some point (may be even in this patch) it makes sense to switch to use 'map'
in all applicable cases.

>  			 "Failed to power down (%pe)\n", ERR_PTR(ret));

...

> static int ads1015_probe(struct i2c_client *client)

>  
> -	ret = ads1015_set_conv_mode(data, ADS1015_CONTINUOUS);
> +	ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG,

Can you also use 'map' here?

> +				 ADS1015_CFG_MOD_MASK,
> +				 ADS1015_CONTINUOUS << ADS1015_CFG_MOD_SHIFT);
>  	if (ret)
>  		return ret;

...

> +	ret = regmap_update_bits(map, ADS1015_CFG_REG,
> +				 ADS1015_CFG_MOD_MASK,

This is now perfectly a single line, same for the cases above.

> +				 ADS1015_CONTINUOUS << ADS1015_CFG_MOD_SHIFT);
>  	if (!ret)
>  		data->conv_invalid = true;

-- 
With Best Regards,
Andy Shevchenko


