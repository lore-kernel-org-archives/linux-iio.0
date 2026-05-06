Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC44F3F0ABF;
	Wed,  6 May 2026 10:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778061900; cv=none; b=AXMIhhNdCNyqUPLmFoj1GlcHIZOUTuZvEaLnr3SMXJJ7371F5zcMWH/w/ffvKeAO7IfgSwfGP6amy5UWrOKmkKP+LpIemliUnLMWM14OBKzi+sDlbnbVhWgGyjZuomp/zDTrMFerhEHKHw7pqS4927d/ep5zPHaSteF7o5Oy/A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778061900; c=relaxed/simple;
	bh=QwGiOYgQKEjV/q8YgIe91uC5Q0zeqgJSXl2VdXCyPgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3uFAK8XwjgAe5Xi62xXeNUFoD5lM69vLm3gOWuy2ZZfKEMc5ZKi0W7pFLNp3moC7sKg1w9CTpzoNbpMO6J+PikrNEMrN0t7FQtKtc/gF8sL8cPF/cNrQW4qcBsos1ivERt6vZ3b90HfEpsQeLUGjEvimOV5mGapoJqk5EJddnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n1dw6bI1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n1dw6bI1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778061897; x=1809597897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QwGiOYgQKEjV/q8YgIe91uC5Q0zeqgJSXl2VdXCyPgQ=;
  b=n1dw6bI1kTeH1r+6GULEC+WUi8UHktdOl5hN4C/WkICU6O79aMpvRLzJ
   2o+LERCNmYr/jIDJvc+N9tlFTyydqlAuRHL1O38oqh9mh+jX4qRWBALTJ
   TvCLEqYx/NBoZkVaJYjPhyfPNDB89cRpBKet4B6/8TkvJiv0GU2Q1Yy1K
   ttAlwbRakiEhCoELrW7GdIytY/LUAZBrTNovQbECPVRVzYYNSFl+tNZDF
   wqMwU4kSfaTysM2K4sWNMVHADYqjGYaNqBmImtwRtK5lKYchYOTQvfijt
   o5cc4sgh7lim/atZv9w3a+BxLSS7F4FCDpitpC2K+UIMOhrqqM+2ydLuv
   A==;
X-CSE-ConnectionGUID: 2vavmajCQri0i+NV8aLdPw==
X-CSE-MsgGUID: +IWVLXiyS5iqE8QjjqQrqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="82594405"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="82594405"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 03:04:53 -0700
X-CSE-ConnectionGUID: qBrVmZE3Qpqq4w/ntAxQuQ==
X-CSE-MsgGUID: 9yc2sZTrRVWhvVUhjxKnmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="233442186"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 03:04:50 -0700
Date: Wed, 6 May 2026 13:04:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 3/3] iio: light: tcs3472: Use guard(mutex)() family over
 manual locking
Message-ID: <afsSQN04yWVSLM2y@ashevche-desk.local>
References: <20260506094311.222500-1-aldocontelk@gmail.com>
 <20260506094311.222500-4-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506094311.222500-4-aldocontelk@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 06, 2026 at 11:43:11AM +0200, Aldo Conte wrote:
> Convert tcs3472_read_event_config, tcs3472_write_event_config,
> tcs3472_write_event, tcs3472_powerdown and tcs3472_resume to use
> automatico cleanup with guard(mutex)() instead of the old manual
> locking method.

> Found by code inspection.

Huh?! Is it a bug? What is the inspection assumed here?

> Tested on a Raspberry Pi 3B with a TCS34725 at 0x29 address.
> The following fields were read and written without any issues:
> sampling_frequency, integration_time, calibscale and the
> threshold event interface.
> The unload of the driver works cleanly.

The comments should be in the cover letter and not in each of the commit
message, we do not want that noise here!

> Signed-off-by: Aldo Conte <aldocontelk@gmail.com>

So, do not do ping-pong programming: when the code introduced in the series is
immediately being changed by another patch in the same series. As explained
this patch should be first in the series to solve that.

...

>  {
>  	struct tcs3472_data *data = iio_priv(indio_dev);
> -	int ret;
>  
> -	mutex_lock(&data->lock);
> -	ret = !!(data->enable & TCS3472_ENABLE_AIEN);
> -	mutex_unlock(&data->lock);
> -
> -	return ret;
> +	guard(mutex)(&data->lock);

Leave a blank line here.

> +	return !!(data->enable & TCS3472_ENABLE_AIEN);
>  }

...

> static int tcs3472_resume(struct device *dev)

>  	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON |
>  			TCS3472_ENABLE_WEN;

Taking into account the comment against patch 1, add a new patch to make this
follow the patter suggested there.

> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>  
>  	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
>  		data->enable | enable_mask);
>  	if (!ret)
>  		data->enable |= enable_mask;
>  
> -	mutex_unlock(&data->lock);
> -
>  	return ret;
>  }

-- 
With Best Regards,
Andy Shevchenko


