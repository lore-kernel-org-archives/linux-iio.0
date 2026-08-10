Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3685F306B3B;
	Mon, 10 Aug 2026 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786387049; cv=none; b=NYDAdW3udYUtlecDEfbRQAU+D/FAY84uz2URuMnGDUcwQoPScsu9e6R/tOZxc5Bm4Ot22+OC9NUPAA8fyiVLGYqBx+QW7LoytDZDJ/mhvlGAFBq3FYWoOT+v4zt/ur9MdPMa970PoUf3dN29LyDvWZhwyvCfs5bvKv9v50Oau28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786387049; c=relaxed/simple;
	bh=fCJ3IU6wY98UeZ2VxZeJrOZZPe0TGlme/Eo9Mkvpung=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irpbh1tgiKM2J1s84/feJ46gLFhav17wsSreULSZQY8lcbDcGJ7sLlYXXtWwyhxOOpv73Jr8ZNsihCZG0DxUze5eVXPbC2yz+6OQHjMtNS/LCR3jTGOCU6xbeR+biCOcc9+C2+W6smKRp5nAtrZ3IUK+QVTeXRHlvNTZO9HREkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9XDqUNc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9XDqUNc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786387047; x=1817923047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fCJ3IU6wY98UeZ2VxZeJrOZZPe0TGlme/Eo9Mkvpung=;
  b=h9XDqUNc+G1dcbOgz620L/o+1A40O/9aPkETy6866AWxduu078SoGR1Q
   cGI8wYO+MrWxUzGtgUHIcMDs2KluHtfiAGQcwBg1FvYo+kuqYOm2J76ru
   3po0aAOFbQB8DTPVctvLVS/CFoS7bvoXnePU1oqomOFLnBUNeVkfumA2P
   Baf5G8Fjhf1m/5JS+BJ9Cfp1Bcd2OdHJDZPphRiATY/IMfCEtMzeF7XiT
   b5TQAZS/wukZllYffChv4+vqIJI44s6XbgNA5gvXXEdTIdmt6ki4xUnjT
   8a+JYwwV9Luz9Ai1EuIZ4ocGt8stFLGlTTiY2q/TaUrdJ21IBI7Wq+MN2
   w==;
X-CSE-ConnectionGUID: CMC4Ta7ySWKyazPVhEd/eg==
X-CSE-MsgGUID: 5sytLKOTQI2PjzF2vF7M9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="90724956"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="90724956"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:37:27 -0700
X-CSE-ConnectionGUID: Dr8OJFLqSseG5yxhQREAOw==
X-CSE-MsgGUID: rN7lVtyZQ/GXQ6g9EdOJ9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="259267928"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:37:23 -0700
Date: Mon, 10 Aug 2026 21:37:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH 3/3] iio: light: stk3310: support the Sensortek STK36C61
Message-ID: <anoaYQNHKSNE8Pci@ashevche-desk.local>
References: <20260810110423.41697-1-jorijnvdgraaf@catcrafts.net>
 <20260810110423.41697-4-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810110423.41697-4-jorijnvdgraaf@catcrafts.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 01:04:23PM +0200, Jorijn van der Graaf wrote:
> The Sensortek STK36C61 is a 3-in-1 ambient light / proximity / RGB
> colour sensor (chip ID 0x95) found in the Fairphone 6. Its register
> interface is compatible with the feature set this driver uses: the
> STATE/FLAG bit layout, the data and threshold registers and the gain
> and integration-time fields, verified on that device (the ALS and
> proximity readings scale with their gain and integration-time fields,
> thresholds written through the event interface read back from the
> chip, and the FLAG near/far bit crosses with them). Add its chip ID to
> the known-ID list and the device table entries.
> 
> Whenever the ALS engine runs, the chip also measures four colour
> channels, laid out directly after the ALS data as 16-bit big-endian
> values in R (0x15), G (0x17), B (0x19), C (0x1B) order; the R, G and B
> assignments were each confirmed by the matching channel dominating
> under red, green and blue illumination, and clear by its broadband
> response. The ALS data register tracks the green channel exactly.
> There is no public datasheet and therefore no counts-to-physical
> mapping for the colour channels, so they are exposed as raw-only
> intensity channels; the gain field the scale attribute controls does
> not govern clear either.

...

> -	if (chan->type != IIO_LIGHT && chan->type != IIO_PROXIMITY)
> +	if (chan->type != IIO_LIGHT && chan->type != IIO_PROXIMITY &&
> +	    chan->type != IIO_INTENSITY)
>  		return -EINVAL;

Is this now a duplicating a bit with the below choices?

...

>  	switch (mask) {

>  	case IIO_CHAN_INFO_INT_TIME:
>  		if (chan->type == IIO_LIGHT)
>  			ret = regmap_field_read(data->reg_als_it, &index);
> -		else
> +		else if (chan->type == IIO_PROXIMITY)
>  			ret = regmap_field_read(data->reg_ps_it, &index);
> +		else
> +			return -EINVAL;

If you want to keep a single point of return, use

			ret = -EINVAL;

here and below in _read_raw().

>  		if (ret < 0)
>  			return ret;

-- 
With Best Regards,
Andy Shevchenko


