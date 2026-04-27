Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EBE359A65;
	Mon, 27 Apr 2026 18:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777313365; cv=none; b=ae8MeZ04eMjHZadsCuUiIdmLg6SxsLRIdng8mpyu0dNkYy9ovYe9Uewzvxje5YmSvoX+CkDK9WT0xVsWSCi7m1NX0HSIRkKZqOeOp882nNdlmfSQw9s2RZkyfaFUr01J96fKm6282qgGDcMSweSQ3lT4D7EQEixfh0+kurDKOV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777313365; c=relaxed/simple;
	bh=1INnpNvSQQ8f/S7V804WASgnVmnFrfZSbzUMRSRIG4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7c6nv5bf9X9E/tKVLlA8Xt6EzXJ3iCFukWpCl8ZPo3MEzFU/Csqm1yd6dAik5HHC1hANgR+/MCaAz/ALpFO3m6FsTyd92M6T6/W1+zaatcUXj3ICVq6nqUtCsEY4JUmjn0Mx+XoeS4lmqHYCEemqw9yPa7SbRJTV/S3WPgCmY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TzyAkb2E; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TzyAkb2E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777313365; x=1808849365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1INnpNvSQQ8f/S7V804WASgnVmnFrfZSbzUMRSRIG4w=;
  b=TzyAkb2ET2yRAheRhTYN0ZUHfAzgSuhp17G6xh2MYGrzbyTFRSx7oO2W
   km9dXZL11+PvVKF2qIMSB4AIINyOa33WMzCNRZ6OB4vMucv4hyCUtkOoY
   e/0ZzlYVMyxUIvnVsRyNg84143xko9X8zo7W0tF0BZIH2hftnqpx+rK/v
   ifQqRMZRdjH0BBBgZGiRjolATY504JF+f3oUui9+t/Dwl4/v/J/xlLNgv
   u8/WmtYkBwXam8lRvOTnke5bcZYjOqDbqqPxvXGTbqsga3K6QvCbjnPvV
   v/MlLRJpSpNaDFc1rcygfuY8xSZ+/TgCkTLXnl6YQUmQZqCKmqk/7sl5c
   A==;
X-CSE-ConnectionGUID: wVOWqaXwTuSqy5s0qUkaGQ==
X-CSE-MsgGUID: FZUu6LvgRX2AJCh16rxhLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78089844"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="78089844"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 11:09:24 -0700
X-CSE-ConnectionGUID: 42E1W+UyT2aqRnqsa5p9ug==
X-CSE-MsgGUID: eYMM1G11QiaN12Pt5+ZJhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="238693951"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 11:09:21 -0700
Date: Mon, 27 Apr 2026 21:09:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stefan Popa <stefan.popa@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Michael Auchter <michael.auchter@ni.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 09/11] iio: dac: ad5686: add control_sync() for
 single-channel devices
Message-ID: <ae-mTn2o0amSJ_xq@ashevche-desk.local>
References: <20260427-ad5686-fixes-v2-0-188e05199368@analog.com>
 <20260427-ad5686-fixes-v2-9-188e05199368@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427-ad5686-fixes-v2-9-188e05199368@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 12:30:16PM +0100, Rodrigo Alencar via B4 Relay wrote:

> Create ad5310_control_sync() and ad5683_control_sync() functions that
> properly consumes the mask definitions with FIELD_PREP(). This allows to
> reuse a function that updates the control register with cached values,
> without relying on confusing logic that depends on st->use_internal_vref,
> which is initialized earlier in ad5686_probe() because it is also
> applicable to the AD5686_REGMAP case, removing the need for the
> has_external_vref. The change cleans up ad5686_write_dac_powerdown() and
> ad5686_probe(), organizing the code for feature extension, e.g. gain
> control support for single-channel devices.

...

>  #define AD5310_REF_BIT_MSK			BIT(8)
> +#define AD5310_PD_MSK				GENMASK(10, 9)
>  #define AD5683_REF_BIT_MSK			BIT(12)
> +#define AD5683_PD_MSK				GENMASK(14, 13)
>  #define AD5686_REF_BIT_MSK			BIT(0)

Since now it's a set of groups of the masks, I would add blank lines to make it
clearer (from the first glance I failed to see that, then I have noticed that
there are the same names, but prefixes, made me harder to understand).

#define AD5310_REF_BIT_MSK			BIT(8)
#define AD5310_PD_MSK				GENMASK(10, 9)

#define AD5683_REF_BIT_MSK			BIT(12)
#define AD5683_PD_MSK				GENMASK(14, 13)

#define AD5686_REF_BIT_MSK			BIT(0)

-- 
With Best Regards,
Andy Shevchenko


