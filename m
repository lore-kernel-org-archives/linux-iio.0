Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E9B1D0DEE;
	Tue, 14 Apr 2026 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776160787; cv=none; b=N9q/9wYbS/c31WxJpkjApo8saUyYEcDZokcwVRdh12xpWubFbzoSMBUmV/2Mc6W1LWM/4HGxmpHq1HD2exjcvKylLMAhv/iIlvIoLdcfh5auObB99WS4N3NObH97eoY0o3e7quO52luNzSVVkqaZgJXPD/aFYDfCeNoHtgppxr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776160787; c=relaxed/simple;
	bh=qRPEBhalGWr8kNJiRCc9zLBNMbRd/H4Z0wQVLL836OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOEwYEhK21zrcsicTED3G8UUe3/TPn8w/QzwEecHCIaulTq9349B3QhQFLaigKYXbn5om7mvqY6HGdFvXwDoUgnKq42+2fQI+KH8XfJWsPksB+toIl30pWY2F5zH4T4IqxEaq3d9/EyrhLNyNEtE7EBCvxX5v9hqCZp50d8g4xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mt/WbNNt; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mt/WbNNt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776160786; x=1807696786;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qRPEBhalGWr8kNJiRCc9zLBNMbRd/H4Z0wQVLL836OU=;
  b=mt/WbNNtyna7N0CaUB9Ocmf8do9iC9v/7dwj5316DaLKlLFuIYxdv1rz
   FYJfZgw+HfAfWY+cgnVmhUy1uyjlOafEMb/TgJkZyueUZ4OAYrTrnm5Zq
   p6zuQ07cEeBVZLWoWSwNVgxt+3Y3Zb2o4jeiG1lS10ynTFedHcit03PvN
   XPR1pbzAs6VwdZSrjfLVdHaoM8kDOpD2mwVt9HFZtXbmQ+ez90vKzLess
   5V2A1Go4pgR2/FJF6RbHIDKEthgLAgtNvmCrrL2B3g7IYQx4iBxwHasV/
   Tf8yvdQe0ma91D0ryRjCriyt+FHVnp/Xn/IEfghYs7m0nomAjmeW1UE6M
   g==;
X-CSE-ConnectionGUID: FZDVBUh/SWyjThUwOaKRsw==
X-CSE-MsgGUID: MjiIBgCMTUu1TldGqsJA/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="94513096"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="94513096"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 02:59:46 -0700
X-CSE-ConnectionGUID: qb4AwUhCQG+84uKuzu9j0Q==
X-CSE-MsgGUID: O9SuEDRLSNeCusHJ7FV3pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="227390843"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 02:59:43 -0700
Date: Tue, 14 Apr 2026 12:59:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Cc: Salih Erim <salih.erim@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: adc: xilinx-ams: use guard(mutex) for automatic
 locking
Message-ID: <ad4QDZ47hUuOHLlJ@ashevche-desk.local>
References: <20260414093018.7153-1-guilherme.bozi@usp.br>
 <20260414093018.7153-3-guilherme.bozi@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414093018.7153-3-guilherme.bozi@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 14, 2026 at 06:29:29AM -0300, Guilherme Ivo Bozi wrote:
> Replace open-coded mutex_lock()/mutex_unlock() pairs with
> guard(mutex) to simplify locking and ensure proper unlock on
> all control flow paths.
> 
> This removes explicit unlock handling, reduces boilerplate,
> and avoids potential mistakes in error paths while keeping
> the behavior unchanged.

OK.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


