Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8E51E1DFC;
	Mon, 16 Mar 2026 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773660306; cv=none; b=hxefqGqrzerJrDZHSD8X0OD227KgMHFUK8SvA3/VSCB9X+TI3AZoDCtExTRRjTfP3nCNOKFipJ0tTk2ZPcCW5mwo7HPkZ5yRoBCiq0ClpjKxuI+C7umCHjN+494Wvy+14ibX+40yLxG25ktK0GhgM6YoBc0YCGBFh2LoYPgr56c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773660306; c=relaxed/simple;
	bh=B1sTM5bQzllfnXzANIrljhS0l19Z0G7SH0icpqGgSV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5I8Dbsrg5UenRKeWecCerg0O00y6G8j+kMsGAG5hgzuE7tArEitbdA++3IbzUPJXOUhi/oIrfCH3xmZeeoTfcWUp4xYSZzEUAjOnVz+BDM/Vaogme95SS+7MKPzhxCpypJgJ6AZdxZsSypkyCkdZwCf4UUE2/+nApIMAiBWG4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LcSSqdC6; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LcSSqdC6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773660305; x=1805196305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B1sTM5bQzllfnXzANIrljhS0l19Z0G7SH0icpqGgSV4=;
  b=LcSSqdC6aX5pFj8rFm2J9QvUXFLD6wgd7oxNvujul98eLgZZOdj59beD
   ekvNjgHlsroBeypLZ7JE62Kv/FUL/D0bMndTvxWJ29ZssZsx3+DxGkDts
   9mboFnbTOz1W8hObwDuuy3kh4bL7GPBUnTJvB3ZBtVQFhUjY1ezUbUTon
   V32lgd6A5jX6Ywv2NV8P5ZQbUq+1l+fhmew13xrLsjLAF0dkoTMiJmj2/
   kbTIPHWoFoSLwwQfpRVitHSzvipm1V6dl9WPp6btj8jqlJptFfqfv6/vt
   PQkgAxrbfBw/8oblO5d/wgn9G4ZY+pFwWymkBh3buBOa9S6GFI9trywaQ
   A==;
X-CSE-ConnectionGUID: uuP23/zESEuv1x8I+WLDHQ==
X-CSE-MsgGUID: Kb/wLs5LT1yI3Zrc3COIWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74559100"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74559100"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 04:25:04 -0700
X-CSE-ConnectionGUID: O1dq8XFpQ8mzNAtxXdrLww==
X-CSE-MsgGUID: qT3yoZihQeK63IpkvE6S6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="217727399"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 04:25:02 -0700
Date: Mon, 16 Mar 2026 13:25:00 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: health: max30100: drop unnecessary cast
Message-ID: <abfojPjXKhI6V9e-@ashevche-desk.local>
References: <20260314-iio-health-max301000-drop-int-cast-v1-1-ed4982d559f5@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314-iio-health-max301000-drop-int-cast-v1-1-ed4982d559f5@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Mar 14, 2026 at 05:33:01PM -0500, David Lechner wrote:
> Drop an unnecessary cast in max30100_led_init().
> 
> val is defined as unsigned int val[2]; so the cast is not needed, nor
> is the address-of operator &.
> 
> Also fix alignment with ( while we are touching this.

>  	ret = device_property_read_u32_array(dev, "maxim,led-current-microamp",
> -					(unsigned int *) &val, 2);
> +					     val, 2);

You want to have ARRAY_SIZE() as well.

-- 
With Best Regards,
Andy Shevchenko


