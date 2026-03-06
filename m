Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0139F3AEF54;
	Fri,  6 Mar 2026 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772808042; cv=none; b=VdOzYntjloQmEOYRM385+fxR387f7skM+BHst3Kj72wn/qoECjv7jnHzE4UZIgmuoB64kpwUY/XcA8PByXjQxabHkLOm9w7Ynf3aY+Km0D+GQvjRzKSSzplvJiy7qq7xZ46bsD+lDl/wEB5SZ4ePqS/7+yWh8o4XvfIQgKtUuFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772808042; c=relaxed/simple;
	bh=CX+4PlYZByCdMDlMD1Su+hPVS2RNviR371x+9e1ZtBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrEyJzMr1FVeXmgNB0njK0JUplv386q1d5W/T5bax8G07CYnCMUQFqNmYlUZ18K5/jb6TVBIyOq/9O44CoALqMWvg62IiVvTOmZef81ZEwGAiAGqruAaVPSjZILW9yxLmVMp5GLGqtkMujgcdl9Hz4qkfVobedJOoE/budgspTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TqGQLVMN; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TqGQLVMN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772808041; x=1804344041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CX+4PlYZByCdMDlMD1Su+hPVS2RNviR371x+9e1ZtBw=;
  b=TqGQLVMNGGkAUkMNwZ6PWO4r+jE0D7bq3P3IIuxaLtbK153Cz3hqY+Gt
   Ox0sC8gQb/tcFMxfbdzzK1NXodZnqhfeWv4pPWEXYQk6O//m1z0pVG80X
   4SD/lh/qs9aLi8dJbLYxbjFNTrxGJTyHFnEUljA2y60st+q5WGu3KkxaD
   1Q/vVAui/6uYRSFBhMFURVwG17OPPXUT3KeJvDicR/wiCw8n61+fDv2dU
   /DOgaIFxNQni21PJBPWBEdq2rnFITVRL0dmfXoJ07h1OoIPIFdPoaGzdu
   yB+lXcZ/IhbKlfouSxtkjP0MljWmlLnOqb8fPLYigU4qBmz2NUDAInMWL
   g==;
X-CSE-ConnectionGUID: UnxI97mLRaqwvWizrN9ZpA==
X-CSE-MsgGUID: fihd1exzSI6j7DdvNR/LzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="72940086"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="72940086"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 06:40:40 -0800
X-CSE-ConnectionGUID: gbYxaMLoRgayd9HbZO904w==
X-CSE-MsgGUID: leGUs/RXRaWHa5E/RYYKPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="218967749"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.1])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 06:40:37 -0800
Date: Fri, 6 Mar 2026 16:40:34 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max1363: Fix leading space indentation
Message-ID: <aarnYqktty1mqUr7@ashevche-desk.local>
References: <20260306134332.746728-5-giorgitchankvetadze1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306134332.746728-5-giorgitchankvetadze1997@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 06, 2026 at 05:43:36PM +0400, Giorgi Tchankvetadze wrote:
> Fix leading space indentation in the device enum (found by checkpatch).
> 
> No functional change.

...

>  enum { max1361,

Make this to be split

enum {
	max1361,

> -       max1362,
> -       max1363,
> -       max1364,
> -       max1036,
> -       max1037,
> -       max1038,
> -       max1039,
> -       max1136,
> -       max1137,
> -       max1138,
> -       max1139,
> -       max1236,
> -       max1237,
> -       max1238,
> -       max1239,
> -       max11600,
> -       max11601,
> -       max11602,
> -       max11603,
> -       max11604,
> -       max11605,
> -       max11606,
> -       max11607,
> -       max11608,
> -       max11609,
> -       max11610,
> -       max11611,
> -       max11612,
> -       max11613,
> -       max11614,
> -       max11615,
> -       max11616,
> -       max11617,
> -       max11644,
> -       max11645,
> -       max11646,
> -       max11647
> +	max1362,
> +	max1363,
> +	max1364,
> +	max1036,
> +	max1037,
> +	max1038,
> +	max1039,
> +	max1136,
> +	max1137,
> +	max1138,
> +	max1139,
> +	max1236,
> +	max1237,
> +	max1238,
> +	max1239,
> +	max11600,
> +	max11601,
> +	max11602,
> +	max11603,
> +	max11604,
> +	max11605,
> +	max11606,
> +	max11607,
> +	max11608,
> +	max11609,
> +	max11610,
> +	max11611,
> +	max11612,
> +	max11613,
> +	max11614,
> +	max11615,
> +	max11616,
> +	max11617,
> +	max11644,
> +	max11645,
> +	max11646,
> +	max11647

Add trailing comma as this is not a terminator.

>  };

-- 
With Best Regards,
Andy Shevchenko


