Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7321F497392;
	Mon, 28 Sep 2026 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586803; cv=none; b=d27Pw0kCEdQVxiL7SAg0Dq6nvXB5S8FPiurIVlmzhRKRwpp+pP+0xF8QVkimy+fDdTU7UHGHQnKLRIPBBYntKDy4nHyZ503vv54rxrmsJiH5yCcBCAev1fgZRCvI2ZR9XaWTQDho8EXbln1AHa7ewTuwWQ4UybSBM2AhKVEcwb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586803; c=relaxed/simple;
	bh=V9c23XTgkvKT7gB8/LPO+qsDl/4PCQsYtVG1yaqalY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y26AYRwzNmG5Ms+sg2N7F0HCuMWnSxuPAg+lyD55s/hJ+tS8rSszx+q1Ie8UE3xVp1L09ITr6/UxHQSFZMY2U9Psazd85cHwVlITqT/geKOyR1R2Auf3NCrMHE1qN+7LTAwY2rxBIYt+cVX5APqgPMdXolzmQwow5fZ3Ldamerc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UWs6HQ7U; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UWs6HQ7U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790586802; x=1822122802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V9c23XTgkvKT7gB8/LPO+qsDl/4PCQsYtVG1yaqalY4=;
  b=UWs6HQ7UcEfjY2TzDaIbAPSs9pkgupU/IOvMSr2HkSly2MNJ5UVJj6pD
   GYfMROdCErJcA4XptiAkgsLUwlFJEF6u4elK4iv1dEoJDRvtkZFzcbQ5p
   pMCrrRQonJp4VBKbEL6e10szHB1y52T4Q8SLaL7JjooH8hSvQu3scAkF+
   mcP2SNSlA3K5ti+kXjZfdECW+zGpLN+KYdngVRZaJBL2qz39oubSHT9/W
   D0UstcUBInk8W+G4Zl2sIRWDS2x1ERlGWKBKzzZ0x7hKomc7kWxH0d4MJ
   wc/KMjz3C8+sxHW8dPzDeRPKbPe46qjV5VDGm9sJphOS2xMrPgy6zPTj8
   w==;
X-CSE-ConnectionGUID: oEUsYH41TGe2QtsPqnZEWw==
X-CSE-MsgGUID: Se9XP6LaRnqciqGNS19h0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90184926"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90184926"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:13:22 -0700
X-CSE-ConnectionGUID: 9f+rWrklRxKIRscFByH7Gg==
X-CSE-MsgGUID: dDuBdldfTWmEcnEs+WBN/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="301280818"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.42])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:13:19 -0700
Date: Mon, 28 Sep 2026 12:13:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jared Wuerzburger <jwuerz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Samuel Dionne-Riel <samuel@dionne-riel.com>
Subject: Re: [PATCH v3 2/2] iio: imu: st_lsm6dsx: Add ACPI ID SMOCF05 for
 LSM6DS3TR-C
Message-ID: <arovrVYSgU64DM5o@ashevche-desk.local>
References: <20260927220559.24169-1-jwuerz@gmail.com>
 <20260927220559.24169-3-jwuerz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927220559.24169-3-jwuerz@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Sep 27, 2026 at 05:05:59PM -0500, Jared Wuerzburger wrote:

> The Minisforum V3 and V3 SE tablets declare their ST LSM6DS3TR-C IMU in
> the DSDT with the hardware ID SMOCF05 instead of SMO8B30, so the driver
> never binds and the accelerometer and gyroscope are missing. The
> Windows driver (version 1.0.4.3) binds the LSM6DS3TR-C to both IDs.
> 
> Relevant part of the DSDT, identical on both models (full excerpt in
> the cover letter):

Don't refer to the cover letter in the commit message. Most will not understand
this pointer.

>   Scope (_SB.I2CD) { Device (STS) {
>     Name (_HID, EisaId ("SMOCF05"))
>     Name (_CID, EisaId ("SMOCF05"))
>     _CRS: I2cSerialBusV2 (0x006A, ..., "\\_SB.I2CD")  vendor data "SLA0"
>           I2cSerialBusV2 (0x006A, ..., "\\_SB.I2CD")  vendor data "SLG0"
>           GpioInt (Edge, ActiveHigh, ..., "\\_SB.GPIO") { 9 }  "SLA0"
>     Method (SLA0): "-1 0 0", "0 -1 0", "0 0 -1"
>     Method (SLG0): "1 0 0", "0 1 0", "0 0 1"
>   } }

Just ask maintainer to add a Link tag to the series instead.

> Both I2C resources describe the same address, and the driver uses the
> first one. The vendor-specific SLA0/SLG0 mount matrices are not parsed
> here; the accelerometer orientation is handled in userspace through
> the systemd hwdb, as for SMOCF00.

Hmm... But is that wrong? I mean does ACPI provide the correct data in mount
matrix?

> Tested on:
>  - V3 SE (Ryzen 7 7735U, BIOS 1.03) with this change.
>  - V3 (Ryzen 7 8840U, BIOS 1.06), kernel 7.2.7, with this change and
>    the stock firmware tables. The driver binds to i2c-SMOCF05:00, the
>    WHO_AM_I check passes (0x6a), and both lsm6ds3tr-c_accel and
>    lsm6ds3tr-c_gyro are registered. Screen auto-rotation works with
>    iio-sensor-proxy (checked with the device renamed to SMO8B30 via a
>    DSDT override, i.e. the same ST_LSM6DS3TRC_ID driver data).
> 
> Link: https://github.com/mudkipme/awesome-minisforum-v3/issues/2

Closes?

> Signed-off-by: Samuel Dionne-Riel <samuel@dionne-riel.com>
> [Jared Wuerzburger: rewrote the changelog with the DSDT excerpt and test
>  results, dropped the mount matrix patch from the series]
> Assisted-by: Claude:claude-opus-5-5

Assisted-by: LLM

> Signed-off-by: Jared Wuerzburger <jwuerz@gmail.com>

-- 
With Best Regards,
Andy Shevchenko


