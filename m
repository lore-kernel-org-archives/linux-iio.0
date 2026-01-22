Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD9F35CB8D;
	Thu, 22 Jan 2026 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094765; cv=none; b=lVYIQN2Esj97XM+Y1N8yyQi9Eu3UhJAa3RneMhp1l6szhWaeM3e3A9Zf9VGWZ+j7x3uYzTAUbwXflizP7Mzhiz5tivggO0KCYo/8IGhYvx6M4QjT+/X4TFt1rCTessLMwrbBupGlo6teXpCOPA1qJi5c9ya0uIyh2CNZlFOQjfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094765; c=relaxed/simple;
	bh=NyE/Zs32hysP0oKKyEIi4lwN3RgH2YJlwyVxOrO1Y0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+FSuH2PngevuFEO2kmY3y/AfSwF6UrygIK4lO/zx17eUvNSgfRj8Sf7k8IOfcBjIgDs8a6ULOHIotNYDPFyn0e+3ALrzD6mdeojn2/YaO7fmcqTwcV/dzKWShggae+vuxy64pQLAl1sNPZGvwsEyTM55Lb0zDQZgh9SWG4l5+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=fail smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cAmEXKHt; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cAmEXKHt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769094763; x=1800630763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NyE/Zs32hysP0oKKyEIi4lwN3RgH2YJlwyVxOrO1Y0c=;
  b=cAmEXKHti6z3C0ZLDRV/y7u+o5g0DFymUc82/UPupgYrSvPbbARqNEMu
   qxo6RLrjYeDU6ztemvkdo0JJE8WKBcbKkJD1kuhFbjNLtq9ZKiKqD9tyL
   dKQ/aBmfVMFQsPI9v7R30AjCfoXJsCiCY0bUtr74Fo8INNxrmy6Jj8pWp
   kIpFA4VynVC5AdBrTZ90BEL4yM90gde9se2evXOB57jwGKX65gyxMhNSl
   dkCFxNQrf1ae3LbuDZDH7a455s+LOva1BO2pm1b9ixjtxtiVjs4PFrERN
   A8FyBB7vOP/7I9ZEFL67isQfUiCjw586gwVWGGjrC1nVFg3feF9Sxqhhz
   w==;
X-CSE-ConnectionGUID: 5DVVBIJuSz6rFFqVebyldw==
X-CSE-MsgGUID: KRzvtYI1S+iD65tq9rf7pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70504232"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="70504232"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 07:12:42 -0800
X-CSE-ConnectionGUID: VqESu723TdOGf+LL2OJuSg==
X-CSE-MsgGUID: oyMLHdq5QeK2TBJGEF2p+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="211614282"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 07:12:39 -0800
Date: Thu, 22 Jan 2026 17:12:37 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: impedance-analyzer: ad5933: use div64_ul()
 instead of do_div()
Message-ID: <aXI-ZV4uAd5GyFLz@smile.fi.intel.com>
References: <20260122145633.14938-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122145633.14938-1-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 22, 2026 at 08:26:33PM +0530, Archit Anant wrote:
> Replace do_div() with div64_ul() since the remainder is not used.
> div64_ul() is the preferred API for 64-bit by 32-bit division when
> only the quotient is needed, as it returns the result directly rather
> than modifying the dividend in-place.
> 
> Issue identified by coccicheck using do_div.cocci.

...

> -	freqreg = (u64)freq * (u64)(1 << 27);
> -	do_div(freqreg, st->mclk_hz / 4);
> +	freqreg = div64_ul((u64)freq * (u64)(1 << 27),
> +			   st->mclk_hz / 4);

It can be one line to begin with.
Then drop that ugly castings and explicit big shifts.

	freqreg = div64_ul(BIT_ULL(27) * freq, st->mclk_hz / 4);

Now you can see That 4 is only 2 bits, so this can be written in
simpler way:

	freqreg = div64_ul(BIT_ULL(29) * freq, st->mclk_hz);

which may give a better precision at the end of the day.

-- 
With Best Regards,
Andy Shevchenko


