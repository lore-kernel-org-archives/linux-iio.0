Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D9E30E84F;
	Tue, 16 Jun 2026 08:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781600023; cv=none; b=WibzPA1VEYE2Ji8891aOFkO43ZnvS/0RHrxVqQJyVxW3w5GiSnChbisKLd/uT4wMshLJ3PXfyU8URf3WsImb7MmAhjoQEJAIJRTlRnyorOpKVbeEk32MFr31bSYyWKxAOv318g3nUATQTo935hH1etf35DcTejPVC1rw4x0naPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781600023; c=relaxed/simple;
	bh=4eXl+6BMV54atctUJAn+UMP+d/Cq5vNngv4WweukLZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLFeB4zsy3LyOqK2TnMugIMmhPVmLar+1NuswSOZZ13WxdiMpt0DqnkeTg0j8hJlXE8+cXRkbFM7ut7sFcKmm9mQn6AY4UpqW+gv4m+lVt3IzHZDjO6vpP9+WTZI+uiNGwnPyD7d9dGC6TrQmToZQyG7QQ855LkbAK+Wx2T41WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jzvgjEkO; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jzvgjEkO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781600022; x=1813136022;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4eXl+6BMV54atctUJAn+UMP+d/Cq5vNngv4WweukLZU=;
  b=jzvgjEkO/vJ9eHL+zfpC7rPPqy3rqCZ2ivHTKMWO4VfF/2s5PmgGwk8Y
   jyFNEqGgejahR1l0kBgLAZpGt13kOomwNnWsNG90QCBBGbKNhYxnG+Zr5
   zJxIaaXuVlUmiG3xVEuDLHyBGtH6RwmNMPPjID8Fp5T1R7Hq6p0e2ZYkT
   5v63VbVcAhpisbWxlwYsCHdcFWLUWbtTHgV3RHIG6xrvHXInDCbPugCag
   bC090FDYqTqLBNxcL4k3HXypak09zR5+8HTMiEz+nJKLa7msmAUkqrqYm
   i5hezOB8NsnpdVVYiHTypmDSSUUcspGK8yUUSQ8IocDf4uxm2/MC2gUys
   g==;
X-CSE-ConnectionGUID: Yn5OqeoORYCHBr2O2bjHtw==
X-CSE-MsgGUID: NWF+LVhfRS+ZYUvrsUwiOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82403062"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="82403062"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 01:53:41 -0700
X-CSE-ConnectionGUID: 4ynVvdJ8Rce3uTVbQCrshg==
X-CSE-MsgGUID: DKnibsVeRWWvQYqSwE2Jug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="247775232"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 01:53:38 -0700
Date: Tue, 16 Jun 2026 11:53:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V13 3/9] iio: imu: inv_icm42607: Add inv_icm42607 Core
 Driver
Message-ID: <ajEPD8gdgiuQdZ7Q@ashevche-desk.local>
References: <20260615172554.160910-1-macroalpha82@gmail.com>
 <20260615172554.160910-4-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615172554.160910-4-macroalpha82@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 15, 2026 at 12:25:46PM -0500, Chris Morgan wrote:

> Add the core component of a new inv_icm42607 driver. This includes
> a few setup functions and the full register definition in the
> header file, as well as the bits necessary to compile and probe the
> device when used on an i2c bus.

...

> +#ifndef INV_ICM42607_H_
> +#define INV_ICM42607_H_
> +
> +#include <linux/bits.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/time.h>
> +#include <linux/types.h>

+ asm/byteorder.h // cpu_to_le16()

...

> +#include <linux/bitfield.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +

Single blank line is enough.

> +#include "inv_icm42607.h"

-- 
With Best Regards,
Andy Shevchenko


