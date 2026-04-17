Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D993368A6
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 08:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776413141; cv=none; b=eE66YhDpRN+5LqP8+SRK3aK+wthwIwXBud4PFOnpkJvh2BVpgxMVhephdJAj9jODq7Kyt70v5Zb/U9Y7shBiQc4audCGcfdV5UH5AcrfiRlaptR7GpvseoUp7nwUEXMozf4BCOuskaqrsvRP/XRFkWQZ8N6l9i4pk4Me9nbF9B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776413141; c=relaxed/simple;
	bh=bZEZD+HmYtYQwXY6U906edubv0kw9kvmahRNNkdlm5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuEtfZYt309rx8E6KWr+lsfwPGdshPO0nQ097f2muARPS4clIw7zOMOwrMz0piCwDCfT3Ihtk0g0Tmv2/2XVLxXv7VFOkZxcROz4lPPHYDnfjCqxEL/r+hvf0pnsXvp3TEmwOKc1k++0y4hchKUoolF9ZhYV3w511FH5EbRbg4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hzBw5Xkr; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hzBw5Xkr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776413141; x=1807949141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bZEZD+HmYtYQwXY6U906edubv0kw9kvmahRNNkdlm5k=;
  b=hzBw5Xkrca2YILJo5QokTW+CGIJm7IGAxE4rh5nKiai8EiAp36Cx5B6u
   29aoxRwh80fAOjEOd0F3C4AZwAbqriPK9UelQuhrXVL7GZfWYa9zcPf6M
   x1vWjIrzZcVJRX7QMxsX/QoaBJvSzMKkiEi8vteaqoG1vGevdRJgzsXRa
   vcD++Ai2cjlM+RoUqLGsroLKWQroDcvxF8ClsAr36vb3KPmguvaBp2NZ3
   IryHA6WeU76bxXCs8KiPIIYo6OIqnOpW9z2zfZCxcSITrN42M1/Sk+qhZ
   bvFxaGjEhQQhke+JeMJIvOgYOOPYnueIzDjglYVF5xbmJ81vpSywihHin
   A==;
X-CSE-ConnectionGUID: YUQZrXU3SNKRwDPy8VhdZA==
X-CSE-MsgGUID: ekePQfaYTquz5Up+AvJZbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="81297234"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="81297234"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 01:05:41 -0700
X-CSE-ConnectionGUID: DZk701YjRnyO13cuLzQbhg==
X-CSE-MsgGUID: evJajTXoRvuec1j8FI3JUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="224468830"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 01:05:37 -0700
Date: Fri, 17 Apr 2026 11:05:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	Felipe Ribeiro de Souza <felipers@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad7280a: use cleanup helpers guard() and
 scoped_guard() for mutex locking
Message-ID: <aeHpz7Ny2hP6Xj0U@ashevche-desk.local>
References: <20260415160856.22231-1-lucas@ciziks.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415160856.22231-1-lucas@ciziks.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 15, 2026 at 01:08:38PM -0300, Lucas Ivars Cadima Ciziks wrote:
> Replace open-coded mutex_lock/unlock pairs with the cleanup-based
> guard() and scoped_guard() helpers in ad7280a_write_thresh(),
> ad7280_show_balance_timer(), ad7280_store_balance_sw(),
> ad7280_store_balance_timer() and ad7280_read_raw().
> 
> This removes the need for the err_unlock label and explicit
> mutex_unlock() calls, as the lock is now automatically released
> when the function returns or the guarded scope exits, regardless
> of the exit path.

...

> static ssize_t ad7280_show_balance_timer(struct iio_dev *indio_dev,

>  	unsigned int msecs;
>  	int ret;
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);

This will add some rather heavy operation into the critical section.
Why do we need that? Please, use scoped_guard() in such cases.

>  	ret = ad7280_read_reg(st, chan->address >> 8,
>  			      (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG);
> -	mutex_unlock(&st->lock);
>  
>  	if (ret < 0)
>  		return ret;

-- 
With Best Regards,
Andy Shevchenko


