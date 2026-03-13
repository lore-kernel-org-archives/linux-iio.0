Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E75D30CD92;
	Fri, 13 Mar 2026 14:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410484; cv=none; b=o4esq5dEILuutoOyBAqaSysiqY1MZNad4vebkcMGQH6y9BhgF9QMZbA7XBc0vwO0kG0gNw8fmJbmr+X5OGRq+a7VmgCyoUqDTCtHtZSBpAlzRHEQXkXZQngo77cmEzEWygd5xSq2KfSLeievsFkomivmCZPOcSpyVqVgA7Sn7dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410484; c=relaxed/simple;
	bh=2BppDJfSxsSjbvRdSpJ2401wKS89758/R3FKR3prU1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWAbJzWbahQKpKYoFbS0o+OE4NDUw87WOLcgW8lvzdEB2kDKNx8ZNj+CNNK8Sve9d3lvDXINaq4UxGG5A3AOSNGI7Duur7TQy03pupuVIGNuarOAax9BXz/eF4zRcrfj6YAwckRzu/n7ampgTxTRwyd06T03VTRYAV7a5xSLSO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g6HLMZFj; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g6HLMZFj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773410483; x=1804946483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2BppDJfSxsSjbvRdSpJ2401wKS89758/R3FKR3prU1A=;
  b=g6HLMZFjGTqeeHwMi/WwWWyAV7EG/Z/eUZTxiFxBO3AyDw2GVkwmUVVJ
   NhdlEpHJWS9YxTdd3NBrW9rZGIPjBDPbf7bz0fCr7Xz7HBBZUroWOr3E7
   HrTKYEkk69A2ZIVLhsXRU1XLf0JXXgPnO1VpDnVwbXBefjmNaEd2MKvYf
   zPft1FrF5ly+90GYwrdrjVnWqw+pueMWfeSosWnJ/XPCbDNqaxOTP5pKt
   ZTYjzsH0QH2tEvBNoiOzgtfCVz7Z/XlJn8kzQbu8KNRFES7fOS7KY96ch
   zww14cJT6AkzJGrVin4wFCO9dHaHe19KRARFs2dqm+tM3dO+5OpWy47os
   w==;
X-CSE-ConnectionGUID: aCjayNtmR8G/Q2F3yvqYxg==
X-CSE-MsgGUID: XO+GxlpZScS3tgB/krE4iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74553770"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74553770"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 07:01:23 -0700
X-CSE-ConnectionGUID: xdhWzKQYQ0O2y+xVHpmc+Q==
X-CSE-MsgGUID: 9RNE0+/oQwenl+GhflUgPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="216078843"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.246])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 07:01:18 -0700
Date: Fri, 13 Mar 2026 16:01:16 +0200
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
Subject: Re: [PATCH v3 1/4] iio: accel: adxl372: introduce chip_info structure
Message-ID: <abQYrLTQvceBCalD@ashevche-desk.local>
References: <20260313115525.85435-1-antoniu.miclaus@analog.com>
 <20260313115525.85435-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313115525.85435-2-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 13, 2026 at 01:54:54PM +0200, Antoniu Miclaus wrote:
> Introduce a chip_info structure to parameterize device-specific
> properties such as ODR/bandwidth frequency tables, activity/inactivity
> timer scale factors, and the maximum ODR value. This refactors the
> driver to use chip_info lookups instead of hardcoded values, preparing
> the driver to support multiple device variants.
> 
> The sampling_frequency and filter_low_pass_3db_frequency available
> attributes are switched from custom sysfs callbacks to read_avail()
> based handling via info_mask_shared_by_type_available. This enforces
> consistent formatting through the IIO framework and makes the values
> accessible to in-kernel consumers.
> 
> The SPI/I2C probe functions are updated to pass a chip_info pointer
> instead of a device name string.
> 
> No functional change intended.

...

> enum adxl372_odr {

>  	ADXL372_ODR_1600HZ,
>  	ADXL372_ODR_3200HZ,
>  	ADXL372_ODR_6400HZ,
> +	ADXL372_ODR_NUM,

No comma for the terminator entry.

>  };

...

> static const struct iio_event_spec adxl372_events[] = {

>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
>  				    BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
>  		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\

Consider at some point making the above consistent by style with the below

	.info_mask_shared_by_type =
		BIT(IIO_CHAN_INFO_SCALE) |				\
		BIT(IIO_CHAN_INFO_SAMP_FREQ) |				\
		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\

> +	.info_mask_shared_by_type_available =				\
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |				\
> +		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
>  	.scan_index = index,						\

>  };

...

> +	chip_info = i2c_get_match_data(client);

> +	if (!chip_info)
> +		return -ENODEV;

It is an agreement to avoid adding a dead code such as above check.

...

> +	chip_info = spi_get_device_match_data(spi);
> +	if (!chip_info)
> +		return -ENODEV;

Ditto.

-- 
With Best Regards,
Andy Shevchenko


