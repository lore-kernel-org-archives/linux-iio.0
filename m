Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E892E11B0;
	Thu, 26 Mar 2026 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774516932; cv=none; b=hzI2mX8N/AVi4HVwUpTB9hXjMe+OfjZ68+IFu3K7+0dsNjg/vC8DCwvg9FUN4NnzxnkKkrzPeOafrxZ3lUQLukeKweCbAZhuiAYOC6LnPwEx8utZcWx12weAYV6/0FLCu/OwOP7X/PZ6vvSAcM17YDEs6LyDYAsIan9PsE3HWOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774516932; c=relaxed/simple;
	bh=5SWa5jcD/GvB5R/Lld4KON/hgap4TPAs7eQCSWd+zZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfY2tLMVYh5LdWpmS18KM91daKYMX8IsdqrD5T7q82i6dGoz6htnexiRKl7aUX9JVtBleNBTY2AAc9a+AO24OfCQnHT6Tdnpowt0TKbrpp0VQCD3MCURab3fNLGZoYNAo00OcTyGwQXP0ogi7kuyX1PrSZCWlKy3MePS4rCCMD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bl8S4aDv; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bl8S4aDv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774516931; x=1806052931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5SWa5jcD/GvB5R/Lld4KON/hgap4TPAs7eQCSWd+zZo=;
  b=Bl8S4aDvvCxWWXGcYb/IAsXpVfPe36yZ56Jx3xhZaUmS1JBC1CHQU+4k
   NIo6sEicaTvhLIapE3dzfTXagaxF42+BvOwOPY5+dJywNv/dU68tgc/SJ
   uBjrvTnw0IJVOvcs3G9OZQGre2Q9AhTRRL5/sm8postcqYP0gAzDO2Tm9
   hDb8Qim95imep7SJ51oAGxW/LMzaPaiDrk9UHZGBxu9b7jZhCCOjJDcxw
   uljlDBSaK4XOv+5tdfrcSYH10zfhvizT5oRJjLWmxq6pjBbzqJgqC6Vur
   qPfciotHWaIWltAs6XYKUtIPXK1lg8D8hN53duEPTM+QUlYIAAPiGEd5D
   w==;
X-CSE-ConnectionGUID: mFZHUm4QRT6WgBEaTDFwTg==
X-CSE-MsgGUID: nhFHeKKsRWOqv2pshy9EXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75284988"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="75284988"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 02:22:11 -0700
X-CSE-ConnectionGUID: c3NPKbouQqSQh1+VnU/Vew==
X-CSE-MsgGUID: 4awdqOXpRgaH0k9IvlKjlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="220545045"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.216])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 02:22:08 -0700
Date: Thu, 26 Mar 2026 11:22:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, kees@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] iio: ssp_sensors: ssp_spi: use guard() to release
 mutexes
Message-ID: <acT6vokgYuUTsWcj@ashevche-desk.local>
References: <20260326081815.925373-1-sanjayembedded@gmail.com>
 <20260326081815.925373-4-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326081815.925373-4-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 26, 2026 at 01:48:14PM +0530, Sanjay Chitroda wrote:

> Replace explicit mutex_lock() and mutex_unlock() with the guard() macro
> for cleaner and safer mutex handling.

NAK. Please, be very careful when do such changes.

...

>  	msg->done = done;
>  
> -	mutex_lock(&data->comm_lock);
> +	guard(mutex)(&data->comm_lock);
>  
>  	status = ssp_check_lines(data, false);
> -	if (status < 0)
> -		goto _error_locked;
> +	if (status < 0) {
> +		data->timeout_cnt++;
> +		return status;
> +	}
>  
>  	status = spi_write(data->spi, msg->buffer, SSP_HEADER_SIZE);
>  	if (status < 0) {
>  		gpiod_set_value_cansleep(data->ap_mcu_gpiod, 1);
>  		dev_err(SSP_DEV, "%s spi_write fail\n", __func__);
> -		goto _error_locked;
> +		data->timeout_cnt++;
> +		return status;
>  	}
>  
>  	if (!use_no_irq) {
> -		mutex_lock(&data->pending_lock);
> +		guard(mutex)(&data->pending_lock);
>  		list_add_tail(&msg->list, &data->pending_list);
> -		mutex_unlock(&data->pending_lock);
>  	}
>  
>  	status = ssp_check_lines(data, true);
>  	if (status < 0) {
>  		if (!use_no_irq) {
> -			mutex_lock(&data->pending_lock);
> +			guard(mutex)(&data->pending_lock);
>  			list_del(&msg->list);
> -			mutex_unlock(&data->pending_lock);
>  		}
> -		goto _error_locked;
> +		data->timeout_cnt++;
> +		return status;
>  	}

> -	mutex_unlock(&data->comm_lock);
> -

Pzzz! See what you are doing here...

>  	if (!use_no_irq && done)
>  		if (wait_for_completion_timeout(done,
>  						msecs_to_jiffies(timeout)) ==
>  		    0) {
> -			mutex_lock(&data->pending_lock);
> +			guard(mutex)(&data->pending_lock);
>  			list_del(&msg->list);
> -			mutex_unlock(&data->pending_lock);
>  
>  			data->timeout_cnt++;
>  			return -ETIMEDOUT;
>  		}
>  
>  	return 0;
> -
> -_error_locked:
> -	mutex_unlock(&data->comm_lock);
> -	data->timeout_cnt++;
> -	return status;
>  }

-- 
With Best Regards,
Andy Shevchenko


