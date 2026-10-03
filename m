Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACBB2F0661;
	Sat,  3 Oct 2026 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791055247; cv=none; b=E2GHZBAudxo2dtp8qlAKWqlPJMnrJHM+t9nlDB+Ug0FaI8/lbUBBA7LGXgbxWP8t82vf1OyHCAuylOCw8c0Jqtg4sU6auPpeSOZ6r4iKOeKQFplFQdEOdl40WPx197/FnsbYxudwokSTbHvgHDjDKqnnxtHycELbOCy5zDwFtmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791055247; c=relaxed/simple;
	bh=FqXfqdW1Ydic08nuT0WbF+aSbgmQa4Sbmj5zI5ZCdgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkEhruUB7XJjPijbcCrCvKDszXMbNw0ICTy6WC0BkfXIkqVi80Q7tMbIIFo4D5JinqEec7cFScVLzh2ktVhrg+HyNCqGxc3WqCA7aYXVbV4fQWEpe6uSX63qqPSXFqXgoqa0cSN3EtFz8BFkU1SC+vRMcGCgkoarjSCe8akxa+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vk4cwDBX; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vk4cwDBX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791055246; x=1822591246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FqXfqdW1Ydic08nuT0WbF+aSbgmQa4Sbmj5zI5ZCdgc=;
  b=Vk4cwDBXZklNLlsr+TYHnxcLkF2LBJoHbCLeNq85u+4igdVn5/FqZCY9
   +cxZTXoHwXQzfveg5nBtCTt4FwWZDSblIlafObrFtLwBULwRTGjohynav
   5T/lR/E7zecNLfhE9efVGVKy+Yu9RS4G94KjPizuDGQgpdALdKyqfFgkv
   CPJrJp6Rr1D0FY4Hbugz4GFangsTqTL2nI8ACaSIMbGGhy9ZCCoEeyMuL
   L1OKws5MK0QcwqhzBdG/8x3xdoWKDQabeBnLSMWafNOXd7cRuVfxHURAH
   ChIAX7Iy75csnX9i2dH5dCvswMMrwgU78JyykTVmEDup7J+g7a3ksHK5I
   w==;
X-CSE-ConnectionGUID: n4boaXzgRZG2nGo/V2gJ/Q==
X-CSE-MsgGUID: bAJ5AF2rQ8+CXqI83xJCIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="90642337"
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="90642337"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 12:20:46 -0700
X-CSE-ConnectionGUID: IsR04nfrQJuzO3e8VTPVpA==
X-CSE-MsgGUID: 34A0YQ/hTia9zjWS2vmQHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="279773540"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.78])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 12:20:44 -0700
Date: Sat, 3 Oct 2026 22:20:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: cdcp206@gmail.com
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Liviu Stan <liviu.stan@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] iio: temperature: ltc2983: pass leak detector type
 explicitly
Message-ID: <asFViTtGq3hQUrma@ashevche-desk.local>
References: <20261002-iio-ltc2983-fix-string-compare-v2-1-b0a5ba847790@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-iio-ltc2983-fix-string-compare-v2-1-b0a5ba847790@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 02, 2026 at 11:44:50AM -0500, Carlos Casadiego via B4 Relay wrote:

> __ltc2983_custom_sensor_new() uses propname both to select the firmware
> property to read and to determine whether the custom sensor is a leak
> detector.
> 
> Pass this information explicitly from the caller instead of deriving
> the sensor type from the firmware property name. This keeps propname
> limited to identifying the property and preserves the existing
> conversion behavior.
> 
> As a side effect, this also avoids the -Wstring-compare warning reported
> by the kernel test robot for callers where GCC can determine that the
> property name cannot match "adi,custom-leak-detector".

Reviewed-by: Andy Shevchenko <andy@kernel.org>

...

> -			if ((index % 2) != 0 && !strcmp(propname, "adi,custom-leak-detector"))
> +			if ((index % 2) != 0 && is_leak_detector)
>  				temp = temp * 1000000 + 273150000;

A side note for the further changes: We have ABSOLUTE_ZERO_MILLICELSIUS
that can be used here.

...

Since Arnd also submitted similar fix, it would be good to Cc him. And in
general, if there is a clash with the patches addressing same issue, Cc all
other authors.

-- 
With Best Regards,
Andy Shevchenko


