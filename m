Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570BA2E645
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 23:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770162596; cv=none; b=VnKo65xK9H+JUgD73WwxikCs6+unpZ4bYVVohU03U17V/ceoHsc3HQK7x1sMJfBySDX87gUnrpjbOAKYBcitkyCVPZ+/VYeTQPGVFzZruXLMf9EgTm60rxrlzV6ikkAVTEPB4A542xuxpZOm7Q4OR3iYaG3fysJYsfGAsVEAllI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770162596; c=relaxed/simple;
	bh=jN27AHIW6plVE8NU7yJp3PET0X7/6zou9zizoZtcyj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPl7MOJNjfQexZ7ambwA9ofMe4PyRF5uOUXni3CpJ3JwiGjcJAhiVoxh6kk+DE0rNyLDF1WIxFmKIyTY2vM9cWhoJODGzUqr5mnr3pWYyldi9pU6Re+sR5zJ1upLBjVTEMYgJw1vUqOp0U6ns+uuBlvqKay1hZzeJkmSmgRRUAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h7pHtQup; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h7pHtQup"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770162596; x=1801698596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jN27AHIW6plVE8NU7yJp3PET0X7/6zou9zizoZtcyj0=;
  b=h7pHtQup69ZNYzG0UlxB4ckjljTvtZpRBwZ78QEI/Qt7INm0MNu4NJli
   T/NIH0Gxj6cC8kcN/YJLSyu50y2eCIOOZJauAotFXArUHetrxwbgClrVK
   hLNXcEYlAEJpqQlha3mbXzPxnX/0tqSWNf+mH1BEzp8skJIEeUnwfXyUE
   aARLA9ympRmGjw4Tns8F4U9c6xBXNHZ6pq9wIcxwXo7tTYTvQKrN+Vbcl
   k9/lXeQVGO8L8OJFxmJsU9ldYJ3NSZS38QspQbvYf01vTuxlH9CkFkYkl
   d1LohRKTzgZbQQxsSqZLxKMDWGhXCNOl89TR03FfgM/a0QqKPIc5xE5K3
   w==;
X-CSE-ConnectionGUID: Vq6Y52Z8RkqQwHR3Odim6w==
X-CSE-MsgGUID: 8jdbPCySTQmpofaZ3SHXmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="74965676"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="74965676"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 15:49:55 -0800
X-CSE-ConnectionGUID: li+PZTIjRNqrsWhLfEOeJA==
X-CSE-MsgGUID: 6p+q/DC6Ssu3c3M8wYi/hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="214540509"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 15:49:53 -0800
Date: Wed, 4 Feb 2026 01:49:50 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 4/6] iio: magnetometer: bmc150_magn: add support for
 bmx055 magnetometer
Message-ID: <aYKJnj-vxDn-gUS2@smile.fi.intel.com>
References: <20260129071105.389493-1-jerrysteve1101@gmail.com>
 <20260129071105.389493-5-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129071105.389493-5-jerrysteve1101@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 29, 2026 at 03:11:00PM +0800, Jun Yan wrote:
> Add the magnetometer driver for the BMX055 IMU, which is an integrated
> IMU including accelerometer, gyroscope and magnetometer.
> 
> The accelerometer part can be supported by the bmc150-accel driver, while
> the gyroscope part can be supported by the bmg160 driver.

...

>  	  This driver is only implementing magnetometer part, which has
>  	  its own address and register map.
>  
> -	  This driver also supports I2C Bosch BMC156 and BMM150 chips.
> +	  This driver also supports I2C Bosch BMC156, BMM150 and BMX055 chips.
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called bmc150_magn_i2c.
>  

>  	  This driver is only implementing magnetometer part, which has
>  	  its own address and register map.
>  
> -	  This driver also supports SPI Bosch BMC156 and BMM150 chips.
> +	  This driver also supports SPI Bosch BMC156, BMM150 and BMX055 chips.
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called bmc150_magn_spi.

Mind an Oxford comma in both cases.

...

>  	{"bmc150_magn", 0},
>  	{"bmc156_magn", 0},
>  	{"bmm150_magn", 0},
> +	{"bmx055_magn", 0},

At some point we need to get rid of ', 0' parts.

-- 
With Best Regards,
Andy Shevchenko


