Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59533C1F45;
	Fri,  3 Jul 2026 12:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081683; cv=none; b=GbGegExw06nv15zkffk+QWiFwH4NVW+BP1KxG6aJXde/jrMN2a3hv/ESWW5JEG93XhWAe0gNv+yfk3HDOlNPtLAdoIetSkPwkmLCpVpxMJgp5dLo0avicg+Z/r8NEIwJ/5nD546d9zuqFNXBibzyIMr6jCVJ/imjgkau2arSklo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081683; c=relaxed/simple;
	bh=c4yO07XgxhMXfmxhxcJoVOvDx9+JuqSX3JpF9p1og4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7X0tB4qsiUImNXJmIDZKVIQfeAmr544Zd0d4MhzSGlpe1PkAupLGRdDiC41hpD2C847y3mKiZw3IcthMzhm+sjgRHUOSzclE1ZUz1GbcYbl4UmdQF9dc2Pbs7+k5JamuEh4NxtFu0z1E/kabZDtZ8TgPMU6a1Uu1Os+ZYfshfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lAb2pMhT; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lAb2pMhT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783081682; x=1814617682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c4yO07XgxhMXfmxhxcJoVOvDx9+JuqSX3JpF9p1og4w=;
  b=lAb2pMhTwZGehzhPTK3KNP8npsmLyOUz3uo+Do36616NAMPVxN6GAeko
   BvZc8umF9sV97byyZ2nUZObYEvNWqpS5uPfmr9EtlMdYPyuv5msjLDvkm
   TsDboLvgwzQNkGMIZR51dPsB7iObEVRmXAFe4NC20xDKDsBoC/GG2ipaq
   0k4F5wByLiRVNqc+Efyh6m0PcrSYMZrA3+ojKW2liSBpGDZMR88DPeRI6
   Qgmdxy6AxJG76AG0lIyobrS08wqkAezvxOL8+V4umySdvz4OntZaxOvnq
   e2jhhu5I0XAd7TAwW0SLJ/Gty5HnikSglFYDB9gWSZHNbui9eKGffm6YW
   A==;
X-CSE-ConnectionGUID: glBsFtSaQTevLVy4ST6/9Q==
X-CSE-MsgGUID: VMpoU20aT2Otj22QB9Uf1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="94990219"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="94990219"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:28:01 -0700
X-CSE-ConnectionGUID: D/0Y5XIxQZGRNiDkZcsw0Q==
X-CSE-MsgGUID: A2JX89pkQYOFqAMR3Yv5hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="277429410"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.80])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:27:58 -0700
Date: Fri, 3 Jul 2026 15:27:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/6] iio: dac: ad3530r: Refactor setup to table-driven
 register banks
Message-ID: <akeqzAzT8AXwq-eO@ashevche-desk.local>
References: <20260703-iio-ad3532r-support-v4-0-69d9a336f4e8@analog.com>
 <20260703-iio-ad3532r-support-v4-4-69d9a336f4e8@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-iio-ad3532r-support-v4-4-69d9a336f4e8@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 03, 2026 at 06:10:09PM +0800, Kim Seer Paller wrote:
> Devices with a multi-bank register map repeat the same configuration
> across several banks, which the hardcoded register addresses in
> ad3530r_setup() cannot cover.
> 
> Move the addresses into per-chip arrays and add ad3530r_set_reg_bank_bits()
> and ad3530r_write_reg_banks() to apply an operation to every bank. Each
> current device has a single bank, so no functional change.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> -	int i, ret;
>  	u8 range_multiplier, val;
> +	int ret;

> -	for (i = 0; i < st->chip_info->num_channels; i++)
> +	for (unsigned int i = 0; i < st->chip_info->num_channels; i++)

Strictly speaking this is separate change. But it's quite small, so I leave it
up to Jonathan to decide if needs to be split or okay to go as is.

-- 
With Best Regards,
Andy Shevchenko


