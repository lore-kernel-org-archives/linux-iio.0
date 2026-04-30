Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3FD21A92F
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 06:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777529009; cv=none; b=C0kgZR4tXgl1JKoiK0lJsiAE2kJZ5AkmHSgMFm2NGuYS2ypdk/1BUj2kohNWNDnLZywu4DqfXhIKkXjXGV9bezHoQp4NtOi9u6rE6ksSEzPASE/OdnGOG6wSx+2IdZqnWExUtP/40fEqMyO6Dv2EcUKyUi3qxqr+Oabhxsey7Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777529009; c=relaxed/simple;
	bh=etJsEXGlA1QIBhnEbOPSr+H3PbR5v+6yuB2IqG5DYhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9nUN63840ZJUt8q1jb8FTYPsdbp6SZg6M9glYCkkXpAhFYbUcsxWTAAXtBNI14WTLMCPZDW3HSW6zyRaoqljZtaSYlBYd67I9ZxhTe8xloGHRpSDxXfPs793FzjA2ORetM92cqunFUAPh+hc7w9RJ3yaz6xcS194OSrXUh3drY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e3BuPXK3; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e3BuPXK3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777529007; x=1809065007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=etJsEXGlA1QIBhnEbOPSr+H3PbR5v+6yuB2IqG5DYhg=;
  b=e3BuPXK3EEZT7CZABqxz6lJwT2z3qcoSN74RxBdCCLjc9Bp3FIfzmlU+
   DIjLNSVo0HjK0bXFOeLsAwjAVG2n9lIOVpA3LpNJu+U/+7QKH2jxvhZZz
   +3oGUMffw/w8BZKUfiWHJAm3VyLxdcXkuQpNsXg2nz86a7ag5AbFAFjob
   WnIS7dF7swWJ3DjkZlsyCQEKCDt23pGj57UmJrYnaASZImw4CoYp67Tdn
   /rQOoXcAVUXr2KaTT9SMydziwXFEhIBRqC9f67laFNmqf1NlhV7lWV2zg
   JQWVWM7GUhs6KkodZKmPSHRORAgRZPnuxpN80fFWmu1I6F2Y6mNA8r75w
   w==;
X-CSE-ConnectionGUID: ikGfd8WAR4uwwS1HJrFdVQ==
X-CSE-MsgGUID: fTaF/ftMSPK28AWc8Ubpcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="82334088"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="82334088"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 23:03:27 -0700
X-CSE-ConnectionGUID: E9c9GqzkTDWpKiCMVa1XfQ==
X-CSE-MsgGUID: tyaZgBjVSb+e2k6alv8Ucg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="231350438"
Received: from zzombora-mobl1 (HELO localhost) ([10.245.244.42])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 23:03:24 -0700
Date: Thu, 30 Apr 2026 09:03:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Educg550 <educg550@usp.br>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
	antoniu.miclaus@analog.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org,
	Lucca Ciriac <luccaciriac@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: frequency: adf4377: replace mutex_lock/unlock with
 guard and scoped_guard
Message-ID: <afLwqYt_XUjeroGJ@ashevche-desk.local>
References: <20260429202304.25308-1-educg550@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429202304.25308-1-educg550@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 05:23:04PM -0300, Educg550 wrote:

> Replace manual mutex_lock()/mutex_unlock() calls with guard(mutex) and
> scoped_guard(mutex) from cleanup.h.

...

>  static int adf4377_freq_change(struct notifier_block *nb, unsigned long action, void *data)
>  {
>  	struct adf4377_state *st = container_of(nb, struct adf4377_state, nb);
> -	int ret;
>  
>  	if (action == POST_RATE_CHANGE) {
> -		mutex_lock(&st->lock);
> -		ret = notifier_from_errno(adf4377_init(st));
> -		mutex_unlock(&st->lock);
> -		return ret;
> +		scoped_guard(mutex, &st->lock)
> +			return notifier_from_errno(adf4377_init(st));

The scoped_guard() makes more sense when we have some code in between before
returning, here the guard()() fits much better.

Alternatively:

		scoped_guard(mutex, &st->lock)
			ret = adf4377_init(st);
		return notifier_from_errno(ret);

>  	}
>  
>  	return NOTIFY_OK;

-- 
With Best Regards,
Andy Shevchenko


