Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AC72F6565;
	Fri,  6 Mar 2026 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772808362; cv=none; b=seTCDvf1jeMPA+VGR1p61+i2JkYvmUv7nXjsXzvG0EsbGnkcXwf0RaZ2BgcJV4Lj8L+Nuc0Ka1aiRRPrjza1mXVpu5/d0nfuc8IfSKYin4ZUCMRLRmaORWPJ9H4v3htxxigL1Zqh84HwJPSvtLPsyNbsFlKMsJlGx4qjfV7FtuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772808362; c=relaxed/simple;
	bh=JDTiNvvd0TyCdRE0N+CLRgu5UiaN1awF3hUlKuhGjoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ey6Jz1NgbT3n3Kc4BfMAN2FMg7K6R53wxgF6QVTB1Pd7N79DXs32P4Qdocp09gSilc8fmZDd8B7KtAhmuakVPwWCPKyvAr6pjYYmcAsJepUb1UvhTeFikyXTCIeOumm+jT2PTHyzoT8VsRAUPP4mzNthCn34XVnTv5sTCG4vWSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PF2R+98s; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PF2R+98s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772808360; x=1804344360;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JDTiNvvd0TyCdRE0N+CLRgu5UiaN1awF3hUlKuhGjoY=;
  b=PF2R+98st6x2rW2AXF6WrYh7yWIFO0vukb1CTrObzmlzu5HWeJTdAvgb
   Fgsxxr9QnIFr97PKg9cxqSofJ6RFJIpk14Nn/gE1aqhSbAFmFLJtNUiff
   PU0APH+NdFAWT5QcWEeyfB7//tMoLX2qW0lCaO/ko8Y85JZ1b8Fy1Wops
   OXJcJHkyy3xWWDuuYGObm+KAjj10sGNjcTbA8zCPky8UrGm2Oxg9HSw2Q
   n2aKKkMbQnkIs14jSc74MGHv2wE2UCfw/OZaSgIdnHTHHC1NN6mi48DxE
   SOc86+Bhi1tLsXjF+cEhbMcbFvE/El3GjLT9PUtmeh9ZAgz9TrDescYnT
   g==;
X-CSE-ConnectionGUID: 9wvVCa1aQ86ugJ8u+jCUuw==
X-CSE-MsgGUID: 5JmUCzXzTrqJVALd+HU3rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="85000105"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="85000105"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 06:45:59 -0800
X-CSE-ConnectionGUID: /3KXTQYATqmhz1cXnYSEWw==
X-CSE-MsgGUID: KwRdf4yoRe+PeMYfzYF4nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="224001556"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.1])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 06:45:57 -0800
Date: Fri, 6 Mar 2026 16:45:54 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: frequency: admv4420: use dev_err_probe
Message-ID: <aaroonLe8Zz6fOhE@ashevche-desk.local>
References: <20260306102504.42395-1-antoniu.miclaus@analog.com>
 <20260306102504.42395-3-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306102504.42395-3-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 06, 2026 at 12:24:46PM +0200, Antoniu Miclaus wrote:
> Use dev_err_probe() instead of dev_err() in the probe path to ensure
> proper handling of deferred probing and to simplify error handling.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
After addressing the below.

...

>  	ret = admv4420_calc_parameters(st);
> -	if (ret) {
> -		dev_err(dev, "Failed calc parameters for %lld ", st->vco_freq_hz);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed calc parameters for %lld\n", st->vco_freq_hz);

Besides too long line, are you sure the lld is the proper specifier?
I.o.w. is it really signed long long? (It also adds missing '\n',
does it need to be mentioned in the commit message?)

-- 
With Best Regards,
Andy Shevchenko


