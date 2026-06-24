Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4FF23815B;
	Wed, 24 Jun 2026 11:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782301679; cv=none; b=u2cTYwNqF6yEmxhXStVh4RrsrSlMfMWYaSpyYPMWSzo+lHRWP5W4ZquUZII48Hr7BOmEFulf4bnaPm8kSmeoTzZmmzuJD4ZtB1276xMoJqLmqmFhz8WbazzMpOR7DQUI0+B1e0vFsNbz4YS0nVrxXDkLJlD0ywC0XgvlRT1bbpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782301679; c=relaxed/simple;
	bh=Agp03wkSsFZPxxNwWNPX9hI2wfzRtyRpdiWYsY59kM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJbbml8nvrfhCcD80cWEH2UWI2Ff96EMf8W1+YrLlryYCOR4n74HcMBoXkYdOmpVsC+KYLiIE9cxiEpRQLFh1sPB2W+/oAD9KtmNn7oJQThO0dl968pz8Q4Lg8GJeFlzn+XCHgC92bnvvGjxOCbrMRFE6UFdofbRq4X4vPjLNsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a2wM9ely; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a2wM9ely"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782301678; x=1813837678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Agp03wkSsFZPxxNwWNPX9hI2wfzRtyRpdiWYsY59kM8=;
  b=a2wM9elyCikbu05iDEqeGN6aUm5gX122z1jnMTKUAMxIvGRHEBDlqUO0
   EuPLtomthYDpigBA0aV+FmmT67tkKapTNAsCrXmANoA4Bj1rmc3vk1J/h
   IN6OVYx+O7B4H3mu0QbKYdYct2KJuqrT6mVD1V8xMa7aLaSxYAFDXhgiE
   /XzzVtrzA7PUo2UMY5BaCLkBldp+gRGH+1JhPO0Zn6k8uv2g4Lrnt339+
   QvGeLygUz7P7fmbBX286F8wxzPiehWn9riEr0gwjo2GkEGyQ4SPnzPRyT
   VjDMIyvQjQLtEQvsKqclfygW6+uj++39+nsABXzXHGWy6dS4wOHpu+eAA
   A==;
X-CSE-ConnectionGUID: FyRbxHANTvuDTdLR+ogC4A==
X-CSE-MsgGUID: FZmU+uTPQB+EoyWj588pgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83181058"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="83181058"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 04:47:57 -0700
X-CSE-ConnectionGUID: DftmvEX4Q5eyYKR/L9cBhg==
X-CSE-MsgGUID: A1Cd8owpQ/+VNbMbzni0hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="246915089"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.156])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 04:47:55 -0700
Date: Wed, 24 Jun 2026 14:47:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: jean-baptiste.maneyrol@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: inv_icm42600: add buffer hwfifo watermark
 attributes
Message-ID: <ajvD6RtuDaRHoDiH@ashevche-desk.local>
References: <20260624-inv-icm42600-add-buffer-hwfifo_attributes-v2-1-12675259e688@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624-inv-icm42600-add-buffer-hwfifo_attributes-v2-1-12675259e688@tdk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 24, 2026 at 10:25:46AM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:

> Add hwfifo_watermark/min/max/enabled buffer attributes.
> Hardware FIFO is always enabled and used.

...

> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c

>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/delay.h>
> +#include <linux/stringify.h>
>  
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/common/inv_sensors_timestamp.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

Since I have another comment below, I would note that the list of inclusions
perhaps needs a preparatory patch to be sorted and regrouped a bit:

<linux/*.h>
...blank line...
<linux/iio/*.h>
...blank line...
<linux/iio/common/inv_*.h> // since it's quite custom but world visible header.
...blank line...
"*.h"

...

> +IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_min, "1");
> +IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_max,
> +			     __stringify(INV_ICM42600_FIFO_WATERMARK_MAX_SAMPLES));
> +static IIO_DEVICE_ATTR(hwfifo_watermark, 0444, inv_icm42600_buffer_get_watermark,
> +		       NULL, 0);

So, why not IIO_DEVICE_ATTR_RO()?

> +IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_enabled, "1");

-- 
With Best Regards,
Andy Shevchenko


