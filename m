Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2283939C8;
	Fri,  6 Feb 2026 14:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770386652; cv=none; b=rozqK1R7rV0TdKyN/N+mHpJZSSh6wyD3fXhhHVbF4fds4IYHE8g9InQi0JM/g6zeYztwrbSwSzE88FigBmPInn1DGbRNjXDQ/+PfC7wda7W2Bu+5yN6xauEdWRYtR1cl6GMPql21abmuQV6pqdHhgUi0cEZ00GHafDSzF7N1hA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770386652; c=relaxed/simple;
	bh=CLxK1I7KvHSgnzOkhuIJ+AAaBZeRHMusEK+TYPOSoRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqtO1OlxK79/Nj1NEPYHKs9p1u2MqeTGFkqke2Wzxr1wE3bGzdrlY1aIhWuDGrmHEO5NZ1TyTr0RDqotMJCn2A45bPuf8pESh8js/WOUK/yOzZbfk/rvNrozBp0B/8ilsbbyI+wKZ56aiYwm+u3QDGXmYB3Dd8pU2d5qlXQ7FTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nlxOtq+T; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nlxOtq+T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770386652; x=1801922652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CLxK1I7KvHSgnzOkhuIJ+AAaBZeRHMusEK+TYPOSoRw=;
  b=nlxOtq+TSq/qg6rivc8109l70wKv7dSM7oltJT/wtqtKLDwdT2fjuBoy
   Qnj/06egbLLe7DygE+KjtoTzILbdOZ1BEML+3dzl6Vbe/bWeAiUpqJsdd
   wm3dYR+p35W9dF8M1wQhqh+baPpAs3cMfCc7KoLzVl16JNq1dvG0prvuw
   IcC2/siLdgRm12uvFnnyAewSo9ncDTxFHChzfEganGkVrCXi0+iD3rICG
   wV8kPPtUe3oYUXianuYi0BLsR1G1r1YAhx3/DkJjjTugzodZJ2Y2vQCAX
   N8Y3tFsWYF36Ha8/dlm79CLOvl5u8kWZN4CMmSiqHEeSPyc3ryDTbaim+
   Q==;
X-CSE-ConnectionGUID: b8/gishPQFyFqEmgGuhVoQ==
X-CSE-MsgGUID: rSZXfLX4QaGqXsGmSGTGfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="89016541"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="89016541"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 06:04:12 -0800
X-CSE-ConnectionGUID: kobeMf57RNKCUJU2gLo+tg==
X-CSE-MsgGUID: y6IP6eqyQ7G6zHsAwEA3Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="210688841"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.202])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 06:04:10 -0800
Date: Fri, 6 Feb 2026 16:04:07 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ariana Lazar <ariana.lazar@microchip.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [bug report] iio: dac: adding support for Microchip MCP47FEB02
Message-ID: <aYX016NlTNkJzGdT@smile.fi.intel.com>
References: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
 <aYXvP5FLA5BvkoVX@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYXvP5FLA5BvkoVX@stanley.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 06, 2026 at 04:40:15PM +0300, Dan Carpenter wrote:
> [ Smatch checking is paused while we raise funding.  #SadFace
>   https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]
> 
> Hello Ariana Lazar,
> 
> Commit bf394cc80369 ("iio: dac: adding support for Microchip
> MCP47FEB02") from Dec 16, 2025 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	drivers/iio/dac/mcp47feb02.c:732 mcp47feb02_init_scales_avail()
> 	warn: passing zero to 'dev_err_probe'

Btw, why the bot mangles the patch, please?
Adding leading information (line number and some other markings) should not
mangle the code (tab-based indentation).

> drivers/iio/dac/mcp47feb02.c
>     712 static int mcp47feb02_init_scales_avail(struct mcp47feb02_data *data, int vdd_mV,
>     713                                         int vref_mV, int vref1_mV)
>     714 {
>     715         struct device *dev = regmap_get_device(data->regmap);
>     716         int tmp_vref;
>     717 
>     718         mcp47feb02_init_scale(data, MCP47FEB02_SCALE_VDD, vdd_mV, data->scale);
>     719 
>     720         if (data->use_vref)
>     721                 tmp_vref = vref_mV;
>     722         else
>     723                 tmp_vref = MCP47FEB02_INTERNAL_BAND_GAP_mV;
>     724 
>     725         mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_X1, tmp_vref, data->scale);
>     726         mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_X2, tmp_vref * 2, data->scale);
>     727 
>     728         if (data->phys_channels >= 4) {
>     729                 mcp47feb02_init_scale(data, MCP47FEB02_SCALE_VDD, vdd_mV, data->scale_1);
>     730 
>     731                 if (data->use_vref1 && vref1_mV <= 0)
> --> 732                         return dev_err_probe(dev, vref1_mV, "Invalid voltage for Vref1\n");
>                                                           ^^^^^^^^
> vref1_mV is not a valid error code.

Why not? When it's negative I believe the above statement is not true.

> Return -EINVAL.

Probably true for the == 0 case.

With the above, this probably should be

>     734                 if (data->use_vref1)
>     735                         tmp_vref = vref1_mV;
>     736                 else
>     737                         tmp_vref = MCP47FEB02_INTERNAL_BAND_GAP_mV;

                 if (data->use_vref1) {
                         if (vref1_mV < 0)
                                  return dev_err_probe(dev, vref1_mV, "Can't get voltage for Vref1\n");
			 if (vref1_mV == 0)
                                  return dev_err_probe(dev, -ERANGE, "Invalid voltage for Vref1\n");
			 // or -EINVAL?
                         tmp_vref = vref1_mV;
		 } else {
                         tmp_vref = MCP47FEB02_INTERNAL_BAND_GAP_mV;
		 }


>     739                 mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_X1,
>     740                                       tmp_vref, data->scale_1);
>     741                 mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_X2,
>     742                                       tmp_vref * 2, data->scale_1);
>     743         }
>     744 
>     745         return 0;
>     746 }

-- 
With Best Regards,
Andy Shevchenko


