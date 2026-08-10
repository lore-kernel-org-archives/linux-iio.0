Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E58A3A545E;
	Mon, 10 Aug 2026 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350755; cv=none; b=OvxVwyOUpJMz9znzz36WN7k8dJ8JsIWJasSjfXwVpMHmnfeSmeE9lL5Tag8XnWbZ+nlHjjAvV2LVB2SzhldpbFxNKmjJdl7yzBwKg6cWOA5yEVtnwPmSC9+2ea8wAaTCOSw1bxGZN7iEDHdKN22WB4dXLHSPAex467HaOa1mORg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350755; c=relaxed/simple;
	bh=tdrdz1u6rgrIEVnUV5DMQCAm7IonxepyebG8e6Gz7ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unjF6E621UyUxnMAq403PmJn29y/LniDkDbq2CLrEtk29BLGG5cgQt6Z+t65NHxQMZMpPg8MP65jaYRsh0GwloDa1QPoJ4vbvSgi9f7ecKMIVaHPypCwpjZSu9z5VhV/LwndcbNECVOZgKXK0d9BX3g7D6UZ9lQvkbS/hw2m5P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ij2KaO5b; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ij2KaO5b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786350754; x=1817886754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tdrdz1u6rgrIEVnUV5DMQCAm7IonxepyebG8e6Gz7ss=;
  b=Ij2KaO5b2qylBvtHEIblWJ05yvBpjHKpX2fkmyVI2ARA0tCkNtSoyhMy
   VIMPsfEeF061kqm4BaNnJtW4GqHwh7uGrRYEayw9D65akBkQONx0WRXw5
   Ksg+pPRSHi+syOTkMmUCp2tFs7RNHlXTUZKERHR+SLkSm2p+rN0wecZj2
   mLhxLXVwabZSnoBklhWsR93E7KybKsGdYUAvg47eBPGuUyi/Mh7Uw8Glk
   mfreGxpqrpZTVpVJJf06sJI0L/gYC4wmyERa1tak5rnuxe0Etx6XD4b5R
   ENy/xVWZ/bT6IYLdlhcaJkEMd0Kicr1Gkuf8yvksTs7OuX93cHXRlezJ4
   w==;
X-CSE-ConnectionGUID: AohCEFtVTZGsaYEMWNHNSQ==
X-CSE-MsgGUID: Mfwj3H3uQIe5wXPgg4VR6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="85826074"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="85826074"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:32:33 -0700
X-CSE-ConnectionGUID: sIJ0ylteRzil7Tggq5BpnQ==
X-CSE-MsgGUID: QKCbDoS9Q5eT0pVl2JntGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="261689002"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:32:30 -0700
Date: Mon, 10 Aug 2026 11:32:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: mdshahid03@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/3] iio: adc: bcm_iproc_adc: Convert probe error
 handling to dev_err_probe()
Message-ID: <anmMmrbhUvtmm5xs@ashevche-desk.local>
References: <20260806023902.8608-1-mdshahid03@gmail.com>
 <20260806023902.8608-4-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806023902.8608-4-mdshahid03@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 06, 2026 at 08:09:02AM +0530, mdshahid03@gmail.com wrote:

> Replace open-coded dev_err() followed by return with dev_err_probe()
> for probe failures that immediately return.
> 
> Leave error paths that jump to cleanup labels unchanged to reduce code
> churn. These paths will be converted separately together with the
> planned devm-managed cleanup using devm_add_action_or_reset().

...

>  	adc_priv->regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
>  			   "adc-syscon");

Size note: the above can be also amended (since you have a 'dev') to

	adc_priv->regmap = syscon_regmap_lookup_by_phandle(dev->of_node,
							   "adc-syscon");

But we can go even further (in a separate patch) and move it to

	adc_priv->regmap = syscon_regmap_lookup_by_phandle(dev_of_node(dev),
							   "adc-syscon");

...

>  	adc_priv->adc_clk = devm_clk_get(dev, "tsc_clk");
> -	if (IS_ERR(adc_priv->adc_clk)) {
> -		dev_err(&pdev->dev,
> -			"failed getting clock tsc_clk\n");
> -		ret = PTR_ERR(adc_priv->adc_clk);
> -		return ret;
> -	}
> +	if (IS_ERR(adc_priv->adc_clk))
> +		return dev_err_probe(dev, PTR_ERR(adc_priv->adc_clk),
> +				     "failed getting clock tsc_clk\n");

>  	ret = clk_prepare_enable(adc_priv->adc_clk);
> -	if (ret) {
> -		dev_err(&pdev->dev,
> -			"clk_prepare_enable failed %d\n", ret);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable clock\n");

This will be less churn if the previous (new) patch will convert this to use
devn_clk_get_enabled(). But if Jonathan is okay with this patch as is, you
can take my
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


