Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9889026D4C3;
	Mon, 12 Oct 2026 21:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838993; cv=none; b=Mge80wKG8bGgS/52MWNGvfSUAkO1bRczRvbVuLbayFpfgW3iztn9qCIJwlzh9Ufj+jiYw1ffilsdpH3wkSF/Nb9ZmxrUWYKjA9gEWNfSNAzlbEp97OrLgTHG2a9Kb0Zi5RjCxxnlJ4s/9pcaLNCH0MSY/ZqSAKMr8QcsIXWB6N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838993; c=relaxed/simple;
	bh=RSFsJAtlDvmcdluKq98Yyik3AX0ndCZVuFsLEkW0ECI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Knx6b5Pcbi5aDMW1j3tZofyadjrR3OwHd3lwZWMpgoNv0J0+iOw6LJifsSyU1YJ/RMklPNi7enPp8F9D25TEq4mCLUVTM9PTTmNfBiLIGqb1IoL0CtvCcZ8fWCpoSgj0Et4PjlCLH822WTtEjvjJqXQ/u831Ds9IJ8jIbka5jF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hwRvPFpX; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hwRvPFpX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791838992; x=1823374992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RSFsJAtlDvmcdluKq98Yyik3AX0ndCZVuFsLEkW0ECI=;
  b=hwRvPFpXpJFUanV3m8bTux5q861J1mLxiMVwf4hkQNGRVqMiZIPTPEeP
   T+4T+EZx4zoCdIss2ej9oTiyCXLel5+HYurZSJrxGQUJSkiiRlQe4z5xr
   2/9ObvhUSfxAbhndEA1emmpgRrtDedsRUtRy7eCMeWG4FEaLO5R+TtciZ
   ISjtg/MBrI37eHBLnkIkll8noLwsZrthTXR1FQPHPUWmcAwrDqHKuC6CV
   RjQk4YqiFCOE83IAAleZvjR+/Ts5AO/8fZBe7WGY9SUJ7W3O6nX2GpFT7
   NO+kKAT7Mn+uq1BtBbgtuFHzVAAePtOOYnLSXyQwxkRrL1NLnMjxPFPyb
   w==;
X-CSE-ConnectionGUID: 9PMc1RRZT46+cP29TbK1YA==
X-CSE-MsgGUID: x2rd3FRcTnCSLxiz7ypNZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="453681"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="453681"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 14:03:11 -0700
X-CSE-ConnectionGUID: RztuPPXFQ3a0Yapghe5rPQ==
X-CSE-MsgGUID: 0OqWiq0uRrSFu+ieXpcVng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="964159"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 14:03:07 -0700
Date: Tue, 13 Oct 2026 00:03:04 +0300
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
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Marek Vasut <marex@nabladev.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/15] iio: adc: stm32-adc: rework internal channels
 data
Message-ID: <as1LCL3y2MN204OB@ashevche-desk.local>
References: <20261006-adc-stm32mp25-v1-v4-0-d31ec75aecf3@foss.st.com>
 <20261006-adc-stm32mp25-v1-v4-5-d31ec75aecf3@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-adc-stm32mp25-v1-v4-5-d31ec75aecf3@foss.st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 06, 2026 at 09:57:36AM +0200, Fabrice Gasnier wrote:
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

...

> static int stm32_adc_populate_int_ch(struct iio_dev *indio_dev, const char *ch_n

>  	int i, ret;
>  
>  	for (i = 0; i < STM32_ADC_INT_CH_NB; i++) {
> -		if (!strncmp(stm32_adc_ic[i].name, ch_name, STM32_ADC_CH_SZ)) {
> +		if (!strncmp(stm32_adc_ic[i], ch_name, STM32_ADC_CH_SZ)) {

So, now this can be converted to use match_string() I believe. However, if you
are going to do that, it might be a separate patch. OTOH, this is not fix
anyway, so might be also integrated (but makes a huge change). Up to you.

-- 
With Best Regards,
Andy Shevchenko


