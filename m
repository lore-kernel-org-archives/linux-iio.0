Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A780F3ACEF5
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142350; cv=none; b=Fa5UcWScfKKVvzYH+PscPyOWTUEm1+OocneNSt+BNaKUMIa0zDWp8uzKVPhl5KP8WAL1E9kel/CMEJWIet3C2nwUtlJ/Zz3xPHqr5ccd1sO9TxpNIDewHwi38Xr7kg0UXTr5AkL/48OzvDqVz6HksPX6rGI5XlDFqQkV9mTrGP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142350; c=relaxed/simple;
	bh=xfRKmKa8pozKEwVu5o+5y889bZ3v/op31WzEdUK1kiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CA8piK23EuJLCPwCm2qZoYxy/6hIDtZcZF73HM/S8SXsQiEO7agoZfhdJpHnGEAXu1DiAYx7ytqVZmcSHp6l5fpr509P7Zyx53nVQbgH4x1I+7K1SDb8mzqCOBABMhiOLiVHAi2cEURemJm2nBzGQ/AF0TOv288Ceck+C6pmZYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UyacBkLR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UyacBkLR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770142348; x=1801678348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xfRKmKa8pozKEwVu5o+5y889bZ3v/op31WzEdUK1kiU=;
  b=UyacBkLRyuDMqhAy9BcXdISv97nHBDqpelHYTBJ42z50VeXGiVfK+REN
   vEIRz96ClZweFKts6d/Mq+i+tLcGLk5Aarv0gzW1oC6osQzf5zZy6QkQ9
   IT165/B8jmYRF5b7V+cVjRmwdZw6vXLdBj0j+3SDKbMiWFM5UjZR39+X+
   65csqeL6rI4ADfWnpUlpsaFh0u0yYghOE8hjAX7ykUqoozp/GpxqMRULX
   DI7k/MZCT1xOK1T/FPZ3m6tOCVHA+oeRIAzqzNOkEJapvoi5obFXvEGPn
   mQ7c8LXOa+XyTA5kJj1Jh4BKeQrgfWScb4WBQRgNICzcYLExm+RNl84dP
   g==;
X-CSE-ConnectionGUID: yxcPZUdzS3OP2UyO+hyHaQ==
X-CSE-MsgGUID: +/hj0rApT+qekwHalY2Ffg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82432613"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="82432613"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 10:12:28 -0800
X-CSE-ConnectionGUID: 1CY0SDBwTcKxiejt+cz6Bg==
X-CSE-MsgGUID: 5Jt0ZtAVTy+79tVmJ15DNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="247521718"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 10:12:26 -0800
Date: Tue, 3 Feb 2026 20:12:23 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 2/6] iio: accel: bmc150-accel: add support for bmx055
 accel
Message-ID: <aYI6h3sbM1JPsbZ4@smile.fi.intel.com>
References: <20260129071105.389493-1-jerrysteve1101@gmail.com>
 <20260129071105.389493-3-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129071105.389493-3-jerrysteve1101@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 29, 2026 at 03:10:58PM +0800, Jun Yan wrote:
> Add the accelerometer driver for the BMX055 IMU, which is an integrated
> IMU including accelerometer, gyroscope and magnetometer.
> 
> The gyroscope part of the device can be supported by the bmg160 driver,
> while the magnetometer part can be supported by the bmc150_magn driver.

...

>  	help
>  	  Say yes here to build support for the following Bosch accelerometers:
>  	  BMA222, BMA222E, BMA250E, BMA253, BMA254, BMA255, BMA280, BMC150, BMC156
> -	  BMI055.
> +	  BMI055, BMX055.

Better to split this a bit. like:

	  - BMA222, BMA222E, BMA250E, BMA253, BMA254, BMA255, BMA280
	  - BMC150, BMC156
	  - BMI055
	  - BMX055

>  	  Note that some of these are combo modules:
>  	    - BMC150/BMC156: accelerometer and magnetometer
>  	    - BMI055: accelerometer and gyroscope
> +	    - BMX055: accelerometer, gyroscope and magnetometer

Mind an Oxford comma.

-- 
With Best Regards,
Andy Shevchenko


