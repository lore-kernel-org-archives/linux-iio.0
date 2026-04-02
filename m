Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F8A36DA0D;
	Thu,  2 Apr 2026 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775119017; cv=none; b=PUz9jQtNt0BdTPFp2PvRBXONx7vWKI3O1SpQX0QH4GK1fSB3qul9Fu+YI+rlmWsCYMBNb8MQdEqMXQ1GlT2vstcLLmVqcZjk5wCLZSTahxicPi0dplR6qmeNXMparL9KSt3kFLETcTrm/xCPl0upe+wPTna3lscUlez7eR+OF30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775119017; c=relaxed/simple;
	bh=n6dDKofgFLnPe/c6p/B1JSZsJ0aN4LfFeu/VlOKPTBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBFh1soOMJ0bYrJ44DId4btMslTe6YruA6T4JB5JsO5KnsCcE+ppu9HcBU/osO8MncuUccM2v5Df97WkBydSp1/edmJXz1XuevSamzXcWXFiwa+Khbw1VX8V+1sym3oY0PalV/N1Fe/+uh4vAkecXeHrv8jLmN1+QIRGeDhxrxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LHjSK2tJ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LHjSK2tJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775119015; x=1806655015;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n6dDKofgFLnPe/c6p/B1JSZsJ0aN4LfFeu/VlOKPTBs=;
  b=LHjSK2tJkYT9Eq08fVu2Pxb8BxHJOocwe26zLS/vV9rwrLsYwbx9us0J
   wbblvjtGzGd5Op4SVskOsxpq1ug3/J2CIOx7cXyI0Wtyuv1LeYyWb+OVv
   FBx3XFgxdgIfvnsgg5HZionrRqp8ok1hBK4cOPNd3F4zhIaGucFniUJmH
   1Wyagn/VVrnIhZ6Fp7kD8Ub2MuM/s40CZjj0J94Z/PCtzJ3yYya7opyIc
   6FDI6m9mJMKwGqgANN9QG9XtzlWd0VnTywH3eOBZiNpQubsLN5GbZ18vU
   cd+6VU1LYYCDkq9QYrqKHDa4xy+ORx9MmTqO/Jy7jSTpvG/O1iHeHq432
   g==;
X-CSE-ConnectionGUID: MyK6s24dQceRKQAuAUgBnQ==
X-CSE-MsgGUID: UkRoSEITRXq9UiD2xY4aLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76064129"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="76064129"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 01:36:54 -0700
X-CSE-ConnectionGUID: gRGSWT/KRxy+wrE1zinSkQ==
X-CSE-MsgGUID: U6sTSczeTOWV5TTgIX3POA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="220259377"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.31])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 01:36:51 -0700
Date: Thu, 2 Apr 2026 11:36:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matheus Giarola <matheustpgiarola@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	matheusgiarola@usp.br, arthurpilone@usp.br,
	davidbtadokoro@ime.usp.br
Subject: Re: [PATCH v3] iio: adc: ad7280a: replace mutex_lock() with
 guard(mutex)
Message-ID: <ac4qoRcVGilRJ0Z-@ashevche-desk.local>
References: <20260402031506.237467-1-matheusgiarola@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402031506.237467-1-matheusgiarola@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 02, 2026 at 12:15:06AM -0300, Matheus Giarola wrote:
> Use guard(mutex) instead of mutex_lock()/mutex_unlock(),
> ensuring the mutex is released automatically when leaving
> the function scope. The change improves error handling and
> avoids issues such as missing unlocks. It also simplifies the
> code by removing 'err_unlock' label and several mutex_unlock()
> calls.
> 
> As suggested, in ad7280_read_raw(), wrap the IIO_CHAN_INFO_RAW
> case in braces, providing a scope for the implicit variable
> declared by guard(mutex).

...

> static ssize_t ad7280_show_balance_timer(struct iio_dev *indio_dev,

>  	unsigned int msecs;
>  	int ret;
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  	ret = ad7280_read_reg(st, chan->address >> 8,
>  			      (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG);
> -	mutex_unlock(&st->lock);
>  
>  	if (ret < 0)
>  		return ret;

This will include the sysfs_emit() and other things in the critical section. Why?

...

> static int ad7280_read_raw(struct iio_dev *indio_dev,

>  	switch (m) {
> -	case IIO_CHAN_INFO_RAW:
> -		mutex_lock(&st->lock);
> +	case IIO_CHAN_INFO_RAW: {
> +		guard(mutex)(&st->lock);
>  		if (chan->address == AD7280A_ALL_CELLS)
>  			ret = ad7280_read_all_channels(st, st->scan_cnt, NULL);
>  		else
>  			ret = ad7280_read_channel(st, chan->address >> 8,
>  						  chan->address & 0xFF);
> -		mutex_unlock(&st->lock);
>  
>  		if (ret < 0)
>  			return ret;

>  		*val = ret;

This also will be under the lock, but it's fine.

>  		return IIO_VAL_INT;
> +	}

-- 
With Best Regards,
Andy Shevchenko


