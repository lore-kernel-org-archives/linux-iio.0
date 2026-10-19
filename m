Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0694B2CD3;
	Mon, 19 Oct 2026 10:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792405025; cv=none; b=l+n2sGs/ewE91kfqFZbz4glJ7AWwhDOesaZwLtgJr6/xpeIOfOH5PxCO2cjGAIoK3YKArTjnIPPSKEjs+aWwkWtaTZvxkFWR78RiEGdFVvcY0MOTLPwki53QBxUhKvao0fTBlbZ9FEkv4huF8PwyhZy+6GnaXZUHC+K7NZHXWSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792405025; c=relaxed/simple;
	bh=qAH4QXQQILxKf4rUswGbhV1iZlZbmHrI9Rk7HcnKayk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgjxaIq+1jE07/ZQTW7Fn+nbdfLimNlcLccM95gefvHa/NPpXR1B0UxpdOLlkAJ35vMgeykgwJsUfoRrjAt79OAXNb01/wP6CrOuKYhO6JnWEhMhmysoq5j3BFi1Eqgpno3feCk8upIpa+N9HION+Kd5TFqm+BUu+ZQpgsq5/U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kax2Omqo; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kax2Omqo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792405024; x=1823941024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qAH4QXQQILxKf4rUswGbhV1iZlZbmHrI9Rk7HcnKayk=;
  b=kax2OmqoXbQHzb4vkfZMC5fbGm61myPxQFY46mKzENpB2luhdGMwUS9D
   XOEPcIdafp/O+e4kOAzMcLp9P1Fy2Gnx/7IrLTWf7Q5/ubaxy2hkEHUh+
   pdPN7Ss7Mr5qRb0A6Pv2FzIToidYQqxuq5E+7bP6yMxf/xJnsJbV9SpIP
   5x91yTgnYYhC2ylOvHAjneJItCH7TLGiNoBkKN1eRc5ZRstEHV4XFjL1f
   9wVlKqZhNLHYIv9II7xy918Ww4N06fvUPd3RM0rL8qnxTYKuvmhmC4ZfM
   lCdOCioIJkvBH8/TpVIYSRjK0+Dsd5UXtwYXJ/4rrXveX5jUW9nK6ZIxG
   g==;
X-CSE-ConnectionGUID: sjeVFf1+Rb6TRCO2h77ikQ==
X-CSE-MsgGUID: Xj9cOoZPQGWY3Nz8kRIM8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="989073"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="989073"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 03:17:03 -0700
X-CSE-ConnectionGUID: O511YhUeTiOpAGkOsUUS/w==
X-CSE-MsgGUID: 4ylu/0J9Qw6juLBXjVKtqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2903740"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 03:17:00 -0700
Date: Mon, 19 Oct 2026 13:16:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stephan Costa Barros <stephanbrrs8@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mike Looijmans <mike.looijmans@topic.nl>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: adc: add TI ADS1299
Message-ID: <atXuGv3esexdRJ4e@ashevche-desk.local>
References: <20261019001247.483005-1-stephanbrrs8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019001247.483005-1-stephanbrrs8@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 18, 2026 at 09:12:45PM -0300, Stephan Costa Barros wrote:
> This series adds a driver for the TI ADS1299 family (ADS1299, ADS1299-6
> and ADS1299-4): 24-bit, simultaneous-sampling biopotential front-ends
> for EEG, on SPI.

Why a brand new driver?

> This first version keeps to the generic IIO ABI: raw reads, the gain of
> each channel's PGA through its scale, the sampling frequency, and a
> kfifo buffer fed from the DRDY interrupt with a software timestamp.
> 
> The part has more, which I would like to add in follow-up series, each
> with its own ABI discussion: SRB1 and SRB2 reference routing, the bias
> drive amplifier, lead-off detection (through IIO_EV_TYPE_FAULT and
> IIO_EV_DIR_FAULT_OPENWIRE), the internal test signal, the temperature
> sensor and supply monitors, GPIO1 to GPIO4 as a gpiochip, the CLK pin
> as a clock output, and daisy chains. The binding already describes the
> hardware for those.
> 
> A question on structure. The driver started from ti-ads1298.c, and in
> this subset the two are close. What differs here is the PGA gain table
> (1 to 24 against 1 to 12 with 3), the data rates (no high-resolution
> mode), the fixed 4.5 V internal reference, the ID register layout and
> the 4 and 6 channel variants; above 0x14 the register maps also part
> (MISC1 and MISC2 here, PACE, RESP and WCT on the ADS1298). Most of what
> would follow, SRB1 and SRB2, the bias drive and lead-off on every
> channel, is specific to the ADS1299, so I kept a separate driver. If you
> would rather have the ADS1299 as a variant in ti-ads1298, I can rework
> it that way.

Okay, I think you can try to rework this as a series on top of the existing
code. I can't easily see if the above difference warrants a brand new driver.

-- 
With Best Regards,
Andy Shevchenko


