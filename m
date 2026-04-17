Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF981F8691
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 08:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776413469; cv=none; b=frVANdPgNz7p1+mXLy25P3q/Eh/0QaJ0gzownw0n8ZR6vUUd8FNL0JEAqSbc6gKZAlZUnnHFtNqA8KVCFHa50xbk+QaliXM5124gs6n+0mpCWdR14FUUgohaMPgCYPggztbbEdAvaxf89QPGe3e7QPPD2M/pUQZe6qeBf+lwWOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776413469; c=relaxed/simple;
	bh=vhJmsnMAV13fwB4/U5ycUrf5t31EAp4u2+QBqVJ4NCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HC8kxog/BXSi/fO+YaXY/JP2UI/N55R3qLozSv7fo7LwGb1o10Rotm9rxUMQKKyB6vHxuACl37j6vwLG8wSbKA0DCDpe0oPdjCF8heCphZGwe5hGuH4YoXyxHPLqkAiuFGMOLlpP4hCcGf7U2V7sykSehnuth/GhSs5zrS8LUwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7wOuKUE; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7wOuKUE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776413468; x=1807949468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vhJmsnMAV13fwB4/U5ycUrf5t31EAp4u2+QBqVJ4NCs=;
  b=K7wOuKUEqwe5QO6BoEfam3xmo9VxXqn4t7EN1D8Su85BMoZGHD/atbvi
   am53C+pf9JrA0V24GIE81SzLy622EDB6zqwZ4bcw/ohauqItxFc4zz8IE
   B6YgVb5NNtx2g8GH+Efog1ZrPKPT7Vvc2Rr39FgLGJNUA3oy/2COlOjtS
   QvHN0zPcP+uSq6zZNpgfbPY76/5Rpw5QpyFDA4TSvd4CgVar716rn+5xK
   1qBdg3YWefv3a29X9UspXSDuGsAlPzN9KpRoEaM+W/4guJw2SYtpzbYNF
   tl+VOb7qRQSWMZZRW0amAsHC9H9A8ilYjfC8rAjUzbReR2HHbpC5tSMyz
   g==;
X-CSE-ConnectionGUID: m5lyC8rRS3i+fVUyGA58tQ==
X-CSE-MsgGUID: cfV4Wr3AQBKykfsrdsksdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="77127157"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="77127157"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 01:11:07 -0700
X-CSE-ConnectionGUID: RkZl6yQ2T4C4tNoPBERIcg==
X-CSE-MsgGUID: C4H9ePU0QYWBTqd3vvQWwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226624444"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 01:11:05 -0700
Date: Fri, 17 Apr 2026 11:11:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rafasales@usp.br
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, "Gustavo C. Arakaki" <gustavo.arakaki@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: light: ltr501: Use automatic cleanup of locks
Message-ID: <aeHrF5HsRoWqazzR@ashevche-desk.local>
References: <20260415203345.195557-1-rafasales@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415203345.195557-1-rafasales@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 15, 2026 at 05:33:30PM -0300, rafasales@usp.br wrote:

> Replace `mutex_lock` and `mutex_unlock` with `guard(mutex)` and
> scoped_guard(mutex)` to reduce boilerplate and allow for
> easy-to-read code blocks.

We refer to the functions as func().

...

> -	mutex_lock(&data->lock_als);
> +	guard(mutex)(&data->lock_als);

This requires a header. But looking at the driver, please add a new patch to
make header inclusion block sorted and followed IWYU principle.

>  	ret = regmap_field_write(data->reg_als_rate, i);
> -	mutex_unlock(&data->lock_als);
>  
>  	return ret;

Now this is simple

	return regmap_field_write(...);

Same comment to other similar cases below.

...

> -		mutex_lock(&data->lock_als);
> +		guard(mutex)(&data->lock_als);

This is not an equivalent. Please, care to explain why does the critical
section need now additional stuff?

>  		ret = regmap_field_write(data->reg_als_prst, new_val);
> -		mutex_unlock(&data->lock_als);
>  		if (ret >= 0)
>  			data->als_period = period;

Ditto for other similar cases below.

...

>  	switch (chan->type) {
>  	case IIO_INTENSITY:
> -		mutex_lock(&data->lock_als);
> +		guard(mutex)(&data->lock_als);

I don't think you can use guard()() in this scope. Please, double check that
this compiles and behaves well.

>  		ret = ltr501_read_als(data, buf);
> -		mutex_unlock(&data->lock_als);
>  		if (ret < 0)
>  			return ret;

>  		*val = le16_to_cpu(chan->address == LTR501_ALS_DATA1 ?
>  				   buf[0] : buf[1]);

In any case, why is this now part of the critical section?

>  		return IIO_VAL_INT;

-- 
With Best Regards,
Andy Shevchenko


