Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC727368946;
	Wed, 22 Apr 2026 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874810; cv=none; b=OW7W8h0CsStK/sG4GJPlBqrJPPkt/1Hpg/HAlO0fMCSvboR9e5H/LAShxGqDD8OvFGgUI1tIIADDNaKF2dOctIzIbPmjm/Ysj5E6MnFhy29A4BAmjuyjyNNgDkAUwU6Ly6Wxn2KL3cWsNjJwTWwO5u9vZKG9q60kHuFz6eA3hKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874810; c=relaxed/simple;
	bh=EqsqqGL4rJFfCh7PF45bdBP753CjN5VeDqJbLdDynSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrhgKnEo3CNmCRU4rDtrLaivQdQsuuZ1yMLXjlaLFpog0g123y7hEbdgluGv+wchVa3W/KznJDStiPq23BpvzWeCepOu/G4iTq3msmh/LpnAA0NNxwCMNsjQ8Jdw+Sofh7VymYL6O0H5zPwYw97FPKI0Nhu7ZRgHNMGTMQCNSu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PrKDAC0f; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PrKDAC0f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776874809; x=1808410809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EqsqqGL4rJFfCh7PF45bdBP753CjN5VeDqJbLdDynSI=;
  b=PrKDAC0fT/C9QtsE+9iEmSWGN32munnerMBnz80ne0uZc19ArOE6QJo9
   UJ/F3n3YecGUX3qFItNsCaqGsEso/Fs12Aj6KKcDdccCplamkm+xx9mdj
   tfK+Dekch2W5sqbUXz6f2kmXY6h+BZXUxgBaJ4+x+gTtSsjLpSjovIrce
   3/kR63D4bYRTTFuWrAS68lpFqcYroE43D8nBN8OJ/sRILCaItr23xYXhB
   yicvtTK5gIlNgmaMHX/N66YPXABdmpXxsnU3vgUayXi2Cywy3reE44/Wz
   9igGHVrvgi4YlXBb8S/bjEG1zFvkQzhRJ/tFdJqtGJSBvC/wavOayPcfZ
   Q==;
X-CSE-ConnectionGUID: tNUzAMD2QBKFiBGcgp1kcg==
X-CSE-MsgGUID: mki+kCC6RcWiqW9T3WrbSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="80419579"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="80419579"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 09:20:06 -0700
X-CSE-ConnectionGUID: w47YyujJTwmoGbT94S5Ptg==
X-CSE-MsgGUID: S1cadY1hRcG3oHUWI+p+WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="232306705"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 09:20:04 -0700
Date: Wed, 22 Apr 2026 19:20:01 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7625: fix type mismatch in clamp() macro
Message-ID: <aej1MTgpzToqxOXD@ashevche-desk.local>
References: <20260422142541.160365-2-giorgitchankvetadze1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422142541.160365-2-giorgitchankvetadze1997@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 06:25:42PM +0400, Giorgi Tchankvetadze wrote:
> Smatch reports a type mismatch warning in ad7625_set_sampling_freq()
> where the clamp() macro is evaluating differing types:
> - `target` is a u32
> - `100` evaluates as a signed int
> - `10 * KILO` evaluates as an unsigned long (due to KILO being 1000UL)

> Replace clamp() with clamp_t(u32, ...) to explicitly cast the bounds
> to match the u32 target variable.

No. Try to avoid as much as possible use of _t variants of max(), clamp(),
and min() (the list is sorted from the least critical to the most),

Also we have constant multipliers for frequency in units.h.

-- 
With Best Regards,
Andy Shevchenko


