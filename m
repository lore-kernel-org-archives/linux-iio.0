Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECCF362143;
	Tue,  9 Jun 2026 19:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781033000; cv=none; b=Hdi+NMJoTm8tHtCGIdvFNHYJ9Qz6zi1y4ts14HB0xz7sq5TO57JbDzOootrvGSVqX8HPc63rRg4OXaSV6oYxu+0GUZG4PKOyu0dkEzmALakltQVfL2OwaHDMlbJj4O3U9eg+LgNIonMR3NHunoXR2kv7NHMNOK9OiLlLMwJbHv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781033000; c=relaxed/simple;
	bh=w89bLBIHCx0Hcg7oxfK3eG1Xm1bHBwPKh+bHpE29Neo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keOeE84TwtozJ9I13q+bjOTPNsitlYFMudj1tu4F76w18oyzOCPwJXnucGNoBOjX2hzIvlkDUwv2cainjWX87TD04XSQHdDhKGaVPyee23zWa2B8B0Yg7uXmnHCZxRkRLNOBpLabwUsJ9HZ6vg9+hgYfSBJWmvqRUwCRRv191ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IrEAeJ7j; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IrEAeJ7j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781032999; x=1812568999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w89bLBIHCx0Hcg7oxfK3eG1Xm1bHBwPKh+bHpE29Neo=;
  b=IrEAeJ7jmllNXM/whGESOSDZnKX284l/skbQKH35xNH77adeRmjy0iSi
   S5wEcbo79byZ0eCo+E8gSFOQ6pIm97anOtiydIafA1ndGvM6x5tw1JiDE
   UNIY+TN73BA6DOEN20hdoOSfdXvxt0zRm+bTp5DTucHJYr5MOvG0vFLJz
   9YxN2Sjb3NDSO2sJ3vh2TSGaB3T73JtMpQueYfwtuHkZJXekoumq0KMAn
   ajn+e00YIKPbLB6glMEy9SSTa9sJEMoU88iTXJ/u8c13YYKwueA/eSakF
   vEeBEMcvVa6mpjBaPRhvnV6H8u1xP3dAVfGQ4aRUTt+A+9k2fwgdNXoTn
   g==;
X-CSE-ConnectionGUID: 0wNKsbN3TfeuUxTUDZBBJg==
X-CSE-MsgGUID: xNnZm1ZnTdy0AfRoFfPXhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="104475574"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="104475574"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 12:23:19 -0700
X-CSE-ConnectionGUID: FMiw3kJQQ+GXszeXr56kVA==
X-CSE-MsgGUID: 98rDPy/aQGKFlSmg6grkhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="250236458"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.162])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 12:23:14 -0700
Date: Tue, 9 Jun 2026 22:23:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v4 14/14] video: leds: backlight: lm3533: Support getting
 LED sources from DT
Message-ID: <aihoH9Pmzufa9pnE@ashevche-desk.local>
References: <20260606045738.21050-1-clamor95@gmail.com>
 <20260606045738.21050-15-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606045738.21050-15-clamor95@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jun 06, 2026 at 07:57:38AM +0300, Svyatoslav Ryhel wrote:
> Add Control Bank to HVLED/LVLED muxing support based on the led-sources
> defined in the device tree.

...

>  static int lm3533_led_setup(struct lm3533_led *led)
>  {
> -	int ret;
> +	u32 output_cfg_shift = 0;

No need to assign the default to this.

> +	u32 output_cfg_val = 0;
> +	u32 output_cfg_mask = 0;
> +	int ret, i;

No need to add 'i'.

> +	if (led->num_leds) {
> +		for (i = 0; i < led->num_leds; i++) {

		for (unsigned int i = 0; i < led->num_leds; i++) {

> +			if (led->leds[i] >= LM3533_LVCTRLBANK_MAX)
> +				continue;
> +
> +			output_cfg_shift = led->leds[i] * 2;
> +			output_cfg_val |= led->id << output_cfg_shift;
> +			output_cfg_mask |= OUTPUT_LVLED_MASK << output_cfg_shift;
> +		}
> +
> +		/* LVLED1, LVLED2 and LVLED3 */
> +		ret = regmap_update_bits(led->regmap, LM3533_REG_OUTPUT_CONF1,
> +					 output_cfg_mask << OUTPUT_CONF1_SHIFT,
> +					 output_cfg_val << OUTPUT_CONF1_SHIFT);
> +		if (ret)
> +			return ret;
> +
> +		/* LVLED4 and LVLED5 */
> +		ret = regmap_update_bits(led->regmap, LM3533_REG_OUTPUT_CONF2,
> +					 output_cfg_mask >> OUTPUT_CONF2_SHIFT,
> +					 output_cfg_val >> OUTPUT_CONF2_SHIFT);
> +		if (ret)
> +			return ret;
> +	}

...

> +	if (led->num_leds > 0) {
> +		ret = device_property_read_u32_array(&pdev->dev, "led-sources",
> +						     led->leds, led->num_leds);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to get led-sources\n");
> +			goto err_deregister;
> +		}
> +	}

This and other pieces may benefit from local variable

	struct device *dev = &pdev->dev;

defined at the top of the function.

...

>  static int lm3533_bl_setup(struct lm3533_bl *bl)

As per above.

-- 
With Best Regards,
Andy Shevchenko


