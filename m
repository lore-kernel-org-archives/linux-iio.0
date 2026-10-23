Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746873;
	b=IWEnG69dq4Bx7VrHRY8m5Sl7l/Q7UupY966KzrUdQRM7yHY9SO8BoeWTrURgIaVG0QMv
	 3Z3wKBsCbKTIKTHLkJsOa25lsFSbDIvr4NXz78mCjOWQ/klVB8jbzXhnmcm7w6Uw/U6qb
	 zYyw46geY/YcOR5u6rendBYJy/DSN2Mwq1k/KD4tT/7tjwvRxSFgFgVyWo3Bwpdk3jcDt
	 Zjbgc6+YXzi51kwHxIOIvvW/UsUygz0GRUjHoTiOq41vjQOSvGds9thW1UfBKKxEbfMni
	 WxPIwdQcG6aDm6Ww31ZgC9EqDBQ5bxfMsF9ehcfAPwhmi/V2VqDwUzTodl0EbKkfqyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746873;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=VtvWRjl8MAnddMfovWj2q6w872RtxbrfTWw2pjGsNnM=;
	b=KE3OYEsX98jXBR1bmC19ExF2D0rxhtvLNnHOLaXaJOSk4rY8IP/EAHHitUzghZSCtYnL
	 zbI+HAsDLCQonYfTtIkrjn6JLSqB68vGcgLEzIWTzySGSn5IK9lj4sBQBEy5UC6RKKkEu
	 3bE+pSyK0vjnCjPYyC04l6T4yrLFwIv6KNffxnGNJFTeP48vSWLkgnqZTuLJh6oj8Y1j1
	 zWGyF6MXN149nfabLzaCNPhAq0b/xwIKZRb+O9/AKmGa0Y6aTDhvIPPbtKP8459zSnpyW
	 Sf6GQ8nICKdN3VSOjE+PfWzUlQWelrS3MCVCPa5/A7oCW0fSlpJ5m1Rn/DFUcr+3MmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O2vUllAP;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC25E606A31B;
	Fri, 23 Oct 2026 09:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC25E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O2vUllAP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792746873; x=1824282873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2W39ih95/AzH17zBqn6rXJXjjgFZun+fD1/GtsbiOl8=;
  b=O2vUllAPIFDhc83mLr/g9VLBoisngjk+bb6qh3pObjQ2wbvUH7XsgikX
   YNl9ZRoa+6ZHwR1QiArJCI/ThYnBoFlt5g6AkmAQnershqHBPmfqykhdr
   uBUw6fODlZndtwwwj6EOImzFyB5XLLLVUc7tDSqgetFdJiClyg+/EnUzw
   /D2F5tVmhZ0nnaaMXqZAEBAb6KjXD0myQLQh/aZPZ/2KjS4CElP9NquIV
   86T6sKc+YN8u8z2HeI5eUWQIO+JB9elJWepaGSc+/ahIHr0XBWZWXAJJl
   LTJ3tBm1yyKbijLuMAgxclvwem5rlqVXVQLq59DL2zn2FVxtRBaqdelKF
   A==;
X-CSE-ConnectionGUID: 6kJuGdiwQ1C43VeleGWR4A==
X-CSE-MsgGUID: BQSd+Gs8S1StyUPGuY4aQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1399923"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1399923"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 02:14:32 -0700
X-CSE-ConnectionGUID: Jbq1sZTuSHmmN4/ImqFQnQ==
X-CSE-MsgGUID: KZS3rtAYTC6W5vNMIGoNRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3685630"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.100])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 02:14:28 -0700
Date: Fri, 23 Oct 2026 12:14:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jesper X Nilsson <jesper.x.nilsson@axis.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH 3/3] iio: light: opt4001: add support for opt4041
Message-ID: <atslcgx03BMp-juY@ashevche-desk.local>
References: <20261023-opt4041-v1-0-45227f82d05c@axis.com>
 <20261023-opt4041-v1-3-45227f82d05c@axis.com>
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
In-Reply-To: <20261023-opt4041-v1-3-45227f82d05c@axis.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 23, 2026 at 09:48:15AM +0200, Jesper X Nilsson wrote:
> Extend the opt4001 driver to also support OPT4041. The devices are very
> similar, with the difference being OPT4041 having two channels, one
> visible and one wide band channel ranging from 380nm to 1000nm.
> 
> The register map is almost the same. OPT4001 has registers to read out
> the last four values sampled. OPT4041 maps to the same registers, but
> has two channels, saving the last two samples for each channel.

...

> Assisted-by: LLM

Drop this.

...

>  	help
>  	  If you say Y or M here, you get support for Texas Instruments
> -	  OPT4001 Ambient Light Sensor.
> +	  OPT4001 and OPT4041 Ambient Light Sensors.

We in IIO established kinda a style for this to be scalable, id est list them
one-per-line:

	  If you say Y or M here, you get support for Texas Instruments
	  Ambient Light Sensors:
	  - OPT4001 (...can add some short useful detail here...)
	  - OPT4041 (...can add some short useful detail here...)

>  	  If built as a dynamically linked module, it will be called
>  	  opt4001.

Perhaps also consider changing summary text at tristate to make it like
"...OPT4001 and compatible".

...

> - * Device driver for the Texas Instruments OPT4001.
> + * Device driver for the Texas Instruments OPT4001 and OPT4041.

Make this and MODULE_DESCRIPTION() to be the same as summary in the Kconfig,
see above.

>   */

...

> +static const struct iio_chan_spec opt4041_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.address = OPT4001_LIGHT1_MSB,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME)

Trailing comma.

> +	},
> +	{
> +		.type = IIO_INTENSITY,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_BOTH,
> +		.address = OPT4041_LIGHT2_MSB,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME)

Ditto.

> +	},
> +};

...

> +static const struct opt4001_chip_info opt4041_sot_5x3_info = {
> +	.mul = 5850,
> +	.div = 10000000,

Just sent a patch to move this to use struct s32_fract, I believe you may
incorporate it into your series as a precursor).

> +	.name = "opt4041-sot-5x3",
> +	.channels = opt4041_channels,
> +	.num_channels = ARRAY_SIZE(opt4041_channels),
> +	.device_id = OPT4041_DEVICE_ID_VAL,
> +};

...

> +MODULE_DESCRIPTION("Texas Instruments opt4001 and opt4041 ambient light sensor driver");

See above.

-- 
With Best Regards,
Andy Shevchenko


