Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794934643;
	b=uwGxFIgxGItTL7h7zKzKejJ4/vrLLnxwkP0a7r33yAVRXXedglPzTqSE8fTaTz1z01RE
	 m6S0U+OLC+YQg71fOF9S9S2Vn1s5MTXpLBSYBYHNHn8DZrfMs+aE2wiLxTDBQ6jzedG7R
	 nOtgIX1Wgg7IfXntud9FaWGi3wYwOczXBTnAeecp27hkEcbUSW7gj7ALkbRkIZYfryAVA
	 s8GuYVadQ6WU+r7JPaGbm0G8mhMZLUuHiH50tUhqnhc3j6e+OrDtQgj/PvIwyJpcuT7oU
	 iiENG/JVRmn8MrB0L2iSRjCACuMD8VjK4RW3zN3TMDrBDCPP21te+yR/venEjTEMCDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794934643;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=ufmv0ihdneYJGz/686P9PM+NVPVoVFx/Yd9ScCj5xII=;
	b=nrhcxWPTCZcNlJ+RtrLPLcMNw1DgCUPLWQEDh+p1QYWEMnCN90DBJDJnHaPEjDgLr01Z
	 LVa7Be+meyP8oO+dIDnTNBLtrLdyMnibifzmZxqG3WXK03GpQwm8ejyQlW1tT4w9If6Ig
	 yJ0MI8Pqiab9p/KqmGh/MvThx8LJhuQsiszkSzmFd1l9WxaIwb5cxt8tCY8HxpTuewbEt
	 pJKwOzWkBhwoDgsaaZ14MOcNeQTgcoNruWhPtADIiIQvM86Bp+i/sfUkAHAIZQkJo1Ret
	 UhclqDJU7D1GFNLaEpPDZhwX0y9Am734HjsY8x40C0tq19KqX9bzVLsAgCjRvPKVuSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Nu1WrRWK;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E011606A31C;
	Tue, 17 Nov 2026 16:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E011606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Nu1WrRWK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794934643; x=1826470643;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5gWosVAhJAIVh6xRABe7voxpNhWAwmAmt4iDoFdypbg=;
  b=Nu1WrRWKnXEfG/CgFEXD6QEvRMTaOjNHmfuwLBZXESkNHg0qsrA67+TM
   nM5ny7ZIdjlOKgAlHlDasqrCmBbJASAI0F52uniAFV5NpRXNo1Xzj4YPk
   kuqIsQ7H0LrGz2yOCqP+CTosYJF991VGwoHRd9c2i70DVrs4NWndYBkGk
   695u8ZdtmAHsSY5AZbFbKiJVrCKNI/0hwwdd83H+ePGn9kQotZ8LRDcMH
   xBZjY2cE9omeJsGFsbjJ6EECL0JnByHs1xQw7JxhkECmegjMn9qGds3oI
   zKHOfpEw02bTihpSEiu6DalWnkSNxh5qlROIQ5LZYrnoCXdAkGybO5yM4
   Q==;
X-CSE-ConnectionGUID: cR3prBFzQdqrLdtn/ZdotQ==
X-CSE-MsgGUID: 3G2WTCFeT7K/Ku0KAVqd9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3705489"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3705489"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 08:57:22 -0800
X-CSE-ConnectionGUID: Z8GSjn/mTjq6l+kVxzb/IQ==
X-CSE-MsgGUID: YhXGeU4HTA2cQbVsXEWi0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9662055"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 08:57:17 -0800
Date: Tue, 17 Nov 2026 18:57:15 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	giorgitchankvetadze1997@gmail.com, amin.gattout@gmail.com,
	antoniu.miclaus@analog.com, gregkh@linuxfoundation.org,
	mripard@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iio: adc: at91_adc: convert to device-managed
 resources
Message-ID: <avyHazy3LJwPSXPB@ashevche-desk.local>
References: <20261117140510.391907-1-abdelnasserhussein11@gmail.com>
 <20261117140510.391907-4-abdelnasserhussein11@gmail.com>
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
In-Reply-To: <20261117140510.391907-4-abdelnasserhussein11@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 17, 2026 at 04:05:10PM +0200, Abdelnasser Hussein wrote:
> Convert the driver to device-managed APIs so that all resources are
> freed automatically on probe failure and on driver detach:
> 
>   - allocate and register the IIO triggers directly in at91_adc_probe()
>     with devm_iio_trigger_alloc() and devm_iio_trigger_register(),
>     dropping at91_adc_allocate_trigger(), at91_adc_trigger_init() and
>     at91_adc_trigger_remove() along with their manual rollback paths
>   - set up the triggered buffer with devm_iio_triggered_buffer_setup()
>     directly in at91_adc_probe(), dropping at91_adc_buffer_init() and
>     at91_adc_buffer_remove()
>   - allocate the touchscreen input device with
>     devm_input_allocate_device(), dropping at91_ts_unregister() and the
>     manual input_free_device() error path in at91_ts_register()
>   - register the IIO device with devm_iio_device_register()
> 
> at91_adc_probe() no longer needs any error unwinding labels and
> at91_adc_remove() is removed together with the platform driver's
> .remove callback.

...

> static int at91_ts_register(struct iio_dev *idev,

The pdev is not used in this function, which suggests to use 'struct device
*dev' as a second parameter instead.

Please, make that change before this one in a separate patch.

-- 
With Best Regards,
Andy Shevchenko


