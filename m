Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502A551DE09;
	Tue, 13 Oct 2026 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908869; cv=none; b=a2gBTpYMO79xcNP0sGW4YmPQpgAb30FTjQFsgeht1s0n9zOCnnreo0FHtqIAOpfRebkZzVPuTrf31pxZqSovVoqR2wQ9ox5QsTiQelBaivp2xGyl7BFtY/+pEiOTFyhj82WWd5XEYCWYV5bFe+TkxR2YJFKdmXo6cY2zl5VwSsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908869; c=relaxed/simple;
	bh=ER4Dd+j8z4PKpBg8k20jDNqMbWHBUM5EcOSDxEz9TV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7TaIsrXfNZ4IC4soxJoYbTlQxqCbUQMlbBXhe8SPrP50fj0bVwk7LKGq83pu/Y0zSMIUmfLxKWADkkDJov6bMzcv9+2svI2KiK3C0KcXxQsdru3jPhX6yDg1kl/PAp9aRsa2doqShClLB+kh5LNwvOeNDCe3SMmaYRDONNLZ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fyEchzav; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fyEchzav"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791908868; x=1823444868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ER4Dd+j8z4PKpBg8k20jDNqMbWHBUM5EcOSDxEz9TV8=;
  b=fyEchzavOeEX2fam7F04gDjnQr0EHcP9mZVuAwmFePt5saeIPgrjtriD
   KNf582b8G6snKyn4xUatWWRV7AFPfk7WNTfBpli2mDXtEn00u9bwl7SOi
   7dH8JAG9vyNl0mHfRhDk6Fr37XNysmAwhr8/cdeKcyycm6mHz20XVe/RI
   hvhPUolhdWDjdLMq9+0FUO3IFeCDpw3ldTuTWM0XSr0kJddkmAaCEYALE
   guFSuh6vl6xP7rKnTI4//BZkqdJY0pPxa9e03TWw8t7RhOMyz5FteaNCk
   aBK6ER3MBcl8XCGcDiYRJCixt7sLqs6V+AYQYfGS+9s/gTAB6Q/u2DMjR
   Q==;
X-CSE-ConnectionGUID: LinC8IplSMadp4X94djnlg==
X-CSE-MsgGUID: Ug0PEYFIRO6l8MXhbarZFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="541876"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="541876"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 09:27:47 -0700
X-CSE-ConnectionGUID: sWQeqysTS6CC0UIkt7KtJQ==
X-CSE-MsgGUID: jQFJU3vCTcSJOWNSiAP0LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1524260"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 09:27:44 -0700
Date: Tue, 13 Oct 2026 19:27:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Shi Hao <i.shihao.999@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: light: add AS7343 multi-spectral sensor
 driver
Message-ID: <as5b_jzx5CG_UoZS@ashevche-desk.local>
References: <20261013115639.167433-1-marcus.yu.56@gmail.com>
 <20261013115639.167433-3-marcus.yu.56@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013115639.167433-3-marcus.yu.56@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 07:56:39PM +0800, Chang Yu wrote:
> Add a driver for the AMS AS7343 14-channel multi-spectral sensor.
> 
> The AS7343 is a 14-channel spectral sensor featuring 11 visible
> channels, 1 near-infrared channel, 1 clear channel (VIS), and 1
> flicker detection channel.
> 
> The driver exposes 12 spectral channels (11 visible light and 1
> near-infrared) via sysfs. Runtime PM is implemented to stop
> measurements when the device is suspended or torn down. Power is
> never cut (PON=1 always) to preserve register values.
> 
> Future patches will add configurable gain and integration time,
> interrupt support, buffered reads, VIS channel, and flicker
> detection.

...

> +/*
> + * Integration time is calculated as (ATIME + 1) * ((ASTEP + 1) * 2.78us).
> + * ATIME must be between 0 and 255, inclusive
> + * ASTEP must be between 0 and 65534, inclusive

Haven't noticed before, but is it indeed 65534 and not 65535 here (or 255 and
not 254 above)? Haven't checked datasheet, please double check.

> + */

...

> +static int as7343_read_label(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, char *label)
> +{
> +	int channel;
> +
> +	channel = chan->channel;
> +	if (channel < 0 || channel >= ARRAY_SIZE(as7343_channel_labels))

in_range()?

> +		return -EINVAL;

-ECHRNG ?

> +	return sysfs_emit(label, "%s\n", as7343_channel_labels[channel]);
> +}

...

> +	/*
> +	 * Setting a 600 * 2.78us * 30 = 50ms integration time as the default
> +	 * for now.

Where magic 600 came from? Please, elaborate in the comment.

> +	 */
> +	ret = as7343_astep_x2780ns(600, &astep);
> +	if (ret)
> +		return ret;

-- 
With Best Regards,
Andy Shevchenko


