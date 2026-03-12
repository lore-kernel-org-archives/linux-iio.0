Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D68A3B2FFA
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773307872; cv=none; b=OB8XWu1Gs+08jUnyCuTaXsjlqsRO9s0aNYq0mv7ln/VsI5v18ZDjb7p3rtSPUM//cF3RN5FKzGedutMC94LyHHri5nxbt1mvt5wPnzcZ+I4lLX/UBPTeQL/0c8EBi6JoWY5xTRSU+EJ/lKPjaUsKOki/g8s+H772JhTN5eSfW9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773307872; c=relaxed/simple;
	bh=f9Pe00m0NT4jinQ2XkImcZQRnKivmEXOHHMjU2VPVHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBwNtcUwfN1adpeXhQ6mKGfb10N8TvAmsYK0vs5vLAfJAFGv02N2bRAXw/kXNT2hqBgeO+fscCZgEC2bJIrPV/7L7RRPiFGLzreNeCeOvR3eRnRz0HCklHel7N5jqX6DX180fXOyFLEO1AJNHdXWOAY7IFpbPn0Lk0qQL76ColQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=da2tdbw3; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="da2tdbw3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773307871; x=1804843871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f9Pe00m0NT4jinQ2XkImcZQRnKivmEXOHHMjU2VPVHs=;
  b=da2tdbw3LT1hYZoSOg5YLsspEhfIAXf555NoIPJBu+x1b8q8WuWV74iZ
   Z2mM8accbOKcxwTnWFRVIF71ZnuTVtqv0Ie9SLpp+HE9QboHg+7kZnAlU
   FotYdAlApyg6qWr37HY4W0wWD30RgFSUskbKUFsn2t1XenWviuN/6JoY2
   YzaNpOT6SNxmsM2k0OYyl9k+vbazHDKBVWJMkFRhbBKpecN3rf01FZhc3
   4auyK9Jh7KIvXy2yXmKq/g7M6eygwRNli3+0lYnWb+WGztJif9+ABRWNM
   N100K13Tn6jZH6st9BaWlHozdf4RBmCjKsH1g8rBzzwbWP8MRT5gpbjmP
   w==;
X-CSE-ConnectionGUID: 0WGHPQxHSuiHF0fCa4Y4Ig==
X-CSE-MsgGUID: 9cg3gE9UQAeXLuR7TheVtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="85479580"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="85479580"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 02:31:11 -0700
X-CSE-ConnectionGUID: ypAK3ogYT0OKk4TJ0vCsdQ==
X-CSE-MsgGUID: 8V6eG4eZQV6JX6eV9PYsDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="251257727"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 02:31:09 -0700
Date: Thu, 12 Mar 2026 11:31:05 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: adc: Format block comments
Message-ID: <abKH2ZnAvJmmI3BY@ashevche-desk.local>
References: <20260312080752.48091-2-giorgitchankvetadze1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312080752.48091-2-giorgitchankvetadze1997@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 12, 2026 at 12:07:50PM +0400, Giorgi Tchankvetadze wrote:
> Fix block comment formatting in several IIO ADC drivers so the
> trailing "*/" appears on a separate line.
> 
> This resolves checkpatch warnings:
> 
>   WARNING: Block comments use a trailing */ on a separate line

You sent patches as the series, but it does not have proper In-Reply-To,
in other words it is not chained. Either don't do series (send patches
individually) or make sure it's an email thread.

-- 
With Best Regards,
Andy Shevchenko


