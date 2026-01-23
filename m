Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976EC201113;
	Fri, 23 Jan 2026 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769178937; cv=none; b=QqjnDe0GSNC4RJ6QVTsMK3ugTWsymcv+vCf70T1H7FDXUt2Xb8ybYtr570MBG8OBvsT4/UEoF+qTZCU+f7RUoVi/HN3+dhW7JXFB+w2x/xuoGaZCxrS6qASqP90tXzNTfcwIRHTpPlZQf9j6LjpdfjRxjBc188cQMGnf6ZbdL7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769178937; c=relaxed/simple;
	bh=jjVZNMbXtDNCqUkpyyw0tc0yzNVL/TJiZd9tqUGscqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIQndB+G+EigDwPqaPdURepUqy9YMguvnA9+dEPaCS4wjnCOzshNXkuyYDlhCSefQUpkahGFMo5io7h0gqwRYngweWtptuRyDLiibqxcVXth2uJmqXQmOm/FjZXdS/x1AfgAkxVj9LsVjaEH0YlrjIue/CbFIdUjkXdanqO3ozE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I3USUZQ3; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I3USUZQ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769178937; x=1800714937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jjVZNMbXtDNCqUkpyyw0tc0yzNVL/TJiZd9tqUGscqY=;
  b=I3USUZQ3Fg8XCJSJ7t4jzKbQmVqjMZQJzK4HG8D9Ur/malYTp/SQ3QAW
   EXxx/ZAIQsEA6v9fzgiqDHiU5O8Ypsi//S6PoL8P6JYoOpR3I20gBSHxn
   kQOK9y8eZdiPhSF/DjQq841FcWK8wW3+e9QdBodeeCAERYmpvGRdeomuC
   JBreonZUpXjAvaD0B6wIv32vclgTwLx1cGQ8xe/qdIZBWcAV4KSYRZIRh
   3W1ZTs75OleeDKN0FThYKbEOWpGW+KKvUyJAZtS73kxMaoe3Oic3wPMwz
   LegikrSukmYooFQjg7aV2pW74jFZD2KQHiF+m4WGvaMpS9Kh17gCGJFoJ
   A==;
X-CSE-ConnectionGUID: WQERexPaRHKCKHZn73Z9NQ==
X-CSE-MsgGUID: lNvbd5L7R/mVV/ZZ2Eu+zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="81543173"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="81543173"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 06:35:36 -0800
X-CSE-ConnectionGUID: nCnHVZr1RsyLQzWSkZJ5Ag==
X-CSE-MsgGUID: 8Eb73Bx0TQWxGr1xM4HK7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="211911149"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 06:35:33 -0800
Date: Fri, 23 Jan 2026 16:35:31 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio:frequency:adf4377: Fix duplicated soft reset mask
Message-ID: <aXOHMyN3_lFsoYLM@smile.fi.intel.com>
References: <20260123115618.403644-1-suunj1331@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123115618.403644-1-suunj1331@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 08:56:18PM +0900, SeungJu Cheon wrote:
> The regmap_read_poll_timeout() uses ADF4377_0000_SOFT_RESET_R_MSK
> twice instead of checking both SOFT_RESET_MSK (bit 0) and
> SOFT_RESET_R_MSK (bit 7). This causes an incomplete reset status check.

Yes, but this commit message completely ignored discussion
https://lore.kernel.org/linux-iio/20251230123609.210454-1-suunj1331@gmail.com/
So it should have summarised the question and answer.

Also this one mistakenly marked v2.

-- 
With Best Regards,
Andy Shevchenko


