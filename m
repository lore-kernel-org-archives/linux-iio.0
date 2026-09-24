Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355BE48CD59;
	Thu, 24 Sep 2026 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790283199; cv=none; b=cb6tUudruxEi1FzLDkIlTV+9eHJShX5IVDCIYEGFrLwApHn/vKieEggBkbX5p+hQDcFRiaib3V5wbU9hPI9dN3jwb5X1odiOm21Ww2kntHmqnv32PAM5wmfunfW9sA9MLIrzkA2tyKygeHFpWWMj6+1RygFtp0KspxzrCutvcHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790283199; c=relaxed/simple;
	bh=q7f2yxHXOO+EhXNPemNFyuYM9CjLPx5BB5xiwbdY6OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Au7IgME0DlOHF3retiYaMzFxhNovdxY/davQNF7CrtOHMEipp4GCwdPWrlCYq/c8BFYYD++PA0nTHJxFh7iG2c/q0SAoyQZvKBlCe9AmC99mtmeG2lFgFxohImHvU7LhQzJpYRcdga/ginn4hRhbaQ+23LLecH6g42snmxKzGsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ifSiNXyS; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ifSiNXyS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790283198; x=1821819198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q7f2yxHXOO+EhXNPemNFyuYM9CjLPx5BB5xiwbdY6OM=;
  b=ifSiNXySRWiCWymlaWHGll0pKh/uX48979N8MmgRdXiv0b9MKS8+2TtC
   Rwcn0n0C6L9j00GrjwPypkMDedp5usujbmmW97l2r92tOJTMY5YCs72Um
   aQixVIhQM3D1Ltv7eCje/XvFC0B8kPZFAsC8L9aH6epcqvvaSp99cOJeh
   HiANmIpkqQCOoQqEPhVXaa4yfqe87Nd35eont8Eay09y/NMeJFfMwFG0P
   mEFv7gp3HGzHCGvqIBhboxD7fzl4DAwZD3Et9X2kcaT2KkoeuPAyAs5y1
   bupMylb73G/7YJlf37uOi8P3wpFEe2Z6hrkQbc8i5pra97DkJeOiCEE4d
   Q==;
X-CSE-ConnectionGUID: afeounszQgmxgChRCq07PQ==
X-CSE-MsgGUID: AayKgZAqRkecjf+UYh9bMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="89931406"
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="89931406"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 13:53:18 -0700
X-CSE-ConnectionGUID: EySsJcHbR/KjdDu1GwigVQ==
X-CSE-MsgGUID: D0+HtdKLSYm1S8nJAIwBVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="270620671"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.199])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 13:53:14 -0700
Date: Thu, 24 Sep 2026 23:53:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Marek Vasut <marex@nabladev.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/14] iio: adc: stm32-adc: rework internal channels
 data
Message-ID: <arWNuD9apkeeT2Rd@ashevche-desk.local>
References: <20260923-adc-stm32mp25-v1-v2-0-46bc019537c6@foss.st.com>
 <20260923-adc-stm32mp25-v1-v2-5-46bc019537c6@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-adc-stm32mp25-v1-v2-5-46bc019537c6@foss.st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 23, 2026 at 05:39:08PM +0200, Fabrice Gasnier wrote:
> Diversity in internal channels data array lead to have zeroed data.
> To facilitate addition of new internal channels, without touching
> all array initializers, only focus on exiting channels on each
> supported ADC variant (e.g. each SoC).
> 
> This also allows to get rid of static_assert() checks.
> 
> No functional change intended.
> Cosmetic update: remove comma on STM32_ADC_INT_CH_NB as it should
> always be the last element.

Yes, but...

> -static const unsigned int stm32_adc_min_ts_h7[] = { 0, 0, 0, 4300, 9000 };
> -static_assert(ARRAY_SIZE(stm32_adc_min_ts_h7) == STM32_ADC_INT_CH_NB);
> +static const unsigned int stm32_adc_min_ts_h7[STM32_ADC_INT_CH_NB] = {
> +	[STM32_ADC_INT_CH_VREFINT] = 4300,
> +	[STM32_ADC_INT_CH_VBAT] = 9000

...you should have it when it's not a terminator entry. Here is the case when
it's not a terminator, neither in other similar cases below.

> +};

-- 
With Best Regards,
Andy Shevchenko


