Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8368938E119;
	Mon,  6 Apr 2026 17:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775496263; cv=none; b=FORfcuTJ9fAUk863ydXhFknb7fnVPf2oDkNKMewSSXDgwXyCt5AA2rIqDO1mGFlxpZe9AboLve9PlxFgQFFvuamyauMSjZe1lR2hFsIQGOo3FwEj8FENokvmNk4EFthm0DGJZKbE52V22gmW+pmQUbK8z0NQZwmLLROSB25QXko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775496263; c=relaxed/simple;
	bh=pnNeFKB4W8R2YW5TrU1RMLrxD9/0EXaR6Tm7ufhU/Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvjdDMKdSPuULgy8o0T7AdR7WJ8zd6+Hf5Gb4ONDDqEM+775GdlzaSNll7HwgCowWMh2CYunxVEV9fmNIjOJksgoLcET98K0EebRKu/J9BEh6fkU509zmMxslmsExSMsbsdOtzmmZ73NH/1svHL16TO9I5euPDy3jwx7kAh8r2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GSbmn2qz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GSbmn2qz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775496261; x=1807032261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pnNeFKB4W8R2YW5TrU1RMLrxD9/0EXaR6Tm7ufhU/Bk=;
  b=GSbmn2qzBGSCLYXXeBrwNMZRBMkBpT/8W7ODFbRCC3q4GTmBIGi0yzQg
   C0BLHsYga3a37LzqOVr8V9Wz+BvYyouwfwP0gotMDvEhKmangGTUqiO0R
   N86MG0++n8R6OsxJm/WeoGi2M32Bl7BtIMKj83YdXCP32cioCa6Zsx77p
   RD89Vj7Q1yh3UV/TxbF+EtZ2GjoDdePC5iUTaTLwDa4hCnxs6GeNot/O7
   Rb8wDakqV0nqt0W2Pds8Goa4rmJ0u7VXa1QG1E6IcVsc8LhMOGu2gmdQI
   4W8xP0PQzDBiKQTC/uOuck7av2n9PfXzwnT1i+fSznEdEiMEVNaMVmx2o
   A==;
X-CSE-ConnectionGUID: /dkFlfc+Tx6+mzrn8GJT+Q==
X-CSE-MsgGUID: FiUq1wGwQgOhLLBga4rNRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="75489909"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="75489909"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 10:24:21 -0700
X-CSE-ConnectionGUID: YfaSJIAOTdGEMcln251LFg==
X-CSE-MsgGUID: 9PNhf2jaTq65TlO42Zc1Sg==
X-ExtLoop1: 1
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.73])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 10:24:18 -0700
Date: Mon, 6 Apr 2026 20:24:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: jic23@kernel.org, ktsai@capellamicro.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, daniel.baluta@intel.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, me@brighamcampbell.com,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2 2/2] iio: light: cm3323: use dev_err_probe() in probe
 path
Message-ID: <adPr4AagFaHfuoOf@ashevche-desk.local>
References: <20260404205853.18559-1-aldocontelk@gmail.com>
 <20260404205853.18559-3-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260404205853.18559-3-aldocontelk@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Apr 04, 2026 at 10:58:52PM +0200, Aldo Conte wrote:
> Replace dev_err() calls with dev_err_probe() in cm3323_init() and
> cm3323_probe(). cm3323_init() is called by cm3323_probe(),  so using
> dev_err_probe() ensures that deferred probing is handled
> correctly and simplifies error paths.
> 
> Remove the redundant error message in cm3323_probe().
> 
> Tested on a Raspberry Pi 3B using i2c-stub. The driver probes
> successfully and successfully read integration_time after this change.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
assuming the comment from David is being addressed.

-- 
With Best Regards,
Andy Shevchenko


