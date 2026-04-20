Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632F7386551;
	Mon, 20 Apr 2026 09:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776676696; cv=none; b=R9hb69B2otTeKXJ1vzxoENM07kMfJ0rmU0bERpeYed8EuitVh7fuKQl95Y6ckx6/qbcZTO1UmUxRiElAWkOvJQ51C30wJFS94pzsp+TEohuYCtNdk+azPWUJKHKcU67vYOZ+kQdoWh3NO2taL1vWgGi6fVaWd18WMUOMKluAMfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776676696; c=relaxed/simple;
	bh=Ews81qwbWTDLy8MrQh7L0w6xh1yIz+OzmwfX9X6ZxTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpLokOzhLMGMk5Mz/jnYbPM1KsILyvIPFf0Xdmmtx3kLavI69f8V37MumKYbal8gxKMpHueivhZtnKn+gH1ieuB+j07bfejLW3RGaAPaQhVkuTriIbFNaBcVkQgTjFJf0j4eypHqI2MXdiAwOqS0EEnjbZ/FwXSEl2VzvtXdAJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RgUwpoFr; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RgUwpoFr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776676694; x=1808212694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ews81qwbWTDLy8MrQh7L0w6xh1yIz+OzmwfX9X6ZxTA=;
  b=RgUwpoFr9muuN6zL3r3PmM59rU9jSuf3aAZPe7XtgwQ6nYYeVDj8OXzG
   JU+TM0OdMxTCvpvDOVSoC13TCGbi5zkTq1/BFW1hdGTO4R8ID7a5OoCq5
   0R8oStevjxzhd1CKq6tfZAy60wYN3ibhoBkBk3MSpwisBICzbBwVphdz3
   LWfuGAzlU4yT2tjf08KSEgRcZpzyfAq/FZFTSP1ktzYd6QLSMMjzp2a23
   rJKGRTFvFv36lc/MZvcWZtSMjcAddD3em1fuGFSfr0TdITn9I8yrdV9Ei
   XWpz1WLe5Yy+dWLkb0qevImTZzb6tpmaaSNQ9BuTNO9JYzRDGMBvqwFPR
   w==;
X-CSE-ConnectionGUID: Wx8+A8GqQhaz8nY9bkaLVQ==
X-CSE-MsgGUID: fhUWwgo6Qu+HFvE1yrZJ+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77601899"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="77601899"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 02:18:14 -0700
X-CSE-ConnectionGUID: B8Y1CBUqSsGXj998AkT6CA==
X-CSE-MsgGUID: 85T12Jz/QYu9Svnq2XYHSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="236048689"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 02:18:10 -0700
Date: Mon, 20 Apr 2026 12:18:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hardik Phalet <hardik.phalet@pm.me>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, andy@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	dlechner@baylibre.com, krzk+dt@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, me@brighamcampbell.com,
	nuno.sa@analog.com, robh@kernel.org, skhan@linuxfoundation.org,
	Hardik Phalet <hardik.phalet@gmail.com>
Subject: Re: [PATCH v3 0/5] iio: magnetometer: add driver for QST QMC5883P
Message-ID: <aeXvTwLXeAaB5bvE@ashevche-desk.local>
References: <20260420-qmc5883p-driver-v3-0-da1e97088f8b@pm.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420-qmc5883p-driver-v3-0-da1e97088f8b@pm.me>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Apr 19, 2026 at 10:32:09PM +0000, Hardik Phalet wrote:
> This series adds an IIO driver for the QST QMC5883P, a 3-axis
> anisotropic magneto-resistive (AMR) magnetometer with a 16-bit ADC,
> communicating over I2C. To my knowledge there is no existing
> upstream driver for this device (see "Prior-art register-map check"
> below).
> 
> The driver supports:
>   - Raw magnetic field readings on X, Y and Z axes
>   - Four full-scale ranges (+/-2 G, +/-8 G, +/-12 G, +/-30 G),
>     selectable via IIO_CHAN_INFO_SCALE
>   - Four output data rates (10, 50, 100, 200 Hz), selectable via
>     IIO_CHAN_INFO_SAMP_FREQ
>   - Four oversampling ratios (1, 2, 4, 8), selectable via
>     IIO_CHAN_INFO_OVERSAMPLING_RATIO
>   - Runtime PM with a 2 s autosuspend delay
>   - System suspend/resume delegated to the runtime callbacks
> 
> Regmap with an rbtree cache is used throughout. CTRL_1 and CTRL_2

I'm not sure this paragraph answers the question "why not maple tree?"

> bit fields are accessed via regmap_field to avoid read-modify-write
> races. The STATUS register is marked precious so regmap never reads
> it speculatively and clears the DRDY/OVFL bits unexpectedly.
> 
> The probe-time init sequence is: soft reset, wait 300 us for POR
> to complete, deassert reset, drop the register cache so subsequent
> RMW writes read fresh values, then enter normal mode. 300 us
> comfortably covers the 250 us POR time given in the datasheet.
> 
> Patches:
>   1/5 - dt-bindings: vendor-prefixes: Add QST Corporation
>   2/5 - dt-bindings: iio: magnetometer: QSTCORP QMC5883P
>   3/5 - iio: magnetometer: add driver for QST QMC5883P
>   4/5 - iio: magnetometer: qmc5883p: add oversampling ratio support
>   5/5 - iio: magnetometer: qmc5883p: add PM support
> 
> Patches 4 and 5 are split out from the main driver so that the core
> (1-3) can be reviewed and picked independently, per review feedback
> on v2. 4/5 exposes the CTRL_1 OSR field via
> IIO_CHAN_INFO_OVERSAMPLING_RATIO. 5/5 adds runtime PM that puts the
> chip into MODE_SUSPEND when idle and wakes it to MODE_NORMAL on
> demand.

-- 
With Best Regards,
Andy Shevchenko


