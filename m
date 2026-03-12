Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69383B52F1
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 09:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773308178; cv=none; b=bIobWzHZfE1GMk09hKm4EXIjM7eKOoqS2R6uq3Gxr7eqgCcob2K3wcG5QgiukD9W+YoNLs7aE1z62l7XNhChQ9TTFDEUAKqIfwihGBSRWn7yagar2o1YH/EPghJ69DFErSDh+VM8BpoA69aYs67E+fW09FXXu9Ajk2n9ejqeRQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773308178; c=relaxed/simple;
	bh=e4b3th8r7eY8TTAbLS/IfI3P5nUTdSV2jpevdT74/gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gG892IYVGHkrWAgNVSTtqmj7vqHV0GmUmsMR9YnBfNWWi5X4w3ki6Cjn0ib0HYCfGGQD1lIvYFDXit84d9xbGMkO0M3bXPhu6Ffb2I5O/vlCn07PoJ8HYkqoNhqi7Nfc9pJ3GNCkus+fRRjzZ9Z2GdXTenbQN+rjEXJOxBxnngQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jYdqrSRu; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jYdqrSRu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773308176; x=1804844176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e4b3th8r7eY8TTAbLS/IfI3P5nUTdSV2jpevdT74/gM=;
  b=jYdqrSRulrOG7Kg7YAi36PMVXWy/wxZVt5Vyx3vm+vIN0Hz7HxVMUkzx
   J3YwiSYdyaAHd0wLqbqLDduPBeX7tqB7z2rjq1RDNMcTeBY+QZpC9uu14
   U9um37UIoZ48C/UcHUCD0n+QTRmhO74a1u6s1ZB69riGmsh/LBUwERlEz
   kOJfD1NriRRivJmxssqCfjcBBtZ3R5Sl3xee6ojHPNC9JnYPqGygJ/VSu
   +7aib5M3Aqjdc0NHPprBerEw/N7y4ea3Owo9zTtdj3G0y5u3By9XT7bmG
   Yhu4h1X2wm18Pwnr6Ap5Jgn84BvP79MtW06ogHFvTxAc/VvoFdc9uSkgg
   w==;
X-CSE-ConnectionGUID: cf+7FFVIQseuudrJu9GT0Q==
X-CSE-MsgGUID: 2wAlpa99TTWbtYKk7UX8Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="85480128"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="85480128"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 02:36:15 -0700
X-CSE-ConnectionGUID: Y5bZZdDtSd+U4nY+1iM/vA==
X-CSE-MsgGUID: cKFJ/vnfSBSz1KXH8H/EfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="220966015"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 02:36:12 -0700
Date: Thu, 12 Mar 2026 11:36:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: adc: max1363: Format block comments
Message-ID: <abKJCRvTkz045yKw@ashevche-desk.local>
References: <20260312080752.48091-4-giorgitchankvetadze1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312080752.48091-4-giorgitchankvetadze1997@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 12, 2026 at 12:07:52PM +0400, Giorgi Tchankvetadze wrote:
> Move the trailing "*/" of multi-line block comments to a separate
> line to comply with the kernel comment style.

After your patch it gets not closer. I do not see how it really fixes that,
see below why.

> This resolves checkpatch warnings:
> 
>   WARNING: Block comments use a trailing */ on a separate line
> 
> No functional change.

...

>  /* There is a fair bit more defined here than currently
>   * used, but the intention is to support everything these
> - * chips do in the long run */
> + * chips do in the long run
> + */

Make sure:
- proper comment style is in use
- the English grammar and punctuation is respected.

...

>  	/* Using monitor modes and buffer at the same time is
> -	   currently not supported */
> +	   currently not supported

Wow! And after that checkpatch doesn't complain?!
Please, go and fix checkpatch, this is NOT how we
do comments, so besides the two issues mentioned
above, this misses the leading asterisk.

> +	*/

-- 
With Best Regards,
Andy Shevchenko


