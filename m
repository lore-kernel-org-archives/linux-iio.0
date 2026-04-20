Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768F438CFE9;
	Mon, 20 Apr 2026 08:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776674283; cv=none; b=NFTgIWH2aLrBsDmOYRad2MjLwrdtcrxIYWHToJ67i1AL8ENIIkkuE3B/qHakHiwWg0ywpu3Lir2ZolTvJUmo7j2QLDxt78sgUXdn60eMHohkYZ0NvpDUh1PKMouff0QKlwsFPWk/37/Wlk7O1fZAUOZ0lRy0/DFa3wrmcTVoZwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776674283; c=relaxed/simple;
	bh=Gbya5oXKaAMZhy9lQDSpzS07YizLz6mOef1S9GPA278=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUB0Plziojl1UI3Z2obH1V2Xho/u86gjG2i1DsRqvgIwIkrTdTlNqQxTM1dVZozb/zdMK4eskGHZUiUmhcn5moUcg9TtRmCEcmL7OCdMVEf+gvaZgi+Zmu9lJmo/dTLhEOQ7ZrBil538qBbsPGU5wuzMQ9HomZSsGNxH0HTRwlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T1AMVAbX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T1AMVAbX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776674281; x=1808210281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gbya5oXKaAMZhy9lQDSpzS07YizLz6mOef1S9GPA278=;
  b=T1AMVAbXx2fgx7hqrNTRK7o41pA6kD8QMhq0md/nC8OKzGub5Emb3m1M
   0ATvVeVB3t0HT5Pw8LfekGSzNGsy7PEyPCram6FqBYqPEWHgOWdmvkVBW
   hYiwOO17PQEnBy25Sao03OJdAlsJ+e5YS5cRU81urEfeeLycdILXAHLd1
   Wuo+eValmQU6v+NK1gNTu+fAYx+nCiGHF+Hs1zQEF/Ez+Dk65XzJwPeNy
   q/h4FXqOlMdQo5nezjWkBuTV+5Z9Qhvt84XXWEg27d8mJLMRnvPnvPhx2
   2cP6j68jAj+yrEkHaliUuipb6dQgkg3fsfvdBf2nK/73ubD7uXsmyjq/2
   A==;
X-CSE-ConnectionGUID: eKxCeZb4SES1TW2KKjDMrQ==
X-CSE-MsgGUID: XvTgCH92TA+eOwZrwx0+NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="103050555"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="103050555"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 01:38:00 -0700
X-CSE-ConnectionGUID: jPoRTTOQTd6fzvT1G7mBeg==
X-CSE-MsgGUID: IPCeMjJRSy6C3LyKzrnPJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="236041746"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 01:37:58 -0700
Date: Mon, 20 Apr 2026 11:37:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Felipe Ribeiro de Souza <felipers@ime.usp.br>
Cc: paul@crapouillou.net, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org,
	Lucas Ivars Cadima Ciziks <lucas@ciziks.com>,
	linux-mips@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ingenic-adc: use guard(mutex)(&lock) to
 handle synchronisation
Message-ID: <aeXl5BO91iRUqNWp@ashevche-desk.local>
References: <20260419152917.8984-1-felipers@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419152917.8984-1-felipers@ime.usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Apr 19, 2026 at 12:27:34PM -0300, Felipe Ribeiro de Souza wrote:
> Replace mutex_lock(&lock) and mutex_unlock(&lock) calls with
> guard(mutex)(&lock) in functions ingenic_adc_set_adcmd(),
> ingenic_adc_set_config(), ingenic_adc_enable(), ingenic_adc_capture(),
> and with scoped_guard(mutex, &lock) in function
> ingenic_adc_read_chan_info_raw().
> 
> This removes the need to call the unlock function, as the lock is
> automatically released when the function return or the scope exits
> for any other case.

...

>  	/* We cannot sample the aux channels in parallel. */
> -	mutex_lock(&adc->aux_lock);
> -	if (adc->soc_data->has_aux_md && engine == 0) {
> +	scoped_guard(mutex, &adc->lock) {

This makes a bit noisy refactoring, hard to follow. Perhaps, split out
the helper function first (in a separate change) and then use guard()()
there.

> +		if (adc->soc_data->has_aux_md && engine == 0) {
> +			switch (chan->channel) {
> +			case INGENIC_ADC_AUX0:
> +				cmd = 0;
> +				break;
> +			case INGENIC_ADC_AUX:
> +				cmd = 1;
> +				break;
> +			case INGENIC_ADC_AUX2:
> +				cmd = 2;
> +				break;
> +			}
> +	
> +			ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_AUX_MD, cmd);
> +		}
> +	
> +		ret = ingenic_adc_capture(adc, engine);
> +		if (ret)
> +			goto out;
> +	
>  		switch (chan->channel) {
>  		case INGENIC_ADC_AUX0:
> -			cmd = 0;
> -			break;
>  		case INGENIC_ADC_AUX:
> -			cmd = 1;
> -			break;
>  		case INGENIC_ADC_AUX2:
> -			cmd = 2;
> +			*val = readw(adc->base + JZ_ADC_REG_ADSDAT);
> +			break;
> +		case INGENIC_ADC_BATTERY:
> +			*val = readw(adc->base + JZ_ADC_REG_ADBDAT);
>  			break;
>  		}
> -
> -		ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_AUX_MD, cmd);
> -	}
> -
> -	ret = ingenic_adc_capture(adc, engine);
> -	if (ret)
> -		goto out;
> -
> -	switch (chan->channel) {
> -	case INGENIC_ADC_AUX0:
> -	case INGENIC_ADC_AUX:
> -	case INGENIC_ADC_AUX2:
> -		*val = readw(adc->base + JZ_ADC_REG_ADSDAT);
> -		break;
> -	case INGENIC_ADC_BATTERY:
> -		*val = readw(adc->base + JZ_ADC_REG_ADBDAT);
> -		break;
> +	
> +		ret = IIO_VAL_INT;
>  	}
> -
> -	ret = IIO_VAL_INT;
>  out:
> -	mutex_unlock(&adc->aux_lock);
>  	clk_disable(adc->clk);
>  
>  	return ret;

Alternatively, propose the respective ACQUIRE*() macros to CCF.

-- 
With Best Regards,
Andy Shevchenko


