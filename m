Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE833DB62B;
	Tue,  2 Jun 2026 23:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444758; cv=none; b=uEmlu1VBxUouhybzAgGtifjNUuEB+ez+acteaK6ikorcVX/5BDnbz+TtijvUmBP8LHWkFmPxndY4B8em4VQgvQNfwu11cQ3AhmiFiq+cXTKnx91OtbRAQl0UpVvePJykteIC7vEbHAcbzQ6NPzBMoVq7mfjQsAy0sY8IgicmMuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444758; c=relaxed/simple;
	bh=pOhBfaxZFb1UNByK3qBSb/A3iQDnWRbzXSMsaT4vZQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8WD0HlSYOtlMR0BVd2gpq9zmGxKFGE3VJSOxZ/2C28VQXLB+0LDrjoR1GXkMYmBHjB/BssEk9yhbEemCUi3glfjqe102ZT8pjqDMP+ZJk44y4SEtVm/Jhl33J84lM2cnzWwMg3zRUllZs0nmfTxOALti2tyaggLmF2qfD/iOjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D/3HZEjI; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D/3HZEjI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780444756; x=1811980756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pOhBfaxZFb1UNByK3qBSb/A3iQDnWRbzXSMsaT4vZQQ=;
  b=D/3HZEjI+Pp7tADpeX3tXcmY+UoGCTb4hZ4cev7p/perxMrv+AMhKWO1
   2ja6agciwQeiNq1b6NKXd5v+kdWEPx4wRKnGt/BBrxvSlSO4VQ/r9BzF8
   1p9lf3v3wHAsuEeY+2PJoRl4kOwmyjq1sg7g/6nyX2CO975hxs1+6psf4
   ajat4AD5fwQCcSbs0iHeiSp4Q/vca93E4IXucfxdab9rggXfLte49W4FA
   E+tp1Ra5Vu/XCkCbLDgXN5plwRRLzA8PCPKZOFLPMN7OK+GK5VJIguAkm
   9g94oQj2Ht4BaJc4HZE4M5cGkfKbTq2t5tIIS9C5JpaUDk0PZT8LkzShG
   w==;
X-CSE-ConnectionGUID: NUV+MBNiQRmpiLR6icvbhQ==
X-CSE-MsgGUID: Gx0/ZhxMRyqZqsodpfRYMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="80383907"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="80383907"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 16:59:15 -0700
X-CSE-ConnectionGUID: pt27Bkt5Ssm9vOwmxiRclw==
X-CSE-MsgGUID: z0zeDeHDSEeQUfGAbaxXsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="248363140"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 16:59:12 -0700
Date: Wed, 3 Jun 2026 02:59:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 0/7] iio: add Open Sensor Fusion UART driver
Message-ID: <ah9uTfl6IZaTCeQC@ashevche-desk.local>
References: <20260524085312.15369-1-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260524085312.15369-1-kimjinseob88@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 24, 2026 at 05:53:05PM +0900, Jinseob Kim wrote:
> This series adds an IIO driver for a UART-attached sensor aggregation
> device. The device sends OSF0 binary frames over serdev UART. The driver
> uses capability reports to register IIO devices for supported sensors.
> 
> v2 preparation changes:
> 
> - split the previous RFC driver patch into smaller patches
> - add a Device Tree binding
> - add an OSF0 protocol reference
> - use get_unaligned_le16/32/64() for wire fields
> - use IIO timestamp handling for buffered samples
> - push decoded samples directly to registered IIO devices
> 
> Tested path:
> 
> - STM32F405 OSF0 UART stream
> - Raspberry Pi 4 serdev
> - kernel 6.12.75+rpt-rpi-v8
> - IIO devices: osf-accel, osf-gyro, osf-magn, osf-temp
> - raw reads from accel, gyro, magn, and temp
> - buffer reads from accel, gyro, magn, and temp
> 
> No OSF oops, panic, or call trace was observed in the Raspberry Pi
> runtime smoke.

My comments from the previous version seem still valid.

-- 
With Best Regards,
Andy Shevchenko


