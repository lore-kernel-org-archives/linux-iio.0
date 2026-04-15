Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F68B3D3492;
	Wed, 15 Apr 2026 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776263871; cv=none; b=jbZILaB2P+wVXH1vB9p09Jd54Zf+MebhTpRaVSEb/O848cxqKIGBI8AptkQi/zjhJh6PjCuEjbCXEwh6yi6E7xot65WrVw57sKcx708GAWIuIJLvijiX5+0aLLiEQFZFOHRJp1CCNOIcbwfFadJl3t5chvzVh4bdor5iubR0VvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776263871; c=relaxed/simple;
	bh=BFqrNN1iAZHhm57ZhCGQQKENns/SG9rhO/aH0KdLUP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToW1n3M0kMMB+LZPkOFEaOLijhUSJz5IqXmvunou9rS6UIJUMiKeb9onimgsxS4LnTCH6GYT+BFooyALAgNbbIGOB68/Fo+xNuJGwRrwnQBcN4lwB4BzW1gMQY14+ibsO0K5W5wapd8i0Thpc+qE5yJe3WdX9ZaT+atBtzbqieM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V2Vg03Db; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V2Vg03Db"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776263870; x=1807799870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BFqrNN1iAZHhm57ZhCGQQKENns/SG9rhO/aH0KdLUP4=;
  b=V2Vg03DbPGOnUXv+cJoUHOFfbj3DLpDoescCUUN9rc/CmEGD572lDA8i
   pw5HijXMRZS1KFfrcc2b1DzeX61Won8cWrsHCivqr6sN/rdefmWgX8Ua6
   ZvZJCVTZNMJiiqapOZNRvlmO8wU2deIImfBJTGe01sZgoD5CL8xYrZQmA
   tCjN8Z9xyLzKzLq+YhTv1sUVNnuJ9X3Diu/p/jmy9gI1nl9tdqSaBVD0u
   CKM0TZuNn4vCd+P7RniZmCy+ChxeS8CtTEwk/+NuHtNczzk/Q2ZDADr5U
   CBNKM/dmAWBI635VZPXREAN9IiDSAa6Ugi8icKadbqj8xWUcgCMfpWYQg
   A==;
X-CSE-ConnectionGUID: NDFqRjQCSQ+Gn6/KIuTD2g==
X-CSE-MsgGUID: 8IcdY9TRS72DibKihR6pkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="79825503"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="79825503"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 07:37:34 -0700
X-CSE-ConnectionGUID: lUIXQh3GTceSm1q2mUCE7A==
X-CSE-MsgGUID: FIoRmws5Swm4TManAowMKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="230363684"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.34])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 07:37:31 -0700
Date: Wed, 15 Apr 2026 17:37:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: frequency: ad9834: clean up includes
Message-ID: <ad-iqJxCoZ18nESz@ashevche-desk.local>
References: <20260415112030.1324-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415112030.1324-1-joshua.crofts1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 15, 2026 at 11:20:30AM +0000, Joshua Crofts wrote:
> Cleanup include headers by removing proxy kernel.h
> header and unnecessary list.h, interrupt.h, workqueue.h
> and slab.h headers. Reordered remaining drivers

s/drivers/headers/

> alphabetically.
> 
> Verified using IWYU.

Probably you need to somehow elaborate that this is tool, IWYU is the acronym
of the principle, tool called 'iwyu'. Maybe adding a link?

"Verified with help of IWYU tool (...here is URL...).

> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>

...

> +#include <linux/bits.h>
>  #include <linux/clk.h>
> -#include <linux/interrupt.h>
> -#include <linux/workqueue.h>
>  #include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/slab.h>
> -#include <linux/sysfs.h>
> -#include <linux/list.h>
> -#include <linux/spi/spi.h>
> -#include <linux/regulator/consumer.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/sysfs.h>

Still missing types.h, math.h, and probably more...

Yes, asm/byteorder.h, kstrtox.h, mutex.h. And maybe even more, I just
briefly scrolled over the driver code.

If you look at Git history of the replacement kernel.h in the drivers
you may find that usually it takes 10+ headers to be added.

-- 
With Best Regards,
Andy Shevchenko


