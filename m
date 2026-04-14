Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161DD1A681B;
	Tue, 14 Apr 2026 12:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170920; cv=none; b=VyTm5KwgDwNSGf3T+hkMuKxa5VxfsSGNi+/ssucgeOGRgY05kfuGbEuecxSVUz5dEhUqO29fNoL5v5eKb5tGm3T2gvW7xZkKU2KcYTXT8naCsyVdhAYM+QtPMPU9wmdcrC31UjAa+bE4W/nLDPpTgc4q88nhd2JXGxuW7cp2D70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170920; c=relaxed/simple;
	bh=K0lBrb5et1SgBXzICtHG7KFp6o9YawOpFe3/KSXijiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMYYiRUSG4pv1XMZBW6+I6naTctM6U3DfRvywMC4Il0NBtcBYPVK40Aq2gl2/N41FYCpx2kNO3I+lJ/1PgdBKGkGAWsqlGK7tbE/uVx0c88pAngYlE3dOqSegWDyu6TKNT+iIPapZR+HFfibXPsx3agrvnEGb5CINq+VM88JvwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XJcfiYGL; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XJcfiYGL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776170919; x=1807706919;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K0lBrb5et1SgBXzICtHG7KFp6o9YawOpFe3/KSXijiM=;
  b=XJcfiYGLbZEnwo8AK+tC9Jb2UJKJ5fCGCgui2FHJIj3IME5PUXpyiJSL
   vSrsjIPe2j24pOYd6aXJJP2d8C7Xb7g/CQ3sz2mM9oamtrngq99i6TUa4
   TE1Oyj59Xt3VEMMHqNKSVhQ0mEanIG0m47EEwrAoQhUWyyMltaYMqoXKj
   OGZLX403XFMI03LcTf9UIzkLTJo8i/vTuOsxQrBczLcdkwkrOc919Zb5p
   bUQTf+f4D8kzPc9Up0lQr6VPgQx/+gBJPgqMSyVllglYvYjMWASs14lpY
   VrtKIdn34mg4hX/FZ2auRlOwCktWH4KfA27muJhrEO6GWs/H3Q68fxUMg
   g==;
X-CSE-ConnectionGUID: yBMIipsFRDWwRk1du8coJg==
X-CSE-MsgGUID: qWFb9dqnSqm7UcsxzM6tyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77093899"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77093899"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 05:48:39 -0700
X-CSE-ConnectionGUID: MStD1VeLTdm7GzgSglnrAg==
X-CSE-MsgGUID: XUOM7c45Tp+3h/URT1R7iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="230308353"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 05:48:35 -0700
Date: Tue, 14 Apr 2026 15:48:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] iio: dac: Fix passing uninitialized vref1_uV for no
 Vref1 case
Message-ID: <ad43ofFZwzEkYifY@ashevche-desk.local>
References: <20260414-mcp47feb02-fix4-v1-1-9d71badfd25e@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-mcp47feb02-fix4-v1-1-9d71badfd25e@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 14, 2026 at 03:33:38PM +0300, Ariana Lazar wrote:
> Initialize vref1_uV variable to 0 before calling
> mcp47feb02_init_ch_scales() in mcp47feb02_probe() to avoid passing an
> uninitialized value when have_ext_vref1 is false.

...

> +	vref1_uV = 0;
>  	if (chip_features->have_ext_vref1) {

I'm wondering what will happen if we do the below unconditionally?

>  		ret = devm_regulator_get_enable_read_voltage(dev, "vref1");

If we have no regulator, we get a dummy one, right? What is the voltage will
be? 0?

>  		if (ret > 0) {
>  			vref1_uV = ret;
>  			data->use_vref1 = true;
>  		} else {
> -			vref1_uV = 0;
>  			dev_dbg(dev, "using internal band gap as voltage reference 1.\n");
>  			dev_dbg(dev, "Vref1 is unavailable.\n");
>  		}

-- 
With Best Regards,
Andy Shevchenko


