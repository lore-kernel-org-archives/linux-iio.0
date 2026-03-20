Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0796F3C6610;
	Fri, 20 Mar 2026 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017855; cv=none; b=FraSidiJOxapgjR0uApeKQynYAp96s5PYR/1rJuu6NJpK0H4+finjOK4yAbGgFG62wI04Wo+EoKlE3uA0pP2cCQ5TOHnfkXpNnHkeqF7G2XEzGMM/Nb499Dlo5edeVgDRVtoFgN+Y8pIJ1EGWE1S3c0m0kwn292YoEwN5Wv+mtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017855; c=relaxed/simple;
	bh=8kAzpA/Vk80V8Y5g8qECcysCfrjvj5fgCgcU6+EckdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QktJXyLI7E2oDSfkpy/MEtrfxxIDQLbht0yuBSXuYoTfr8BUPA3PDROKXUiyZhaw1s64WIIxDOkGpfxT1Vi7Dv0skK6n7NeFhAG2St8e/YbJ082Mw0cvh9A0RNAFJ5vN33HMAkUbklJDLs3sRZuWzhkbQ6UZyoCwlgjYmdmZP/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g4qiZ9GN; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g4qiZ9GN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774017854; x=1805553854;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8kAzpA/Vk80V8Y5g8qECcysCfrjvj5fgCgcU6+EckdQ=;
  b=g4qiZ9GNJm/Tyq1ZkEefKeMn1H4fY9d0b/S3lwYaXDgH9/wzjhPLiREe
   rdfkFGjvioN5MwubOSSl/5qiheIR+fy2LkVRvMC70RWvVFbOZPJZNWXd6
   DQEjG6akZLGIXsUvMndwfCXLVYOgN2F7W8/g/rNogttZgR+H7CliD8Css
   GM/3fIHwjcyRXscj9k+ULu5wlScSRWKfl5uy9iaRUElBcoOMIXxVgFiUb
   iZ9fCbirzGdqijKh8L1PCyMvlWIh5xqCML/QSB0bi/VQLOXec9NqOhGU9
   LZEnm7GlJeO7Vy1GhQ/zD4qJ+emawwn9onVT1lW3LVkdmMoH1JbXIxwGG
   Q==;
X-CSE-ConnectionGUID: +c8V331hSpW5XhoOWf2ZRg==
X-CSE-MsgGUID: LBxO/6blSvSVgGRoFOxF3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="62664209"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="62664209"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 07:44:13 -0700
X-CSE-ConnectionGUID: xJWdDY6FS7efULLNryweUA==
X-CSE-MsgGUID: eCAY6FaCTD2TwdgNT6TvYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="228242122"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 07:44:09 -0700
Date: Fri, 20 Mar 2026 16:44:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Carlos Jones Jr <carlosjr.jones@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Liam Beguin <liambeguin@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Jorge Marques <jorge.marques@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: ltc2309: introduce chip_info structure
Message-ID: <ab1dNoC6dg4X-Yml@ashevche-desk.local>
References: <20260320140819.191700-1-carlosjr.jones@analog.com>
 <20260320140819.191700-2-carlosjr.jones@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320140819.191700-2-carlosjr.jones@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 20, 2026 at 10:08:17PM +0800, Carlos Jones Jr wrote:
> This is a preparatory patch that introduces a chip_info structure
> to the LTC2309 driver to facilitate adding support for additional
> chip variants with different channel configurations and timing
> requirements.
> 
> The chip_info structure contains chip-specific data including
> the channel specifications, number of channels, and read delay
> timing. This change does not modify the existing LTC2309
> functionality.

...

>  struct ltc2309 {
>  	struct device		*dev;
>  	struct i2c_client	*client;
>  	struct mutex		lock; /* serialize data access */
>  	int			vref_mv;
> +	const struct ltc2309_chip_info *chip_info;
>  };

Have you checked the layout with `pahole` tool? Does it agree with your choice?

...

> +	if (ltc2309->chip_info->read_delay_us)
> +		usleep_range(ltc2309->chip_info->read_delay_us,
> +			     ltc2309->chip_info->read_delay_us * 2);

fsleep()

...

> +static const struct ltc2309_chip_info ltc2309_chip_info = {
> +	.channels = ltc2309_channels,
> +	.num_channels = ARRAY_SIZE(ltc2309_channels),

Perhaps you also want to add (currently missing?) array_size.h.

> +	.read_delay_us = 0,

Unneeded.

> +};

-- 
With Best Regards,
Andy Shevchenko


