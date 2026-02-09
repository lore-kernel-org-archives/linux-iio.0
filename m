Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3156A242D91;
	Mon,  9 Feb 2026 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770626800; cv=none; b=u3nWkXnmB0vgSb1032y42CGf7Ftk59IPfd4wcLHCV7k+pvQ+gP1TyodlQQLAmJEYKDPsp6zi4Vfny7lIlUJeqGpx5Y1YkDCIiU2ZC5q/FTTD8xweHXfQEBUspwJ/IWjU+NcTLYbeeFPHEY7xjLSvbG61pNH3bNRSGIvjuivKxoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770626800; c=relaxed/simple;
	bh=aIes+ukf7Pz8aplkopk59A/uWVjjaQle7YmiUvHt97E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmLhvPe6KUV3aiZafqxhtBuTkl6DaeavOnwGKcqdXnwvaS+RuigaTazMK2aYPFzTTwl/ytX/OY/aSmcM264IECg9O7p1iB1x1Qu5J4C3NXgnMFFf/6W0kFZNueO2gCwesyPSGdiXIqfS1O9UpXYdUhkQ01yLKMm8GHYcKAquCs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IbX4Cftj; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IbX4Cftj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770626800; x=1802162800;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aIes+ukf7Pz8aplkopk59A/uWVjjaQle7YmiUvHt97E=;
  b=IbX4CftjVa1p2VJtSCYA+wRk+HNz8VggwPOU63I91B3M9Y5U8sKZevWU
   1JZgxWNVua5+TBvI5yJ/NZKk0R8jk/fe01Mqi0UqiiZmhV6XvN3KCdDxI
   i9PQQfdjqiW3jN3wBX95gNNQKlF6P2xlkKMM4efWt+pFKm2l8lcfijsoU
   1nQputU1TXt9zLPYtwLdbsNT4EZbLZeqWMv9nRgU+Ybjg/4HYeaDeDJ28
   nDyalItzcJ93JfD98eUPhvC7o3I4NowqjV8uQCM2DCsGJQK+4WRPEdB1Z
   Q8GIl9ae33UsVvk+x7QVarqfyw/fiwajcXaM4rANNKrN0Q3ZVfghHWaLs
   g==;
X-CSE-ConnectionGUID: X/jqeHysRJaPZAl4igykSg==
X-CSE-MsgGUID: osa3pUlCRO6UiD1waJ9TSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="74333197"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="74333197"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 00:46:39 -0800
X-CSE-ConnectionGUID: NlRjM7woQPitqRvN7UC6wg==
X-CSE-MsgGUID: DFEOtU30QpusADi7qetdbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="234460813"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.128])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 00:46:37 -0800
Date: Mon, 9 Feb 2026 10:46:34 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yasin Lee <yasin.lee.x@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: proximity: hx9023s: Protect against division by
 zero in set_samp_freq
Message-ID: <aYme6jXNyPM_AHo-@smile.fi.intel.com>
References: <20260209-upstream-20260219-v1-0-2b4d74e309d1@gmail.com>
 <20260209-upstream-20260219-v1-2-2b4d74e309d1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209-upstream-20260219-v1-2-2b4d74e309d1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 09, 2026 at 11:37:03AM +0800, Yasin Lee wrote:
> Avoid division by zero when sampling frequency is unspecified by
> falling back to a default 100ms sampling period.

Fixes tag?

...

> +	if (!val && !val2)

What's wrong with the positive conditional?

	if (val || val2)
		...
	else
		...

> +		/* Fallback to a safe default sampling period */
> +		period_ms = 100;
> +	else
> +		period_ms = div_u64(NANO, (val * MEGA + val2));

-- 
With Best Regards,
Andy Shevchenko


