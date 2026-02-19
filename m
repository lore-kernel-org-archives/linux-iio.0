Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B942618027;
	Thu, 19 Feb 2026 07:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771487047; cv=none; b=JCYfYiqyLOTdU4XXL1CntdcMFrlkB3wNQut1RjeE3n9fzrnOr7xyNgBEjv00g5+n75PRZR3M0qzOhqaaoaQSGT7ncaqvcX1ab+qP5Oz1xLqVEEbp4XQADzODrvkbicQ+ctiboNE9E9dKhl2JD0KZ/++R256Y0OBG9mxqSEixQJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771487047; c=relaxed/simple;
	bh=CWpJJrcELpAqUcwwgoTh0ihanHTAd117sPRUgE2OnGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyEkvFEa0UJjUPX6n9YOjYFJeTA3GAexV2uta4Lx+3LVmt/ZtS0U3RCHhWfepSiimOAAGqB63zT2F+2MWagIQhjE4qcB6Ca6tSW7E93oyFXRQlityv3ImAvDoXPZxEPaKk2ONllP/Lh0KdEfsKWEKln7n2sK4H7ZmKpKsKg0auc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DGqI91jD; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DGqI91jD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771487047; x=1803023047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CWpJJrcELpAqUcwwgoTh0ihanHTAd117sPRUgE2OnGk=;
  b=DGqI91jDH2wQPF6Z6pw2od+xKJ5XNh44OMo1SkInZgXQVaVVe/JuZ+aD
   PIswkJns4ub5LlZlLyurYYxb+Fm4+g1s3JA1rLuN8O1xVDJTWLgNtryXD
   aYgjISF6E99IEkMXkTg09cP+VfmAmzEEvbaZx6x/7vptmJEd3EIyzjFGD
   USoankw9fSt65FyGDIQjxQ3NjN/Vr5YSnvOQH3AN72Q97+NhcjweMcVPl
   5RrPNSOq7fAvbxTlL41xwemnAkaZHZiYHFCR5M/8EA/MIP0JM7TtOfpcm
   2tP7kI9fvA2bBAUHPkCCzkAE7aanSWqieaye8Kf/oAvJXWGyeDj/tqvhJ
   A==;
X-CSE-ConnectionGUID: /mH479HSSrSUM6692yLMzA==
X-CSE-MsgGUID: w0p01VUTTralj4PBN3+DPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="72746039"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="72746039"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 23:44:07 -0800
X-CSE-ConnectionGUID: BmJuDQLTSS+KkkQ8tQW3Uw==
X-CSE-MsgGUID: WEdTVFbMQxKE2XbXNalD0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="214454473"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.114])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 23:44:03 -0800
Date: Thu, 19 Feb 2026 09:44:01 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: bhargav <rougueprince47@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio:frequency:ad9523:convert symbolic permissions to
 octal and remove unwanted arguments in macro
Message-ID: <aZa_QbwCumULvTf7@smile.fi.intel.com>
References: <20260219010244.191668-1-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219010244.191668-1-rougueprince47@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 19, 2026 at 06:32:44AM +0530, bhargav wrote:
> this fixes following warnings in checkpatch

1. Respect English grammar and punctuation.
2. Use imperative mood (as per Submitting Patches)
3. Choose correct style for $Subject
   (see `git log --no-merges --oneline -- $FILE` to how mark it properly)

> WARNING: Argument 'x' is not used in function-like macro
> WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> WARNING: Symbolic permissions 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
> WARNING: Avoid multiple line dereference - prefer 'pdata->pll1_charge_pump_current_nA'
> WARNING: Avoid multiple line dereference - prefer 'pdata->pll2_charge_pump_current_nA'

These are three changes in one patch. Split them. Also see below.

...

> -#define AD9523_CLK_DIST_DIV_PHASE_REV(x)	((ret >> 18) & 0x3F)
> +#define AD9523_CLK_DIST_DIV_PHASE_REV	((ret >> 18) & 0x3F)

> -#define AD9523_CLK_DIST_DIV_REV(x)		(((ret >> 8) & 0x3FF) + 1)
> +#define AD9523_CLK_DIST_DIV_REV		(((ret >> 8) & 0x3FF) + 1)

Make use of '(x)' instead, having 'ret' here is definitely a bad code.

...

> -static IIO_DEVICE_ATTR(pll1_locked, S_IRUGO,
> +static IIO_DEVICE_ATTR(pll1_locked, 0444,
>  			ad9523_show,
>  			NULL,
>  			AD9523_STAT_PLL1_LD);

No, instead of doing this, just convert to use IIO_DEVICE_ATTR_RO() and
respectively for the rest.

...

> @@ -649,11 +649,11 @@ static int ad9523_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_FREQUENCY:
>  		*val = st->vco_out_freq[st->vco_out_map[chan->channel]] /
> -			AD9523_CLK_DIST_DIV_REV(ret);
> +			AD9523_CLK_DIST_DIV_REV;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_PHASE:
> -		code = (AD9523_CLK_DIST_DIV_PHASE_REV(ret) * 3141592) /
> -			AD9523_CLK_DIST_DIV_REV(ret);
> +		code = (AD9523_CLK_DIST_DIV_PHASE_REV * 3141592) /
> +			AD9523_CLK_DIST_DIV_REV;
>  		*val = code / 1000000;
>  		*val2 = code % 1000000;
>  		return IIO_VAL_INT_PLUS_MICRO;
> @@ -701,7 +701,7 @@ static int ad9523_write_raw(struct iio_dev *indio_dev,
>  		break;
>  	case IIO_CHAN_INFO_PHASE:
>  		code = val * 1000000 + val2 % 1000000;
> -		tmp = (code * AD9523_CLK_DIST_DIV_REV(ret)) / 3141592;
> +		tmp = (code * AD9523_CLK_DIST_DIV_REV) / 3141592;
>  		tmp = clamp(tmp, 0, 63);
>  		reg &= ~AD9523_CLK_DIST_DIV_PHASE(~0);
>  		reg |= AD9523_CLK_DIST_DIV_PHASE(tmp);

No for the above. This should be left untouched. Or more work is needed
if we want to have meaningful name instead of 'ret' here.

...

>  	ret = ad9523_write(indio_dev, AD9523_PLL1_CHARGE_PUMP_CTRL,
> -		AD9523_PLL1_CHARGE_PUMP_CURRENT_nA(pdata->
> -			pll1_charge_pump_current_nA) |
> +		AD9523_PLL1_CHARGE_PUMP_CURRENT_nA(pdata->pll1_charge_pump_current_nA) |
>  		AD9523_PLL1_CHARGE_PUMP_MODE_NORMAL |
>  		AD9523_PLL1_BACKLASH_PW_MIN);
>  	if (ret < 0)
> @@ -842,8 +841,7 @@ static int ad9523_setup(struct iio_dev *indio_dev)
>  	 */
>  
>  	ret = ad9523_write(indio_dev, AD9523_PLL2_CHARGE_PUMP,
> -		AD9523_PLL2_CHARGE_PUMP_CURRENT_nA(pdata->
> -			pll2_charge_pump_current_nA));
> +		AD9523_PLL2_CHARGE_PUMP_CURRENT_nA(pdata->pll2_charge_pump_current_nA));
>  	if (ret < 0)
>  		return ret;

These are okay despite being long.

-- 
With Best Regards,
Andy Shevchenko


