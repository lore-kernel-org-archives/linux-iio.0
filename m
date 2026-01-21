Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1A633F391;
	Wed, 21 Jan 2026 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769000300; cv=none; b=gZx13tH8ZR6tWhGuamx0SyEjrU/A2Dd/VEirHMj1I2HeWusonpOWX4cI/2d3MKhRYZ8eo5434t9iCkP55w9144C+3YjBfo7nJkJvZkDog3/aJL/+7pWoXDiDYMkHd6BuW4fGGwVHZBRhQiBMcQ6JlKEo975bWskco8t1urWYui0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769000300; c=relaxed/simple;
	bh=fBpr1W+Xl2h5s1QCsAMz7ixgsoniQQRhwy+ZukbhKJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhIRaIKyzdGVIT7TluYKLTBWXhRmU9Os0Yy8kSR3cy/mNHm7L2OayQLZaAMNKR1eMPtGLkojDl4XvFm8xYVCuxJh7nXatZnHB0OxH/1JG/H7MUNf5ePa38CQUhkSQZWfhH9uhr0j6VAx1gk92gyqz5BsMgoX85ha4+JshttL7UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mxbvCMdY; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mxbvCMdY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769000298; x=1800536298;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fBpr1W+Xl2h5s1QCsAMz7ixgsoniQQRhwy+ZukbhKJ8=;
  b=mxbvCMdYzmVljXgXrG29lkUTqxUjUNQ5RtanllAgKBTNJdgVV265DJeG
   ii3aszTt/R+n4odjGxaY5K5exy5p14Cx6Ole+u3289Fn1POUnB/QPP7fJ
   8Zc8G4sz6Q7voZJi5x6QFycjH07x1IaL+umHa+EloWmO7T3tGqJt+vs47
   2rafgj1j6KGzKyEDmIbcVzMbu2rkxBNv1Q5r3hiZWTMgAyFh9gCJe3QBh
   hHadUcikyY3iO8j85rwWNXvCWDipK2KabJQFjLnTAwnYGZ0KyiX5Pe4nC
   7xJPj756Xw0FWI4XAu1NaJAXLqR4kbLoulFoMGYY2ue87WJ9FvhOpCZaV
   Q==;
X-CSE-ConnectionGUID: X6BqxwStSx2XBtRSNmb0Hw==
X-CSE-MsgGUID: F9H3hCIbSl+qmgokzkPmrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="74091147"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="74091147"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 04:58:18 -0800
X-CSE-ConnectionGUID: POrh6QsrT++9f60Lko7PTQ==
X-CSE-MsgGUID: NdrJaI8yQtGBkNuFzwLXbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="206681589"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.73])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 04:58:15 -0800
Date: Wed, 21 Jan 2026 14:58:13 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] iio: adc: ad9467: check for backend capabilities
Message-ID: <aXDNZWSWpuDPzdwv@smile.fi.intel.com>
References: <20260121-b4-ad9467-optional-backend-v4-0-18d2c0d450cc@vaisala.com>
 <20260121-b4-ad9467-optional-backend-v4-4-18d2c0d450cc@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121-b4-ad9467-optional-backend-v4-4-18d2c0d450cc@vaisala.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 21, 2026 at 12:08:33PM +0000, Tomas Melin wrote:
> Add capability checks for operation with backends that do not necessarily
> support full set of features, but are otherwise compatible with the device.
> This ensures a fully functional device, but with limited capabilities.

...

> static int __ad9467_update_clock(struct ad9467_state *st, long r_clk)

>  	if (ret)
>  		return ret;
>  
> -	guard(mutex)(&st->lock);

I would leave this as is. Yes, practically we don't need to cover
iio_backend_has_caps() with mutex to access the data, but it just makes code
slightly more maintainable in my opinion. If anything appears here, it would
probably mean some kind of if (...) do_blablabla(...); pattern that will need
a mutex.

> -	return ad9467_calibrate(st);
> +	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_CALIBRATION)) {
> +		guard(mutex)(&st->lock);
> +		return ad9467_calibrate(st);
> +	}
> +	return 0;
>  }

-- 
With Best Regards,
Andy Shevchenko


