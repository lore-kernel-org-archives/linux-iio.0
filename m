Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD8E22FE0E;
	Thu, 17 Sep 2026 06:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789626287; cv=none; b=omljkekw5a95k0ZIULxdQpdZ2dwzoB2ppE7h7b8KtkxwMfLiFwSsfDZfJ73tQ56yLC1JPxGO0+Za0Q/YY3kHq87lnXxE5SMHVtpl33A1BRcybN7fplfUHpEvXWbuU9tDdLCwQat+MKNJd29PRXVnjsnhXtEYIxeErbSDBDVrnd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789626287; c=relaxed/simple;
	bh=qT+cSvgxR/drCHZE3qZtKVtSgJX/veG+thk2cR/IrnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuZjMq6fs+XJMb/Lyk61B5cSd4U2SPN8e8rEvqbHC87sBVpphKC4B00v6hvbFebZqwabDzWR4CENiHWwVQkidNH4kHj0sGi8V0upAo9riOYNb7jnu1AQO6p80Yl6rqR50CYknos+/Y9o0rHZRlOejbH9ZpLs4dJ8zcMe7uQBtbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B9hQH3va; arc=none smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B9hQH3va"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789626286; x=1821162286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qT+cSvgxR/drCHZE3qZtKVtSgJX/veG+thk2cR/IrnE=;
  b=B9hQH3vaHDZbMt8HwlnghWIzmF2oT9oxp5vovijtfotAJHudkBY5lK64
   cXAaFv9w5ZtqDwIW1fdcWL0yfCxYU0jZgveExqLRpwKZ1fUApjYugInZ3
   lSEju+ymhZXbNZUbEl/plCd66Q3L3JrXBHY3+CYEk9OXmWDJG64IkccIo
   10GjYj9BJGM9QjZvGPqI7uUYV07zeHgEK6RENpk4QsgYS1fApzl3dfjYY
   TmxI9IqzGnNN2eHhCgQPcMU1OOEleTjjjVnFyJORotCLLhIcXcbcu8qNu
   daK1HmdBBSGB6S+SJDzGdcjZnbBT7WKH79VnctT/W982+IDsYr5EthMmY
   Q==;
X-CSE-ConnectionGUID: Dm5ZTCMxRzKyaWFUkNH6kw==
X-CSE-MsgGUID: NSwpQKydTYehtsz5wwI3eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="521666"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="521666"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 23:24:11 -0700
X-CSE-ConnectionGUID: qhUQHYQJTCqSbjz7LP9MMQ==
X-CSE-MsgGUID: C0p1b/cgTB2SPYyn8EQStA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270954024"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.11])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 23:24:02 -0700
Date: Thu, 17 Sep 2026 09:23:59 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
Cc: linux-i3c@lists.infradead.org, alexandre.belloni@bootlin.com,
	vitor.soares@toradex.com, samagazaryan@google.com,
	gregkh@linuxfoundation.org, arnd@arndb.de,
	boris.brezillon@collabora.com,
	oleksandr.shulzhenko.viktorovych@intel.com,
	tgopinath@linux.microsoft.com, corbet@lwn.net,
	skhan@linuxfoundation.org, linux@roeck-us.net, Frank.Li@nxp.com,
	jorge.marques@analog.com, pgaj@cadence.com,
	wsa+renesas@sang-engineering.com, tommaso.merciai.xr@bp.renesas.com,
	nuno.sa@analog.com, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, andy@kernel.org, lorenzo@kernel.org,
	enelsonmoore@gmail.com, rppt@kernel.org, pratyush@kernel.org,
	giovanni.cabiddu@intel.com, gabewhigham@gmail.com,
	haren@linux.ibm.com, pasha.tatashin@soleen.com,
	jirislaby@kernel.org, adrian.ho.yin.ng@altera.com,
	ustc.gu@gmail.com, jszhang@kernel.org, adrian.hunter@intel.com,
	akhilrajeev@nvidia.com, tze.yee.ng@altera.com,
	manikanta.guntupalli@amd.com, shubhrajyoti.datta@amd.com,
	jarkko.nikula@linux.intel.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/3] I3C character device driver using driver_override
