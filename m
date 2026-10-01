Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092B93B7B7A;
	Thu,  1 Oct 2026 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790877695; cv=none; b=ZRkchrZPkD/8bAymV8HN054x8nyZ/qnxgM2BSxs7bBQ1RZEE4fHnaEdrdUqIp177jlc5ChYar4RXYsaNaDa4udtUBFizxFGNEDu98aht+H0IaluaxN9W0JUeLvoyj6dSprdGORjf5uiKKdYftwNAOjqEezkWhXijXQ0yI0kQxHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790877695; c=relaxed/simple;
	bh=6C/lxn3E34F+gLTSJBLswB5cV2SJg4yCj/dUkhP+HV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZoD4Zn/TH/1N+e655btBQiBVuqZFJ0V8wbDEF9+ZKOLXoYEqCx/BiFCXpmIG1cy8kg1nu2zMKH3zYsrbVynMRAFav1/u4Ej75XLootEK84bH4GD8+R0ncVGh6axf0I9Pp3wHhblTFNYDDD2spgi4rtB+ehmO51+xdQLnZvxiYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BfRXZWZ6; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BfRXZWZ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790877691; x=1822413691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6C/lxn3E34F+gLTSJBLswB5cV2SJg4yCj/dUkhP+HV8=;
  b=BfRXZWZ60yzqXRdasj6JfD90bSW3q2ibrD4ojjkT6HeFL8syiTB+R7bd
   pvxB9TjCgGwTjLsGlf8/TIcv3RBjoB6FvcwOpfhYQNTj8NwMrKZ8O4ag2
   k8Tkda8hE2DkZKAfBJA3r7j7bvceiujvUV7+Y+AtjFlEc5ED6dKHR55rI
   1rqOIqHrKaCaMtA6+lzO0wMyms4WMc/oKLagw5ThrbG5GeNL4qLSqa3sW
   THa5QLU8dCdXfM+XT3CtBzw45etX/Dh+Kj7w6NTwUsOox4f+egz2YY2jR
   IpGFgSW4oWT1ZEZDgw/ZjOXJ6/+WiQ5CaZ4Zbo86UawvEJjjOFTO7PJAg
   Q==;
X-CSE-ConnectionGUID: wE3p+NZuR9uz9JmYkDcUsQ==
X-CSE-MsgGUID: DUpyZjpkQwuvqOnxWoM1uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="102166951"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="102166951"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 11:01:22 -0700
X-CSE-ConnectionGUID: oJ6Qse4mREKPNBF1cpoynQ==
X-CSE-MsgGUID: UK4EEDa6St+is3dFFzcp0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="274689692"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.27])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 11:01:19 -0700
Date: Thu, 1 Oct 2026 21:01:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
	nuno.sa@analog.com, u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/10] iio: adc: ti-ads1015: replace custom shift
 macros with FIELD_PREP/GET
Message-ID: <ar6f7Zg_-ensItvm@ashevche-desk.local>
References: <20260930171204.12863-1-architanant5@gmail.com>
 <20260930171204.12863-11-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930171204.12863-11-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 30, 2026 at 10:42:04PM +0530, Archit Anant wrote:
> The driver currently uses custom _SHIFT macros and manual bitwise
> operations to read and write to the configuration register.
> 
> Modernize the bitwise logic by replacing all manual shifts with the
> standard FIELD_PREP() and FIELD_GET() macros from <linux/bitfield.h>.
> This improves readability and prevents potential bitwise errors.
> 
> Remove the now-unused _SHIFT macros from the top of the file.

...

> int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)

>  	dr = data->channel_data[chan].data_rate;
>  	mask = ADS1015_CFG_MUX_MASK | ADS1015_CFG_PGA_MASK |
>  		ADS1015_CFG_DR_MASK;
> -	cfg = chan << ADS1015_CFG_MUX_SHIFT | pga << ADS1015_CFG_PGA_SHIFT |
> -		dr << ADS1015_CFG_DR_SHIFT;
> +	cfg = FIELD_PREP(ADS1015_CFG_MUX_MASK, chan) |

> +	      FIELD_PREP(ADS1015_CFG_PGA_MASK, pga) |
> +	      FIELD_PREP(ADS1015_CFG_DR_MASK, dr);
>  
>  	if (ads1015_event_channel_enabled(data)) {
>  		mask |= ADS1015_CFG_COMP_QUE_MASK | ADS1015_CFG_COMP_MODE_MASK;
> -		cfg |= data->thresh_data[chan].comp_queue <<
> -				ADS1015_CFG_COMP_QUE_SHIFT |
> -			data->comp_mode <<
> -				ADS1015_CFG_COMP_MODE_SHIFT;
> +		cfg |= FIELD_PREP(ADS1015_CFG_COMP_QUE_MASK,
> +				  data->thresh_data[chan].comp_queue) |
> +		       FIELD_PREP(ADS1015_CFG_COMP_MODE_MASK,
> +				  data->comp_mode);
>  	}

Personally I would go with if-else with full initialisations of mask and cfg.

	if (ads1015_event_channel_enabled(data)) {
		mask = ADS1015_CFG_COMP_QUE_MASK | ADS1015_CFG_COMP_MODE_MASK |
		       ADS1015_CFG_MUX_MASK | ADS1015_CFG_PGA_MASK |
		       ADS1015_CFG_DR_MASK;
		cfg = FIELD_PREP(ADS1015_CFG_MUX_MASK, chan) |
		      FIELD_PREP(ADS1015_CFG_PGA_MASK, pga) |
		      FIELD_PREP(ADS1015_CFG_DR_MASK, dr) |
		      FIELD_PREP(ADS1015_CFG_COMP_QUE_MASK,
				  data->thresh_data[chan].comp_queue) |
		      FIELD_PREP(ADS1015_CFG_COMP_MODE_MASK,
				  data->comp_mode);
	} else {
		mask = ADS1015_CFG_MUX_MASK | ADS1015_CFG_PGA_MASK |
		       ADS1015_CFG_DR_MASK;
		cfg = FIELD_PREP(ADS1015_CFG_MUX_MASK, chan) |
		      FIELD_PREP(ADS1015_CFG_PGA_MASK, pga) |
		      FIELD_PREP(ADS1015_CFG_DR_MASK, dr);
	}

// also note the broken indentation

-- 
With Best Regards,
Andy Shevchenko


