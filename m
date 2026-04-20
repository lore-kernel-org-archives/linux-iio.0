Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3186740DFC7
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 08:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776674752; cv=none; b=QVR0MNMSqXBfwfIk1BMQAinczY2M4KQ1FwMqC99Q4OCqFbo9//7lGnr4iQL3Ts2ch8hAsh/vsCseDHirc6tfaizQLsDbIF1l4n9eNNZbv0PvaajvzdhJ/RKA0W830FQGAQbT+nwuJEliWPztw+124Gjdipj0okUaGVbmaemxioo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776674752; c=relaxed/simple;
	bh=+HNr687+JmUm1hbA/e71Pu2qRadvk7+sGg0I0Y49exI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olss9G8nO6ZLY3B5A/EHYdgeiOhaU3YHNJG0KrLcgIL0Invn2iBR6dHJzwKbxhy51m1qXqtHeL2wb/Ful+Kg7LyGt6QM+vBJGmMQAmUpIR0dG7x3GnnvyvtEfTPQq1i6NZ902LPbyXb68D539BRoYW98WMECzRhQWlTmI+0x1Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nRAOlQNN; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nRAOlQNN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776674751; x=1808210751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+HNr687+JmUm1hbA/e71Pu2qRadvk7+sGg0I0Y49exI=;
  b=nRAOlQNNId9TpgsH+FRn3pwdHxCZ92RvmXEBQuYfNBQ9c1YOx1KrEPMG
   6w2nB6jfV8N9n9GQ6HYqGkPWcQuG4nfrLpXt6rk0YT74NfwXHvA5zggW6
   XwhK7UXhaT8/UsKsX6s5rk+3tDEWVqLydf65vmQPDPzRBnmU7RJwXl3/I
   kd+y3yr8npl30JKiIEUTep3KUSQW183rhr++2OroI4Tn0xRcJqre7IA65
   pCzkvvqpaMIDp/GlJG1aB6//I+Jq2pT2CdAfZOnq1ri0xF2IF8kJA3WpC
   O0cd6gaVRJCojYAPEKLlE8gjq+lfyIH/9X6YpRx4NbzH1H/0gu3pn5JTQ
   Q==;
X-CSE-ConnectionGUID: nUxbdCsWT9S64me5lCgByg==
X-CSE-MsgGUID: 6ThXnTUQTt2sHCoTjKvP8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="94986708"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="94986708"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 01:45:50 -0700
X-CSE-ConnectionGUID: 1nGz1puTT223+DbQKE53Eg==
X-CSE-MsgGUID: tDAZink/RRaOOLwctxklQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="228977565"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 01:45:48 -0700
Date: Mon, 20 Apr 2026 11:45:46 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Pedro Barletta Gennari <pedro.pbg@usp.br>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: light: iqs621-als: use lock guards
Message-ID: <aeXnujb9-aui4ArO@ashevche-desk.local>
References: <20260419213202.68356-1-pedro.pbg@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419213202.68356-1-pedro.pbg@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Apr 19, 2026 at 06:31:23PM -0300, Pedro Barletta Gennari wrote:
> Use guard(mutex)() for handling mutex lock instead of
> manually locking and unlocking the mutex. This prevents forgotten
> locks due to early exits and remove the need of gotos.

...

> @@ -15,6 +15,7 @@
>  #include <linux/notifier.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> +#include <linux/cleanup.h>

Keep the list ordered.

...

>  		ret = iqs621_als_init(iqs621_als);
>  		if (ret) {
>  			dev_err(indio_dev->dev.parent,
>  				"Failed to re-initialize device: %d\n", ret);
> -			ret = NOTIFY_BAD;
> +			return NOTIFY_BAD;
>  		} else {

Now 'else' is redundant.

> -			ret = NOTIFY_OK;
> +			return NOTIFY_OK;
>  		}
> -
> -		goto err_mutex;

...

>  	struct iqs621_als_private *iqs621_als = iio_priv(indio_dev);

>  	int ret = IIO_VAL_INT;

Drop it, use the value explicitly inline in each of the cases below.

>  
> -	mutex_lock(&iqs621_als->lock);
> +	guard(mutex)(&iqs621_als->lock);
>  
>  	switch (dir) {
>  	case IIO_EV_DIR_RISING:
>  		*val = iqs621_als->thresh_light * 16;
> -		break;
> +		return ret;
>  
>  	case IIO_EV_DIR_FALLING:
>  		*val = iqs621_als->thresh_dark * 4;
> -		break;
> +		return ret;
>  
>  	case IIO_EV_DIR_EITHER:
>  		if (iqs621_als->ir_flags_mask == IQS622_IR_FLAGS_TOUCH)
>  			*val = iqs621_als->thresh_prox * 4;
>  		else
>  			*val = iqs621_als->thresh_prox;
> -		break;
> +		return ret;
>  
>  	default:
> -		ret = -EINVAL;
> +		return -EINVAL;
>  	}

-- 
With Best Regards,
Andy Shevchenko


