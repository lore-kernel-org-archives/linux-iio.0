Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C2A1990C7;
	Mon, 15 Jun 2026 13:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781531700; cv=none; b=H+vpA28CNQuoGFDrwge/NHVqxXXT/rPZCv2yYwwLLWqRi+9VXyt4oHdFpyZC/xU43OMIIyicU/3RCe+AN1oHF7ch3iVV1cZCv85s5AsrZiib04YG+T8icnxEewEKH7YeXtTBcFLf59RIjfMdriVDmuFVU24oigaFHOw+hMiVT5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781531700; c=relaxed/simple;
	bh=pnWdWRoZ0E2giqzHl8/G2UBXyOUBypGI2p0nvkV2tj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dm05eQZiUbBSvz22YiygEwsc5DjWxBsQ/ZpyYE6fz8x/BJ22i69mGHCgiIWECCg2rZHxFHqy5etpjHPcuHU8/cyAt/NSLFnLOZjve9WLr4tMLGj8wGj7rpZuzzAmWiGCPqtmdrfo/z6l2R+FEPPjJ6yYC8fh7mSoNIcY93o1tkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AQmv45LI; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AQmv45LI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781531700; x=1813067700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pnWdWRoZ0E2giqzHl8/G2UBXyOUBypGI2p0nvkV2tj4=;
  b=AQmv45LIM6mgf2pBsjFnOhUwQREo8EGsUL+Y3Um+7InUGLEMv2CcTySC
   4FCSc9ilI8EKxwuAQWkSlhSfPoyrY/h3oLjz/XGN/QjuyWvpAZZT0dqjs
   dJwFDKDRK4NjWx8aRv7Jo+L4V9VL7HU1afzUE6oMM30lKR4lRhsQEhWdE
   BirIMqDVdz0ZwRhM8zittlyNRRBOMe5sDovYvIQFlAox8dDpeWaLLO3Ps
   hci5QoK8POuT/Uuvhzp1UHzXamOp7YoXp+zdCX9U0dBTlP/RHj6I2gokr
   MzzSNoE1iP9H/hBsoIqJ3yCdVhsGBEbmU5Bt2HV7Xc1gWg385h16jjAmd
   Q==;
X-CSE-ConnectionGUID: xYa/ZusuRcyMt0L/jLSiLg==
X-CSE-MsgGUID: uCruc0qmS3yXfQlhbNTZWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82463866"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="82463866"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 06:54:59 -0700
X-CSE-ConnectionGUID: HaijJ//TRSiMONIsVSDoiQ==
X-CSE-MsgGUID: KBpr7sh1RSO7FFLYgJYDqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="285588439"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 06:54:55 -0700
Date: Mon, 15 Jun 2026 16:54:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Prashant Rahul <prashantrahul23@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Shuah Khan <shuahkhan@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-adc12138: fail init on calibration timeout
Message-ID: <ajAELZtaZXV1UL-A@ashevche-desk.local>
References: <20260615111156.199906-1-prashantrahul23@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615111156.199906-1-prashantrahul23@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 15, 2026 at 04:39:13PM +0530, Prashant Rahul wrote:
> adc12138_init() starts device calibration and waits for the EOC
> interrupt before checking the calibration status. The wait helper
> returns -ETIMEDOUT if the interrupt does not arrive in time, but the
> init path ignores the error and continues probing the device. This could
> lead to registering the device even tho it may not be properly
> initialized.
> 
> Return the wait error so probe fails cleanly when calibration does not
> complete.

...

> +	ret = adc12138_wait_eoc(adc, msecs_to_jiffies(100));
> +	if (ret) {
> +		dev_warn(&adc->spi->dev, "wait eoc timeout\n");

> +		return ret;

		return dev_warn_probe(...);

> +	}

-- 
With Best Regards,
Andy Shevchenko


