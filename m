Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4393E0C5E;
	Mon,  4 May 2026 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904717; cv=none; b=tQ+SdTlJrLTiJ5uFB9P7y9Ujywz3iqs3Y1ZV7+R0sSvr2vzgqt82j6UU/LSNgrgcR47JW9Je6gER5Pb0sYnXCghorJlfSiGkXwGu7xGq7RPszbJxdm/IXKG0vo/KLboVGDSN8QWqkbT4QKDvCFdlZOcrAZD+FqvCgfj97/xHFrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904717; c=relaxed/simple;
	bh=DUSSVROYb4DS2NA8+SXrmEQ21dg1ZxCAhVIZPDuGArE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcYFrYXVN15wA6wtRFVLMRGt+W61/DSJEqOrzQhsGrWSwk/aAlUBrSnJN+aJUKUa8H0BKjXMQKs79knh+8Mjvz1CxMEdltoIVV1Arz9BPq3O6vmw/WfdI92kXXl+wFIB+7Tic9l7r9geyvVxUIoTjxD1AXk8P8PzmSBkj85MBFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mGy+AQ5k; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mGy+AQ5k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777904716; x=1809440716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DUSSVROYb4DS2NA8+SXrmEQ21dg1ZxCAhVIZPDuGArE=;
  b=mGy+AQ5kDDqfsBpPAKGSBpRxapyH33DtY3W9RSbV8desO0TvbkRiD+89
   9ueJAGu1pR9ks1rpW7V7x7bDEwWfqHx6A8aqm2mJ/1fThMkBTPcsAFoHA
   ypvc7ZbKod5JWzR2c+hEskQWvCCmMq44GlolMvH9gqd7whPVOpBEkMuyv
   nxB2dN9etCeBTmJrwdxjbQstOb53BnVYdTfKqs4vu1yiak7iBe9f5qcD5
   c0wrTZ2OGdjm8igd2d1ru2jzoPGESoD8rXqxGAkTpPDGPN+PPTS6PLUgZ
   XvE0WAwKZbK2gJbJz/RET6mo171YFs8xDaDesdMwFujSi8yRiIGpnXzWp
   A==;
X-CSE-ConnectionGUID: SDyMUuY0QrifmbE6ItujSw==
X-CSE-MsgGUID: W91JqkYHTMKNktJAK55vpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78752324"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78752324"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:25:16 -0700
X-CSE-ConnectionGUID: N0BtDaPbQPiMpKg53yQ08A==
X-CSE-MsgGUID: oAQo10OaRgmwlBpmysa69A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="235780601"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.198])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:25:12 -0700
Date: Mon, 4 May 2026 17:25:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/11] iio: adc: hx711: move scale computation to
 per-device storage
Message-ID: <afisRtohis1eJBBZ@ashevche-desk.local>
References: <20260503120949.80292-1-piyushpatle228@gmail.com>
 <20260503120949.80292-6-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503120949.80292-6-piyushpatle228@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 03, 2026 at 05:39:34PM +0530, Piyush Patle wrote:
> The gain-to-scale table is global today, so probe-time scale updates for
> one device overwrite the values used by any earlier device instance.
> 
> Fix this by making the gain table const and storing the computed scale
> values per device in hx711_data.
> 
> No functional change for single-sensor configurations.

...

> +static const struct hx711_gain_to_scale hx711_gain_to_scale[HX711_GAIN_MAX] = {
> +	{ 128, 1, 0, },
> +	{  32, 2, 1, },
> +	{  64, 3, 0, },

In such case the inner trailing commas are not needed. They are needed when the
supplied lists are arrays and may be extended. Here it's a proper data type
with fixed number of arguments. If you want to be even stricter and robust, move
to C99 initialisers (but note, I'm fine with just trailing commas being removed).

	{ 128, 1, 0 },
	{  32, 2, 1 },
	{  64, 3, 0 },

>  };

...

> @@ -574,4 +575,3 @@ MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
>  MODULE_DESCRIPTION("HX711 bitbanging driver - ADC for weight cells");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:hx711-gpio");
> -

Stray change.

-- 
With Best Regards,
Andy Shevchenko


