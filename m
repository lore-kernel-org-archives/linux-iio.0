Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB0D305E32;
	Wed,  6 May 2026 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778059884; cv=none; b=rJFrqw0NRIYWy8Ti2o7IfpvNe+qpztlC4ate4wSuc6pjq0LVl50xWrXcsYfPlvtBJ7qJYYnjqHd5d1EDRYgywqpmWlNTX38trwhcMJB9zu2xKwfDKliME85y1yz1azErwrMBZe00nMZb93u77UoZ7C1btmbjsQp/s5mLmirqH8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778059884; c=relaxed/simple;
	bh=9wr2b02Cbf3eEETM8Y4lth12whGyempgcHAvwNt2akc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEbMOJGhlvJuGSZVy4hLhBfGyEfMgh7UK69eDFuKNMRtOL8QrbCYSSh2PTKXIUAjmvVeBakxDbGSFPLE/Mk2Vt1V93B33E00JqmZgns/oWCvrI8pQqQIWiO0nXSTIJJ1P386tGPKEytMxM8Pz/ChIcRvkI6gXSuvlxKh8vdYYRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GiPnRvqu; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GiPnRvqu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778059883; x=1809595883;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9wr2b02Cbf3eEETM8Y4lth12whGyempgcHAvwNt2akc=;
  b=GiPnRvqu8ZRDaKTThvDCdEBKRbLhE9P4rAP556aTmxSWaMsMaWQx0f8f
   +sAG1bA0AKBbz3bFmrcPxy9tw9g3sakI/H1oS5UJjyDQP3LNStbMFca5u
   NBG+fmnuUP0fKx8VOjbYwBDaUhgUE63fbmFfvO1JB8/sKlA5BUlRPV56f
   eY+F+YRYvoTQzvs7mCgwjf5tR23+5LZ9g9El/wimzhbeWa7yTZ5DnqUqH
   8/j0k63dHklmF1MCOovkt7cYS+8CrFTkQICUrXJ4nZWEgCb7f2vf5QIl4
   v0RtA8+yvQWfaA07o3XDSHvcSmPZe6Vv9lJ4nUZnO3v3vgjrHX6abbTdd
   w==;
X-CSE-ConnectionGUID: SuQA6QkWQWCVZgN2XUBVkA==
X-CSE-MsgGUID: 5f5aqP50QKeKsnds9RpyyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="90442078"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="90442078"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 02:31:23 -0700
X-CSE-ConnectionGUID: pPogSlOoR+WUxBjsYdMtPg==
X-CSE-MsgGUID: EEM7SOjNQdmUJMuDti4Y3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="236191061"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 02:31:21 -0700
Date: Wed, 6 May 2026 12:31:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, sakari.ailus@linux.intel.com,
	christoph.muellner@theobroma-systems.com, martink@posteo.de,
	mfuzzey@parkeon.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/10] iio: accel: mma8452: convert to bulk regulator
 usage
Message-ID: <afsKZjvG2EGy3p1j@ashevche-desk.local>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
 <20260505174640.3998281-7-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505174640.3998281-7-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 11:16:36PM +0530, Sanjay Chitroda wrote:

> The "vdd" and "vddio" regulators are always controlled together. Switch
> to the regulator bulk API to handle setup, enable, and disable paths in
> a single call.
> 
> No functional change intended.

...

> struct mma8452_data {

>  	u8 data_cfg;
>  	const struct mma_chip_info *chip_info;
>  	int sleep_val;
> -	struct regulator *vdd_reg;
> -	struct regulator *vddio_reg;
> +	struct regulator_bulk_data regs[2];

When touching data structures, always confirm with `pahole` that the chosen
layout suits well. You can also consider doing another patch to rearrange
the members for that. But be careful about the code generation, rearrange of
such a data needs confirmation from both `pahole` and `bloat-o-meter`.

-- 
With Best Regards,
Andy Shevchenko


