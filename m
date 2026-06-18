Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF47F33F383;
	Thu, 18 Jun 2026 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781809233; cv=none; b=HuagPj+jSaXl7/6BZ3uxW6gNOx1geNEa322SeYWFo76RaMkCEfZfJTzXHO7fEVDmWQcrkRVtrE4V8HozRyJPLu5rDBdg9ThsPU+c7idpQZw+zQavw3bCbOCrjAcGhyayG+vPHIGHAL7wu7/u7UNJzaZ1K+RYeeNaczffMBlJfuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781809233; c=relaxed/simple;
	bh=uwrKGooD/XFWVSoz9Nbrm3hYukYYWRsR61eew9SX6QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5Sqam79KcmA1KOHKfQzzCc0QX5GDqNxIG6FQ7orHRkc4tAKR2+uWaMztSMXUfp7Xw7GM8PwuniJCM9QifRgdhq/xi3qUCV5mDupxFSV7ZEhAVX0bnlPSb2ayUCK2UzimorxrMoumsOOJ7VZSI5ntZwZZ3GurZVe7FOthazeCQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nWAlu7vq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nWAlu7vq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781809230; x=1813345230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uwrKGooD/XFWVSoz9Nbrm3hYukYYWRsR61eew9SX6QY=;
  b=nWAlu7vqO0cmYkbNuC1+I533oavx43lVCdLjLzDhpxieSIvZVEWuHX6o
   1RL1KbZnoCEVGx/ZcdzGokHr1bFDNHADwkODgcbkySLQ+T4vjaeTWQklM
   KzQSGMk0BgFqmvUjIfT/VOm9InnJBjVuRA0+/gm0fm9Bl9QDI/pcTTfI5
   J3u0TP9pbJh/Xx541vrwB3+ktIYld+JCQhsYrH90agyMFuBFLr7Afpsqi
   jcr8lbUAfXHyoN3GltfBLuyZFhoSCSRZyeDz46e/TU2y76mlOIT02Kgsk
   WFELQlbzbXf8jH114snYB+AkTNdBLLZOYUv4bFrxri89sBRheZONryzks
   g==;
X-CSE-ConnectionGUID: NrNmKyIVScGgTACgaG9plA==
X-CSE-MsgGUID: iZhQjb57THKDqW+S1CRRkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="82665150"
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; 
   d="scan'208";a="82665150"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 11:59:08 -0700
X-CSE-ConnectionGUID: lXTew5dLR0OP2mG8IS4NDQ==
X-CSE-MsgGUID: HIIPBauwR4K4zZ4S+j6RXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; 
   d="scan'208";a="248524360"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.10])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 11:59:04 -0700
Date: Thu, 18 Jun 2026 21:59:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: magnetometer: add support for Melexis
 MLX90393
Message-ID: <ajQ_9uHMcTY2Hnmx@ashevche-desk.local>
References: <20260618160141.11409-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618160141.11409-1-nikhilgtr@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 18, 2026 at 09:31:39PM +0530, Nikhil Gautam wrote:
> Hi,
> 
> This series adds initial Industrial I/O subsystem support for the
> Melexis MLX90393 3-axis magnetometer and temperature sensor.
> 
> The MLX90393 supports both I2C and SPI interfaces. This series
> implements support for the I2C interface while keeping the driver
> structure transport-independent to simplify future SPI support.
> 
> Currently supported features:
> 
> * Raw magnetic field measurements for X/Y/Z axes
> * Raw temperature measurements
> * Configurable gain/scale selection
> * Configurable oversampling ratio
> * Direct mode operation through the IIO subsystem
> * I2C interface support
> 
> The driver has been tested on Raspberry Pi 5 hardware using an
> MLX90393 sensor connected over I2C. Magnetic field and temperature
> measurements were verified through the IIO sysfs interface.

This doesn't answer to two important questions:
- why do we need a brand new driver?
  Can't one of the existing be updated to cover this HW?

- where to find the datasheet? Any Links or other means to get it?

-- 
With Best Regards,
Andy Shevchenko


