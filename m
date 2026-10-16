Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B564AB1DF;
	Fri, 16 Oct 2026 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792155997; cv=none; b=e5BAW+dOnuQaKO1Z02mV7gb2FWisBjNqH9cv29JH+Poj421QAW9/rpzlmW3oFZSc6uWQPpdly0GQsY2iPMfqEA+tOVMa13vn8okpki4vpiJ7PfSnbsGzgfC//aCiHnrTMBUWObC36vzlahIT6HPYaBNBV7x6NPoLlxqI44aysUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792155997; c=relaxed/simple;
	bh=b66PwVgixFODkxnqwvb8zbNY+Im0BxU/SnjjTDsRYqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHKC4Ok7x+EblVsmhFeiCJtW4Jl3QraGcCJ3dShPdTsSPFqpI7pfnLJptGIOzII7Lj+LXA4pnPxUMQ7sTU7llwN6YDxk7ePFUJP1d7qOjhjM0y0rBI4IlcyM9lVJ/wnIGY7sANo+ZuUzbVIq5cL5NHvDxQuqf+Bxyul08WGEGOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IznA6M8/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IznA6M8/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792155993; x=1823691993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b66PwVgixFODkxnqwvb8zbNY+Im0BxU/SnjjTDsRYqU=;
  b=IznA6M8/VVTI6DEFr65rieubcSiVutF8fd1yrJAGOtJ4XHfxUekz6ysI
   GI08klDacg9fo2BMYWQ6Nqkueq3XdNKBMtjBtbgQiP5CH8iYXdjkCitO0
   Hitm7eXQmQdS3fMqWeDS1I40FUpsxbFozteOTA51OeJA6cVT/8Zo+GZJb
   /7VsOox9ZmDSKhzpv82HnXAb+S3UyY3rDUqxEEQLxV5InbJ/sbKlhxmWh
   GRPUfQo95agMZeE7OoBxJgDsRNoLBVY4mtElrax4f39f6HYaUB7MdhZkT
   udPmG9mt0RcNu4k4DsJg3Dub31D/Vh3CcyRLc1cZYqB4s7DzOfYUjBNsI
   A==;
X-CSE-ConnectionGUID: sOY3kuIjQJiw7yUgHAxdkQ==
X-CSE-MsgGUID: vvE6E3kGT66+XkM4gJogsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="934250"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="934250"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 06:06:33 -0700
X-CSE-ConnectionGUID: 0QGEmuoyRxWTE2j7eyKIdw==
X-CSE-MsgGUID: unqe8aqCQWyJM9QWpP87mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1929831"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.35])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 06:06:30 -0700
Date: Fri, 16 Oct 2026 16:06:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: amiratefabdallah1122@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: frequency: ad9834: use guard(mutex)
Message-ID: <atIhU8goKaSJUcrV@ashevche-desk.local>
References: <179214943270.333.5921549521929682753.20261016-ad9834-guard-mutex@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179214943270.333.5921549521929682753.20261016-ad9834-guard-mutex@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 16, 2026 at 02:17:12PM +0300, Amir Atef via B4 Relay wrote:

> Use guard(mutex) to manage the state lock in ad9834_write() and
> ad9834_store_wavetype(). simplifies error handling by allowing
> early returns instead of setting the return code and breaking out of the
> switch statement to manually unlock the mutex.

...

> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);

+ blank line.

>  	switch ((u32)this_attr->address) {
>  	case AD9834_REG_FREQ0:
>  	case AD9834_REG_FREQ1:

...

>  			st->control |= this_attr->address;
>  			st->control &= ~AD9834_PIN_SW;
>  		} else {
> -			ret = -EINVAL;
> -			break;
> +			return -EINVAL;
>  		}

You can get rid of now redundant 'else' (although I haven't checked the full
context, it might work only in the if-else case, but if-else-if-else requires
different approach).

>  		st->data = cpu_to_be16(AD9834_REG_CMD | st->control);
>  		ret = spi_sync(st->spi, &st->msg);

...

> static ssize_t ad9834_store_wavetype(struct device *dev,

>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad9834_state *st = iio_priv(indio_dev);
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -	int ret = 0;
> +	int ret;

While at it, move it to be the last in the definition block.

>  	bool is_ad9833_7 = (st->devid == ID_AD9833) || (st->devid == ID_AD9837);

...

> static ssize_t ad9834_store_wavetype(struct device *dev,

>  			st->control &= ~AD9834_MODE;
>  			st->control |= AD9834_OPBITEN;
>  		} else {
> -			ret = -EINVAL;
> +			return -EINVAL;
>  		}

Try to get rid of 'else'.

>  		break;

...

> static ssize_t ad9834_store_wavetype(struct device *dev,

>  			st->control &= ~AD9834_MODE;
>  			st->control |= AD9834_OPBITEN;
>  		} else {
> -			ret = -EINVAL;
> +			return -EINVAL;
>  		}
>  		break;

Ditto.

>  	default:
> -		ret = -EINVAL;
> -		break;
> +		return -EINVAL;
>  	}
>  
> -	if (!ret) {
> -		st->data = cpu_to_be16(AD9834_REG_CMD | st->control);
> -		ret = spi_sync(st->spi, &st->msg);
> -	}
> -	mutex_unlock(&st->lock);
> +	st->data = cpu_to_be16(AD9834_REG_CMD | st->control);
> +	ret = spi_sync(st->spi, &st->msg);
>  
>  	return ret ? ret : len;

Rewrite it with proper if ().

	ret = spi_sync(st->spi, &st->msg);
	if (ret)
		return ret;

	return len;

-- 
With Best Regards,
Andy Shevchenko


