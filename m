Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0691F3A2544;
	Mon, 10 Aug 2026 19:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786391137; cv=none; b=euUy0jCNBDwTGYe96g0FJ66uY5Y6lZ9rNwE+r6INvwh5Y+eKae4jQOn/SZ76LTTPmjXxOOsXpoy62ZsmKG8fKfBfSyM2Cbw74JEJ1mK/AyNxATo24Kb2ciDrVwaRESBkeiBusgQGRGYMTNZ5EK4UOD3Cn7gzBpv6CjXhs9RQ1rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786391137; c=relaxed/simple;
	bh=bXwYOF2PoLnSjwgmoTREFBntYABSQ9RQ/LaVHJI7XGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gf2sv7zcftG9aKsT5XoOJnd2nddcqM9NNjpa9u7++wM6J3BgV8tNauSI5e8FiFKMjYDJSbpbMPdd/4oTYgB9OqpwfXVQz69yfpmoqv47HJWE/UwTg93N4gIRiDlL2TWaktbjiVJfK5Yp2gTULyQFA/JQPYfMLdg8kF2Jk1QKxUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BtShPkEZ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BtShPkEZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786391135; x=1817927135;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bXwYOF2PoLnSjwgmoTREFBntYABSQ9RQ/LaVHJI7XGI=;
  b=BtShPkEZK2hysf+gV2wNAJ+bQlYGEnXpcFcdw5w6NEptfF21RWCy6paT
   WjEOCH61EKND6DbSiap5mc63zFiqA/+d776j42DLHiiliHHA6EhrCtkO3
   WLK0Pj3hjGeWkxfG06nbKh/NvhjOETBzVIPQTVrBrSRXZApl/NO6i8y8c
   JOT7qtGCyafkBOk/iRKbSMLfNbAelfGRUhI8FfBvDHxayr7/tWyOpe2NB
   Id05arPldoz70sfUKxOZhaJ6I8CAQkMy42G7K4pcl47OnXOikS+gX7lMq
   U4LHW2+CRQEFbt9zi+YHvjuhZeaLilWMzF/HFz+rFrhm2iZGZ8+D1/Cal
   w==;
X-CSE-ConnectionGUID: gvJSUjeKQnOIOkXNceD5aw==
X-CSE-MsgGUID: aKSApTdrTvWWIt0FRAzY+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="98276347"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="98276347"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 12:45:35 -0700
X-CSE-ConnectionGUID: ng4Wzm2zQlWtGOmBnKmJ1w==
X-CSE-MsgGUID: ZFiTwNTYTo+VYXfD1GTXsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="262628565"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 12:45:31 -0700
Date: Mon, 10 Aug 2026 22:45:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Luca Weiss <luca.weiss@fairphone.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v4 2/3] iio: imu: inv_icm42600: log whoami mismatch
 instead of failing probe
Message-ID: <anoqWLNK9_MzU1YP@ashevche-desk.local>
References: <20260810191157.125550-1-jorijnvdgraaf@catcrafts.net>
 <20260810191157.125550-3-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810191157.125550-3-jorijnvdgraaf@catcrafts.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 09:11:56PM +0200, Jorijn van der Graaf wrote:
> A WHOAMI value differing from the one the compatible implies aborts
> probe with -ENODEV, which prevents a register-compatible part described
> with a fallback compatible from probing at all.
> 
> The devicetree compatible is authoritative for which part is fitted:
> log the mismatch at info level and continue. The message keeps a
> breadcrumb for anyone seeing an unexpected part change on their device
> versus the devicetree; tmp117 takes the same trade at the same level
> for its fallback matches.
> 
> A whoami of 0x00 or 0xff still fails probe: SPI has no transfer-level
> ack, so those values mean nothing answered; this is the same
> no-response guard inv_icm45600 carries. Otherwise the probe outcome on
> mismatch changes for all parts the driver supports.
> 
> Tested via a backport to a Fairphone 6 running a 7.1-based kernel: its
> ICM-42630 (WHOAMI 0x0C), described with an icm42631 fallback compatible
> and matched as icm42631, probes with the one informational line, and
> accelerometer, gyroscope and temperature reads work.
> 
> Suggested-by: Conor Dooley <conor@kernel.org>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>

> Link: https://lore.kernel.org/all/20260722-creature-volley-0f083b904c1d@spud/
> Link: https://lore.kernel.org/all/20260728222015.6a62b287@jic23-huawei/
> Link: https://lore.kernel.org/all/20260801032310.18f5f16d@jic23-huawei/
> Link: https://lore.kernel.org/all/20260804-scarily-hacker-651df3eafea9@spud/

What are those links for? I haven't seen references in the above text.

...

>  	if (val != hw->whoami) {
> -		dev_err(dev, "invalid whoami %#02x expected %#02x (%s)\n",
> -			val, hw->whoami, hw->name);
> -		return -ENODEV;
> +		/*
> +		 * SPI interface has no ack mechanism.
> +		 * 0xFF or 0x00 whoami means no response from the device.
> +		 */
> +		if (val == U8_MAX || val == 0)

This is strange to be here. If hw->whoami happens to be 0x00 or 0xff (let's
assume some hypothetical future case), this check will become invalid for them.

If it's guaranteed to be not the case for any HW (including the future variants)
this check should be outside, no?

> +			return dev_err_probe(dev, -ENODEV,
> +					     "invalid whoami %#04x expected %#04x (%s)\n",
> +					     val, hw->whoami, hw->name);
> +
> +		dev_info(dev,
> +			 "device id %#04x is not the %#04x associated with the FW-specified device (%s), probably using a valid fallback compatible\n",
> +			 val, hw->whoami, hw->name);
>  	}

-- 
With Best Regards,
Andy Shevchenko


