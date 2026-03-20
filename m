Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415FD2C21F2;
	Fri, 20 Mar 2026 08:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773995923; cv=none; b=kKICttoOnfDIOI+n5eMNJ8gbeehxIDIiLb372+Q38bvHYzvya8UEy43mFrmEUw5mNbAsdK6FQDpgfziUZP03F6j4XJOvGpUojuBgZQJQedgwh/m8ImG7ELgOixA0FcTcEX6cR5XgKai4gACfvxR3oR7Ri4LdFI8gvupnPAbiB6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773995923; c=relaxed/simple;
	bh=WzQki4esm2bSXcPacYWgW0MMcozufKN02uhnhwpB4vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvBEh8i0G5+ubojJ39M7FmoDZ33YSlCdocn1A4E3/BiO2OcjG1eDv9YMHDfW/vcEcFY1k5sNmd6ROGapp4yS6YoknSwiA0omie6fSSH/v9HVNCRoA6CEKsjHd+cwWgmLqO7tO0GmRpZTKOLl3SzTi8YksqRLcE/NUuqFQhiIakU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nPF8vxH3; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nPF8vxH3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773995921; x=1805531921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=WzQki4esm2bSXcPacYWgW0MMcozufKN02uhnhwpB4vc=;
  b=nPF8vxH39Z0trXh9pSgiXMF+CXiCpplI+Rt/0SeoEf8A68ewQcucshd/
   pn3qImhfUg378nbIwYSsV+zziGOtc+LZVlEGailIjTzwuPZCIAMM+a8F8
   +F7GBHSiPqQvePOLDgt4kVzFe9TV4wk0APVmb8DxF9v61XibzaIvf3CWK
   jmY7EwkPLxpEY4txTpSrroO1RprmAg9t9sNX4YppyUNG0cGTZjUMp2ZCR
   zLRXyCBwv+Xu/ZkgjtNpjN6dqwDa2o3VxiAthadgvB5jFv7JvRFF7PrdU
   mHa5RsX1pbsHmUM+dotCOlXcBCDR28f0AP9WO5QWI9dANA6Sa3ATSadHV
   w==;
X-CSE-ConnectionGUID: 8wz/hyeHTpq6i8DhbzArSQ==
X-CSE-MsgGUID: 0zrvcw3RT8Snl2tF2OQUsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74093212"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="74093212"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:38:40 -0700
X-CSE-ConnectionGUID: NX3SEgrkQMSw5lEDIzEd3w==
X-CSE-MsgGUID: 9WEYMAoVSjqSdbJlw4b+fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="219051799"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:38:38 -0700
Date: Fri, 20 Mar 2026 10:38:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Siratul Islam <email@sirat.me>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: proximity: add driver for ST VL53L1X ToF
 sensor
Message-ID: <ab0HiyZcjuLr8kFw@ashevche-desk.local>
References: <20260319190738.151614-1-email@sirat.me>
 <20260319190738.151614-3-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260319190738.151614-3-email@sirat.me>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 20, 2026 at 01:07:14AM +0600, Siratul Islam wrote:
> Add support for the STMicroelectronics VL53L1X Time-of-Flight
> ranging sensor with I2C interface.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

A couple of small style amendments below, but no need to resend
only for addressing them — Jonathan can tweak if he agrees on that.

...

> +static const struct regmap_range vl53l1x_wr_only_ranges[] = {
> +	regmap_reg_range(VL53L1X_SOFT_RESET, VL53L1X_SOFT_RESET),
> +	regmap_reg_range(VL53L1X_SYSTEM__INTERRUPT_CLEAR,
> +			 VL53L1X_SYSTEM__MODE_START),
> +};
> +
> +static const struct regmap_access_table vl53l1x_readable_table = {
> +	.no_ranges = vl53l1x_wr_only_ranges,

I would spell 'write' in full in the name of the array variable.

> +	.n_no_ranges = ARRAY_SIZE(vl53l1x_wr_only_ranges),
> +};

...

> +	ret = regmap_write(data->regmap, VL53L1X_SYSTEM__INTERRUPT_CONFIG_GPIO,
> +			   VL53L1X_INT_NEW_SAMPLE_READY);
> +	if (ret)

> +		return dev_err_probe(dev, ret,
> +				     "failed to configure IRQ\n");

It's perfectly one line.

-- 
With Best Regards,
Andy Shevchenko


