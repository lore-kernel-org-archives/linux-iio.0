Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4C7370D44;
	Wed, 22 Apr 2026 19:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776886219; cv=none; b=kz3yOTxYo+rcF1UIQnJXTsTwOlB6l7axrjJGvSoO+dXqvkB66z9bf+1CvmqLZpNIfwR7uRUp+4H0dK23rB0rBOAIcNON1ax1J5R2vRTxhSxMYIJSHziV8I6FjD9rhpzeM45A175IEnplFBk2uRCfZyzsTorJBzZyxrTqA1aU4RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776886219; c=relaxed/simple;
	bh=H5tft6W49RubSDPHsjuuGwukGK8MKAOmHqniirnmiXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amwmFFO+oSKYIEok3PteeB4mDW1I+s9jFmkgkG6Mql+5+tpU0rcW036dUPTYIHEM2yF9+MADfHMpf9JQn9hebch1aditw8gwBtcVS2iPaPOrZQWxTu3O4+ux/ZU6CGYOIZIATs+WQa2j2hDSb9SxQR/36XwSZWYRrluR//eCD+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qq3OO6Bx; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qq3OO6Bx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776886217; x=1808422217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H5tft6W49RubSDPHsjuuGwukGK8MKAOmHqniirnmiXY=;
  b=Qq3OO6BxdubvYK8e//n5rnABSA5XrinSAJhh8Jki9cvegrQJ2vaFTK1m
   AmLIAbQFf/6sg1FehXxG/SojlnWjVcmg+NXizkx/+gwQv+FyGFBe7pIVD
   XvHtbZ+WgM0j72BVw837ely+kV+3SG+Q58e/alz7VDioZ3Qp00osWTOI1
   faC/0iWebR+wG6jTfCaySiMZqW2zdYURnLqOZ8ISjb2P5i0Vj6xHQxZ6n
   b8BIgZWpdwQbUt2L6wSRIjNNWdZ/1XvCV40PX/CGxthRfeGaASE9IYrvh
   ierR2wjjmzWg4BUFJOKK08fiwSfmByssl6ti/3nXxRCrRG2o0XLXVh7dU
   A==;
X-CSE-ConnectionGUID: 0vJJvrgNTKOcO51FQRju2Q==
X-CSE-MsgGUID: x8tlo1//QeqItkZiWxUXMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="95264710"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="95264710"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 12:30:15 -0700
X-CSE-ConnectionGUID: Y0+GkkTySl67QgjfxXllWQ==
X-CSE-MsgGUID: An1QVX0DT0W9ph28zrDdQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="229262422"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 12:30:13 -0700
Date: Wed, 22 Apr 2026 22:30:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, sakari.ailus@linux.intel.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iio: accel: mma8452: sort headers alphabetically
Message-ID: <aekhwk14at43zT7f@ashevche-desk.local>
References: <20260422165643.2148195-1-sanjayembedded@gmail.com>
 <20260422165643.2148195-3-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422165643.2148195-3-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 10:26:39PM +0530, Sanjay Chitroda wrote:

> Sort include headers alphabetically to improve readability.

...

> -#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/property.h>
> -#include <linux/i2c.h>
> +#include <linux/types.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> -#include <linux/iio/buffer.h>
>  #include <linux/iio/trigger.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
> -#include <linux/iio/events.h>
> -#include <linux/delay.h>
> -#include <linux/pm_runtime.h>

> +
>  #include <linux/regulator/consumer.h>
> -#include <linux/types.h>

For this driver the regulator/consumer is a regular header and can be moved to
be between property.h and types.h.

-- 
With Best Regards,
Andy Shevchenko


