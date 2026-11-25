Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606505;
	b=PZKRzMvGoSjEikliv/MEc/B34belU3e6Onn770raJX8+LLAiy6uoxOcZV+uxsMAYDsPo
	 nJH0+rLG3LpIr1Kxq+87wg5RMc3cdg78kH+O+u5DKfQkklpnAWLcf8brOwPNgwr5bkGpa
	 XVwLsIMInGCaOgRstZ8KlNI1/yeHTvGwOF02wLhdSy8pls57lSd6DGRmhY7jBKoy444tJ
	 IrF7dnQNRKalFSZDWl1hz8ASokw5hdd+nOO+qvLW1offoIEN9o5RvNqkXEauOJ1w1FjnQ
	 99IJiJ0k+deZ3tJxYj9zkqEyK5u6EOz40Z2mrFECBjZQD42si6pqMyAzJ6oWDh1l7jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606505;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Ff3Cl/JJeExr6kILvGX+SicD9xIWfjDB/TEpsnvKFqw=;
	b=03WGXaPMf9A+F4vQJHWUkh4vtvBuCWZ6mKDXpkxe/5oZnUjLfXKqlvJkS3VQoUBFDIDY
	 o7OFlNYHNYIKg1tF3O53CrBqlNe0lTvrpSuM3TymKG9sYcOqXlloChYWWcajyiQLRoLp2
	 k2I0upgo2SAp9onRYNePYpHFBGyV6mKMVFkMO8aQDA/YHYpdnXbnGcjdjUJAAG+Cbfu+P
	 zqvolKYSjjO5erRJf+dQsG1c6hrGIkuGg0jHNNblj7lmizUoxc/l2R+ZeBC1o+KRESdMe
	 ncSzWYqJT35DxULyv98fySHPppEeow78LjvJHdpP9P2KoHfsdeC2kTZyxCn18wlg1Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WiIGSsCz;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9743606A31E;
	Wed, 25 Nov 2026 11:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9743606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WiIGSsCz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795606504; x=1827142504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=usu8wnf/tEyRqO30pySI/6w3usELj7hOp6imvwraHfY=;
  b=WiIGSsCz8SGBBlVEOTP95pyqGF4jCdvUuGn+VjwGtIQvvw/5iGz+ew4p
   1fMBVwqKjQQA3GnfhPjQuGha3VPKQL2AEgAqGLVyf7CbWrJENA+nCnbQl
   6N+KxLJE8WmoWeaCerW8aCah3puRlMq8d3nn6KpBoUy5aVmZq60Gs8cN3
   oU/qD18I1GXt3ChfvgDk5C0FEwunTfkTATb0vyzHoxBAL3mqdPoW/YYPK
   3UdK8cNKWGWswFZFYuu1i6BteitGstwlhq/P+6/lujmEfQHQ6S7QdYMVh
   0q2Dw33JT8EEIDBiPDMp8YlRWA/YeeSGXqKJc7e0z0Mg17EybGZN32MRX
   w==;
X-CSE-ConnectionGUID: t4LvFQMtT3S+LPxoJVzldA==
X-CSE-MsgGUID: AfKFm6XgQ9uyUn6dTxPzTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4542271"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4542271"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 03:34:59 -0800
X-CSE-ConnectionGUID: ikAqfyFPQiGYikroglB74Q==
X-CSE-MsgGUID: JjwpYNxbRdmEZ55IQHauYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11709000"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 03:32:27 -0800
Date: Wed, 25 Nov 2026 13:32:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Vaibhav Chahar <vaibhav.chahar26@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Marius Cristea <marius.cristea@microchip.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <crofts@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: palmas_gpadc: Use guard(mutex) to
 manage locks
Message-ID: <awbHSDdEyW6FS07l@ashevche-desk.local>
References: <20261124204054.85634-1-vaibhav.chahar26@gmail.com>
 <20261124204054.85634-3-vaibhav.chahar26@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124204054.85634-3-vaibhav.chahar26@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 25, 2026 at 02:10:54AM +0530, Vaibhav Chahar wrote:
> Use guard(mutex) instead of manual mutex_lock() and mutex_unlock()
> calls to modernize the driver and simplify error handling paths.
> 
> Made a new helper function palmas_gpadc_read_raw_locked() and called
> palmas_gpadc_read_done() after it so it can still run before the mutex
> is unlocked, allowing the goto and labels to be removed safely.

...

> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  	case IIO_CHAN_INFO_PROCESSED:
> -		ret = palmas_gpadc_read_prepare(adc, adc_chan);
> -		if (ret < 0)
> -			goto out;
> -
> -		ret = palmas_gpadc_start_conversion(adc, adc_chan);
> -		if (ret < 0) {
> -			dev_err(adc->dev,
> -			"ADC start conversion failed\n");
> -			goto out;
> -		}
> -
> -		if (mask == IIO_CHAN_INFO_PROCESSED)
> -			ret = palmas_gpadc_get_calibrated_code(
> -							adc, adc_chan, ret);
> -
> -		*val = ret;
> -
> -		ret = IIO_VAL_INT;
> -		goto out;
> +		ret = palmas_gpadc_read_raw_locked(adc, adc_chan, val, mask);
> +		palmas_gpadc_read_done(adc, adc_chan);
> +		return ret;

Hmm... But now this _read_done call makes sense inside the helper.

		return palmas_gpadc_read_raw_locked(adc, adc_chan, val, mask);

>  	}
>  
> -	mutex_unlock(&adc->lock);
> -	return ret;
> -
> -out:
> -	palmas_gpadc_read_done(adc, adc_chan);
> -	mutex_unlock(&adc->lock);
> -
>  	return ret;

Are you expect anything than 0 here?

...

> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);
>  
>  	if (palmas_gpadc_get_event(adc, adc_chan, dir))
> -		ret = 1;
> +		return 1;
>  
> -	mutex_unlock(&adc->lock);
> -
> -	return ret;
> +	return 0;
>  }

So, what is the returning value of palmas_gpadc_get_event()? It might be
possible to simplify more, but current approach is good enough.

...

> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);
> +
>  	switch (info) {
>  	case IIO_EV_INFO_VALUE:
> -		if (val < 0 || val > 0xFFF) {
> -			ret = -EINVAL;
> -			goto out_unlock;
> -		}
> +		if (val < 0 || val > 0xFFF)
> +			return -EINVAL;
>  		if (dir == IIO_EV_DIR_RISING) {
>  			old = adc->thresholds[adc_chan].high;
>  			adc->thresholds[adc_chan].high = val;
> @@ -759,20 +743,14 @@ static int palmas_gpadc_write_event_value(struct iio_dev *indio_dev,
>  			old = adc->thresholds[adc_chan].low;
>  			adc->thresholds[adc_chan].low = val;
>  		}
> -		ret = 0;
>  		break;
>  	default:
> -		ret = -EINVAL;
> -		goto out_unlock;
> +		return -EINVAL;
>  	}
>  
>  	if (val != old && palmas_gpadc_get_event(adc, adc_chan, dir))
> -		ret = palmas_gpadc_reconfigure_event_channels(adc);
> -
> -out_unlock:
> -	mutex_unlock(&adc->lock);
> -
> -	return ret;
> +		return palmas_gpadc_reconfigure_event_channels(adc);

I don't see the full context, but can this be moved inside the switch-case now?

> +	return 0;

-- 
With Best Regards,
Andy Shevchenko


