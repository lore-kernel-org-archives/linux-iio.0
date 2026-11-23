Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795460751;
	b=MeiRSBkIwneM+xgtmLoD/vYxX3olCyal1z1I5xcsFT/75/oj31XTydNK68cGqJmrhgaZ
	 ev1en09g/+34+VHvvYidVbcfxtLXXDG+HOMEGyQXcnkCHSybOtdyK/oeCheTDWUp69NTu
	 Dr4NmlKTgyCsyl5rG7fAaEIiuS6RzBg7qbExUEq6eukXzuESFY+qLAqAtZS0sOU1It+O+
	 JQJWLH06pFRB/pljiYGNp21y7p2WCjl8Wi6K8psmphpf2sSFHgsThlCPih1bheGcORwRt
	 /Gaz0huhLqhVtlkhBn2c+SSkRW9rO7JKhBCOs5UlTYE2ugSOlSGM/svX3eh1sNcpobA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460751;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=EBzO6kW6isUCcKf/9l8tTod3oC/9E7aGgdz6lYKkWGE=;
	b=sFHwAeBoV3M5DEyUHNr+KsCUPOkHFsZUFyHPy2QmGD1qWrn4YR/GDFn+4wSathPZKfyk
	 Ys/u1bZVhgoke3yJXuJ2a8jQbQGwuxfbuK1W4DasUP0Ho7Fh82UMAnaxx8ZpcC95/J1z4
	 br4MWguDYq4QKoaquxHucDTQ2CWX1DfBHdafktsNNqDUvlN+XrBTR8U1JgS2ciBbWzD3V
	 PgyQG+4RbFXgJ0hnsB2Zn6SGxF0fuVKttFH6PkA6yZ8W6lNna6AyeaLglbCjW48TjgkT5
	 KktpOKQ6OmGYBhGAMYJytLpM7K0e4X3VbFpS3Nzh4x9ria8ASeVEoJ/9p4+h5xWVaQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LYrU8x2A;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE592606A337;
	Mon, 23 Nov 2026 19:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE592606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LYrU8x2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795460751; x=1826996751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HjLAv4JJx7rlNuC2NaLWJe74a46siPB2FTLvrm4JVew=;
  b=LYrU8x2ALA7mf5JQXKDQko9Lpr6JGT3fKmZBCVDqQP9aiMXHVKBfLCOS
   RdQgRk5V/gddXjmiioTAO1wVkUa6TfQBbKEI29LTq1q5PZVGJ4hsPs3Yu
   va0cbk4GyQGLl5DUZpT74HAso0SdEkLiomhqX/rOwPTk16KJYDO4+4cBb
   BnbZFK5Gh8rxVVeTjj1x0IcLZ25h4+Th1GKR6xHN/wtLE+twpm7ZDxyXS
   x8pGXszBRPuRuRG9PwXRsCgKCRohOBjTGom48XBNjLGDd2dIE0t31xrJQ
   HSg4yZ6faejnTzyBNDITlNkPr+RKNI3miazlmCAaOvhbVl9EjFAirM2hJ
   g==;
X-CSE-ConnectionGUID: R60sluLwTE2oMNdv2GiR0Q==
X-CSE-MsgGUID: k87JItS7Rpy/WmE5mgO9Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4130892"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4130892"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 11:05:50 -0800
X-CSE-ConnectionGUID: Hyu/YX85SRm8QsukIAo8Pw==
X-CSE-MsgGUID: PCr81zIwQoaSB+z2enfJSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11780883"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 11:05:48 -0800
Date: Mon, 23 Nov 2026 21:05:45 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Vaibhav Chahar <vaibhav.chahar26@gmail.com>
Cc: jic23@kernel.org, marius.cristea@microchip.com, crofts@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: adc: mcp3564: Use guard() and scoped_guard()
 to manage mutex
Message-ID: <awSOicGtjjU7-tXz@ashevche-desk.local>
References: <20261123070802.14487-1-vaibhav.chahar26@gmail.com>
 <20261123172836.130440-1-vaibhav.chahar26@gmail.com>
 <20261123172836.130440-2-vaibhav.chahar26@gmail.com>
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
In-Reply-To: <20261123172836.130440-2-vaibhav.chahar26@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 23, 2026 at 10:58:35PM +0530, Vaibhav Chahar wrote:
> Use guard(mutex) and scoped_guard() instead of manual mutex_lock() and
> mutex_unlock() calls to modernize the driver and improve mutex handling.

...

>  	dev_dbg(&indio_dev->dev, "%s: %d\n", __func__, mode);

Consider the patch to drop __func__ in dev_dbg() calls. If required with
Dynamic Debug it may be switched at run-rime.

...

> static int mcp3564_set_current_boost_mode(struct iio_dev *indio_dev,

>  	else
>  		adc->current_boost_mode = mode;
>  
> -	mutex_unlock(&adc->lock);
>  
>  	return ret;

Now you will have double blank line(s) here and elsewhere.

...

> static ssize_t mcp3564_auto_zeroing_mux_store(struct device *dev,

>  	else
>  		adc->auto_zeroing_mux = auto_zero;
>  
> -	mutex_unlock(&adc->lock);
>  
>  	return ret ? ret : len;

Consider going further and unwind this to return as soon as possible.
As you understand the whole patch has to be revisited for all of the comments.

...

>  		if (channel->output) {
> -			mutex_lock(&adc->lock);
> +			guard(mutex)(&adc->lock);
> +
>  			*val = mcp3564_burnout_avail[adc->burnout_mode][0];
>  			*val2 = mcp3564_burnout_avail[adc->burnout_mode][1];
> -			mutex_unlock(&adc->lock);
>  			return IIO_VAL_INT_PLUS_MICRO;
> +

Stray change.

>  		}

...

>  	case IIO_CHAN_INFO_SCALE:
> -		mutex_lock(&adc->lock);
> -		*val = adc->scale_tbls[adc->hwgain][0];
> -		*val2 = adc->scale_tbls[adc->hwgain][1];
> -		mutex_unlock(&adc->lock);
> +			scoped_guard(mutex, &adc->lock) {
> +				*val = adc->scale_tbls[adc->hwgain][0];
> +				*val2 = adc->scale_tbls[adc->hwgain][1];
> +			}

Indentation issues.

>  		return IIO_VAL_INT_PLUS_NANO;

...

I stopped here. You must read what you send. Do not blindly copy'n'paste
AI slops!

-- 
With Best Regards,
Andy Shevchenko


