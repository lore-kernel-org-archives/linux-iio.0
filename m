Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEC63126A0;
	Thu, 13 Aug 2026 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611513; cv=none; b=sBQuCsUcc+wqYI6KUB9ZOK3NetFnRdskYMx177GQVHhXL9VNqbE6dtOOobFLXqIXCzZQrKlirnoene7Lazknn+AzL+3SZjo+U+1zo4ko8VHvuvwV2NYq/bBCZkgPguhyMIQIxVRtR2MvJcmwEk+hArCe6zFnOuyH6IaqHLbnwPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611513; c=relaxed/simple;
	bh=aNR4ZOcqQp4tKZS3RQ55C7WLshxywRPbcQjU5K+0IMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k02dE1gZWCrWOuq/ZITCBLj7SzaY4x0wEKpeCpie0SXakN7oaq+NPfuUIc7GhpvW5VlmIxg04sMEN/whifBxejSx0dTKte1HvnxyTLrGi+3tNJhkmSWGvgE/hnBy9RFFhNJR0aHXa8pN5n50mgAUDx/o7XyWQ3U4TW94FY/+/NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SXGOBgmJ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SXGOBgmJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786611512; x=1818147512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aNR4ZOcqQp4tKZS3RQ55C7WLshxywRPbcQjU5K+0IMM=;
  b=SXGOBgmJK8nE5eh1qjDU8fOZwBAQxeXMMoS2lqpPrvgMRvuyMz23yF/I
   cVMgz6DOYRhe0wE907fESuV6904ukrHk70SStsFVVVGJa8b4EnX4PJ161
   8Eo4nJrp4anHF5oBTX2dD9gJLocgK2usRIXKgRD5XVNNIwnOHeZa6TvgZ
   Id2Db6dHXTdPaZG6NnVlb2uHrjVQHliO9JGtavXEm1axvcSt4Nin6l7Zp
   ZZ938zfRx1gh5mkeije8QuxwI2wyJeMSz++zz8B7AGP28Q8U24Jg9iH8A
   KIDhuSOwiMaiCuHtRGaM+siznvWMkXhjdDcwiSirqJB61IwFNrcaPptxx
   A==;
X-CSE-ConnectionGUID: qZxLkGFgRduvCzVG0ppSTg==
X-CSE-MsgGUID: S0Lv+6JiRny5PnO7zM3/8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="97528788"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="97528788"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 01:58:31 -0700
X-CSE-ConnectionGUID: UhJLqQmfRxW30OPF3+/8Fg==
X-CSE-MsgGUID: S06AoNc6QOCzheOwxai4RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="259637425"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.250])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 01:58:28 -0700
Date: Thu, 13 Aug 2026 11:58:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
	nuno.sa@analog.com, u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/8] iio: adc: ti-ads1015: convert to fully managed
 resources
Message-ID: <an2HMjolkHE_l19C@ashevche-desk.local>
References: <20260812164433.23011-1-architanant5@gmail.com>
 <20260812164433.23011-7-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812164433.23011-7-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 12, 2026 at 10:14:31PM +0530, Archit Anant wrote:
> Refactor the driver to use devm_ allocations and power
> management, allowing for the complete removal of the
> ads1015_remove()

...

> -	ret = iio_device_register(indio_dev);
> -	if (ret < 0) {

> +	ret = devm_pm_runtime_set_active_enabled(dev);
> +	if (ret)

There are more places with unneeded ' < 0' comparisons, can you add an
intermediate patch to drop those? With that being done, this, in particular,
will have less churn.

-- 
With Best Regards,
Andy Shevchenko


