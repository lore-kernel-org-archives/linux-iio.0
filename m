Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795167506;
	b=DJv5CZ6yT6Q1jCjwz87Q0SsFcmuMh4dH3jDzBC5vCI9DV+AMbKCokOKCmajIjaAQECUT
	 goUEMixl+a+Gz4ZSqjeyENRFa2QihgXRh1Q0cLCiYO7rgMInJuViX2LoUxdeWidps4T4Y
	 LwweZXTWtwrjquwQ93XCjB82wxFZtczEM/Or9xSe+VIP1BWd9lGN6bvHEpTLkPh7cxfKq
	 seS5dTCHzdItyG35RNZ2s06M0EfhAeJ1nGTDh6/yxwiVgcP6wDp/Roa/ZhtG3MjSbz7iA
	 X3lB5UPu498qk5AaFXUKurg8vH70+ozE35ubNzJu+NPapzEe+5yREFIM5z4Luoxv98A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795167506;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=kwC0xDuNplkRIWU2CJYnECjtyQYBFzQCnJXU6Th4qBI=;
	b=Wljn7Jv1sa3Db9hoZhkvCrTlotSb3wND7KtB0ERCeoNlUXN2WMCckIMVcVSFbtulHi48
	 VtgbtCcre1+DVq6IzX+wBUF1THs+4Xqk0w0IfdCXxCVF3bqvmRnH84+qrH2UWsDPBg9yy
	 fQ1uNYB5mddbEkifBlV9x3vh8g3Qena4IOLv7ZyBE9TwIBhF1Q2YZGNdOan6akChXeO1Y
	 aEA/l5Zn8EkobSKGnXcVIIDG1CV5P8MYBNXsXTtdksWGJS/y/2Jshjq9BtN2sUCDUhJMo
	 VRyq5VldVC7JHU0Y6P2YKk3Ng0oUh/W3fsWv6bvEjKKjhSOGzd8M0Gk2qi7tDplsM1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DxIP2CdI;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8036D606A320;
	Fri, 20 Nov 2026 09:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8036D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DxIP2CdI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795167507; x=1826703507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d4z22dbLFF5+izXeibGLiumsowuWVEBFUdQkzbj352Y=;
  b=DxIP2CdIDg9gfosQQ9lli1K5rAy3KGm2Vb0TDKjpdgCudegej71aFDZ3
   c528XshTqzEVj/TjZWw7Ufhzc3ukg8uploI5XM7Phr2QiqQiudtdgT0+G
   zWCyWVx+zcDgR2MrR3sLY6d8QgZ/RrBXmW+uKeGf9yAOylqzVx5YZ8Rz2
   ElK/WWwAyjAyL2S+oyBIYp+ZlvQkUCNU42IFPJ8uVoswvB/bledEjG3g5
   vWVlPqwUzgMwyMmeDioAPs+jy9xE8NNjpcvHciHZZU4CYHiUL7/7vfEUj
   IuNmhVf3N4FYghOVg3MrgNOCvSmThMgVinvw87K+mNdSzi9Glx21pITq+
   w==;
X-CSE-ConnectionGUID: EFB+aCMWSp+eccK0Ynsaeg==
X-CSE-MsgGUID: Q1OhBmBJRVyeSiEmXN9HVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4046122"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4046122"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 01:38:26 -0800
X-CSE-ConnectionGUID: j/h1/qPIQF6kuVUf1Vq8xA==
X-CSE-MsgGUID: 6CH7eEogRJym2DAYzY9E+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="10654992"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.218])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 01:38:24 -0800
Date: Fri, 20 Nov 2026 11:38:21 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Siqi Chen <chensiqi@uniontech.com>
Cc: jagathjog1996@gmail.com, jic23@kernel.org, crofts@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: bmi323: check i2c_transfer() return value
Message-ID: <awAVDTwKYxT7v8mL@ashevche-desk.local>
References: <20261120022143.4065982-1-chensiqi@uniontech.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120022143.4065982-1-chensiqi@uniontech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 20, 2026 at 10:21:43AM +0800, Siqi Chen wrote:
> i2c_transfer() returns the number of messages transferred or a negative
> error code. The BMI323 I2C read path only checks for negative values and
> maps all errors to -EIO.
> 
> If only the register-address message is transferred, the function copies
> data from the receive buffer and reports success even though the read
> message was not completed.
> 
> Require both messages to be transferred, preserve negative error codes,
> and return -EIO for a short transfer.

> OpenCode was used to identify the issue and draft the code and changelog.

This line should be in the comment block, behind the '---' line.
No need to resend (just remember for the future submissions).

> Fixes: 8a636db3aa57 ("iio: imu: Add driver for BMI323 IMU")
> Signed-off-by: Siqi Chen <chensiqi@uniontech.com>
> ---
> Changes in v2:
> - Split the transfer error and short-transfer checks for readability.
> - Move testing information below the separator.
> 
> Compile-tested with CONFIG_BMI323_I2C=m using:
> 
>   make O=/tmp/opencode/linux-build-bmi323 W=1 \
>        drivers/iio/imu/bmi323/bmi323_i2c.o
> 
> No hardware or I2C fault-injection testing was performed.

Code wise LGTM.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


