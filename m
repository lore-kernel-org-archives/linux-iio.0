Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C2234CFC6;
	Wed,  4 Mar 2026 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772631555; cv=none; b=TKd+MWSdC7mR7IwYAUi3GYALDu1MsSV88BuzuqrqmGFesvK1mNE+4nM1UKbN6kjZnidm3GSfDUl+ArD9UcMD+WmLpzt9fRu+ukkU++GwxwkFsTuRsHRbBq+LtYPR2P/IWnYqO67gX6YOen6uiPYgFl253qfSquQbE/+hcbtJOy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772631555; c=relaxed/simple;
	bh=hXhdcYQDbcNLP6WsaGhN/LetmATKYhJ5rvFeRguUxJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6I4yyJLiHSw2OsmozqfP89OqLp7SFskpAsqFvCYRg21iAykEr2++Ot+V10qbxpE84EdQlX1xRJ5aA6Qoz568/SA28B4BeXPlAioRBG9ym/rmEGn8B9gg1o4XsGpw1j+T1KXLDSc8dcBYpEUSy5R2pQFNomjroOySLFdW3q/TpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O5vCdcqx; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O5vCdcqx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772631554; x=1804167554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hXhdcYQDbcNLP6WsaGhN/LetmATKYhJ5rvFeRguUxJY=;
  b=O5vCdcqxIaE5yEArHexMwiAKtql8gFvyWs4jkM5OEx85aCqXnuDSDzQz
   oO7Bqu4/mb52Eq25o8AGLFUi8gViHyyPE/u6TZqnzPHhzLgLPQJNKfd6l
   tWQSOGGHo35nP+Kc1Esjoi077eeuI47CAH/jhDi67gCihiSHZyrUR+lc2
   CdGnyXnzEvbmujT+abyNVAa+YTb2a/3lnxx2E+O8lJkQG40jomBIjlrGB
   D485SE6qKfQgsw47HMi/SHvBT2CcrU/baaOi2PqyDgTBiiidBtcrlSjg8
   QyTMRZBpA6kgHyhu7bLIhftZ9Cgb4qFmRcJgiZs44s83R9x3MDEHlHTew
   w==;
X-CSE-ConnectionGUID: iVwOoanvQRCtCISJggSWhQ==
X-CSE-MsgGUID: +3c9jMU0So+havH//wTo1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="99163319"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="99163319"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 05:39:13 -0800
X-CSE-ConnectionGUID: 48+O1WGpReivhG+BzWNdVw==
X-CSE-MsgGUID: Gn1Mm0F3TUybYySGPQk4Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="222509655"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.127])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 05:39:11 -0800
Date: Wed, 4 Mar 2026 15:39:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 6/6] iio: imu: st_lsm6dsx: Add support for rotation
 sensor
Message-ID: <aag1_TpKpwpS59k6@ashevche-desk.local>
References: <20260304080519.2844101-1-flavra@baylibre.com>
 <20260304080712.2844514-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304080712.2844514-1-flavra@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 04, 2026 at 09:07:11AM +0100, Francesco Lavra wrote:
> Some IMU chips in the LSM6DSX family have sensor fusion features that
> combine data from the accelerometer and gyroscope. One of these features
> generates rotation vector data and makes it available in the hardware
> FIFO as a quaternion (more specifically, the X, Y and Z components of the
> quaternion vector, expressed as 16-bit half-precision floating-point
> numbers).
> 
> Add support for a new sensor instance that allows receiving sensor fusion
> data, by defining a new struct st_lsm6dsx_fusion_settings (which contains
> chip-specific details for the sensor fusion functionality), and adding this
> struct as a new field in struct st_lsm6dsx_settings. In st_lsm6dsx_core.c,
> populate this new struct for the LSM6DSV and LSM6DSV16X chips, and add the
> logic to initialize an additional IIO device if this struct is populated
> for the hardware type being probed.
> Note: a new IIO device is being defined (as opposed to adding channels to
> an existing device) because the rate at which sensor fusion data is
> generated may not match the data rate from any of the existing devices.
> 
> Tested on LSMDSV16X.

...

> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c

+ cleanup.h
+ errno.h

> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/sprintf.h>
> +#include <linux/types.h>
> +#include <linux/units.h>

...

> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		u32 odr_mHz = val * MILLI + val2 * (MILLI / MICRO);
> +		u8 odr_val;
> +
> +		/* check that the requested frequency is supported */
> +		err = st_lsm6dsx_fusion_get_odr_val(settings, odr_mHz,
> +						    &odr_val);

In cases like this I would leave it on a single line. Here I counted only 81
characters.

> +		if (err)
> +			return err;
> +
> +		sensor->hwfifo_odr_mHz = odr_mHz;
> +		return 0;
> +	}

-- 
With Best Regards,
Andy Shevchenko


