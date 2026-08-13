Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C383A9D9D;
	Thu, 13 Aug 2026 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786612115; cv=none; b=DqxUcCfoCbmwRokPNILC3T8KyqC/d/uptyP0pXksfdrjj8K2g0GAXLM8rnv6+2HItQksEYSxKnkUzMzC4enb7sohJVI+UMIMMDMpCmZo7tnQvs1C6bROhsUI3ZRKtWlNQMoBZz023fe2elQrnU2tAOHBfA3rVkRc4h9Btf4D/xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786612115; c=relaxed/simple;
	bh=NrU2fmIx+h2U7qXsYNioWTBQPwz7TPyb8sMfCgtGBEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESGvbwMR8C31A2e5EUImv4b+1OrZfE0ruKUbZ6Bhi1/6JfyiIzbNDJEijL80vW+9OjSM0d0I2bh6Z0o7g/FleXPFk4xEgJS0K3iMfKdDbMweFDsD4ZXSW+Ltp0biG+mZy3FyCpgRRuiUD5+MB+cKRhdXV0vvZxpjSp1+JPhjwiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cXxIMKzt; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cXxIMKzt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786612115; x=1818148115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NrU2fmIx+h2U7qXsYNioWTBQPwz7TPyb8sMfCgtGBEQ=;
  b=cXxIMKzt0ahvhmUayaZb3cQLUmFD8VhKbb2KsyscN2v9ZHYGCCM675hp
   cmhrlOcrD29Q5f26FmG+POl3c4ZCCp0kwkkMUKmtmzFH82OqaBvs8LwZR
   3TfiH29fO6YtwG9JciU5w9FgPVmautwyuj/hPYVIn4DJHKLUvfrjrtK6c
   0xVX11JTQ31C5Zwn7Y7ZIyA4t3mrGOzzv3lcD1j1nSA4ayQ8dP5sndFV/
   /x7/kI08+RAVVe7s+4GOwSzV+DhdsHQN43XMrNwcMcbxFexBfipQjvrCV
   GADl6nh+u9LR/CbOH45MzywOsvlSwDTghvYSgvXIyxzSLeN8wIJ8tC7Tf
   g==;
X-CSE-ConnectionGUID: tl7DSIQOSJCRceV98A7vBA==
X-CSE-MsgGUID: 6rDERVDdRkuIPZk/zn7TYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="98332681"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="98332681"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 02:08:34 -0700
X-CSE-ConnectionGUID: YN5bCTuPR/imCoKVjIHo1w==
X-CSE-MsgGUID: y575klGBQE6r7qpBFbntTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="293837476"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.250])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 02:08:26 -0700
Date: Thu, 13 Aug 2026 12:08:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
	nuno.sa@analog.com, u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/8] iio: adc: ti-ads1015: inline
 ads1015_set_conv_mode()
Message-ID: <an2Jh5dGjrDLgUoq@ashevche-desk.local>
References: <20260812164433.23011-1-architanant5@gmail.com>
 <20260812164433.23011-9-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812164433.23011-9-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 12, 2026 at 10:14:33PM +0530, Archit Anant wrote:
> The ads1015_set_conv_mode() helper function is a single-line wrapper
> around regmap_update_bits().
> 
> With the transition to the FIELD_PREP() macro, the raw register updates
> are now self-documenting and easy to read. Remove the wrapper function
> and inline the regmap calls directly at the call sites.
> 
> This also allows for the removal of the final custom shift macro,
> ADS1015_CFG_MOD_SHIFT.

...

> -static int ads1015_set_conv_mode(struct ads1015_data *data, int mode)
> +static void ads1015_power_off(void *data)
>  {
> -	return regmap_update_bits(data->regmap, ADS1015_CFG_REG,
> -				  ADS1015_CFG_MOD_MASK,
> -				  mode << ADS1015_CFG_MOD_SHIFT);
> -}
> +	struct ads1015_data *st = data;
>  
> -static void ads1015_power_off(void *st)
> -{
> -	ads1015_set_conv_mode(st, ADS1015_SINGLESHOT);
> +	regmap_update_bits(st->regmap, ADS1015_CFG_REG,
> +			   ADS1015_CFG_MOD_MASK,
> +			   FIELD_PREP(ADS1015_CFG_MOD_MASK,
> +				      ADS1015_SINGLESHOT));
>  }

Wouldn't be better to have it as

static void ads1015_power_off(void *data)
{
	unsigned int val = FIELD_PREP(ADS1015_CFG_MOD_MASK, ADS1015_SINGLESHOT);
	struct regmap *map = data->regmap;

	regmap_update_bits(map, ADS1015_CFG_REG, ADS1015_CFG_MOD_MASK, val);
}

In lieu of this, think if the similar approach can be applied elsewhere in this
driver.

-- 
With Best Regards,
Andy Shevchenko


