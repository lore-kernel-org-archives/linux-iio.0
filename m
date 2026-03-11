Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E145A3DDDCC;
	Wed, 11 Mar 2026 12:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230851; cv=none; b=XrDmkYXtAOY5NvJUGe1+qXl/l+WZtz5KBCHUqXk645wqLQTuc02y1iGlbSiPhIiJXfJAkNeKi4aFdzhZ+CKRVLgbgrpHlbzbXO/j/oEyCSJTTG/al/2ArIVFf1HcdHxByFfyeyzXEPtci2CUlA9k2yiWuluMgEmsd2rEQpv31uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230851; c=relaxed/simple;
	bh=RK+pKuRfdfGfw8oANuvpjd3fTlBXpMU22AHKCXyNTcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CplfRWD3oTbozL4fTzsXis8z7+vzhNhPxy2rnT2uIcZggZ11e/qNnz4WKiEtMQHVIHfk1sOjXNIu2WHuGFcZlueXD1JC4JscdGCR0WUAZATEP5u6B8PoI2u4RAs4wBhGdxWlv6BMYFd0avYX8ID5yDEYK2RtAsLOa9BLLIIeiwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QP6ssVBO; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QP6ssVBO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773230846; x=1804766846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RK+pKuRfdfGfw8oANuvpjd3fTlBXpMU22AHKCXyNTcA=;
  b=QP6ssVBOsnAuLpxZOXj1UElbxsqKJhePnck+AMH/DblHcWODqMMKwAt3
   ws4/e55hAOvyLS/cSCo35pcXRte2rwjmdZ2/GGnFHr5Y9vyFYUKMI1zb3
   L1hy7JgDRzcjs50oQZXd8CgOZJ4UKNaRJJ/gmnsDYeXA+hLnrUDNLGPcA
   zC+3/z7Iz0F0+BJnc45VfumQiCubvcd1sIJC3n4i1GJb2XV9JrmhLsAY0
   Yrue/fVgqplPeGl1M2UNxwMyfZmbPYJwM+sveBIreR+XALETBo//HDklh
   HQTYI4szxkdip2+Cc9CiisZqBNSsBYWsbaMlOK1oYOCVxmzhmquQANivI
   w==;
X-CSE-ConnectionGUID: aMBo3VajTvWJvy8UEmeqPA==
X-CSE-MsgGUID: qi83aCT/QGWBVl5WDsr9ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74171528"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74171528"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 05:07:21 -0700
X-CSE-ConnectionGUID: c444PqeVTW68jz/O7+Etlw==
X-CSE-MsgGUID: mY4K9MB/TreCXpG9WYgUVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="217118798"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.178])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 05:07:19 -0700
Date: Wed, 11 Mar 2026 14:07:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Neel Bullywon <neelb2403@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: frequency: adf4350: replace loop with order_base_2()
Message-ID: <abFa9G81Bj4YTZqq@ashevche-desk.local>
References: <20260311020115.56321-1-neelb2403@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311020115.56321-1-neelb2403@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 10, 2026 at 10:01:15PM -0400, Neel Bullywon wrote:
> Address the TODO in adf4350_set_freq() by replacing the iterative
> power-of-2 shift loop with the standard order_base_2() macro.
> 
> By utilizing DIV_ROUND_UP_ULL(), we
> can calculate the required RF divider selection in a single step.
> 
> This ensures freq is properly shifted to meet or exceed the minimum
> VCO frequency.

Thanks! My comments below.

...

> -	st->r4_rf_div_sel = 0;
> -
>  	/*
> -	 * !\TODO: The below computation is making sure we get a power of 2
> -	 * shift (st->r4_rf_div_sel) so that freq becomes higher or equal to
> -	 * ADF4350_MIN_VCO_FREQ. This might be simplified with fls()/fls_long()
> -	 * and friends.
> +	 * Calculate the required RF divider selection (power of 2 shift)
> +	 * to ensure the VCO frequency is >= ADF4350_MIN_VCO_FREQ.
>  	 */
> -	while (freq < ADF4350_MIN_VCO_FREQ) {
> -		freq <<= 1;
> -		st->r4_rf_div_sel++;
> -	}
> +	st->r4_rf_div_sel = order_base_2(DIV_ROUND_UP_ULL(ADF4350_MIN_VCO_FREQ, freq));

We don't need 64-bit division even with your approach as values are 32-bit for
this case (yeah, I know that they have 64-bit types).

What you need is to do as suggested by comment: use fls_long() against the
constant and freq to see the difference in value, if there is none the while
will become just a check and a single shift.

Or consider it as the opposite problem: "How much the given constant is now
bigger than freq?" With that it might be more obvious solution.

I.o.w. think about this a bit more.

> +	freq <<= st->r4_rf_div_sel;
>  

I would move this blank line to be before freq shift, this will associate it
with the check below.

>  	if (freq > ADF4350_MAX_FREQ_45_PRESC) {
>  		prescaler = ADF4350_REG1_PRESCALER;

-- 
With Best Regards,
Andy Shevchenko


