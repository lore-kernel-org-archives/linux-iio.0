Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793793512;
	b=J/rPVNozLRXoQkRHzcQznjC/KhICW6eJ9jpB5XLkonPHkv9v8GyC7V4PF//K9fHUw7lz
	 BBNq7RLTP3hI0qov4I3W5jRqO+Ub//GnAftyysn3Jn/dYu98Qu7HWL2So1OwEnSCxtZFa
	 qMHfDaB7fTpB+0udwL+pUJpIIs2mGu42vtEO4xKbqqNUWLuQ3sJ41h1yCe6Im1s8G2FEA
	 oBZ+5NlATyCXi06rm8OSa4KwPXMG5TCBPVWuY+LcbDk/iBJE1y3PAMamUrwQJQ0LiNoIA
	 dI+AV5/LFfEUZKNBTYp+g0EHc4EZUfmH53efnG5tNT0uwkQYauB1EHnDpzq1yweYvJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793793512;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=HSI0Xww2UgPhD6qCDAAZFlGcjtmPKieQAs4A1FJaqGE=;
	b=FRdjOz2PLou1nhFXFkoXSwKTgq7y8ifIrz0aE/tDamjodMeSs1N601sFl03woqMUJ56S
	 EMw/DZu3oL14Fwgy/ueAd05MG6j9ZQUrtLmrMMYYndWi9424dmbrk7Ja/iBtvxXAqrnYx
	 a8sKMJ3LNJWbwfN+qIbuvYngSVXotUPC21Rux/D7d8CGJGsMK5mcb+NMnCy2CAzlbEtSH
	 MF5zAWa6l2RFKjT8mnXMUhUaExpjHsuKW5M0KlAYlDYWRHEJLymJPxactgxy39U1nHLcY
	 6q0nQiYZ/d+7ARQt0auaZoornrZjICPYwEDuBDdPx1OC8iMF0HhFPQPHyJ+ygDr+VWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P4nudwVK;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBD6606A31B;
	Wed,  4 Nov 2026 11:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACBD6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P4nudwVK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793793512; x=1825329512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WO3KEix7IJnsFekpM/PGTdWDQ9CMyYbj9Dej1ojiGw8=;
  b=P4nudwVKkwWn1VHrhOTLYR4qGUQq19KdtKJU5ZcYa6joVe9yLCOIdi7W
   sUXfguCVKNZEFUS/zHjMSfx3SZjMHE1mSVh0xkRXyF3Rp1rvvy8gRkSUh
   6ON4MG5c+Pu6kIXTeu+aog2EJVgnd/XfSd3uKtNGqODXe5YwSZMW5zsmR
   SFiplKxuHWR1pwy4puFl7se+kNIgV+Z4ULzLhojuAw5HdiDWhPECglk8T
   LHk7t1nRcA8KL2r8cNGCDFOQQ78V4GdZKcR5zG1034KNlr2OCy7IJ2Oqs
   dW9wXGYP66YqtaVnkvc8KqsPmaw9iFIOWEp9CiC13HD4yQTLIXbFwwRYl
   Q==;
X-CSE-ConnectionGUID: 7BHvNR2lROGQqb2HcEsuLA==
X-CSE-MsgGUID: PM7xwYJISaWXcotqmBWWPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2573005"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2573005"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 03:58:31 -0800
X-CSE-ConnectionGUID: HQxZ4PyJQw+IrwV8YTVh2Q==
X-CSE-MsgGUID: WRRryNqJTrmDLhLU/rpu5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6584447"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 03:58:29 -0800
Date: Wed, 4 Nov 2026 13:58:26 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, andy@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com
Subject: Re: [PATCH v4 2/2] iio: gyro: mpu3050: Fix runtime PM refcount leak
 in trigger enable path
Message-ID: <ausd4u09AfIcviHI@ashevche-desk.local>
References: <20261104040008.1458-1-laixiangwu@cmss.chinamobile.com>
 <20261104040008.1458-3-laixiangwu@cmss.chinamobile.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104040008.1458-3-laixiangwu@cmss.chinamobile.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 12:00:07PM +0800, Xiangwu Lai wrote:

> mpu3050_drdy_trigger_enable() calls pm_runtime_get_sync() when
> enabling the data ready trigger, but all five error returns in the
> enable path return directly without the matching
> pm_runtime_put_autosuspend(). The disable path, in contrast, drops
> the reference correctly.
> 
> As a result, a failed trigger enable leaves the runtime PM usage
> counter incremented and the sensor can never runtime suspend. It also
> leaves hw_irq_trigger set to true, claiming the hardware IRQ is in
> use when it is not.
> 
> Use pm_runtime_resume_and_get(), which does not leave the usage
> counter incremented when resume fails, and add an error label that
> drops the runtime PM reference and clears hw_irq_trigger so that a
> failed enable returns with the device in the same state as before
> the attempt.
> 
> Also propagate the error from the IRQ status read that clears the
> data ready flag instead of only printing it, so that a failure
> anywhere in the enable path consistently rolls the trigger state
> back.

...

> static int mpu3050_drdy_trigger_enable(struct mpu3050 *mpu3050)

>  	unsigned int val;
>  	int ret;
>  
> -	pm_runtime_get_sync(mpu3050->dev);
> +	ret = pm_runtime_resume_and_get(mpu3050->dev);
> +	if (ret)
> +		return ret;

Why not PM_RUNTIME_ACQUIRE*()?
Yes, to make the

	mpu3050->hw_irq_trigger = false;

this needs to be wrapped (two functions, outer one uses PM_RUNTIME_ACQUIRE(),
and handles the flag).

>  	mpu3050->hw_irq_trigger = true;

-- 
With Best Regards,
Andy Shevchenko


