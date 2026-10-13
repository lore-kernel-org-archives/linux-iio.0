Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509C951588E;
	Tue, 13 Oct 2026 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910342; cv=none; b=h2YR+daxmhZY8BswcNsmoRjUzlCka6HWNLgAdORn5gkS/9Ri3XcuzkeAE4tPTjizT/YmD/OBw0IHo02Ht0GOkIRHRYRg+HQPrZ9BLm/eKA0U9IVqKcqaFa8+TVXhPaEw+XNPVOSQWWWE+YnhobQIAdrSHxTp4BGTK3LlUgxkffM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910342; c=relaxed/simple;
	bh=0+KEzP3gRwlpVR9PpFO3iMp5jt5Jx0M0g1qKovCh0mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIomRcBxC2n0noSCuBo4OL5CmnAM2hjkJxEkgVOBeDg4DZA2Kn6bk/UotyMzaLQDcNiicUd73+xfvqa4Z//JYaV6rVPjg080vmbQP2wkFbbrUusZjx/Y4giyvMR1pt83Rx3i5EzOl6iu1IJ3UONvhjM70flyP+BWJtp95mfnsaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TWNwJAZM; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TWNwJAZM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791910341; x=1823446341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0+KEzP3gRwlpVR9PpFO3iMp5jt5Jx0M0g1qKovCh0mA=;
  b=TWNwJAZM7J5nw6hiYS1B/sI/5FgNrr3EF8GwX3/c/6rBZ9KX0Yv322J1
   ihJL+j693Mwj9wS5mafaHlgWAmsQ0cPSGLiMZqga13pkuuavhVj7By83+
   UfxjNkeky2Wma2c8koexA0AVkNuGUw75LVanK4gOM2guPArPg02FHbYAu
   6YSLXJhvY7/Tw7HkXt9OB+mLEuLcJ4Z2tvg2VAVo1UODCj/9jL/3+wfHy
   9BwKs3q9kvjdteHADfUuQY8RD6a8zKgvup6sC78CY+uFUPU57RbxOIqFx
   sTY+DwiYbIWcvqSRTUV5K92jJo16GYS5c3w8ss2TVUJCnYbLzTbecmMV1
   A==;
X-CSE-ConnectionGUID: DLeVa55VRGKBUHHgloKIpg==
X-CSE-MsgGUID: D9229FAESRuNkg2ssouXSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="533631"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="533631"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 09:52:21 -0700
X-CSE-ConnectionGUID: 8tHZjU/9SNuZzYhz48+WxA==
X-CSE-MsgGUID: ykBJIzv6SF6meCTI58Solw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1129718"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 09:52:17 -0700
Date: Tue, 13 Oct 2026 19:52:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iio: pressure: dps310: add per-chip data
Message-ID: <as5hvvfHPIO5uIuj@ashevche-desk.local>
References: <20261013112124.1878296-1-paulius.zaleckas@gmail.com>
 <20261013112124.1878296-5-paulius.zaleckas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013112124.1878296-5-paulius.zaleckas@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 02:21:22PM +0300, Paulius Zaleckas wrote:
> Move the coefficient count, the TMP_CFG startup value and the IIO device
> name into a per-chip structure, passed through the I2C and ACPI match
> data. This prepares for the Zilltek ZTS8032, which has two more
> coefficients and a different TMP_CFG layout.

...

>  static const struct i2c_device_id dps310_id[] = {
> -	{ .name = DPS310_DEV_NAME },
> +	{ .name = "dps310", .driver_data = (kernel_ulong_t)&dps310_chip_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, dps310_id);
>  
>  static const struct acpi_device_id dps310_acpi_match[] = {
> -	{ "IFX3100" },
> +	{ "IFX3100", (kernel_ulong_t)&dps310_chip_info },

Use C99 initialisers while at it.

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, dps310_acpi_match);

-- 
With Best Regards,
Andy Shevchenko


