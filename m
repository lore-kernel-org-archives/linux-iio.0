Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283114;
	b=RnPVmyBGj2TxNNpC29+9wx3jHmXHnSarnW27Tt8lFw733tOvsmjw3ogboH/A/epWRDI8
	 bUdhUeo3nJlkwMRJXHLYCMTsJMTrFt2q+w2g2ad9PFs2Gxyt5s7BtB37FS6pxK0YhSGk8
	 3KQwYAWK4sBptwDmSF97dDdF7IjnxFrMrhk+OTEbIY8MZtRLZ7s8QsljSZT6pW/l4ytnh
	 5NmNtYiMWTYbdUixDbGT25gdFWK67yQhmxdcWvWDGhmsE/Ua7aoAgCLECq9X0U9J1fGQV
	 u/wk1ASD9kcFqPq2hU2Tm7TCjdwu7BfqR0lTkLzpAXpNBXG8CFLWh+/N06oFBgvrxQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283114;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=OzKnLRYb2RHjO5vpLJyGvVckIFjS3eGZhvq3T7EZubc=;
	b=Tu08MJ7C8iqE/R6bFOqel7SDzPa70BbTXKx4GXKwaxpu7K3LOGXL15o5C0JQJqpkSDnx
	 AxSpVtg7aZLrwyUVjP9hg34PUNrven1O9MwrSiFEFz1p/QAZYa2CaxtPRHFEK5VYWqKaV
	 D/dINz8UHSUQbRp8fSsSdSKIjEmOKbdRI2/8bl9WIphBhadsh2TbKyhdZkfGtTSEHidiB
	 BnFRfiioyfQm5qkXbR/oFhC1jKMFrslcOV5mqjIGGznVhEjgHQdmoXCweA+1/oL4YReRT
	 NpxpHZ9ofmilS4xdIdMr5pkNGoL2F9XRkCJcQAKnGA6GaFOyRoh67RygxyY+zNFBAww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fDYnTqh3;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67432606A31C;
	Thu, 29 Oct 2026 14:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67432606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fDYnTqh3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793283113; x=1824819113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IGMKDb/7ZPZl5Y96TrIzG3Ewn1xwYH/zIgJht6qrTJ0=;
  b=fDYnTqh3F8xuKC47a9Tz6thYrEq018NyAv7hFiix94oZbCqJgAWDuKL7
   ESr1XE7oSmrO78RoPkADJLWNEorogILaM0xF8LYeTgEuIKREW6+SLZ6RP
   zSRxplTAte8x1Tg8JdfHCuKvFxAe5jgmOWdZg30rSrONaDMRZgrKxJk+h
   gtDNv2d9q4cqvFzE2Ow2KrUaQMwVFrAWPX+rTcUBQjyBqQAjVZLg2NPJ6
   sjtoW9ltK5g+33kuPZM9f/5aocGISGNnsfB7jHNn28wwpjcdrlvlUlyMX
   ZNlHQtmsyvX1Hvry75YATOg8IdslyLf/U0eTQ5NPXZYHVfjhqZO8ggEeH
   A==;
X-CSE-ConnectionGUID: ERafY8wWT/aYNReuhvW4CA==
X-CSE-MsgGUID: +n46ajfjRsyynT1owP65Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1903513"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1903513"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 07:11:52 -0700
X-CSE-ConnectionGUID: uyNBvJHcSg+cXeZLEedqOg==
X-CSE-MsgGUID: 6UbarMXGSZOTtgWO97tlQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5524691"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 07:11:49 -0700
Date: Thu, 29 Oct 2026 16:11:47 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tristan Madani <tristmd@gmail.com>
Cc: Marius Cristea <marius.cristea@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v3] iio: adc: pac1934: validate ACPI _DSM return type and
 bounds
Message-ID: <auNUI4rbGHjbwuzs@ashevche-desk.local>
References: <20261029001447.1114691-1-tristmd@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029001447.1114691-1-tristmd@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 29, 2026 at 12:14:47AM +0000, Tristan Madani wrote:
> 
> pac1934_acpi_parse_channel_config() calls acpi_evaluate_dsm() four
> times to read channel configuration but does not validate the returned
> object type or array bounds:
> 
>   1. No check that the returned object is ACPI_TYPE_PACKAGE.  If
>      firmware returns a different type, accessing rez->package.count
>      and rez->package.elements on a non-package object produces
>      unpredictable values.
> 
>   2. The loop bounds use rez->package.count directly without capping
>      to PAC1934_MAX_NUM_CHANNELS (4).  A package with more elements
>      than expected causes writes past the fixed-size labels[],
>      shunts[], and active_channels[] arrays.
> 
>   3. The bipolar and sample rate DSM calls access elements[0] without
>      verifying package.count >= 1.
> 
> Use acpi_evaluate_dsm_typed() with ACPI_TYPE_PACKAGE to validate the
> return type at evaluation time.  Cap loop iterations to
> PAC1934_MAX_NUM_CHANNELS, and verify package count >= 1 before
> accessing elements[0].

...

> static int pac1934_acpi_parse_channel_config(struct i2c_client *client,

>  	struct device *dev = &client->dev;
>  	unsigned short bi_dir_mask;
>  	int idx, i;
> +	unsigned int count;
>  	guid_t guid;

Preserve reversed xmas tree order.


> +	count = min(rez->package.count & ~1u,
> +		    (unsigned int)(PAC1934_MAX_NUM_CHANNELS * 2));

No, you are not supposed to cast parameters for min(). It should work for int
as small positive predefined number.

...

Ditto for the other case of min().

-- 
With Best Regards,
Andy Shevchenko


