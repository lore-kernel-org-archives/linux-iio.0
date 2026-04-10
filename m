Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4DE1A5B8A;
	Fri, 10 Apr 2026 04:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775795780; cv=none; b=fCCzCKSRGxqkAeBt73Dc86QgxrWT83WeIzFjqZwUUlmUkixCGzE77il9fkaPuBn9AZW7WSvzOqx3SCIsLbOdKR37Ep1a/Nzb53UOM2KqlB0cs/LfsevrpQUoMf+7J38mdqaohzifb0bWeRc5az5MHnrRXU8krrSeqRpLyE1IEQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775795780; c=relaxed/simple;
	bh=WyAPf4u3OnCDlYw52PEw13Dsu76+nIGYYHDYX1XBV0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2hIas2W0v8c3apndrBmpLLONjB37ymDZTFfMldk4XaqaFfzEg6DM0dXnNwtodfNK4qRFAkDp2nQY35xTNikfxD0r7NFTizzzc9swCBZS6spDDVtbAsa7gOUqCWBaLC2oUZ/RcTO/5Svn7Ja3llCggntggOMGg6RPnq8rJg2Gqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jRuE6tPM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jRuE6tPM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775795779; x=1807331779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=WyAPf4u3OnCDlYw52PEw13Dsu76+nIGYYHDYX1XBV0Y=;
  b=jRuE6tPM21YvUgYpXvNBhsD6CKRVCZUpDwQzr6JZMCy7JdcBRXZBNVyC
   QHQfVjY4LPDhKMGF1qM/dTeSIKI7jQxE8p5STs36mOq4zUJCBWSg4kDPN
   5SB9hGb+alWcC1WOFoxUHh0+o2dNmR5kYHTYeXagJZHO1xVei37lEFG8Y
   MYMF4n80QOKGOjhp/+5jeagJE7biu6IWppUeQ3K2QhgwLDn8MSLsq5UG1
   +LKYyS9xII2okMhcs6lDmAYRkNf24w9rMnIA1J3jfjFQyvfb1Ywa7Kz8X
   M8pDZM6zLFywC1Lqwk31md/SD+purJtlRrOCUFxo6vf573GXHiamSIyjF
   A==;
X-CSE-ConnectionGUID: O10bEmzdRCO/Qw8hEV5Y5A==
X-CSE-MsgGUID: HPoO1H3lQri/uwuwmWlJOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="80700111"
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="80700111"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 21:36:18 -0700
X-CSE-ConnectionGUID: VEGK0P0OQk+tBgohmJFROQ==
X-CSE-MsgGUID: gSDzWepjS6amvvylZdzBYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="252335932"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.51])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 21:36:15 -0700
Date: Fri, 10 Apr 2026 07:36:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hardik Phalet <hardik.phalet@pm.me>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 0/4] Add QST QMC5883P magnetometer driver
Message-ID: <adh-PKgh5C0-iAah@ashevche-desk.local>
References: <20260409210639.3197576-1-hardik.phalet@pm.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260409210639.3197576-1-hardik.phalet@pm.me>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 09, 2026 at 09:07:11PM +0000, Hardik Phalet wrote:
> This series adds initial Linux support for the QST QMC5883P, a 3-axis
> anisotropic magneto-resistive (AMR) magnetometer with a 16-bit ADC that
> communicates over I2C. To my knowledge there is no existing upstream
> driver for this device.
> 
> The driver supports:
>   - Raw magnetic field readings on X, Y, and Z axes
>   - Four selectable full-scale ranges (±2 G, ±8 G, ±12 G, ±30 G)
>   - Configurable output data rate (10, 50, 100, 200 Hz)
>   - Configurable oversampling ratio (1, 2, 4, 8)
>   - Configurable downsampling ratio (1, 2, 4, 8) via a custom sysfs
>     attribute
>   - Runtime PM with a 2 s autosuspend delay
>   - System suspend/resume via pm_runtime_force_suspend/resume
> 
> Regmap with an rbtree cache is used throughout. CTRL_1 and CTRL_2
> bit fields are accessed via regmap_field to avoid read-modify-write
> races. The STATUS register is marked precious so regmap never reads
> it speculatively and clears the DRDY/OVFL bits unexpectedly.
> 
> The init sequence on probe is: soft reset → wait 1 ms → deassert
> reset → configure SET/RESET control → apply default ODR/OSR/DSR/RNG
> → enter normal mode. This ordering was determined empirically on
> hardware to produce reliable, non-zero axis readings.
> 
> The driver is placed under drivers/staging/iio/magnetometer/ with a
> TODO file tracking the remaining work before it can graduate:
>   - Triggered buffer support (iio_triggered_buffer_setup)
>   - DRDY interrupt support
>   - Self-test implementation
> 
> Patches:
>   1/4 - dt-bindings: vendor-prefixes: Add 'qst' for QST Corporation
>   2/4 - dt-bindings: iio: magnetometer: Add binding for QST QMC5883P
>   3/4 - staging: iio: magnetometer: Add QST QMC5883P driver
>   4/4 - MAINTAINERS: Add entry for QST QMC5883P magnetometer driver
> 
> Testing
> -------
> Tested on a Raspberry Pi 4B running a mainline kernel (aarch64) with a
> GY-271 HM-246 board connected via I2C bus 1. The chip was confirmed to
> enumerate at address 0x2C via i2cdetect.
> 
> The driver was cross-compiled from Fedora (x86_64) targeting aarch64
> and loaded as a module (qmc5883p.ko) with the Device Tree overlay
> pointing at i2c1:0x2c.
> 
> Verification steps performed:
>   - Chip ID register (0x00) reads back 0x80 on probe, confirming the
>     correct device is present
>   - All three axes (in_magn_x_raw, in_magn_y_raw, in_magn_z_raw) return
>     non-zero, stable values when the board is held still and change
>     appropriately when the board is rotated
>   - in_magn_x_scale (and Y, Z) returns the expected fractional value for
>     the default ±8 G range (1/37500000)
>   - in_magn_sampling_frequency / _available, in_magn_oversampling_ratio /
>     _available, and downsampling_ratio / downsampling_ratio_available all
>     read and write correctly; the chip responds without error to each
>     valid setting
>   - Runtime PM: after 2 s of inactivity the device enters suspend mode
>     (MODE = 0x00 confirmed via i2cdump); the next sysfs read correctly
>     resumes the device and returns valid data
>   - System suspend/resume (echo mem > /sys/power/state) leaves the
>     driver in a consistent state; readings remain valid after resume
>   - dt_binding_check passes for patch 2/4
>   - Kernel builds cleanly with W=1 and no new warnings

This driver is rather huge. There are mistakes you made in the process, though:
- never send a new version for such a code (amount and complexity) earlier than
a week; give others a chance to review
- do not put driver to staging, why?
- the investigation is rather poor about existence of the driver — make sure
there is no compatible (by register layout) driver in IIO or even outside it
(for ADCs it might appear as HWMON [drivers/hwmon] or INPUT [drivers/input]
 in some cases)

-- 
With Best Regards,
Andy Shevchenko


