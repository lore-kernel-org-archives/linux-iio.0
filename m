Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BA71B4F09;
	Thu,  2 Apr 2026 13:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775135910; cv=none; b=nbf4tv7siawLdtP4EmLdcrEBezMKmRrd7WHyq5Enzbu4ctJk1VqlUZgEihzmTzl+fa/dS1motgqZYJf1Ld7WQ6PHGkP3PFw/oHWLfErKPzAMWZjhj1gCSBQOvFKHJKDznYhS6IE91pJoGqHcBKwHF5KHAkUN/DlTD/ai/EhRtMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775135910; c=relaxed/simple;
	bh=+ty5PA1ulsJNL2tx+BC1bsQkHlYQmOcAsSW1x62Mux0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1BMDutwLDDEbLRNZOQro8pMP0VCLZUBYG0sKpOH7BU56vB/8oAeJT3wvj1vYlHTGYhH/jRAvIKFolp98RY+nXP9znsbdjgak1Xl05oxi4Pjq3C4uVCPug/bGvvFOjnbqLDO6qxFe6AkArX/YtpKvED2iua34dm1JnpSrlMNFug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O57fCcqc; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O57fCcqc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775135909; x=1806671909;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+ty5PA1ulsJNL2tx+BC1bsQkHlYQmOcAsSW1x62Mux0=;
  b=O57fCcqci30Ru2OFZ+3+V05Ue849vsrkD8OBzOkyZ65hkv1VZixlGYjb
   8pWeIF0M3pcexRolf89SNabvEg75qJfL1bOFHJGYtMXKUoiZlkrLqCdPY
   Xnf4wav3g+Q146MZSp6Z0anh1R/CQpVnez6qfZpLe8ZPyIFUEepeL0YhN
   7llYbJ0VR4EwkFgSvSDAdI7L7/sfjIu3PtMWP2CpFKtm6pnpnalhcqBPb
   RSC8Bb/d98vDEmKQBvd+2hCJ+PO7Eveq6xR/VJagVdOr1A6ysaaC8TB27
   iU6+mJS7HF9XiscPdlswhGomgyDYJKOTdUPXPz1tH71dlCdH4crBc1JZK
   A==;
X-CSE-ConnectionGUID: 6XDgCOISTwuv7T+tK0raQA==
X-CSE-MsgGUID: bNk/bZDSQP+goLzCgdYLlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="101646361"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="101646361"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 06:18:28 -0700
X-CSE-ConnectionGUID: Gwm71YmITniMkqMejrlwpA==
X-CSE-MsgGUID: jv7WuLawRYyyOkUJQp916g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="264909835"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.31])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 06:18:26 -0700
Date: Thu, 2 Apr 2026 16:18:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Advait Dhamorikar <advaitd@mechasystems.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: st_magn: fix default DRDY pin
 selection for LIS2MDL
Message-ID: <ac5soAtijnX3gCjY@ashevche-desk.local>
References: <20260402113653.212043-1-advaitd@mechasystems.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402113653.212043-1-advaitd@mechasystems.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 02, 2026 at 05:06:51PM +0530, Advait Dhamorikar wrote:
> The device tree binding for st,lis2mdl does not support
> st,drdy-int-pin property. However, when no platform data is provided
> and the property is absent, the driver falls back to default_magn_pdata
> which hardcodes drdy_int_pin = 2. This causes 

Trailing white space. Please, drop.

> `st_sensors_set_drdy_int_pin` to fail with -EINVAL because the LIS2MDL
> sensor settings have no INT2 DRDY mask defined.
> 
> Fix this by checking the sensor's INT2 DRDY mask availability at
> probe time and selecting the appropriate default pin. Sensors that
> do not support INT2 DRDY will default to INT1, while all others
> retain the existing default of INT2.

This looks like it requires a Fixes tag.

...

> -	if (!pdata)
> -		pdata = (struct st_sensors_platform_data *)&default_magn_pdata;
> +	if (!pdata) {

> +		if (!mdata->sensor_settings->drdy_irq.int2.mask)
> +			pdata = (struct st_sensors_platform_data *)&alt_magn_pdata;
> +		else
> +			pdata = (struct st_sensors_platform_data *)&default_magn_pdata;

No need to use negative conditional when you have full if-else branches.

> +	}

-- 
With Best Regards,
Andy Shevchenko


