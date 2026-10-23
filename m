Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792763507;
	b=EgjRIDnE9PGL/NqVRnMwHLs8zFfY+XhdViRODmkg5Pg+GMfmwVJhpMA4Tl6F4efCpwWE
	 z3de0oweZy+gugmWIJmk39PyfVsqdcd56wYWkLKDAcSLDXTqeu8oKO2i2k+pYUvM0Edg3
	 Ja7zp3X3oM3zh+h1zkfsIMToVYsOQsoVBvFVX6oz2SmPrNeqyE0Nw4JypoXrEdUFezjdk
	 XGa/RkjVyNoenVLAZUURANp0zijKHPNqPMjZgjgxJYMUEPL79hVHLe+ZpPP1sCVQTJQAA
	 an8CHK/rbHhVd1V6zcLUEDuIqY1mxatKnEyQqA861XOTU7mEwx9h5pkaqWv13558u4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763507;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=joixts8zgFRUYPor7ADRLgrDRgyFPt5+1Vu6wZ6MOOA=;
	b=ehAvj6chJgYHz5NApcmh1Z4tO4DYMlKH903wOlI3jQlIYKnUnW7E94ha8ORqgSNvbdbU
	 xUOvTRUnGMzxunh9k0HujEsJowN6lPmipt+3My9yogV3KhtQLwhwsc/g3jKYecQvJ6cj2
	 GP2jKN7IdKBvnZJaDl5RNEPz1GonF44lvPTNgOTZarCr9uFTKqLhLXQUMzYqjoLMLcx2f
	 k7DA1S3xIO/ciHI7zD9FiodDvEOcEF025OzbwOB+MWwa6m623FCUelSdAj9ExGxCVAUqu
	 tOdmVOasfx8Gbz6u5Se96CjFL6DQn9nK6ch8YIFC8Zd5Bb2P0Lo4Tok60SROOveQSZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XXa4PfPX;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5610606A31A;
	Fri, 23 Oct 2026 13:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5610606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XXa4PfPX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792763506; x=1824299506;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JyOc5X/H7qBUPgOoeFVTmum8NUyYQnowE607Sf8cNOo=;
  b=XXa4PfPX1GiYc8NAmwd3/WrfVz5MTjB8IeE00LChhAUGf1VMHTwSBP2y
   ghW1U339IW2LHkSbFsnr5H2iA3cbt1kypGhqI8/FGkE6xnAkzXAzXn5iL
   U3pDafZpkKGu7v3T5eAz1EHfEbx5O475NDvUsO93we80wMozsdtYR6wF/
   4dABUD1lZUMCfH4mWBOMIqPgXK3yr3PjJsH9rfzAkcDSXq5YAxNe4fvNo
   V1s8b+EHM87pTIUYMly2hFXYyoiGYy40RQn+hsOgWMFwSmQPcNQ/7uznl
   udRxDqpZ3uL0EAOW5ktr+kwy0ZKB6srMG/UdG8X6C+fXOYHIHNvtCVfAx
   w==;
X-CSE-ConnectionGUID: FiDdXqL/R/+ecknRmbhQbg==
X-CSE-MsgGUID: rEySwHrxTtivhrcuuevm7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1559805"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1559805"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 06:51:45 -0700
X-CSE-ConnectionGUID: 3rWdARpbTzup6nCRad8Rpw==
X-CSE-MsgGUID: OCENSKdHTrOY18IZy82o+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3745263"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.100])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 06:51:43 -0700
Date: Fri, 23 Oct 2026 16:51:40 +0300
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
Subject: Re: [PATCH v2 3/4] iio: light: opt4001: refactor driver to prepare
 to support more devices
Message-ID: <attmbDFpqyBHV0VW@ashevche-desk.local>
References: <20261023-opt4041-v2-0-ee320812804c@axis.com>
 <20261023-opt4041-v2-3-ee320812804c@axis.com>
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
In-Reply-To: <20261023-opt4041-v2-3-ee320812804c@axis.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 23, 2026 at 02:30:30PM +0200, Jesper X Nilsson wrote:
> Prepare opt4001 driver to be able to support OPT4041. Extend struct
> opt4001_chip_info with fields channels and device_id because OPT4041 has
> two channels and another device id.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> -	ret = regmap_read(chip->regmap, OPT4001_LIGHT1_MSB, &light1);
> +	ret = regmap_read(chip->regmap, reg, &light1);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to read data bytes");
>  		return ret;
>  	}
>  
> -	ret = regmap_read(chip->regmap, OPT4001_LIGHT1_LSB, &light2);
> +	ret = regmap_read(chip->regmap, reg + 1, &light2);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to read data bytes");
>  		return ret;

Can it be actually a bulk read? (Not part of this series, I assume.)

-- 
With Best Regards,
Andy Shevchenko


