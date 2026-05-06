Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B940439B974;
	Wed,  6 May 2026 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778058398; cv=none; b=a/hRq0P04wgXr0f9PHjsQQuZMJk9AIb3DDkPfE0elFzFKXXJsdetCCXP4DF1IjOuv+eQD5ZLuOk7KwPG3dtms8SrBgQR95HBbMmsl6TDSqDajwtlWF10DabWtAJNTKlt1+dij+5ogHBLEP2OLzXKwtGNw1Oh5Xn8Pci841D3xgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778058398; c=relaxed/simple;
	bh=Lj9N/63yCHchw305uLOld162zDTU1SpaPIDilaBg4M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdLd9UzVSf4WgFxDEoFQ+ORsgmfVHsAKhAZghubOU/Qof3QfW7aUr1NdgJm1u68uXLcad4gBL2R6UcoDeODXdp0D7JaXJ2Cs6/zM57PCwcSsXTDrwjIWcdOaQN8oAabQNMUZaDCJCDBJxXeGpdXqwPaL7lVB6i00P70Ff+dndbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k6S66SGU; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k6S66SGU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778058397; x=1809594397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lj9N/63yCHchw305uLOld162zDTU1SpaPIDilaBg4M8=;
  b=k6S66SGUsfjvOrgdwwkJBEYPSgkA85Ys0PhsxOpUhNgX+O+EGksVmcTO
   XLjVOwHCLrTCISLUsBlhSDx8SqB8GMh+g2d31/c+FqX9qvwrBisDOsI/l
   Ap/q5VbzZmOHuowh/6/CEKeFE+/nTJ0Xdxp+jQIU2t8Ey0xTengdocJiQ
   e/IroJ16pkVZ2nyA3LU0c44UlF/5HNRMvp+KBwNvRKM9JAe9T4RnegvAt
   HnRg7dSkJsUaEe6+459b8AXPY1WLJJjgwSnh66ZMwyoSjl/o8ON04ImSK
   Dm70mQh+uqNuMlszEmQnaUhb3/j3nquMQV30ygTk7r9Hu4Rk0ZcYBK8PT
   g==;
X-CSE-ConnectionGUID: T8RZuvbwSaGMudbe5Mgfxg==
X-CSE-MsgGUID: M+BXnaoXSFavjhFH1crDLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78989529"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="78989529"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 02:06:36 -0700
X-CSE-ConnectionGUID: vFecjN3mR5akSXplZD+wOg==
X-CSE-MsgGUID: IUmnS1w4QIW9CJBuOJ/28g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="241063965"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 02:06:33 -0700
Date: Wed, 6 May 2026 12:06:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: jic23@kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] iio: imu: kmx61: Use guard(mutex)() over manual
 locking
Message-ID: <afsElj3doL4HZqYd@ashevche-desk.local>
References: <20260505220719.44646-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505220719.44646-1-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 05:07:19PM -0500, Maxwell Doose wrote:
> Include linux/cleanup.h to take advantage of new macros.
> 
> Replace manual mutex_lock() and mutex_unlock() calls across the file
> with guard(mutex)() and scoped_guard() where appropriate. This will help
> modernize the driver with up-to-date functions/macros.
> 
> Remove now redundant gotos and ret variables, as the new RAII macros
> make them unneeded.

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
>  	return -EINVAL;

For making the above less ambiguous, add default case here instead of the
standalone return.

	}
	default:
		return -EINVAL;
	}

>  }

...

>  static int kmx61_runtime_suspend(struct device *dev)
>  {
>  	struct kmx61_data *data = i2c_get_clientdata(to_i2c_client(dev));
> -	int ret;
>  
> -	mutex_lock(&data->lock);
> -	ret = kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MAG, true);
> -	mutex_unlock(&data->lock);
> -
> -	return ret;
> +	guard(mutex)(&data->lock);

Leave a blank line here. Same applies to all guard()() cases like this.

> +	return kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MAG, true);
>  }

-- 
With Best Regards,
Andy Shevchenko


