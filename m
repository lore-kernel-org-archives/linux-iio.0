Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B672E739A;
	Thu, 16 Jul 2026 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784224780; cv=none; b=VP9Paot5yr8cjU2cdkDh3l0t12AO4dyRir9rbWpSDjgpdTAIdrN+eUHt+ngfwfm/H3oaiXySMvgTvH8B90rSuca1S2ZHMgoXhcaPfoPdSy5PWFu0RsAS/4yd4mnj5ZjpHkjbcT0ZFErTrEkaPYXRJIcthE2f3a5uAWNrfNrUJrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784224780; c=relaxed/simple;
	bh=PjWl2x2UVCzKbnWYSeLcD570FssDy9FuCo17PqcO1w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+ixmJ1muxaxX6Lzh1TZsZ12+Mpp+XKApyIAE+Tyh03tvf/n4nW+C0ynptrXSpDRv85h6BepupneSZArZHOV+Nqii1TGDH+Xo5FCpQk9dMLvPUMuPI/JS3r/Kmw4r8+C6x8yw+24rvNtLi1zO2CspbFWT3uTKm+55CeQe0+TIo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YFKMBN+i; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YFKMBN+i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784224780; x=1815760780;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PjWl2x2UVCzKbnWYSeLcD570FssDy9FuCo17PqcO1w8=;
  b=YFKMBN+iZUYRQrX5sdfT8hcve0tfNByrD7ifaXLAYM2QqC3NaFGvnuCU
   AdkKK/kcud+R3h8AlCoevMmuYek8RvnHaeD8BSZml4L2VgxsJrWJmrBm0
   AhfR4mju8AsdbC39L39Gt3m0hCSHYBtCAWxEaL8IRRFAjA6hoK8V2Syff
   gvqmsgTFZ3g9J2kg8HkXbqPskS9X/FUPulzSBx8wKagr+vCqMrvoHf/kN
   CJ2cfSIhX3k8oPOut+aSufCbPFFqIHr71nN5L0E4wmwIl/wNbxO3M8aB4
   RvvoA04L+TUV2HoXakKX8x1CiyMch8T+Z8O0hopHpDs7ZMGKoKut6X9zn
   w==;
X-CSE-ConnectionGUID: QaHBF4CLQ/mDiRfBS3hZtQ==
X-CSE-MsgGUID: 4xqcdKflTaC8c1cTSy9t5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="95249958"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="95249958"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 10:59:39 -0700
X-CSE-ConnectionGUID: 3cQcGnHURn6WTZWU1rG0Ig==
X-CSE-MsgGUID: Yk8ziLdYR7mYcWTCy4RjpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="253927212"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 10:59:35 -0700
Date: Thu, 16 Jul 2026 20:59:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: ABI: add DAC high_z powerdown mode and current
 output entries
Message-ID: <alkcBaHV0gHY37wR@ashevche-desk.local>
References: <20260716-iio-ad5710r-upstream-v1-0-e848a4bb701f@analog.com>
 <20260716-iio-ad5710r-upstream-v1-1-e848a4bb701f@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716-iio-ad5710r-upstream-v1-1-e848a4bb701f@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 16, 2026 at 03:59:25PM +0800, Kim Seer Paller wrote:
> Add high_z powerdown mode for DACs with high impedance output in
> current mode (IDAC) and 15kohm_to_gnd resistor to GND. Also add
> out_currentY_powerdown_mode, out_currentY_powerdown_mode_available,
> and out_currentY_powerdown entries to document current output
> powerdown support.

...

>  		125kohm_to_gnd: connected to ground via an 125kOhm resistor,
>  		500kohm_to_gnd: connected to ground via a 500kOhm resistor,
>  		640kohm_to_gnd: connected to ground via a 640kOhm resistor,
> -		three_state: left floating.
> +		three_state: left floating,
> +		high_z: left floating.

It may be less churn if just located before three_state, but hey, why?!
three_state is a synonym to high_z. What's the impediment to use it?

-- 
With Best Regards,
Andy Shevchenko


