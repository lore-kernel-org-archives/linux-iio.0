Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D598247AF75;
	Wed, 30 Sep 2026 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760396; cv=none; b=WOp7qwEW8ng74I0byp1qjn64klDVOlW4q5x0d5GSPABc5TRD43jctwHqLbg9OQjJ8a5wtDTvyGAEXSyrWNzJR7M3kaHvgbkCTUc7QcrL3lzkdyc4+n0MEOF84KixBjD7op431zuYYJz05qkGQtR0mam1DbzMKXFmVLA0f9O/GeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760396; c=relaxed/simple;
	bh=rMd9S+rhPYUjIH42FvN2RL4U6ANgR1UX4u5KmL5fbz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZddOMuUxFHaM4npejZoeZhJD7yTIzBLi1nOnQPFOZSwTGkzdyeoBiLAEFfiqdDL4LchmA9f1jSl0cY05oTpZbXZ5BDGPh98xlj8zBjl2P8b9Ymq2cyLRxpLJkj9hOw57EIGG/5/3wMbhxsXpcI/oXVJ/2a3xBIT+Ofm4ARljjbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZDk2Xp1y; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZDk2Xp1y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790760395; x=1822296395;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rMd9S+rhPYUjIH42FvN2RL4U6ANgR1UX4u5KmL5fbz4=;
  b=ZDk2Xp1y3L2uOe2Wb2RRw9RTVgyM7lLokYxKQz9FP6S+RsKXB1d5ME/0
   NKpHO7s3vwb3W3DQnx1yVpXdaOdg1+3bQuSWzq1G6TEdywkDiKvUVQjQX
   mXc/HNR2l1S9Tbj20e2r0FQ7LdvVkQb4gu8PzjDQxsgnvgKB29KHCgQlF
   04hvUE69L8hMe8h5v/opxMZksJDzBuHaosbcyroXvRbSdV8fhJVl1wVk7
   +pDP4t3jv7MBwVQCVqtaJL1VpBXOquwaqGIbKt1JYnk/nNqBwnnDNPhbu
   OMBlECMzt/+nTRMy1CU86Lwp080/kQlxQCC24L7ZGA7Pu+CGNYUPAdGqN
   Q==;
X-CSE-ConnectionGUID: 9wvzSRjvTAOtdHz1+b73QA==
X-CSE-MsgGUID: h9OgsxIpRSmwb44zD/NNEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90353440"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="90353440"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 02:26:35 -0700
X-CSE-ConnectionGUID: arKvBQZARyiwkS9Hq23NLg==
X-CSE-MsgGUID: CYJodn92RQOYT3Q9UkDP7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="272101956"
Received: from spandruv-desk1.amr.corp.intel.com (HELO localhost) ([10.245.245.137])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 02:26:30 -0700
Date: Wed, 30 Sep 2026 12:26:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 3/8] iio: adc: rzt2h: Add chip-specific configuration
Message-ID: <arzVw02dIqn4M-VK@ashevche-desk.local>
References: <20260929124248.237032-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260929124248.237032-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929124248.237032-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 29, 2026 at 01:42:43PM +0100, Prabhakar wrote:

> Prepare the driver for supporting SoCs with ADC IP that is similar to the
> RZ/T2H ADC but may have different channel configurations.
> 
> Introduce chip-specific configuration for the channel template and number
> of channels, and use it when setting up the IIO channels and DMA layout.

...

> +struct rzt2h_adc_chip_info {
> +	const struct iio_chan_spec *chan_template;

__counted_by_ptr() ?

> +	unsigned int num_channels;
> +	u8 features;
> +};

...

> +	chip_info = device_get_match_data(dev);
> +	if (!chip_info)
> +		return -ENODEV;

-ENODATA

-- 
With Best Regards,
Andy Shevchenko


