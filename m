Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF8D315793;
	Fri, 20 Feb 2026 07:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771572093; cv=none; b=QXQj3czLmScpOtXPRSFoGvEr1dlP6Pn0mB6Kcbo8rycu06Nt3BfcaK9k6tvWyXpWdk/Jyb+uz7GbiW4xI37UklFVN8UN9keQqWuXnqbT7CO9VI0Xf/BI1nShEWxLMuHvXU5MA+vNgwfB5w7WTq2C4/7r7ZWExYeWkUvj5YMez5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771572093; c=relaxed/simple;
	bh=9gcazFXTVF4sBUiUSmMa3K5MHz4pjmxa+L7eySUKYSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8t+UruvcaXJzOdA6TY06zRXZZEEMxprvtKVj06mi1q7ClRTayFKm+IIxxTccDmJz/xskxkVwXBBNc+JSZA2S2mO25cmJww4gsIKV2Vv9Hf4fRUnNGUJHV+L+v9znNcqqCCV03dj/IqAsiGXr6Nbsjf6Ga59e8vf2Ia8FUrW19Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fajKgt8B; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fajKgt8B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771572091; x=1803108091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9gcazFXTVF4sBUiUSmMa3K5MHz4pjmxa+L7eySUKYSM=;
  b=fajKgt8BjreG1nmLueDGwbVm4fhDy+RZ+p0x3gjQrfk4/TMWshJ6/Bqh
   cUPGzg6hFWY1W1v+LBhRvSi80TBIk0+AHNUHwSmbDd8T5ooSqzGWNyJ9k
   KO7OD7MMKhmLFt9gmChp6maGCJQaKl3cwXRDRdbKP4VL5K9w5AWV/Xw+4
   1fregqVp2Osyze5akUch6DdhEQ/RgA6U9pP34fco+4mcTAuJHmX63xPwz
   evodgQF5XH1V6w4bWn9eBOKJNpUZ/N35PLxLy40X7EbAbgw5SRfljTGo/
   aIYksUVKxrzT6bWTxebuBhck8fD+RY+3+jWlKB5BHOqfugRCFya3TAjWx
   g==;
X-CSE-ConnectionGUID: hbBxJ4qCQH2HOqxIuDdZ2g==
X-CSE-MsgGUID: E1o9AkznTlaZyvDqxXZiiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72727415"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="72727415"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 23:21:31 -0800
X-CSE-ConnectionGUID: XnU+KwIXTgynk3j13F3FEw==
X-CSE-MsgGUID: w9nALqf2QTGxiu4Grr8YHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="219785007"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 23:21:28 -0800
Date: Fri, 20 Feb 2026 09:21:26 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: bhargav <rougueprince47@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: frequency: ad9523: fix implicit variable
 usage in macros
Message-ID: <aZgLdlTcua4jC0NN@smile.fi.intel.com>
References: <aZd2jAVnTIuz2o7h@smile.fi.intel.com>
 <20260219213549.59645-1-rougueprince47@gmail.com>
 <20260219213549.59645-2-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219213549.59645-2-rougueprince47@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 03:05:47AM +0530, bhargav wrote:
> macros AD9523_CLK_DIST_DIV_PHASE_REV(x) and

The macros

> AD9523_CLK_DIST_DIV_REV(x) implicitly relied on variable
> named 'ret' instead of using passed argument '(x)'.
> 
> Update the macros to explicitly
> use the argument '(x)' for their operations.

Something with wrapping of the lines, use up to ~72 characters per line.

> This also resolves the following checkpatch.pl warning:
> WARNING: Argument '(x)' is not used in function-like macro

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


