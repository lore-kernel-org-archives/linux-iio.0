Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794345491;
	b=Y1fCcPEWnbeus9OAxIH7mli4AeC7XesYbWvLKFVjKH+6bnscpPS7Eh4A/cBVRFxeX5P8
	 v07s+dMe79kMvt9mX3fJyAOpaHYQDV3JOaps3Jooz6gEO5yL2lJjQna17mVSdyfYUJ/yW
	 N7iv0GaW+i8/mQ2kO+ehgb6j+QFKCFviqI+RjYVQVYBSQG0jVyxQUlHQmd4y6sVfJ4vD+
	 P9ZK/HJuYyh+ypODJQFzP4VK2hBQdCfSzmoyHUHlpcQRNBwvfFmE45KFmgIeY1WJHzqRv
	 8iB8+gGmGZ5I2DFV1IDv9a85NWCWp5ww5cAKuq3vxe+r+vVpSuCElxIdrgOAzKI3ZWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794345491;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=K4Bn/AxY3R847Ni+gw7yt5bTetT/8VPQbq6aTbCCdis=;
	b=nNdX1AcZ5iWD930IJ23BmWTgnYDZRsy+AU9HOBxUggLoh/DpRPWCOWuf5dg+pXWMgQkT
	 wTpEicK+KaXzwkkJ0sB3WIwLsG+NeelKQl+iCGdLQJteavUdvjUmX3D8VfFrcBR/8aZ/0
	 RiPkJuLY9sz16wrF59RA5cAwOx3AxTKwU6A3tsQ6gnwJk3CfnPnjlQ4qsMdktJJrPeOsN
	 7FkxzbUfjQp1tbk95Ya0hSY8sOy7OvHJbz/2KPluI6kNYeQSHWW7yvVvMv8MO47pwmkjm
	 awttGr9wiHxwa/orSPgm5zjUmdcZAwxf8ETmki0P6qXsmBlKOd3VXqXAzutPoNBYVbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LtmGsile;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC2B606A31C;
	Tue, 10 Nov 2026 21:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CC2B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LtmGsile
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794345490; x=1825881490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZhkKr7Z0NgW54lPiWU2ysSosYmPc7dT/lq+ki47djYI=;
  b=LtmGsileLglUbuUt0wrtMqiVev9nGCE6j6zTgpSR9wxmtY2ThFzvmvrD
   Ld6Wyu1UDASxYwhD/LncGP3t2n69Kj9RJBs4uVNOVhEWdS7PAZJ8rO47b
   ZzPIUucHhupjqVk6vjNa6CcTmwRvoUCjUtQM0Zc5CtQHa3/wBFtlChK/j
   QW3kv9fy5vRQMGFHNAfl1kjB0DwcdIRSaXKRkyndRhHuIlkHHsiB4xLK7
   N64MJuZ86AfmculkUAm50eZWFZjwStpaBkVqIKLzgAb8DWasTNeDEZC9p
   GDNY1EzrdYyjjhHilLSbDDVd7v6k2DVq+C31SjlAzzNnohp89FSX9AlP7
   w==;
X-CSE-ConnectionGUID: ajz6KtyRQFKiubY+4/gURQ==
X-CSE-MsgGUID: lvsIjru2R/ChXJsFLn3d1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3006624"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="3006624"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 13:18:09 -0800
X-CSE-ConnectionGUID: qQDNqPZoRLWMkMRug8Bxqw==
X-CSE-MsgGUID: thDUmj42Q6O4xT3RZvTJ5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8545551"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 13:18:08 -0800
Date: Tue, 10 Nov 2026 23:18:05 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <avOKDbkkDwqhHEaC@ashevche-desk.local>
References: <SN1PR12MB2528F139EE6C0B4576C3A0CCA5722@SN1PR12MB2528.namprd12.prod.outlook.com>
 <SN1PR12MB2528B1D75F35447B0DF9A88CA5722@SN1PR12MB2528.namprd12.prod.outlook.com>
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
In-Reply-To: <SN1PR12MB2528B1D75F35447B0DF9A88CA5722@SN1PR12MB2528.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 02:24:22PM -0600, Victor Chernyakin wrote:
> The FDC1004 is a high-precision 4-channel capacitive sensor that talks
> over I2C. It can report the values of each of its 4 channels individually,
> as well as the difference between any two of them.
> 
> This initial driver allows performing single reads and configuring
> the sensor's various settings (sample frequency, calibration
> gain/offset, etc.). It could be extended with support for triggered
> buffers, repeated measurement mode, and/or power management.

Basically a single nit-pick below (add a comment) and I'm totally fine with
this to go (we may polish it later on).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +static const struct regmap_config fdc1004_regmap_config = {
> +	.name = "fdc1004",
> +	.reg_bits = 8,
> +	.val_bits = 16,

Add a relatively short summary here as a comment on why the below is true.

> +	.use_single_read = true,
> +	.val_format_endian = REGMAP_ENDIAN_BIG,
> +	.max_register = FDC1004_REG_GAIN_CAL_CINn(3),
> +	.rd_table = &fdc1004_readable_reg_table,
> +	.wr_table = &fdc1004_writeable_reg_table,
> +	.volatile_table = &fdc1004_volatile_reg_table,
> +	.cache_type = REGCACHE_MAPLE,
> +};

...

> +static const int fdc1004_calibbias_decomposed[] = {
> +	lower_32_bits(fdc1004_calibbias[0]), upper_32_bits(fdc1004_calibbias[0]),
> +	lower_32_bits(fdc1004_calibbias[1]), upper_32_bits(fdc1004_calibbias[1]),
> +	lower_32_bits(fdc1004_calibbias[2]), upper_32_bits(fdc1004_calibbias[2]),
> +};
> +
> +static const int fdc1004_calibscale_decomposed[] = {
> +	lower_32_bits(fdc1004_calibscale[0]), upper_32_bits(fdc1004_calibscale[0]),
> +	lower_32_bits(fdc1004_calibscale[1]), upper_32_bits(fdc1004_calibscale[1]),
> +	lower_32_bits(fdc1004_calibscale[2]), upper_32_bits(fdc1004_calibscale[2]),
> +};

Can we prepare them dynamically at runtime? Use global variables and a macro
from once.h to make the populate function a singleton, so we don't have as many
copies as devices on the system that are driven by this code. We can probably
do this later, though.

-- 
With Best Regards,
Andy Shevchenko


