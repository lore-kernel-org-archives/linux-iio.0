Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AFC332906;
	Wed, 15 Apr 2026 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245604; cv=none; b=jAQyzBS8C4/5Y8OueHQ+NLobq5wQCJGW7hQV523jP3UrFovwZ1/RzmQME7P9JUpaoASsZ0eLgpCZbFQvXHulLDaxHIgGGpN81YwIrDZ5Av4uDf6wnZWmih5Ce4b+xiU2/r1u7ESjiNMhpWsjRZRg4MzCn/XIiSHvTIUvaqsm5Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245604; c=relaxed/simple;
	bh=JutTR/Uq9jbJ0o5lULq964lCoWPpQISELF+TxNzK3Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oqzc4B2m8eIpnwTx8f6KI4y0JEXAuvXpgszpUt0UfNDRVxfhDWp9PiK3tYKb5lB2vnUsguxyw536PuNLvdJEj8+HvUGa0hOWdHOkOWCSKg22tC9QkLum2YsgG6zwrxT2TRdPhh8F7GEMh3ppbLRwOOOB8Hm8yVRpOtyO2OslYlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CKIB39JB; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CKIB39JB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776245603; x=1807781603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JutTR/Uq9jbJ0o5lULq964lCoWPpQISELF+TxNzK3Cg=;
  b=CKIB39JBCd6k6jDBktFdeYnDD1aAUaRtSQnBG/9110xefFkfruhNRR5Z
   OH6PcrGI0His6DfTIVUZB9ga//Ac/huqmJX+TxepfMxVj80MIdOEhD1x2
   8uUm+7EU5sHrPZxrUMi8nn5cwGs3JRuo/dPQkSNmTE4piBusyqmEmPtmV
   sY2BhP0BFhGZPIyAZYAi3SzJQQXvwal6v1dCzuiUA0GmSn/qKUr8AYk7b
   IEu69aEXNSiQIWN2nlCRWMV8CYz3dV/pvfjSU67uRGCJzIKAhYl+OvWp5
   NaZN2HQQ35ew9frhcisD1nbtBoRmxtQRgbHewHIWa/5Qc2ITKQOOQk5Wj
   w==;
X-CSE-ConnectionGUID: 64zrPKUWQw+Rx6u9ziftsA==
X-CSE-MsgGUID: H5Gs23c2RjyBEsKvXIL0ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="76922136"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="76922136"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 02:33:22 -0700
X-CSE-ConnectionGUID: tq2dvjBsR8OyEK0XfXvvGQ==
X-CSE-MsgGUID: XJUWUtfLQJCrRMYitVFeCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="232109574"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.34])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 02:33:19 -0700
Date: Wed, 15 Apr 2026 12:33:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, tglx@kernel.org, christophe.jaillet@wanadoo.fr,
	mingo@kernel.org, nabijaczleweli@nabijaczleweli.xyz,
	kees@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/7] iio: ssp_sensors: convert probe and teardown to
 devm-managed resources
Message-ID: <ad9bXYpuSLRaocVd@ashevche-desk.local>
References: <20260415050749.3858046-1-sanjayembedded@gmail.com>
 <20260415050749.3858046-6-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415050749.3858046-6-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 15, 2026 at 10:37:47AM +0530, Sanjay Chitroda wrote:

> Convert SSP driver resource management to use devm-managed helpers
> and devm actions, tying the lifetime of all resources to the device.
> 
> Mutex initialization, IRQ registration, work items, timers, and MFD
> resource are now managed using devm APIs. Cleanup logic previously
> handled explicitly in probe error paths and the remove callback is
> replaced with devm_add_action_or_reset(), ensuring correct teardown
> ordering and consistent behaviour on probe failure and device unbind.
> 
> This simplifies the probe path by removing goto-based error handling,
> eliminates the remove callback entirely.
> 
> No functional change intended.

...

> +	ret = devm_add_action_or_reset(&spi->dev,
> +				       ssp_disable_wdt_timer, data);

It's perfectly a single line of 79 characters (we allow 80 in strict mode and
100 in relaxed and you seems stick with the former, which is fine).

	ret = devm_add_action_or_reset(&spi->dev, ssp_disable_wdt_timer, data);

...

> +	ret = devm_add_action_or_reset(&spi->dev,
> +				       ssp_shutdown_action, data);

Ditto.

-- 
With Best Regards,
Andy Shevchenko


