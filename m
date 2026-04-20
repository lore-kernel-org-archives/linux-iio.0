Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786383A1D1B;
	Mon, 20 Apr 2026 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776705530; cv=none; b=SrSgJ5UK5fD/i+2N+SjuyeFizUUUFHTfhGpicA8qMje0q3I6Dhzo32/o5T3WdRF4rxRgLjHFc7TuLS1M0ohXY0ciVG+/YS7BCRJUt1HnkXOEwep0zqgt9PIbFZyMN1ntCOn6B9yT3XT2OInFndd0NEBKXgL4bKIhAzk0Lgn9gDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776705530; c=relaxed/simple;
	bh=CFKP7QAGKhY1DBjZESQqdTImVsrc/ph2AvgPd9WVUY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AD9DOeFLO3KiVLMq2DGL/b2Wk/rfyFQcKPZ3mXmi8WQ4FPz8p0ZYZL4jEYFXGI3LXpaY8DNwbz0SLBenQojAfq/n7/tB2HWV4RwzacJsBpYARNJZwayD1Kt8v0uqdhIqB6SbkSyzet6itYFMBSHDj6TyluQJsIEYMKZJpjPFxoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eo4ttCaH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eo4ttCaH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776705528; x=1808241528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CFKP7QAGKhY1DBjZESQqdTImVsrc/ph2AvgPd9WVUY0=;
  b=eo4ttCaHWeRB+jlLmNMf2rC0fa6t6+HW9eYmHEsacgx6Oa7aAFfN3LtL
   nTL9L16XvSeR/CuK4Ig0PQCPxhW92+SzCupUDkYrbnlXk9FTtF8DC3D/r
   X8PjV1RIEuKqDufikvW2LtFdHH3P6AhOaq369plulZNfimmj6p/ae0E19
   wyn4wd5B0BVbi/nMdQgCLwfSeQrEuieY7u8s7BmTRPXlXB6SK/4buGask
   sFvmk+hKjp93FK7iqkg0emlS0L+DTiyllbzjbSsKETlxTbsub7xQQ1Vfs
   kXCDXU0UV5DLGH8MZFr8jLZIz85hi3e1PnoxYJhEGIzmt/3p0O5GNBmYf
   g==;
X-CSE-ConnectionGUID: Lp0xKPklSyaNaxh9u/iolg==
X-CSE-MsgGUID: LhZSBNfITyqlOOB1RdIsIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="81497119"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="81497119"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 10:18:48 -0700
X-CSE-ConnectionGUID: Bf/1SKoBTlymyKF0RNRirw==
X-CSE-MsgGUID: y3wSj6NqSe6/gtR3W5lKBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="236757142"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 10:18:45 -0700
Date: Mon, 20 Apr 2026 20:18:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: magnetometer: ak8975: header cleanup
Message-ID: <aeZf8_NszentI8-M@ashevche-desk.local>
References: <20260420110804.1353-1-joshua.crofts1@gmail.com>
 <20260420110804.1353-2-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420110804.1353-2-joshua.crofts1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 20, 2026 at 11:08:01AM +0000, Joshua Crofts wrote:
> Clean up headers by removing proxy kernel.h header and adding new
> headers to ensure atomicity (array_size.h, dev_printk.h, types.h,
> asm/byteorder.h). Removed unused headers (slab.h, iio/sysfs.h,
> iio/trigger.h) and added minmax.h, property.h, wait.h, irqreturn.h to
> mitigate transient dependencies during compilation.
> 
> Audited using the include-what-you-use tool.

Seems this implied sorting as well. As Jonathan says somewhere else
he prefers to split sorting and IWYU patches.

...

>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
> -#include <linux/iio/trigger.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>

Also note that this group left unsorted.

>  
> -- 
> 2.47.3
> 

-- 
With Best Regards,
Andy Shevchenko


