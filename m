Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A733C495046;
	Fri,  2 Oct 2026 13:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946304; cv=none; b=d7zLFn/5UrDkiqrKsEO4Ms0VUjyVF1uzUsFGCPtQPqqJ5TFc9Xo8glYfW8MsP4LGWQK46Jp1C6czKwq5EOhvvjOuDvRRAfyjBYnRx7pugHyTE9jFX0MzldtaSEFz6Kuo+LRccdRMFqHlXY0wNsmy5K+tzhG4EeUmf05bI61Fg3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946304; c=relaxed/simple;
	bh=289DZ6JiRG+M4wMsk8erbXXe25eqe8qAT+bL1cCZqaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqftxOogQSVhdM63wR7i6tIqnOsgdkwXziGzYY4YwWVQ9XsIPTBanWab4dVkZ4Y1dGQan3J6k//JH1LJomtbwHlEG6JiEQZ5uWScjn4DiIehqY5rxqn/VCi+233T/U1MiWGvIXQ0rlcYFBo1MErNuBaZTzKrBcPcGjOUDsPvJcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YzC04hWq; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YzC04hWq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790946301; x=1822482301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=289DZ6JiRG+M4wMsk8erbXXe25eqe8qAT+bL1cCZqaM=;
  b=YzC04hWqeeHilyBwuT/HjbvzCIRN3AnOd9ShVzBJQ9mExk7FRem19rrO
   ljkf3VxzJBmOauyvN5+DuQoN6eSMENqUsRUb9MIaLUtiot5xNQCZoEyQx
   6bv+prqSGVMoS3xlnXCuN5kQeMs542R2SmRcrhbGoxgqelE3vpMfb5gru
   /zl481q78wVSCNBql6oxGtAzGOzUjWQOji7U17rSX8jgc6UU5vS4acQmf
   tBZbN4VjPRq2pYWpXF6+diYv6FkyM9xBgfYArAcVWYTSdeN6mBH0J2aVo
   mrUMPJztFspa4yq/D/XhC5LuvuqPi3mZuCffuJyKNSNRsn1Ga0MD81q8U
   Q==;
X-CSE-ConnectionGUID: MA5cNl8aTEaqvs9jxkqezQ==
X-CSE-MsgGUID: XujY7mepR1qQbXETzH5lFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90922518"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90922518"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 06:04:57 -0700
X-CSE-ConnectionGUID: rb/GzBuUScCWhsV+JwVDFg==
X-CSE-MsgGUID: EnD0veMoTZ+hlXsCWG1SLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="274051669"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 06:04:54 -0700
Date: Fri, 2 Oct 2026 16:04:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>, kernel@axis.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/6] iio: imu: inv_icm42607: Add support for
 ICM-42370-P
Message-ID: <ar-r80gJSb3U-MwB@ashevche-desk.local>
References: <20261002-b4-inv_icm42370p-v5-0-c65281b745c9@axis.com>
 <20261002-b4-inv_icm42370p-v5-4-c65281b745c9@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-b4-inv_icm42370p-v5-4-c65281b745c9@axis.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 02, 2026 at 01:54:28PM +0200, Kanak Shilledar wrote:
> Add support for the Invensense ICM-42370-P MEMS MotionTracking 3-axis
> accelerometer with built-in temperature sensor. This device is almost
> identical to the existing Invensense ICM-42607-P IMU, but lacks
> gyroscope. The device supports I2C, SPI and I3C. Implement only I2C
> support for now, and provide support for raw sensor reads via sysfs.
> There is also a built-in temperature sensor but it can not be turned off
> similar to the ICM-42607.
> 
> While at it, change so dev_err_probe() is returned
> when the WHO_AM_I read fails.

...

>  	}, {
>  		.name = "icm42607p",
>  		.driver_data = (kernel_ulong_t)&inv_icm42607p_hw_data,
> +	}, {
> +		.name = "icm42370p",
> +		.driver_data = (kernel_ulong_t)&inv_icm42370p_hw_data,
>  	},
>  	{ }

...

>  	}, {
>  		.compatible = "invensense,icm42607p",
>  		.data = &inv_icm42607p_hw_data,
> +	}, {
> +		.compatible = "invensense,icm42370p",
> +		.data = &inv_icm42370p_hw_data,
>  	},
>  	{ }

Keep the ID tables ordered by name/compatible.

-- 
With Best Regards,
Andy Shevchenko


