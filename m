Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF60330FC26
	for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2026 18:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773858162; cv=none; b=ljG+Bof7SHM5N4FDxAQ8Bysd+7WmR0bsyfJikds2DFpexulLi/hl9nhk1cfi7neI4XW/OaXu17c14EfLAagKKt/dQzxp6Y6wFBFv3bQJ3aHM6U5hHrVBDmdYSJ3UDpYT52RJiFd5AGV0N5iessFCQwk2l37xW9HYWv6qC4Vyrcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773858162; c=relaxed/simple;
	bh=qldq4DYPTaIokcMX4KdTJD9X8TXntbakR+sfWm3Gn2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBru2vA5EEnILHi27hOUgrNUrb2npcLQgZ78FXPbA49hVLHiPzL8/AWP3i2qlJdAyWdlz1E73cg7rsOqb8hILWd2ptsmMMbJYVbzKlGhZem74hWwEAPRxxz/FdmY3b7Behc/q1Dkz7SFUj8+KTEeVsihy2yLmkLd55Sk1J6Z3s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hmlrd1ZA; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hmlrd1ZA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773858161; x=1805394161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qldq4DYPTaIokcMX4KdTJD9X8TXntbakR+sfWm3Gn2Q=;
  b=Hmlrd1ZAEqnjAcJqyU6gCivLjiFbN2Jb1qNnEwz8FbKzKP687q+Ch4Hh
   KuTlNQSmuUoushKlA5U7lQWPukiuZNpdQFg92t/4j392oOyL21VWMCxUI
   IDY8Kevk3wCQ7HttHPfrzQlWOXbg1PCadRVTpOtL8NQK6RlOAVUQgBZBV
   pyScpU5Hf3/eKaAY1FOs6XZq0q8Tjj5KjZdgO8E7pUTltRMZhIa5Vrwk0
   c2VHkPrYw2fcT0TGVjatcxVX7k8WyRwNaxzh5I4BMGcwXYYbyGcva/MoL
   VljHw3Y8YN+kpK7fKNslEH85vFN3JdQZtAanqmCKnRZKKZo4q5pK5Kax6
   A==;
X-CSE-ConnectionGUID: ovA2638LQxqnGRPk0UKeDw==
X-CSE-MsgGUID: e0j9XI8GT0CuxFp1zPYopw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85240806"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85240806"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 11:22:41 -0700
X-CSE-ConnectionGUID: lfDnVguCSTu6DosLZRQQ4A==
X-CSE-MsgGUID: hXXd+IQ6SCq/yd9PFyqsnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="222762333"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.240])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 11:22:38 -0700
Date: Wed, 18 Mar 2026 20:22:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Bhargav Joshi <rougueprince47@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH] iio: frequency: ad9523: check return value of
 ad9523_io_update()
Message-ID: <abrta3uIg32sY6oF@ashevche-desk.local>
References: <20260317232552.28485-1-rougueprince47@gmail.com>
 <abpd4Y88DhBlr0Cj@ashevche-desk.local>
 <CAPC4XCQkOTOtEOAfnQeVajczX0cRVbWpPU3+F1hoZwiqBqAweg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPC4XCQkOTOtEOAfnQeVajczX0cRVbWpPU3+F1hoZwiqBqAweg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 18, 2026 at 08:59:09PM +0530, Bhargav Joshi wrote:
> On Wed, Mar 18, 2026 at 1:40 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Wed, Mar 18, 2026 at 04:55:52AM +0530, Bhargav Joshi wrote:

...

> > So, now the errors that were non-fatal become fatal. Is it a problem from
> > functional behaviour point of view? How did you test this?
> 
> Regarding errors become fatal, is true for function ad9523_sync()
> because even if error occurred it clears the sync bit and calls second
> io_update anyways so returning early here would make it worse, Apologies
> for this oversight on my part.
> 
> However for the  ad9523_write_raw() and ad9523_reg_access()
> ad9523_io_update() is the last step and Returning the error in these
> cases seems strictly correct to prevent silently ignoring I/O failures
> and returning false success to user-space regarding the active
> configuration.
> 
> Regarding testing: I do not have access to the physical hardware, so the
> patch is compile-tested only.
> 
> Would you like to send me v2 with dropping ad9523_sync() changes and
> keeping the other two or just drop the whole patch?

Don't be in a hurry. Let's wait for others to comment. We have ADI people here,
they might chime in and may be even help with testing if they consider the changes
valuable.

-- 
With Best Regards,
Andy Shevchenko


