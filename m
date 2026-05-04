Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE2F33F5AF;
	Mon,  4 May 2026 08:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883779; cv=none; b=Ngc0vIi5+XUT+AdEVene8S1brO1UiSCSkT5nwig5Oq95v8RAu/Mm+HCes4mdHx98Q9X78szY5SaUOd74IiBO3JNmrJnWqBTDWR/PE+9LMX1uKHaXwr1sEKiTFpRci8cyQmlBny2WyGajs/TsRDULIwlakGZCw0NmMajyf0+V0ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883779; c=relaxed/simple;
	bh=DiQHJJlNC1C7NGG/jIJhSMigQgjPrYXXExw76L6lW4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=colT+js9NRvp4wG2DVs1jf3T7U8/DhtIVDmEsLMA2/NnSNyDm12yiyOhAVPDbMCzS8KDqEIqe5Kc0YpBaPsmbg7hcrxi2AgLUeQdhwl20I7XhtrL/VETn3Dr//0Dg5cqQTavScQ5RSZj5sLt/FIefPfORLp9K7CcttpZg8tsvAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IkeHBdrE; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IkeHBdrE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777883777; x=1809419777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DiQHJJlNC1C7NGG/jIJhSMigQgjPrYXXExw76L6lW4w=;
  b=IkeHBdrEYEoJSpp/c66tskcoKY0oYViediaFgyuIdBg/axmIJEr966dd
   u6+nqEEuiiz/9ES/YjtQMBkINlifPvtGgDekvJN1TxEo5IDmQg7YUMkrA
   I46JIOl5zHvpfJyUh5iQYQp8+1h1Sy2i01v2VO19ihMlskdtRm5tMaBx3
   mEcGBPBUn7X2klxuj3sl6emJtNpUfEYm8JeVnX4W7kjq+QS8DB9eLOTqK
   o/yMGS6iVok+n+t7R2Hjyr/SNevSztt+Jnp//Ftg5VgeqSPMgRs3Prnc5
   EcPC2856wbDm1MrlmDCath9Ir8QzdIUx6GBl0tiIVKOFgDa/2nneCt3d0
   A==;
X-CSE-ConnectionGUID: acm1MMF8R76Q2pSR5sbVsg==
X-CSE-MsgGUID: kRRIQPd9QI63SsDasxlMVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="101404599"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="101404599"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 01:36:17 -0700
X-CSE-ConnectionGUID: 7goztyBySemzArx8A2QRgA==
X-CSE-MsgGUID: mZfMR388S16SblhBMunZsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="234595917"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 01:36:14 -0700
Date: Mon, 4 May 2026 11:36:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: jic23@kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: kmx61: Use guard(mutex)() family over manual
 locking
Message-ID: <afhafBqBV79d9FBv@ashevche-desk.local>
References: <20260502032455.76107-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260502032455.76107-1-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 01, 2026 at 10:24:54PM -0500, Maxwell Doose wrote:
> Include linux/cleanup.h to take advantage of new macros.
> 
> Replace manual mutex_lock() and mutex_unlock() calls across the file
> with guard(mutex)() and scoped_guard() where appropriate. This will help
> modernize the driver with up-to-date functions/macros.
> 
> Remove now redundant gotos and ret variables, as the new RAII macros
> make them unneeded.

...

>  		*val = sign_extend32(ret >> chan->scan_type.shift,
>  				     chan->scan_type.realbits - 1);
>  		ret = kmx61_set_power_state(data, false, chan->address);

>  

Now this blank line becomes a bit confusing as the following conditional is
tightly coupled with the above code, remove it.

> -		mutex_unlock(&data->lock);
>  		if (ret)
>  			return ret;
>  		return IIO_VAL_INT;

...

> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>  	iio_for_each_active_channel(indio_dev, bit) {
>  		ret = kmx61_read_measurement(data, base, bit);
>  		if (ret < 0) {
> -			mutex_unlock(&data->lock);
> -			goto err;
> +			iio_trigger_notify_done(indio_dev->trig);
> +			return IRQ_HANDLED;

Hmm... Is the HANDLED a right choice?

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

If the answer is yes, I'm wondering if we may deduplicate that...

...

>  static int kmx61_suspend(struct device *dev)
>  {
> -	int ret;
>  	struct kmx61_data *data = i2c_get_clientdata(to_i2c_client(dev));
>  
> -	mutex_lock(&data->lock);
> -	ret = kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MAG,
> +	guard(mutex)(&data->lock);

> +	return kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MAG,
>  			     false);

One line is okay in this case.

> -	mutex_unlock(&data->lock);
> -
> -	return ret;
>  }

-- 
With Best Regards,
Andy Shevchenko


