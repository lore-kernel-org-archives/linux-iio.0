Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88343392C3A;
	Fri,  8 May 2026 09:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778231980; cv=none; b=ZYxKg2ZQM+W2Y10y6nCmBMRg8GhAiHtA105EoTl6MO5n6DKqojL7mJhsrJYUOt1R9YqbZy8V9GxsXW9Zn3XC45utr9jS74LUWvPVAwfjBnzAcaJoTHe+PKilfR4OHkhnKFaDwUgfGo+AgntYf0tkWaSi2QxtoKFo9jtT5BKnh6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778231980; c=relaxed/simple;
	bh=evgdrf1uUbXqKdff9nbCCOTZC5KS9mqxfsfg/KUKK40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xzm5AcrDLQcj4JQvIBw+OEzjfYl1uCMYC1cAqPmPzR7+UrM5r7CMcVLpXUU/NVeOA78vdp9EAWLt20cvyY+oIFJiENGLArRwAC/G5QQsNl16FqYMzQIj2QeNCK4OoXxN5Rgg+exmg9UigrGwEGRMnA/C1ujd3t3qM8l5Cq6HoAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cXS1hxeb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cXS1hxeb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778231977; x=1809767977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=evgdrf1uUbXqKdff9nbCCOTZC5KS9mqxfsfg/KUKK40=;
  b=cXS1hxebfMrpYZsbgo6kGPKnzHiwFy3mWfQdMDEoOKBqTAogzo5zGNwR
   qKtaOs9gWWBc8bSuifxg3bWeGivH25BzNa3IskRlWqy5hc7XQwstVtHPp
   8f5JfOc6MKGp5WTshl8Z8e6stQ22/zj/RJ6RVuVDNpNJ33J4Y9xsQ1ogh
   HwQVwa1SolwjZKwLRAtdvBVCRGVAZe8giuXfsrmdVP5JnRJXHgNVyjnv3
   viP6G2yD9uM0sjDiWH0s/ItK806Hpoz3Q9r83M1arLRmsoeNEh59M7V8j
   mgz2wq4k6UlYc/wchKjrLH7HRsrWlRzUQHrFlrefpRZSdRV0dj8TYy0co
   Q==;
X-CSE-ConnectionGUID: WHEKf4zORqiLYClR5bAEyw==
X-CSE-MsgGUID: E5J5RakfRae0AY6I3ehKaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="89897109"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="89897109"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 02:19:35 -0700
X-CSE-ConnectionGUID: YT11dSKiT+qeksO4fNui/w==
X-CSE-MsgGUID: WXlKqgP6Q7yuCMPNtxCa4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="241064668"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.237])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 02:19:32 -0700
Date: Fri, 8 May 2026 12:19:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Vladislav Kulikov <vlad.kulikov.c@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: magnetometer: add MEMSIC MMC5983MA driver
Message-ID: <af2qoVNumFdxlXkS@ashevche-desk.local>
References: <20260507124724.813043-1-vlad.kulikov.c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507124724.813043-1-vlad.kulikov.c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 07, 2026 at 12:47:21PM +0000, Vladislav Kulikov wrote:
> Add an IIO driver for the MEMSIC MMC5983MA 3-axis magnetometer over
> I2C. The driver provides raw magnetic field readings with per-measurement
> SET/RESET offset cancellation, giving 18-bit output with a full-scale
> range of +/-8 Gauss.
> 
> Tested on a Raspberry Pi 2B with the sensor on I2C-1 at 0x30.
> 
> The following chip features are intentionally left out of the initial
> driver because the public datasheet does not provide enough detail to
> expose them confidently through stable IIO ABI, or because they still
> need more validation:
> 
> - SPI transport: deferred because SET/RESET polarity behavior has been
>   reported to differ between I2C and SPI, especially around SET/RESET
>   timing and/or SPI mode.
> - Temperature channel: deferred until the temperature output behavior is
>   better validated.
> - Continuous measurement mode and Auto SET/RESET: deferred because the
>   datasheet does not clearly define the interaction between CMM, TM_M,
>   Meas_M_Done, and SET/RESET sequencing.
> - Saturation/self-test bits: deferred because the applied test field
>   strength and bit lifetime are not specified.
> - BW/decimation filter tuning: only the documented measurement timing is
>   used; no filter response is exposed because the filter topology and
>   coefficients are not documented.
> 
> The driver uses a conservative 500 us post-SET/RESET delay before
> starting the following measurement. The datasheet describes a 500 ns
> SET/RESET coil pulse, but existing sample code and practical testing
> indicate that a longer software delay is needed before taking the next
> measurement.

Missed section for a new driver. Id est answer the question "Why a new brand
driver? Do we have something similar in IIO  already to be expanded to cover
this HW part?"

-- 
With Best Regards,
Andy Shevchenko


