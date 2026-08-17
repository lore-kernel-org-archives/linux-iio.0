Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41FB4B049C;
	Mon, 17 Aug 2026 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786992440; cv=none; b=tHhXDUpHg+mewaa27/q8ofJjsYo0+KGtjTcUafQwXe/9Gp4i6JqL/nRdEViO8LZvKCyR/kTUB3zHfHYQQBSYLgm6ZTy41s9zT8gYBSWwephFVqVIgxJLkEVdYscG5gZowVyhuhgfO08JlZ2hPcvJnwfZTQv6MqvAnXPCN4agXbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786992440; c=relaxed/simple;
	bh=zDRDQUkuYLixhc7ZUiUAi0G43+BV2zul0H02ecleAcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1cuIhfdl8wgitpZY0YbTS08KLGmM8CegfyDvkaKC7PLrdw5FLXk/Yk/AE7IVBP/sIdgVxkGswZpyx70eibL3bpuN2XfC1hcwhpcw0snBz8/3wx85mwoi+2/XcMuYn1tMp5Ql9fgUKwgLzYRIfWNQXXRdldaWOX/hDCBGlOMXyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n4fxWB7O; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n4fxWB7O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786992439; x=1818528439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zDRDQUkuYLixhc7ZUiUAi0G43+BV2zul0H02ecleAcE=;
  b=n4fxWB7O+OTEoyopZpZMUcxVUZ8ypKWpgBAwoVHn9z4K3hEQL71hVQFV
   GI1PAhUUslBQbmpkEbrDkf55+byb5OY4yy74WmshGy8VW7RUm8NCXChNQ
   LuNs87RnpqbBiU8HrI8whEM1V4B25TFsn8is2QwmOKfrjG5yVC212ub9N
   DIJj7JJb5CZjeM1hLBmmedo7cz74ejZcxlS03KWYfMfHG+F7afBfaCuv4
   00U3UqRzxPhUSVGrT1G+3N1adOVwkcDFc6p98CVHm2bDDiyFq9NXCrYAi
   rz4SdM6X6Z4Z6VjDHIpA2O+Mj0D/6eEi888S30kTkvsv3Qn3OZKaPQNb3
   A==;
X-CSE-ConnectionGUID: 2SvL5/AyQ22hH2XeQt4xpQ==
X-CSE-MsgGUID: qStdcNdcSrem6Ozlb3AeHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="91347478"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="91347478"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 11:47:19 -0700
X-CSE-ConnectionGUID: EmalknGgSdCT4VKga8v5cQ==
X-CSE-MsgGUID: LygTtJiaQI65/Yur2eXsww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="270199929"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 11:47:16 -0700
Date: Mon, 17 Aug 2026 21:47:13 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] iio: pressure: dps310: FIFO and triggered buffer
 support
Message-ID: <aoNXMdpsUPvaGwFR@ashevche-desk.local>
References: <20260817170725.1074078-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817170725.1074078-1-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 17, 2026 at 08:07:22PM +0300, Rupesh Majhi wrote:
> The dps310 has no buffer support today. This series adds it, with the
> hardware FIFO used when no external trigger is attached and the FIFO
> left disabled in favor of the trigger when one is, so the switch between
> the two modes can be reviewed together rather than in two submissions.
> 
> Patch 1 fixes the CFG_REG bit definitions and replaces the standalone
> fix I sent on 27 July, which Jonathan asked me to fold in here instead:
> 
>   Link: https://lore.kernel.org/linux-iio/20260728223009.0cb86996@jic23-huawei/
> 
> All three of those defines have been wrong since the driver was added,
> but only P_SHIFT has a user and only that one misbehaves, so the patch
> carries a Fixes tag for the original driver and one for the commit that
> added the first user of P_SHIFT, along with Cc: stable. The FIFO enable
> is needed by patch 3.
> 
> The three INT_SEL interrupt enables at bits 6 to 4 are still not
> defined. Nothing uses them, the driver has no interrupt path, and the
> binding has no interrupts property, so adding unused defines to a fix
> did not seem worth it. David also asked for the register defines to be
> sorted low to high. That is a cleanup series of its own once this lands.
> 
> Patch 2 adds the triggered buffer path.
> 
> Patch 3 adds the hardware FIFO and the selection between it and an
> attached trigger. Those started out as separate patches, but the branch
> on iio_device_get_current_mode() is four lines and the FIFO patch is
> wrong without it, since postenable would otherwise start the FIFO while
> a trigger was driving the buffer. Splitting them would only have left a
> broken commit in between, so they are one patch.
> 
> Verified on an Infineon DPS310 breakout wired to a BeagleBone Black,
> running this series on 7.2.0-rc2. Two modules built from the same tree,
> differing only in the three CFG_REG defines corrected here, loaded
> seconds apart. Three reads of in_pressure_input per oversampling ratio,
> ambient 98.4 kPa and 27.2 degC:
> 
>   OSR    before              after
>     1    98.433  98.428      98.445  98.446
>     8    98.460  98.460      98.477  98.479
>    16    -ERANGE             98.566  98.564
>    32    -ERANGE             98.428  98.427
>    64    -ERANGE             98.464  98.463
>   128    98.439  98.440      98.434  98.434
> 
> Pressure oversampling 16, 32 and 64 return -ERANGE before the fix.
> P_SHIFT is never enabled, so the result register no longer matches the
> scale factor the compensation divides by, and
> dps310_calculate_pressure() ends up negative. 128 is not affected in
> practice. Temperature is unaffected throughout, since TMP_SHIFT_EN was
> already defined correctly.
> 
> Everything else was checked with checkpatch --strict and a W=1 build,
> plus an arm build for aspeed_g5 and a boot under qemu-system-arm -M
> rainier-bmc, which covers probe, the sysfs values, raw times scale
> matching processed, EBUSY on sysfs reads while the buffer is enabled,
> and all three scan mask combinations. QEMU's dps310 model implements
> neither the FIFO nor the interrupt, so patch 3 was tested on the
> BeagleBone Black above only.
> 
> On hardware, patch 3 was checked with both channels enabled, temperature
> only and pressure only, at 8 Hz and at 128 Hz. A blocking read returns
> in every case, which is the part that needs the timer: with no
> interrupt, hwfifo_flush_to_buffer alone would leave a reader asleep on
> rb->pollq. At 128 Hz, 100 scans arrive in 0.81 s, so the batching is
> real. Timestamps are monotonic throughout and land on the configured
> period, 125.0000 ms at 8 Hz, except where a drain collected more than
> the rate accounts for and the batch is compressed to stay ordered. With
> a sysfs trigger attached the FIFO stays disabled and the trigger drives
> the buffer, at the rate trigger_now is written.

Are the commit messages are written with AI? Please, do it yourself.
They are way too overloaded with unneeded noise and details. Make them
to be straight to the point.

-- 
With Best Regards,
Andy Shevchenko


