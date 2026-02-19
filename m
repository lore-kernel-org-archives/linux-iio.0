Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938C513957E;
	Thu, 19 Feb 2026 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771533971; cv=none; b=aF/BMcWnH62kA+wydcZOJ05pIELEDWIwHt4uG8SBcCCjY4vpK9kcADXyNGo1YMmqCD+2Ew6B8QE2Aa1wcAZgi19R1jQCf+Gcl9cdUhsVTx6CdC3sNY22J4lhmjjrZu5mPWtRleUk3dtZjA7sjtu3gdguC3Ui9h/+6f05m/1VblU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771533971; c=relaxed/simple;
	bh=eFb9hN/IVL+BkJ+rMMYHztSXUeWH10sChJzRp5qXwsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFIS9uadldyaufcYDPwqfOFJZVy1IaCGt6nP1El3A4Lh9xoCXe1slUTPI/W5sD33FJnIeED/1FuNzHxx4PhBElNu2fLW1ZPOHajbdchdpoQRQKTrFLvF0cOot/4IPlEgPyArzkHCPa0Xz2xLhGpI3e9cpS2UBzG65M+bIfB1Lek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nhptlHmJ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhptlHmJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771533969; x=1803069969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eFb9hN/IVL+BkJ+rMMYHztSXUeWH10sChJzRp5qXwsQ=;
  b=nhptlHmJ+tnXQk5bMJc9mQWnG7e84kBL5MDW/hg1UZY3fxVSF1FzG+n/
   49JYqUS7wMSXb+oDLHrlh0Qkyur1qJK52/jDLEblA3ZOeE+UB3Gmx2wvr
   4gT8sRYGQmQ1XDRLjana+yxIbsnpGwQtpR3srWRg/SKg4hvJ3Pc24BbG2
   Kf71tOvCMxQw/+DD13bOuCtkctQUCFZHlIX2HsEpy6RlnHRt0G8g1TyjO
   TROLvLK8GwChow8CYng85W1ZWTQxutLDYv5lbEd/XCx/+P+8FmshIO8ZW
   GLa7f3n37Qv3Uht2x+OIGkAnpwWywAGTjacan1OPr3q55/dTWzig/FtaA
   w==;
X-CSE-ConnectionGUID: OKeVjrj9RXihQrE7nqCOXw==
X-CSE-MsgGUID: AV3EsY4FSdGtOiS9f0WOGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72675470"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="72675470"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 12:46:09 -0800
X-CSE-ConnectionGUID: siAcpV6lRAOx1H7y/Aeuzw==
X-CSE-MsgGUID: 6EnVJhfGQx2nhBJ2g0AwWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="245235842"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.114])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 12:46:06 -0800
Date: Thu, 19 Feb 2026 22:46:04 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: bhargav <rougueprince47@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: frequency: ad9523: fix checkpatch warnings
 for symbolic permissions
Message-ID: <aZd2jAVnTIuz2o7h@smile.fi.intel.com>
References: <aZa_QbwCumULvTf7@smile.fi.intel.com>
 <20260219203215.15566-1-rougueprince47@gmail.com>
 <20260219203215.15566-4-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219203215.15566-4-rougueprince47@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 02:02:15AM +0530, bhargav wrote:

...

> Changes in v2:
> - It was suggested in v1 to convert these to 
>   IIO_DEVICE_ATTR_RO() and _WO(). However, those helper macros 
>   expect uniquely named callbacks (e.g. pll1_locked_show), 
>   whereas this driver uses shared multiplexed callbacks 
>   (eg. ad9523_show). Converting to the helpers would require 
>   generating wrapper functions. 
>   Therefore, this v2 keeps IIO_DEVICE_ATTR but updates the 
>   permissions to standard octal format.

Okay, but...

> -static IIO_DEVICE_ATTR(pll1_locked, S_IRUGO,
> +static IIO_DEVICE_ATTR(pll1_locked, 0444,
>  			ad9523_show,
>  			NULL,
>  			AD9523_STAT_PLL1_LD);
>  
> -static IIO_DEVICE_ATTR(pll2_locked, S_IRUGO,
> +static IIO_DEVICE_ATTR(pll2_locked, 0444,
>  			ad9523_show,
>  			NULL,
>  			AD9523_STAT_PLL2_LD);
>  
> -static IIO_DEVICE_ATTR(pll1_reference_clk_a_present, S_IRUGO,
> +static IIO_DEVICE_ATTR(pll1_reference_clk_a_present, 0444,
>  			ad9523_show,
>  			NULL,
>  			AD9523_STAT_REFA);
>  
> -static IIO_DEVICE_ATTR(pll1_reference_clk_b_present, S_IRUGO,
> +static IIO_DEVICE_ATTR(pll1_reference_clk_b_present, 0444,
>  			ad9523_show,
>  			NULL,
>  			AD9523_STAT_REFB);
>  
> -static IIO_DEVICE_ATTR(pll1_reference_clk_test_present, S_IRUGO,
> +static IIO_DEVICE_ATTR(pll1_reference_clk_test_present, 0444,
>  			ad9523_show,
>  			NULL,
>  			AD9523_STAT_REF_TEST);

...even for the longest line you can update them to be like

static IIO_DEVICE_ATTR(pll1_reference_clk_test_present, 0444, ad9523_show, NULL,
		       AD9523_STAT_REF_TEST);

Also note, that the indentation is broken for all parameters
that are on the next lines to the IIO_DEVICE_ATTR().

> -static IIO_DEVICE_ATTR(vcxo_clk_present, S_IRUGO,
> +static IIO_DEVICE_ATTR(vcxo_clk_present, 0444,
>  			ad9523_show,
>  			NULL,
>  			AD9523_STAT_VCXO);
>  
> -static IIO_DEVICE_ATTR(pll2_feedback_clk_present, S_IRUGO,
> +static IIO_DEVICE_ATTR(pll2_feedback_clk_present, 0444,
>  			ad9523_show,
>  			NULL,
>  			AD9523_STAT_PLL2_FB_CLK);
>  
> -static IIO_DEVICE_ATTR(pll2_reference_clk_present, S_IRUGO,
> +static IIO_DEVICE_ATTR(pll2_reference_clk_present, 0444,
>  			ad9523_show,
>  			NULL,
>  			AD9523_STAT_PLL2_REF_CLK);
>  
> -static IIO_DEVICE_ATTR(sync_dividers, S_IWUSR,
> +static IIO_DEVICE_ATTR(sync_dividers, 0200,
>  			NULL,
>  			ad9523_store,
>  			AD9523_SYNC);
>  
> -static IIO_DEVICE_ATTR(store_eeprom, S_IWUSR,
> +static IIO_DEVICE_ATTR(store_eeprom, 0200,
>  			NULL,
>  			ad9523_store,
>  			AD9523_EEPROM);

-- 
With Best Regards,
Andy Shevchenko


