Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104F9194C95;
	Wed, 18 Feb 2026 07:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771398489; cv=none; b=sFcjWnQZP6LauanJfhoV1dwLAvGFlqV83/T1HTBs5T3s50VH/xNUWuSiL5VS8oA9EmFjSFBttvmuLIg5HyOh7fPoNQEoDsuvoEwsKaLYmeREw1ko1PJ7wg63X0Fy8y9JLxe68uFg0/5uOsJNEzdZB+LJr3/kYMreYHIHfc4YYuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771398489; c=relaxed/simple;
	bh=6k0vlvTTqAk5qXdKc6/+JrlJSDTSi7F3M33vG0xJMBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ks4n6l+n5aFaCqXR4RMKMc5MRSEkP+K8bAVP0pPil7Njwlllos7kXAF6r2Z/1MDK982FT8O9XNCNTLl8wUvHvfB+TsJWqXHGW0KFSufG0Ie2jCwBCEOGeOuSmp1i1sTL/yEqZdPRcsTXF1eQVdXQ3ceAWv29lfDTCjgk9RxzhD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KP1DTCHp; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KP1DTCHp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771398488; x=1802934488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6k0vlvTTqAk5qXdKc6/+JrlJSDTSi7F3M33vG0xJMBc=;
  b=KP1DTCHpunzpRMBCKG6MoAi+aSNX83VK0cHWlS8HegRrBFAZ1jwZeAw4
   AaECgLE953rTQl2FBxUNLo5rt2QFXkBUE9TTyZhQ5KVUjWt5049LL+XE/
   c/DG0pZ0Ik4een0r6PaXsqvf9XcCVfUTsjEZ3CfsAu70QTH+L8R2KIW4H
   ISY5JN6FI3Pe8gyJLOlVI+yrlU4Yf4l7H//QXg2NqmnI3fgAWcuCFS0lO
   aWzx8JMrubeWeRGkecq3gqszlR7Z282edc5c//i+n7kMALUTkzt+dikvz
   /nZAz6HACw1rQPIJbyO+HnuhrIKgPFHHQ0LbULqdo7254sLOjeXxoy39q
   g==;
X-CSE-ConnectionGUID: FT9bBVsDT+C4aOFglrYFdw==
X-CSE-MsgGUID: 5LhzwlQBToSTg7KJpoaR4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="72382510"
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="72382510"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 23:08:07 -0800
X-CSE-ConnectionGUID: oi3QitpcTj2t8Pu79AfZkw==
X-CSE-MsgGUID: +k+DNAvsSRKMrSR9lP7ldg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="213361099"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.215])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 23:08:05 -0800
Date: Wed, 18 Feb 2026 09:08:03 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/9] iio: light: gp2ap020a00f: simplify locking with
 guard()
Message-ID: <aZVlU9SL9e1x8Vwu@smile.fi.intel.com>
References: <20260218043728.609659-1-ethantidmore06@gmail.com>
 <20260218043728.609659-2-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218043728.609659-2-ethantidmore06@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 17, 2026 at 10:37:20PM -0600, Ethan Tidmore wrote:
> Use the guard() cleanup handler to manage the device lock.
> This simplifies the code by removing the need for manual unlocking
> and goto error handling paths.

> static int gp2ap020a00f_write_event_config(struct iio_dev *indio_dev,

>  	enum gp2ap020a00f_cmd cmd;
>  	int err;
>  
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>  
>  	switch (chan->type) {
>  	case IIO_PROXIMITY:

>  		err = -EINVAL;
>  	}
>  
> -	mutex_unlock(&data->lock);
> -
>  	return err;
>  }

What I meant in the my cover letter is that you need to take some pieces from
my patches and incorporate them here, so this becomes

	return 0;


...

> static int gp2ap020a00f_read_event_config(struct iio_dev *indio_dev,

>  	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
>  	int event_en = 0;
>  
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>  
>  	switch (chan->type) {
>  	case IIO_PROXIMITY:
> @@ -1223,8 +1204,6 @@ static int gp2ap020a00f_read_event_config(struct iio_dev *indio_dev,
>  		break;
>  	}
>  
> -	mutex_unlock(&data->lock);
> -
>  	return event_en;

Same here, now event_en is redundant.

>  }

...

> static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)

>  	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
>  	int i, err = 0;

(Do you need this '= 0'? Check it).

>  
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);


>  	}
>  
>  	if (err < 0)
> -		goto error_unlock;
> +		return err;
>  
>  	data->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
>  	if (!data->buffer)

>  		err = -ENOMEM;
>  
> -error_unlock:
> -	mutex_unlock(&data->lock);
> -
>  	return err;

And here, this should become

		return -ENOMEM;

	return 0;


>  }

...

> static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)

>  	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
>  	int i, err = 0;
>  
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>  
>  	iio_for_each_active_channel(indio_dev, i) {
>  		switch (i) {
> @@ -1452,8 +1428,6 @@ static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
>  	if (err == 0)
>  		kfree(data->buffer);
>  
> -	mutex_unlock(&data->lock);
> -
>  	return err;
>  }

Same here.

-- 
With Best Regards,
Andy Shevchenko


