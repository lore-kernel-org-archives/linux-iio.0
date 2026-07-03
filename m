Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2523A3D47A0;
	Fri,  3 Jul 2026 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082359; cv=none; b=gXmLJP2X8Znwoc/20Jesb2pHAa2lIjEehXLqVWwAkn2c0I4urSL7G0/u6sepID3Br8SvaOkHLLNviBLqbld57Vwmn/z0tmRXg052Rzsrk34ewEMzVlpZyYwAnb483NST2T94I5beyLRVqRr66Xq46Prv1ed+uMi7PKhQPGMLFYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082359; c=relaxed/simple;
	bh=ccwKPedi3ANfLRhwlH5byFtlKzHS4dkefsMA8y3VAE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dr5nGP4sPToJignGhgz0Q107LVHsetpmWupiqeFqvUTMW3Vt4plQaXi6CIU4jF04q7wAeQczpb0b/qqXo1sVV9T+SmTsQXUuDXa4wXBg7RucBfMOeY4yHhwX4De6DnCd2WAg9LZqgJER4D/AZ5hcT0WXAriK5w3hC9XFoggnIBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UktGdAnr; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UktGdAnr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783082358; x=1814618358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ccwKPedi3ANfLRhwlH5byFtlKzHS4dkefsMA8y3VAE0=;
  b=UktGdAnrBH9qvg4c3k6wOERj0rafbjlc6zEqtWaW1eCJygej7NvBg7l6
   1HQianUXLOReraYrC6yVqXw/5UjysSDwepi/lreYd+hHYaF4quCvYU7Gf
   bFF13tInlHcW4iuYdfFJO7XSinYQGLH+DsMh9kahw5iLlABoykZNBiin3
   WDzwpbMVmnPJD1HP5zXQZPRLD473nMfCqhuLeBwVN9ZBbzMeUd4q4yu90
   icv4YHOBpGq1tKFQLIDK+fIFcLfpkJFqcL4uC05qbUVV1tR1P1t3/wt/Q
   h/wnZLJ0Fexs70MnCQur9lIWYcD4pjXeP438xXxe65X8ssoSggDoeqgCj
   Q==;
X-CSE-ConnectionGUID: nnRH/IG0SdWxauyyZ85GqA==
X-CSE-MsgGUID: v72k83YJSna5v/1+IBruHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="101256601"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="101256601"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:39:18 -0700
X-CSE-ConnectionGUID: QFIfsuxrSxa7VPBViqEuKQ==
X-CSE-MsgGUID: 1Tv3hTgxQpmWqxmj2D8XIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="251386375"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.80])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:39:15 -0700
Date: Fri, 3 Jul 2026 15:39:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 6/6] iio: dac: ad3530r: Add support for AD3532R/AD3532
Message-ID: <aketcG19lGeE3TpQ@ashevche-desk.local>
References: <20260703-iio-ad3532r-support-v4-0-69d9a336f4e8@analog.com>
 <20260703-iio-ad3532r-support-v4-6-69d9a336f4e8@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-iio-ad3532r-support-v4-6-69d9a336f4e8@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 03, 2026 at 06:10:11PM +0800, Kim Seer Paller wrote:
> The AD3532R/AD3532 is a 16-channel, 16-bit voltage output DAC. It shares
> similar functionality with AD3530R but splits its registers into two
> banks: bank 0 at 0x10xx for channels 0-7 and bank 1 at 0x30xx for
> channels 8-15. The input, LDAC trigger and operating-mode registers are
> therefore selected per bank.
> 
> Add the AD3532R register map, channel specs, per-bank register arrays, a
> dedicated powerdown handler and its own regmap_config, reusing the
> table-driven helpers for the shared configuration steps.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
I still don't like much the all this register offset calculations but I have
nothing better to suggest, so let it be.

...

> +/* AD3532R/AD3532 bank 0 registers (channels 0-7) */
> +#define AD3532R_INTERFACE_CONFIG_A_0		0x1000
> +#define AD3532R_OUTPUT_OPERATING_MODE_0		0x1020
> +#define AD3532R_OUTPUT_OPERATING_MODE_1		0x1021
> +#define AD3532R_OUTPUT_CONTROL_0		0x102A
> +#define AD3532R_REFERENCE_CONTROL_0		0x103C
> +#define AD3532R_SW_LDAC_TRIG_0			0x10E5
> +#define AD3532R_INPUT_CH_0			0x10EB
> +
> +/* AD3532R/AD3532 bank 1 registers (channels 8-15) */
> +#define AD3532R_INTERFACE_CONFIG_A_1		0x3000
> +#define AD3532R_OUTPUT_OPERATING_MODE_2		0x3020
> +#define AD3532R_OUTPUT_OPERATING_MODE_3		0x3021
> +#define AD3532R_OUTPUT_CONTROL_1		0x302A
> +#define AD3532R_REFERENCE_CONTROL_1		0x303C
> +#define AD3532R_SW_LDAC_TRIG_1			0x30E5
> +#define AD3532R_INPUT_CH_1			0x30EB

+ blank line here as the below is not related to any bank.

> +#define AD3532R_MAX_REG_ADDR			0x30F9

-- 
With Best Regards,
Andy Shevchenko


