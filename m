Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9443C478865;
	Tue, 18 Aug 2026 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059829; cv=none; b=Xn2phZeRRu0cgBAfk7qfZsuQMLmJ4GJUrjhXAhwS8wnbtMDIMhZUfUulo3pE8yW0BiCX05xesbGYejTT/bz8PfHi1WCgPgNADdp3xJqdI9zSIjhM+j69wC22QTryMIeTeTp+kjzBmlX8Rdnjb6bYt4DDO9ltPypDM9PkH/Xt1es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059829; c=relaxed/simple;
	bh=UiUFOnhrlf8oZ3uWFoAFIFr1w8DOnOtxhFMK4A4w2Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgl6sfDo4TI36bQMRLT62KwhIqyvLWUHyf+hsQG+2G2gwFMZMNSgaxrmFw6YLBcSVyRdFGdsg3BzeGkzDIRunvJ0GjnpNVluJRaDrSL/8QxKruYqA0zd/POubEQ4Gu5OFWCdRuNF77FhYldZS7pzvrzC4Nn1ZA7N6Ibwhu56/4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fc4/JPtO; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fc4/JPtO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787059827; x=1818595827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UiUFOnhrlf8oZ3uWFoAFIFr1w8DOnOtxhFMK4A4w2Z0=;
  b=fc4/JPtOiiHw7HLDanwq+sljzDqWhyiLETogLYDZhTquv6uXaSUw39VT
   qYkkzJ+URClsAan+Nf0VQGILu6/a8Bv08LjQRF/KENiSJ9ZRWEinbt0R+
   2473wNzbLrqE7+IdQ/Y7Cj9OMuYufO6Kzjl+FXDVTpicBKkPZjSfvu9pj
   XN/XeZrJQ9MWc1TR1obXeTPnq4DAB8NO5nNVJk5r0VzJuXQHL6IW+0MZK
   Cz1hkcZVnFBKv4T5cHUxtwb9isNV3RbbTkUcoLWJJ/BLJ+cXnEdpFgvzi
   W+H0aeHooEQJmMbcKt+C8TmXTQnyWqPKsf0FMoRwYb8/HiP2bDEa8EH2Q
   g==;
X-CSE-ConnectionGUID: W8m1TwR4Q7ikBYubZi+Q4Q==
X-CSE-MsgGUID: c+pYHpIkQ1OGdgMWAfYXlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87619908"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="87619908"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 06:30:27 -0700
X-CSE-ConnectionGUID: rWiNatRvQXGpByBBLk3VYA==
X-CSE-MsgGUID: FqA47kxsTL+oHIC2Ywmcvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="263500729"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 06:30:24 -0700
Date: Tue, 18 Aug 2026 16:30:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/4] iio: light: add support for veml6031x00 ALS series
Message-ID: <aoRebVLfzAddMjeX@ashevche-desk.local>
References: <20260818-veml6031x00-v7-0-2b0de0f20edf@gmail.com>
 <20260818-veml6031x00-v7-2-2b0de0f20edf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-veml6031x00-v7-2-2b0de0f20edf@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 18, 2026 at 01:34:27PM +0200, Javier Carrasco wrote:
> Support device identification, raw ALS and IR readings, and configuration
> of the scale and integration time.

...

> +static void veml6031x00_als_shutdown_action(void *data)
> +{
> +	struct veml6031x00_data *priv = data;

	struct device *dev = regmap_get_device(priv->regmap);

> +	int ret;
> +
> +	ret = veml6031x00_set_power(priv, false);
> +	if (ret)
> +		dev_warn(regmap_get_device(priv->regmap),
> +			 "Failed to shut down device: %d\n", ret);

		dev_warn(dev, "Failed to shut down device: %d\n", ret);

> +}

Same amount of LoC, but more flexible and scalable.

...

No need to resend just for this, the rest seems fine to me.

-- 
With Best Regards,
Andy Shevchenko