Message-ID: <aquHf5yuubnCvgHT@ashevche-desk.local>
References: <20260911210935.1353126-1-meaganlloyd@linux.microsoft.com>
 <aqVTBIKRP3iRDCvf@ashevche-desk.local>
 <20260916-8a117e874c96753fd704b163@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-8a117e874c96753fd704b163@linux.microsoft.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 16, 2026 at 12:28:57PM -0700, Meagan Lloyd wrote:
> On Sat, Sep 12, 2026 at 04:26:28PM +0300, Andy Shevchenko wrote:
> > On Fri, Sep 11, 2026 at 02:09:32PM -0700, Meagan Lloyd wrote:
> > > This is a rework and revival option for Vitor Soares' I3C character
> > > device driver patch series from 2020 [1] that I've been exploring for a
> > > few months.  Recently there was a revival posted to the list [2], so I
> > > wanted to share this design option as well.
> > > 
> > > In [1] and [2], the i3cdev driver automatically attaches and detaches
> > > depending whether another driver has attached/not. In [1], Boris was
> > > suggesting we explore a more straightforward and traditional binding
> > > method aligning with the Linux driver model. At the time, there wasn't
> > > a way to auto-bind while keeping manual binding possible as they shared
> > > the same match() hook. Now with the new driver_override feature,
> > 
> > Where is it new? It's quite an old mechanism in the driver core...
> 
> My understanding is that this support was added in March 2026 here:
> https://lore.kernel.org/all/20260303115720.48783-1-dakr@kernel.org/

> Some busses had their own version of this, but the above series made
> a general, re-usable solution available.

Nope, the series fixes the bug and at the same time refactored to provide a
generalised solution. The driver_override as a concept exists for ages.

> > > the auto-binding of i3cdev on boot can be avoided if the i3cdev driver has
> > > an empty match ID table. After boot, where specialized drivers would have
> > > already bound, user-space can explicitly opt-in by setting the
> > > driver_override sysfs file with 'i3cdev' and manually binding via sysfs
> > > (or by simply loading the driver if it's loadable). This can also be
> > > easily automated with udev rules that run whenever the I3C core exposes
> > > a new device.

> > > One downside of the automatic attach/de-attach is that if a different
> > > driver is loaded later, the first driver could have altered something
> > > on the device, breaking any assumptions of the subsequent driver.

...

> > > Note that i3c-tools [3] or a fork of it will need small updates:
> > > 1. Update include/uapi/linux/i3c/i3cdev.h to match updated uapi structs
> > > 2. In i3ctransfer.c, use actual_len for reads
> > 
> > > I've added MODULE_VERSION("1.0.0") in the i3cdev driver, so i3c-tools
> > > could use that to determine whether to use the old out-of-tree uapi or this one.
> > 
> > Absolutely no. This is legacy macro which has no need since Git era. In Git
> > the module version is the Git SHA hash of the tip of the used tree. Nobody will
> > understand what 1.0.0 means and how it maps to the applied patches (if any of
> > them affects the behaviour of the feature in question).
> > 
> > On top of that, upstream has no clue what and how many possible custom ABIs /
> > UAPIs exists, and we do not care, to be honest.
> > 
> > > [1] https://lore.kernel.org/linux-i3c/cover.1582069402.git.vitor.soares@synopsys.com/
> > > [2] https://lore.kernel.org/linux-i3c/ap_1-gFF7S821xJT@ninjato/T/#m9107c1785a4a16b1b3cb84c3269d17fac35819c8
> > > [3] https://github.com/vitor-soares-snps/i3c-tools

> My reasoning was that i3c-tools has been around for years now and it may
> be in-use assuming the UAPI from [1]. Adding MODULE_VERSION was a low
> effort, compatible, and

> reliable way

Nope, you are mistaken. As I explained the opaque 1.0.0 means nothing. The Git
SHA *is* the version of the code in question.

> to keep using the same i3c-tools
> repo (and accommodate a changed UAPI).
> 
> In any case, in Sam's thread [2], there is talk of moving i3c-tools into
> the kernel's tools directory. That's the better solution, so I can drop
> the MODULE_VERSION in future revisions.

This is really orthogonal. But yes, keeping tools at the kernel source tree
makes sense for a better maintenance.

-- 
With Best Regards,
Andy Shevchenko


