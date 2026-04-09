Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCCD3E1CF4;
	Thu,  9 Apr 2026 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749748; cv=none; b=cpiyCzCyrVXP+EF56ygnWmnpCfgqyPVzp8P10JccoIi44dJrzF2MovkGtEuZ/0sobn67o24tKbmVXEvRfoXE2NQK2ulAAbOqsuJtIoA4Iahz6IaNSYm2gEPOWOWzTxxESG0rJhGMBF2WS1Lrqcs0+xoxZKJ26eDsGAPu8m/I7TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749748; c=relaxed/simple;
	bh=ek/vqWnWV0MvaODJRsodsL8fvw1532Vy1sbvx7XZ9GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3Zm9as9D58wHx/nFoJA03cuTpdZuOxXKbvddTwl+Tf7Jdx69lCvBderj6MqXWbdiu//EwssG4mXIiZ6uvSARLjIvwef9kjm6P52Th7ygr/5r8/KROD91jAk7hdvYxFTW8EUlpynpk4ScgbWEfUyUnfxUsXWx39hDh7KEizoec0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJ08laq6; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJ08laq6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775749747; x=1807285747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ek/vqWnWV0MvaODJRsodsL8fvw1532Vy1sbvx7XZ9GQ=;
  b=fJ08laq6izSmzuqBuBBPATFL4tyFqTpW0UhXoJ16e5BZvX8HuC3CYe3e
   WVf6Wv16niasGg49y/tSsxteEIjehLvAb7BNAXdJ8VUgDWJ54ncKicq30
   VPU+4DaPaPbqaZ+83MULETPtlcY3dJzASg9IUf7PKe3IN4xyVBtWPqL53
   Wk2KLi+aAZcwEy9BM1skUD+C3ICndYvHUQcMmlxvwPewu+YQsGYi0vDtJ
   EzfiJWdlfxNQBUTrPgRhwvvoagyykSk7zvejb93zeq+2Acn9W4oKzCE5b
   7KMC+QgcA3mqvlwylQXbxzoceMnLbqOlkbHci68phAE5frTvuR83vKiL1
   A==;
X-CSE-ConnectionGUID: Tp2rMe8nRQSwXMbnpvBwAg==
X-CSE-MsgGUID: uGsME25VRwmPe2iuBZIbmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76878708"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="76878708"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 08:49:06 -0700
X-CSE-ConnectionGUID: rVMrN0mtTySuroDhL9fnLQ==
X-CSE-MsgGUID: N4po9ZgHReSEBdf3GfmyKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="233794431"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.162])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 08:49:04 -0700
Date: Thu, 9 Apr 2026 18:49:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	greghk@linuxfoundation.org, dlechner@baylibre.com,
	nono.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] iio: frequency: ad983x: replace do_div() with div64_ul().
Message-ID: <adfKbAyEO0K1p9Vu@ashevche-desk.local>
References: <20260409131823.1289-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409131823.1289-1-joshua.crofts1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 09, 2026 at 01:18:23PM +0000, Joshua Crofts wrote:
> Coccinelle reported the following in both ad983x drivers:
> do_div() does a 64-by-32 division, please consider using
> div64_ul instead.

div64_ul()

> Fix this by replacing do_div() with div64_ul(), which
> safely handles 64-bit dividends and unsigned long
> divisors across all architectures.

You should really dive into this code, it has more to work on...

...

>  #include <linux/device.h>
>  #include <linux/err.h>

>  #include <linux/kernel.h>

Consider replacing "proxy" headers at some point. (Not related to this patch,
though.)

> +#include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>

...

> static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
>  {
>  	unsigned long long freqreg = (u64)fout *
>  				     (u64)((u64)1L << AD9832_FREQ_BITS);

(u64)1L is a fancy way of doing 1ULL. The second (u64) is also redundant and
altogether it's just a BIT_ULL(). But, check the value of _FREQ_BITS. If it's less than 32, the whole train of nonsense can be collapsed just to a BIT().

> -	do_div(freqreg, mclk);
> +	freqreg = div64_ul(freqreg, mclk);
>  	return freqreg;
>  }

...

> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -10,6 +10,7 @@
>  #include <linux/workqueue.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> +#include <linux/math64.h>

Side note as per above.

>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
>  #include <linux/list.h>
> @@ -101,7 +102,7 @@ static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
>  {
>  	unsigned long long freqreg = (u64)fout * (u64)BIT(AD9834_FREQ_BITS);
>  
> -	do_div(freqreg, mclk);
> +	freqreg = div64_ul(freqreg, mclk);
>  	return freqreg;
>  }

Ditto. Also split changes on per-driver basis.

...

So, if you go suggested way, I would expect to have 4 patches (2 series by 2
patches each) out of this one.

-- 
With Best Regards,
Andy Shevchenko


