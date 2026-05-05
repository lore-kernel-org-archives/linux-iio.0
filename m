Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E064B3D4121;
	Tue,  5 May 2026 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986535; cv=none; b=TsqzRCy3vnjGud4hfr1xoTnjEIqyEYb/m8V8kjuyCDaeA4wpgso49MJE/6dNVO3cKCbqcL3V5YPOnVmTuq5RIqFtxxB+9MYWQdufF4W57d+/Q1vsonXYcpa1zbIX8FpPU7GV+tTXKsdmWYTuSNuXFQYaRFQ4QFtOhmhkTuOPoHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986535; c=relaxed/simple;
	bh=Sxspct++6Z419YdUQ8CJspChJZ5IfxCECEDjV7GHXMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxUbsZF8HWXzVtVs+KKwwbiuueHp5bMWkbDtfOkSIkUAEeUycWEO/r5aKibAk5u5FlEiXQnSHBUTYo6cdwqq5uHrx/f1VJtjd6VxsNNvpTg4o/4YuHx6VH8MjocCvFbaHYYEIsxq5WhvIqBdqH/B6J+YZSLUGqlylTXGJI8Vfas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=canM8BZq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="canM8BZq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777986534; x=1809522534;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sxspct++6Z419YdUQ8CJspChJZ5IfxCECEDjV7GHXMY=;
  b=canM8BZq8ijZ3lsG+F8JRh0G4ENvHsGVmRTKZvmN+iexyUAE9r9NR37H
   ipdLnCL6aP7QS0HhQrBwD45Ar+3lzhoh/DCl3qPK8BcuzMs6tzGNV3OGC
   y944b4o1L/+A1EHxMZS7dslwgofDYa3RlIZISxKhcx7T4zw4lKT5/fnS5
   r3HsqmoGlVQA2cyd6u3u4gf51d2saOIcef8z+vvIQw7UW3LwDHJtPRFmo
   dd3Phe2T+/Ue9V6LM0OofTh/RTYh0jyPRLzsgMrqyXnvPf5kByf5jKNMy
   M8UJWoyk1Auc9L1ArQkM8cdQtQEf5cwV6dv2QaY/aw8c2NQKmcgIosjzO
   A==;
X-CSE-ConnectionGUID: E0quQmvvQOWClQP6cJcqtA==
X-CSE-MsgGUID: OcI7slwiR8iIKDhyG9BW7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78905050"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="78905050"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 06:08:53 -0700
X-CSE-ConnectionGUID: hH4OuBOVRIqDbzZbK26sSQ==
X-CSE-MsgGUID: MbgdqPc9RTK7arg53wAdYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="259485785"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 06:08:51 -0700
Date: Tue, 5 May 2026 16:08:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: jic23@kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iio: imu: kmx61: Use guard(mutex)() family over
 manual locking
Message-ID: <afnr4TjC3DVxkVJt@ashevche-desk.local>
References: <20260505124706.9862-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505124706.9862-1-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 07:47:06AM -0500, Maxwell Doose wrote:
> Include linux/cleanup.h to take advantage of new macros.
> 
> Replace manual mutex_lock() and mutex_unlock() calls across the file
> with guard(mutex)() and scoped_guard() where appropriate. This will help
> modernize the driver with up-to-date functions/macros.
> 
> Remove now redundant gotos and ret variables, as the new RAII macros
> make them unneeded.

Did you compile this version?

...

> -	case IIO_CHAN_INFO_SAMP_FREQ:
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
>  		if (chan->type != IIO_ACCEL && chan->type != IIO_MAGN)
>  			return -EINVAL;
>  
> -		mutex_lock(&data->lock);
> -		ret = kmx61_get_odr(data, val, val2, chan->address);
> -		mutex_unlock(&data->lock);
> +		scoped_guard(mutex, &data->lock)
> +			ret = kmx61_get_odr(data, val, val2, chan->address);
>  		if (ret)
>  			return -EINVAL;
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	}
> +	}

This looks suspicious.

...

Please, slow down and check the patches you sent.

Also, use, if not yet, --histogram when preparing patches, it might make them
more readable.

...

>  	switch (mask) {
> -	case IIO_CHAN_INFO_SAMP_FREQ:
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
>  		if (chan->type != IIO_ACCEL && chan->type != IIO_MAGN)
>  			return -EINVAL;
>  
> -		mutex_lock(&data->lock);
> -		ret = kmx61_set_odr(data, val, val2, chan->address);
> -		mutex_unlock(&data->lock);
> -		return ret;
> -	case IIO_CHAN_INFO_SCALE:
> +		guard(mutex)(&data->lock);

+ blank line.

> +		return kmx61_set_odr(data, val, val2, chan->address);
> +	}
> +	case IIO_CHAN_INFO_SCALE: {
>  		switch (chan->type) {
>  		case IIO_ACCEL:
>  			if (val != 0)
>  				return -EINVAL;
> -			mutex_lock(&data->lock);
> -			ret = kmx61_set_scale(data, val2);
> -			mutex_unlock(&data->lock);
> -			return ret;
> +			guard(mutex)(&data->lock);
> +			return kmx61_set_scale(data, val2);

Missing scope.

>  		default:
>  			return -EINVAL;
>  		}
> +	}
>  	default:
>  		return -EINVAL;
>  	}

...

> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);

+ blank line.

>  	iio_for_each_active_channel(indio_dev, bit) {
>  		ret = kmx61_read_measurement(data, base, bit);
>  		if (ret < 0) {
> -			mutex_unlock(&data->lock);
> -			goto err;
> +			iio_trigger_notify_done(indio_dev->trig);
> +			return IRQ_HANDLED;
>  		}
>  		buffer[i++] = ret;
>  	}
> -	mutex_unlock(&data->lock);
>  
>  	iio_push_to_buffers(indio_dev, buffer);
> -err:
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;

...


> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);

+ blank line.

>  	kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MAG, true);
> -	mutex_unlock(&data->lock);

Since guard()() is not like lock/unlock, the blank line is better for
readability. lock/unlock scenarios look&feel as special scope, that's why
the blank lines there are optional.

-- 
With Best Regards,
Andy Shevchenko


