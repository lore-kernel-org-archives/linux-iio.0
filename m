Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4764532D7FF;
	Fri, 13 Mar 2026 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410717; cv=none; b=m2deGXt/Nn87UgHWnCC0jQc4wwnUHdBmMFm/57oZ0EBAUXYN/xcw16ppt1tJsYTbmMv0kS62eR0pZzdHAkhyFdfT9LK2JhTgn0ULIzh3UpgcCJgU4fIMmAVvwck8nFmHNBX08iuSIQnarrQZkgpYN2A8GyODvatOqP9TIoivfwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410717; c=relaxed/simple;
	bh=1vSQZbv62qc35prjvp6H3LJfli5G3/bUikTEoBdTMK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkJ+E7eLnLTr3VIcLwr1BAvl/LeLwp6Lj2N18dSDunFM8qGN70JLYqfT3LPJneyvo3+ZqASLGtz0uiIJReEc4hEoHJT7AbN3MFAsdXujX2rO/VwwkQHjUNwKROEuaEpD4sEFI46gbzf/ldzPANIDtdUWGvBWbbriqpF05eNCBoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iZg4GyqG; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iZg4GyqG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773410716; x=1804946716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1vSQZbv62qc35prjvp6H3LJfli5G3/bUikTEoBdTMK0=;
  b=iZg4GyqGzcOPitG1SOHh0RHDRQ97MH7QhaTiBoZJEoDrpsuoiNHAd1S3
   ha21WylSVRuSiII7PchX8ZI+1CIYBkiYJ7tPY0P3acB6KDqDjlp/JpXHb
   NDg5NfIMEQp9wPz9YDFzsKShJrvVVXdYme60UNWrc37VKQeaSN8GfIakZ
   5vAKJmiv9F/3Q4YKFsR5XOf3RhGcYXyqlOCaNI3esA6OrVWbseBkjRNbO
   MzI3f70jul7e4t4yyTctXytoKUMCqZWhdR8nJL9fyQJ0tdGwQLb3YjxdZ
   +vPUdwyPaVQ5V3w9fqPV0pEYa/7psDe6htaBbUynpvTlu5TSB8Z6mTnIq
   A==;
X-CSE-ConnectionGUID: pxVf3VwHQL+fYk7dz52gTw==
X-CSE-MsgGUID: hDPJWpK0Q7uWf37ZlOAXUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74216812"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74216812"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 07:05:16 -0700
X-CSE-ConnectionGUID: k1XTfjBJQ4GgdXiZMj5bIg==
X-CSE-MsgGUID: D4f9VV8MRY6XIc7GFwtSDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="225290890"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.246])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 07:05:11 -0700
Date: Fri, 13 Mar 2026 16:05:08 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Jorge Marques <jorge.marques@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] iio: accel: adxl372: add support for ADXL371
Message-ID: <abQZlPRhCQfjKFEV@ashevche-desk.local>
References: <20260313115525.85435-1-antoniu.miclaus@analog.com>
 <20260313115525.85435-5-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313115525.85435-5-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 13, 2026 at 01:54:57PM +0200, Antoniu Miclaus wrote:
> Add support for the Analog Devices ADXL371, a +-200g 3-axis MEMS
> accelerometer sharing the same register map as the ADXL372 but with
> different ODR values (320/640/1280/2560/5120 Hz vs 400/800/1600/3200/
> 6400 Hz), different bandwidth values, and different timer scale
> factors for activity/inactivity detection.
> 
> Due to a silicon anomaly (er001) causing FIFO data misalignment on
> all current ADXL371 silicon, FIFO and triggered buffer support is
> disabled for the ADXL371 - only direct mode reads are supported.

...

> +enum adxl371_odr {
> +	ADXL371_ODR_320HZ,
> +	ADXL371_ODR_640HZ,
> +	ADXL371_ODR_1280HZ,
> +	ADXL371_ODR_2560HZ,
> +	ADXL371_ODR_5120HZ,
> +	ADXL371_ODR_NUM,

No comma for the terminator entry.

> +};

...

> @@ -1217,8 +1258,8 @@ static int adxl372_buffer_setup(struct iio_dev *indio_dev)
>  		return -ENOMEM;
>  
>  	st->peak_datardy_trig = devm_iio_trigger_alloc(dev, "%s-dev%d-peak",
> -							indio_dev->name,
> -							iio_device_id(indio_dev));
> +						       indio_dev->name,
> +						       iio_device_id(indio_dev));
>  	if (!st->peak_datardy_trig)
>  		return -ENOMEM;

Stray change. It doesn't belong to this patch.

-- 
With Best Regards,
Andy Shevchenko


