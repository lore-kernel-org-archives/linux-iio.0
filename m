Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E10340403;
	Wed,  3 Jun 2026 05:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780465973; cv=none; b=Wli4gxfUWn8EFmWqNz2YiIAn3Zn8iFW098CQ93NxrvW1kJzd/yIaijXxCFgojfCqBQhjrBlGTOXL+G/MKa2T+aIP90lP8cXaGOppcma68JcaDTPkgTTJ3SXzzjBUzIV0qqlsHbnMWg8U0DG+Dp460lnSK43aBJgUcLBQ7aWZgK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780465973; c=relaxed/simple;
	bh=SrBv+AtAPf8BYfkPH3HlxzIvPOQJ2hubye5tDQlkWbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcKjFogz6Zy+L1fGlhvqUnGOGE/2UGPhooDgiI0cgUR1zP1GyqZCeqoI6ogKO98ZNCmjpsAmRqXrHXDTUwjoOJpojI5bENvsbilDf/OYzzp+3dh4ux3NUXmqEn5svJhFajS6PN3H6xhN3DvUhczujS3rcli/Maz1XLYfe001ur0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S3tc5jfR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S3tc5jfR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780465973; x=1812001973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SrBv+AtAPf8BYfkPH3HlxzIvPOQJ2hubye5tDQlkWbs=;
  b=S3tc5jfRJ2FgcEhs4ZCGYI01g1WoFB7qLvHHOrqmBFqN3Ih8N/2daJlD
   NPPtNdrIQ7X8Xjqxcch5VSHBjBW46aijcUVFniKejJvos//iTQiKVIBz3
   MS1Es2cGRmMcRgbu2KC4uIRCPCDWK+SvuogqWSDGrOMVGNMxDpcqPukZk
   Ff5WR+N/NNQ6QYCkb/moLPWKLl2yI0Q/3OEVj4X8wwVmOMdutFuLzFzhH
   RNRpIFak54KY3VY0CZvFzrsccC1d0PKO29Z/ZKiOX2oHC2li32trbhpSO
   cnwc7RGWTatQvmmZI2cPQOuMyVdsqsnbXmRzuqhe6v0uJCv3Pg4S21aXi
   w==;
X-CSE-ConnectionGUID: oya9ehq4SqOJA6h1xmXvmQ==
X-CSE-MsgGUID: rtYBY6JJQPKhXqivzDYlyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="103924446"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="103924446"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 22:52:52 -0700
X-CSE-ConnectionGUID: DkcWOpOGQauJ8o7cPIWG3g==
X-CSE-MsgGUID: AHm6Zx3zTKi+4H36PFhvbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="245939008"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 22:52:49 -0700
Date: Wed, 3 Jun 2026 08:52:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Miao Li <limiao870622@163.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, bigeasy@linutronix.de, waqar.hameed@axis.com,
	marcus.folkesson@gmail.com, dixitparmar19@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	limiao@kylinos.cn
Subject: Re: [PATCH] iio: accel: stk8ba50: Update includes to match IWYU
Message-ID: <ah_BL85vs88ynvQ2@ashevche-desk.local>
References: <20260603015033.187735-1-limiao870622@163.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603015033.187735-1-limiao870622@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 09:50:33AM +0800, Miao Li wrote:

> Update the list of included headers in stk8ba50.c using
> Include-What-You-Use (IWYU) tool, mainly to remove kernel.h
> and add missing headers such as array_size.h, bits.h,
> dev_printk.h, etc.

...

> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/dev_printk.h>
> +#include <linux/errno.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> -#include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/sysfs.h>
>  #include <linux/types.h>

While at it, add a blank line here.

>  #include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>

...

> +#include <linux/iio/types.h>

Not sure if we need this one to be explicitly added when iio.h is included.


-- 
With Best Regards,
Andy Shevchenko


