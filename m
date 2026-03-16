Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C08386569;
	Mon, 16 Mar 2026 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773664846; cv=none; b=jxzMAiKjTWmsA44sE3KR9vhOGEkkybcP8fvqV0DjOC72JnLtodozviKVHwi+8RdUzOHGTMsWy1N0arkh8HZdoqriAW1zY3uDq4Z74YUCHDCCFx5j5nHYfXs4znV4y3rp83wca4FIrJA0X/cl3WjCJqmE48hQv7O9cj3gjQtiyPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773664846; c=relaxed/simple;
	bh=eco3qcaz4LhSCj3ReylAHv395FCWa9mlQ27iAT8EQFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHoPGDIWg+1aA7jA9uYOsw/CC3XnRqvVQpBSOeuTm+zu5mzTRe+U+C3/El77wrDU+QepUic0sfucCM3zkbxE5dGpxwDMvHbUpvhkKFLt3YnMhgI1s1ueNbKPhw2Ykeh96r05A6rUomHY4PRgBqD4yCMsulN6IzgoALcaPmjmmZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OV/2z9Og; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OV/2z9Og"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773664844; x=1805200844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eco3qcaz4LhSCj3ReylAHv395FCWa9mlQ27iAT8EQFw=;
  b=OV/2z9OgnkAZn7cwWPuqzHRw9r1SA9PUiYcAQXOhvqVLA0f2qWFsk6g0
   KmNYACTEGlD2wB9hkFGDLIztYuUDr6z8sWDtAIDjLCiJmn0v/SCp6iWrn
   ZGdm3PLTpp4wPNB9lKhtpTtFWmc/IUR+RxEffCpPFjLbD3TV8l75Uvg9B
   wj2yVLDfkICCDWiuK1Du5pW/7IzEtURzFelbIyS6ClZBiXbGTmdCooR0i
   ZZs2h3Hksj60M9mClu9Dx3zLgRNrGkjFL5KzeiZfaMPqVzYVhuubIGWI0
   sdE8aYRI39RPqdJKpD6NQHK0VBoZP+pq4XfahW0hJo+MT9IklhwDTAuSK
   w==;
X-CSE-ConnectionGUID: 95skP0ECS62NiPUTZbQ4/g==
X-CSE-MsgGUID: 6AlMIukXQbS8gSL7F7Hcjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74713545"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74713545"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 05:40:44 -0700
X-CSE-ConnectionGUID: QZulyHoFQaqL3UsdYGZHdA==
X-CSE-MsgGUID: o3Db2AzoRrqTCUBDpuaUmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221988305"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 05:40:41 -0700
Date: Mon, 16 Mar 2026 14:40:39 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Neel Bullywon <neelb2403@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: frequency: adf4350: replace loop with fls_long()
Message-ID: <abf6RwTHSapCUw52@ashevche-desk.local>
References: <20260311020115.56321-1-neelb2403@gmail.com>
 <20260314172006.69744-1-neelb2403@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314172006.69744-1-neelb2403@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Mar 14, 2026 at 01:20:06PM -0400, Neel Bullywon wrote:
> Address the TODO in adf4350_set_freq() by replacing the iterative
> power-of-2 shift loop with a constant-time bitwise calculation.
> 
> By comparing the highest set bits of the target constant and freq
> using fls_long(), we can calculate the required RF divider selection
> in a single step without relying on expensive 64-bit division.
> 
> This ensures freq is properly shifted to meet or exceed the minimum
> VCO frequency.

...

>  	st->r4_rf_div_sel = 0;

> -	while (freq < ADF4350_MIN_VCO_FREQ) {
> -		freq <<= 1;
> -		st->r4_rf_div_sel++;
> +	if (freq < ADF4350_MIN_VCO_FREQ) {
> +		st->r4_rf_div_sel = fls_long(ADF4350_MIN_VCO_FREQ - 1) - fls_long(freq);
> +		if ((freq << st->r4_rf_div_sel) < ADF4350_MIN_VCO_FREQ)
> +			st->r4_rf_div_sel++;
>  	}
>  
> +	freq <<= st->r4_rf_div_sel;

Yeah, unfortunately it looks like too complicated in comparison with the
original code. Have you checked binary output? My gut feelings that this
gives also a lot of code in addition to.

Little optimisation can be like:

	if (freq < ADF4350_MIN_VCO_FREQ) {
		st->r4_rf_div_sel = fls_long(ADF4350_MIN_VCO_FREQ - 1) - fls_long(freq);
		freq <<= st->r4_rf_div_sel;
		if (freq < ADF4350_MIN_VCO_FREQ) {
			st->r4_rf_div_sel++;
			freq <<= 1;
		}
	}

but it is still too much.

...

Maybe we simply need to replace TODO with a NOTE explaining that if better algo
is found we can replace.

-- 
With Best Regards,
Andy Shevchenko


