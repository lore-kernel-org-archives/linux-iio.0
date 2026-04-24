Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F29838AC88
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777023275; cv=none; b=oQjtn8baJ2VBAHV6pWxTtGmuOArG61aCXLtLaa47MNURsozO2fvaKkOgsfVErQHX8y/iVtbQ2l7bUA4OfHKaErHe8dfMVqpWsBdApTIqgM+7nh936tE0y86+WVv29AaYrOs4+dT6XHPT53CXMFdBLmFgXx9sHbfDJ+pr+mjZ4qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777023275; c=relaxed/simple;
	bh=IhvcKh8UumV/dTIg2Jw5lyMxPJgvKivE1euWI4asnHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnLyucCrhNAxwMPczrBpvaQzpfr3u2IqgXz5Q61OMtQK/MxDBlOpLBGMKw+5svzHNZhBzlJpNnTp0AyXRGYCwNLwiFPrChdixzJHL8XyFUOHL1KtYOAP7Sa1fSsC/J6PY8hPoN2A0+A7P2IjZsrP/06S0K2A0JIznUkk/9kbuiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=no7OD3sA; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="no7OD3sA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777023273; x=1808559273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IhvcKh8UumV/dTIg2Jw5lyMxPJgvKivE1euWI4asnHc=;
  b=no7OD3sA8itYpm23t7i285mPGzr1bGIqPEjNJcMTZLZ+OG64pxIVOlmr
   w7r2T7eUNWGh09RrgC8PZaQRWcbvixgdIKd7IvNHk3jM7WJ8UiXvVxZbI
   2be62vHH3BVUr9blduG0oz5f3uGlSnbP5MZFqhSdE1InfvgZXkFYHPdHM
   /JDce+zHmg62bptgEAKG20sLwECgLngW/l3zrilysYIJ88UviqpQTn4dS
   VevZ0mErwGAsDiF9us+FgPXhuc0vSfwcBX+16IEQ2MYy9LLLl8H/imlMR
   i83fcgLD0GdhIfggUcHSlm33LU4u0E9zCgdMrhk/0LqNYYDcmhqozZQGq
   g==;
X-CSE-ConnectionGUID: xhlbmuvfSBmDfM7uRrOdwg==
X-CSE-MsgGUID: b2FctJNuTDq+4r9sWVZ4Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="77704788"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="77704788"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 02:34:33 -0700
X-CSE-ConnectionGUID: 9Ou1v+r3RdeS/WON4UCNeg==
X-CSE-MsgGUID: ymg9bzw4TSSYtLylQS1eTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="226372436"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 02:34:30 -0700
Date: Fri, 24 Apr 2026 12:34:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rafasales@usp.br
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	nuno.sa@analog.com, "Gustavo C. Arakaki" <gustavo.arakaki@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: light: ltr501: use `sysfs_emit_at()` for
 showing scales
Message-ID: <aes5JB9_1GH4fEei@ashevche-desk.local>
References: <20260422231305.677778-1-rafasales@usp.br>
 <20260422231305.677778-4-rafasales@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422231305.677778-4-rafasales@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 08:12:57PM -0300, rafasales@usp.br wrote:

> Replace `scnprintf()` with `sysfs_emit_at()`, which is
> PAGE_SIZE-aware and preferred for use in sysfs.

...

>  	for (i = 0; i < info->ps_gain_tbl_size; i++) {
>  		if (info->ps_gain[i].scale == LTR501_RESERVED_GAIN)
>  			continue;
> -		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06d ",
> +		len += sysfs_emit_at(buf, len, "%d.%06d ",
>  				 info->ps_gain[i].scale,
>  				 info->ps_gain[i].uscale);

It broke indentation now.

...

>  	for (i = 0; i < info->als_gain_tbl_size; i++) {
>  		if (info->als_gain[i].scale == LTR501_RESERVED_GAIN)
>  			continue;
> -		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06d ",
> +		len += sysfs_emit_at(buf, len, "%d.%06d ",
>  				 info->als_gain[i].scale,
>  				 info->als_gain[i].uscale);

Ditto.

>  	}

-- 
With Best Regards,
Andy Shevchenko


