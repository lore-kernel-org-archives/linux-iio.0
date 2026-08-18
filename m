Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B070D479870;
	Tue, 18 Aug 2026 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787061764; cv=none; b=SgR8TZ7Bde7C9Hmz3WLVEhMe7eSHjkW1AiR1SbccPOVOPs+EhH+1lSmn0sLGVGZf8eqXKCstOf6O0zrtEA0UjlxYGEZbIPY5PJv+vXaAZX9fMb4cSOhuhoICIW4btXFsxlYINcNhYGcUMz0zOIJKDM0Je9QE1qypg6A21MSVSCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787061764; c=relaxed/simple;
	bh=1uDUtP6le3thudkRCXTb6xPMeP5TSm+78BdcIJ8GqnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/28N2fGvxdGjv5TGXIYQE8sxShxPQlQ8PxfGBeaI9epp4Oj3IZh5s+JY8qpzmYA0zkAAIIesv6XOskBA+LFRayv4Wzh4kTQ/B3WJI4hNBPTyCPK1d1ZhvK0suaCLsyu/QPyQh32FX84aXqSWhf4edPRKLDNVl3BZlObfR90mt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OpQOxJQw; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OpQOxJQw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787061763; x=1818597763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1uDUtP6le3thudkRCXTb6xPMeP5TSm+78BdcIJ8GqnQ=;
  b=OpQOxJQwIRk+2BsLU9/SU92OQloV7OUjQvk33Jr7/FcnnS2/b2ni6V/x
   rjmBwwq6y8EKATpFC9uHJTB1mFGdhBPN41wB/7x32c8tjABED99BeFhMJ
   5fYoipeQPtqwqh1RvWQ/mvE+zOEQucUEeLNp5KZH94gCRVUaLMumE7la5
   qbNYxURXWodlqm1HBhIemu/yiKbXSHRfNYm+c/69oVcMqPQmyzUeC+Rfg
   6AlyYnCEzNb69QcxzgGATkxnVE+XdTpfk34DXBLD6h33HmbuyeNK0u8ge
   BIt0tRMCxgYjgc5yEO8YjYpTH01rsoLOqpNO/GfKWIxbrHVDQ9xAvy/bq
   A==;
X-CSE-ConnectionGUID: AfHXN+qkRsufJd/7PnFZ6w==
X-CSE-MsgGUID: RrrHqNHRRm2OJ+cZyQjC6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="90066591"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="90066591"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 07:02:42 -0700
X-CSE-ConnectionGUID: m1LBxjgMQhqbxUcQvySPHg==
X-CSE-MsgGUID: 2aoUIafVR3yQaQblNuQzCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="263505297"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 07:02:39 -0700
Date: Tue, 18 Aug 2026 17:02:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v7 0/4] iio: light: add support for veml6031x00 ALS series
Message-ID: <aoRl-7XIianTyKIB@ashevche-desk.local>
References: <20260818-veml6031x00-v7-0-2b0de0f20edf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-veml6031x00-v7-0-2b0de0f20edf@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 18, 2026 at 01:34:25PM +0200, Javier Carrasco wrote:
> These ambient light sensors with I2C interface provide two light
> channels (ALS and IR), high/low threshold alarms with configurable
> persistence, and a data ready signal.
> 
> The devices covered by this driver have the same resolution, and they
> share most of their functionality. These are the differences between
> them (note that the x belongs to their names, and it is not a wildcard):
> 
>  - Device ID: accessible via two 8-bit registers, different values for
>    veml6031x00/veml6031x01 and veml60311x00/veml60311x01.
>  - I2C address: same grouping, 0x29 and 0x10 I2C addresses.
>  - AEC qualification: AEC-Q100 for veml6031x00/veml60311x00 and
>    AEC-Q101 for veml6031x01/veml60311x01.
> 
> The alarms and the data ready signals share the interrupt pin, and an
> interrupt status register must be accessed to identify the source. Such
> multiplexing is not new in IIO, and I have followed existing examples
> for it. The persistence setting (own attribute) to trigger the alarms
> uses the pattern that has already been used for the veml6030.
> 
> The device configuration is in general documented in the datasheet and
> the application note. There is an exception, though: the activation of
> the "active force" mode that is required for the data ready signal must
> be carried out in two steps even though the affected bits are located in
> the same register: first ALS_AF (active force mode enable) must be set,
> and then ALS_TRIG (active force trigger setting) must be enabled. I have
> added a brief commentary in the code to explain this behavior, which has
> been confirmed by the manufacturer.
> 
> The datasheet specifies the scale and integration time for the ALS channel.
> Although both settings also affect the measured IR value, no transfer
> function, accuracy, or calibration is specified for converting the IR
> output into a physical quantity. The IR channel is therefore intended only
> as a qualitative indication of the infrared content of the incident light,
> rather than as a precision measurement channel. Consequently, the driver
> does not expose scale or integration time as IR-channel attributes.
> 
> The only functionality that has not been implemented yet is the x0.66
> gain (and its x0.165 counterpart when PD_DIV=1), which makes the gts
> helpers less usable due to the conversions required. It is indeed an
> uncommon gain to use (there are x0.5 and x0.125 gains) with no known
> use-case at the moment that justifies making adjustments to the gts
> helpers or adding artificial conversions to make it work.
> 
> This driver has been tested with the four supported devices separately
> as well as in pairs where the I2C addresses don't overlap.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
for all patches, but DT.

There are minor things that may be addressed later, or in next version if asked
for other reasons.

-- 
With Best Regards,
Andy Shevchenko


