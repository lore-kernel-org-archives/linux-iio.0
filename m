Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CB833ADB3;
	Mon, 11 May 2026 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505706; cv=none; b=P93DO63IkY9apEDo/wbaQD8Bbu5n33Epvf0DHpz4RVYaCuQvs7vd1jBEPMDWz4Vaf4WoNLVOHfxDnN/MEtYB/k+luRAwr3QVxt+rLpCgS/J7miVCc4Q+qlAmxH3W+k257Px091yKL/rbJ9JvYYbL/681cRbwpgvBv71Np1srJ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505706; c=relaxed/simple;
	bh=LPTvON3rDRQpU5yC6nAIdn+3yp8410x6hztIvGimaGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pI0RCqPrHkm2qxuHZmSfWZUnqqu+TosLG0lTDJi5xb4ipf74vpe8iBm2JErmPKbxetOR4o5BUJvGv9nSzrOJQNcvLfEstLHezmP1F0JADQ0BuAltY9SiyJGonEdsuMyI4Z/JSr1zwvjGvyMxA9ENXhkuG5Fy2htmLU1F2/ihJsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EQCCp5Y1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EQCCp5Y1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778505705; x=1810041705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LPTvON3rDRQpU5yC6nAIdn+3yp8410x6hztIvGimaGI=;
  b=EQCCp5Y1s7wJaRN83L1ehbaNtsre+jMK9qsGc2bFB/w7tfngBUt+/YFM
   y9l6uTp6ybXN2xFCZ+46xf/YXZR+6cQNJf6Ruzvs/ZW2SsdorljZ7HcQC
   XH1cC93KKJA2d3mFQdiGB3c6lToFFvnw9RWgUqSly3W7Y+aIKS517kX1T
   oclJZg853d0jy3rsvNqdExEspXXEcR6QUgCECef6QgIxm+1ieB/bXBy1T
   f6Eu61tEOscM/0EQPym7uVrExZIUGCFvycmXQ1GqjUZ3/ayRjdtgfsVZg
   trjzDyQhFe/OC5co3ywj+5Rky95CZujwuauc8/j4Yu19sk9fGapQsOVCg
   w==;
X-CSE-ConnectionGUID: Srn4QD4qT1GLUe4Hev2ZCA==
X-CSE-MsgGUID: jZGlHLbDQdCZ7O+1U6PNhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79493840"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79493840"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 06:21:44 -0700
X-CSE-ConnectionGUID: flMRwKnyQ32qNTxxxeYePA==
X-CSE-MsgGUID: 1eKbCSUVSS6OUohQnfwYBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="237406971"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 06:21:43 -0700
Date: Mon, 11 May 2026 16:21:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7793: replace usleep_range() with fsleep()
Message-ID: <agHX4-C5xlBqTK-y@ashevche-desk.local>
References: <20260511053043.229-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511053043.229-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 10:30:43AM +0500, Stepan Ionichev wrote:
> The AD7792/AD7793 datasheet (Rev. B, page 25, RESET section)
> says: "When a reset is initiated, the user must allow a period
> of 500 us before accessing any of the on-chip registers."
> 
> Use fsleep(500) instead of usleep_range(500, 2000). The 500 us
> minimum stays the same; fsleep() picks the upper slack itself
> (about +25% on a default config -- narrower than the original
> 2000 us).

> Add a code comment with the datasheet reference so the "why"
> of the wait is visible at the call site.

Unneeded detail in the commit message (it more appropriate
to have this in the comment block, below '---' line). Up to
Jonathan what to do with it.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


