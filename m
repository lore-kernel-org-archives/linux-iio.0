Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32603A4267;
	Tue, 12 May 2026 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600786; cv=none; b=Ls1Qb1RibgGV/9Aop/JHYraAvac5b7DvvKAZXIxXH6gQO+EMvSdwF7hu+v5yzuJxf2v3I+HSAqzCbm+a+d2HqvPpAB6YtuKNizewU0hMv+dZ1laUqmnqSSHQRfXhtZHx8PFgeON4z5F0uGHRUEK8YY9MrxDHd0q7sbqLXI4NAFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600786; c=relaxed/simple;
	bh=gEc9oWfq00XBMR639taA6xLnqHD9+hCS9uQrJyUfUXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dadZBGLjsBjCcgdYvXWrtU8G2z90iQyEne63HKU4czbWhNB5ekNY14I/8eAGaAKxa2SPmexZKeuLyVs6qsA8uhrlFJK2uGOKlAjHPuNcaQ5uhlEQAJ2HQvFhii6F7vn16KFg1090uzlgpHOg5uWKNKURd4GYMyh9FCVP0AvyRnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VEdo23ep; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VEdo23ep"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778600785; x=1810136785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gEc9oWfq00XBMR639taA6xLnqHD9+hCS9uQrJyUfUXY=;
  b=VEdo23epMZtfWwBW/wBVIIuCa2ID9aSEbIg1QgxOVE2ntY++26hyuuT9
   8oMQ0xGHaBeteD4udWedxxfsxDkXBzx/oZlMH/KD8uAx3hpaqvRJe3N4F
   HLRHehAfgeptGKEbXPSEdiEe04Z70Nnqz7gcCqGnXdkkD2JT6AgTJSpyB
   Jh4/7pKmh4eW2HjgMjKjOy7xT7lXPDmT6DySJ8wm1oO2zuFzV8nY/FnGA
   Im46hpRJhNVOy/ks2uloaqfoGlvaVTkSLe3GWc4B5kctofgbv2RoU29dl
   noihxTuui+VUeLU8EZwm0PYOGkGJYyZLXUbb5UcBCCgbWQydj6ycABRA0
   Q==;
X-CSE-ConnectionGUID: abvOGbZBRUKlATVk0XSOEg==
X-CSE-MsgGUID: xGdiL9b1SZil73HpLcUQ4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="104969320"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="104969320"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 08:43:08 -0700
X-CSE-ConnectionGUID: +BzQP9XoTH2crTt76XjXMA==
X-CSE-MsgGUID: LEp+zNyuRQ+yINzt2hF8Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="261281646"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.244])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 08:43:05 -0700
Date: Tue, 12 May 2026 18:43:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Alexander Koch <mail@alexanderkoch.net>,
	Michael Hornung <mhornung.linux@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] iio: light: opt3001: prefer dev_err_probe()
Message-ID: <agNKhz9rtg41VvAK@ashevche-desk.local>
References: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
 <20260512-opt3001-cleanup-v2-7-8018cf3a8a0a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-opt3001-cleanup-v2-7-8018cf3a8a0a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 12:57:27PM +0200, Joshua Crofts via B4 Relay wrote:

> Switch driver to use dev_err_probe() to unify
> error messages generated in *_probe() and probe path functions.

These lines are not balanced in length...


...

> -		return dev_err(dev, "failed to register IIO device\n");
> +		return dev_err_probe(dev, ret,
> +				     "failed to register IIO device\n");


I believe a single line in this and similar cases is fine

		return dev_err_probe(dev, ret, "failed to register IIO device\n");

(it's only 82 characters).

-- 
With Best Regards,
Andy Shevchenko


