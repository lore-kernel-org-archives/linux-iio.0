Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9583563F6;
	Fri, 13 Mar 2026 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773394611; cv=none; b=unnm8ykhGGZGSRqYeIiMWsxhAKkCxsYeQrDOE8azV9o8sq3jCn0szXH/8LAtrp8Vy3Lbra4SxPkIjtq8u4aNB5hCU6B5ZseXvaez75M0oGMolNvZk2r1cKwXOPKOegn4rcB7xqKM7vDniTixgGki0hFsuaL6hke2sMoeS2gduXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773394611; c=relaxed/simple;
	bh=CeQ//vROr472/ggQjOxi0XcsVEIPRXMjawZoleEGC4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShikhmsTcyqr5ChrNKTg0x5scINfL5SIve02UjzFh+0cQsXe5kONAD82bwh+zOVnSH9jX9wvEzElmbW5QDYCtElaAT5yxZUDHTSS7uUxMRf9mTnE5d8pyhyJHC2V9jf4IGLbWZ3AYbSjf8a17MZxIWU/TgorIq4q+8cwrWR6ojQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i4lF4l4v; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i4lF4l4v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773394610; x=1804930610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CeQ//vROr472/ggQjOxi0XcsVEIPRXMjawZoleEGC4s=;
  b=i4lF4l4vWyB9df1ntTp5Xy9GlQFX2LVts710ZGGXt5FRp6HgJRTLzCu2
   jdYKUki9Fvjk93VgTpkjxLaZFBDpmjTGBeGwOx6eF2jNJQyTVG88HUoMJ
   Frga4mNsX2Stw4aVcuyDlMxWsYaDkA/0osdtGSZV7QqA+6e0MiMwN7haH
   WA5fi3xdXCcOS4fE9TyHnbdcUurwutNp4j0Le7erCtszvc+A8bZe52IFB
   XvFEfiQNfnAuMG6Rblzx8CF8SXYE1qNosnDAKO14+My7dfxqs06xnJ6uX
   Ll6o5b1es7scqpkphQi5dcUBlT5YZvBDIFnYITdjKrTeQSO4YSfCdB9Tr
   A==;
X-CSE-ConnectionGUID: JNNWcFeKSJeiOU2gmnJgOQ==
X-CSE-MsgGUID: k4aNb2/gQP6czG91WVAflw==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="85854677"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="85854677"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 02:36:48 -0700
X-CSE-ConnectionGUID: OSav+kDXRMS2IqEkiEh0BA==
X-CSE-MsgGUID: mi9B7LPjTDKyLHoX0XHeyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="220192185"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.246])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 02:36:45 -0700
Date: Fri, 13 Mar 2026 11:36:42 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Siratul Islam <email@sirat.me>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] iio: proximity: add driver for ST VL53L1X ToF
 sensor
Message-ID: <abPaqo9pBSClZ-PH@ashevche-desk.local>
References: <20260312183721.40482-1-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312183721.40482-1-email@sirat.me>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 13, 2026 at 12:37:16AM +0600, Siratul Islam wrote:
> This series adds support for the STMicroelectronics VL53L1X
> Time-of-Flight ranging sensor.
> 
> The VL53L1X is a ToF laser-ranging sensor with I2C interface,
> capable of measuring distances up to 4 meters. The driver
> supports both interrupt-driven and polled operation.
> 
> Why a separate driver is needed (instead of extending vl53l0x-i2c.c):
> The VL53L1X is fundamentally different from the VL53L0X despite the
> similar naming. Extending the existing driver would require rewriting
> the majority of it.
> 
> Key differences include:
> - A different register map (16-bit addresses vs. 8-bit addresses).
> - Requires a 91-byte firmware configuration blob to be loaded at boot.
> - Requires a VHV calibration cycle.
> - Has distance mode and timing budget configurations.
> - Uses the regmap API rather than raw i2c_smbus calls.
> 
> I also reviewed other drivers in drivers/iio/proximity/ and can
> confirm this IP block does not appear to be shared by any other
> existing driver.
> 
> Tested on Raspberry Pi 5 with a VL53L1X breakout board.
> 
> Note on vdd-supply:
> In v2, I added vdd-supply as required. Since I'm using the
> shared st,vl53l0x.yaml binding now, I had to drop that requirement
> to avoid breaking backward compatibility for existing st,vl53l0x
> devicetrees. The driver itself still uses non-optional
> devm_regulator_get() so no change there.

> ---
> Changes in v4:
> - Move i2c_check_functionality() to the top of probe before allocations.
> - Use struct u32_fract for oscillator correction math.
> - Explicitly set .cache_type = REGCACHE_NONE.
> - Document intentional predisable drain
> - Use dev_err_probe() for firmware boot timeout and remove duplicate IRQ request error message.
> - Use sizeof() in regmap bulk read/writes instead of hardcoded lengths.
> - Add missing headers (<linux/math.h>, <linux/time.h>, <asm/byteorder.h>).
> - Various formatting cleanups per Andy's review.

NAK. we haven't settled down on the v3 comments.

-- 
With Best Regards,
Andy Shevchenko


