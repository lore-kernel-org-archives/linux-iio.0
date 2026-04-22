Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2C240DFB7;
	Wed, 22 Apr 2026 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776843878; cv=none; b=Tdkfj+82FBK8jDsMywdvCR+8hlWT6oKLAkR4OOSN9YhpTTeuUQF7W4EZk4yE2vLvF6wQcHuouJnIF92FZLLK7HH7cq6dwycb2XAjSBvqAgsThsyGSBvHVZ4ruYv9MMbvgCyPHG2JO1m5IblWpwE5JXulKAasHLjeTSRKzuXVaQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776843878; c=relaxed/simple;
	bh=5SArBe/BYOKNwA4SJMf+FfBGjosGqKuTGH0yZZPRuiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0qE4alj0mI1BzTgKUBMr+2M7gLRB/4kxgw1+w8lJt/gC5NfZJB3EAqUztS+zVIAPEcBbFUn7wJzrCYKGo0FoqEOam+TgkPllX/hZO+tZRqLyu2i3DTkkiBuFIePU6Qh40KOzQQr+LxzArjUeRHXTokiZgT14rgbN45iJAMVgNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EzmZh/bS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EzmZh/bS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776843877; x=1808379877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5SArBe/BYOKNwA4SJMf+FfBGjosGqKuTGH0yZZPRuiA=;
  b=EzmZh/bS7je5UagbdJ02U9YW1L18kwoEsTWTw7KQF7htoaYmOXqYh4Kv
   TPI2Ej8l5juXIMlvaiSs+LobB4ytZk9LBJYaLZ1IP21DmUInMkrEpMk3l
   LTfSCcVTvw8serpVVK8vlPIDhOsmlyHvNsTlaZqwd4ey4MYxOYkxbw0Ac
   D9HmOp6aiysvDuttBKquJVx6TDtw232W53S4ohjJt81HqVPbWMel/uILp
   syAC+yVFoYJnaQ7wgLX7QV79sJfUaJ+31ikrbv82eTCCdelFf6FBCuZt3
   wzOYXe16Fr6h6w+7x14D5j+gfd3P1tPRnER8zc8XNlwPPBQOHvDrwYRVu
   Q==;
X-CSE-ConnectionGUID: e7MYHEXhQmCOjbnyTJb9Ig==
X-CSE-MsgGUID: ylOm5RwTTkCf2AHQn0553A==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="65326931"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="65326931"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 00:44:36 -0700
X-CSE-ConnectionGUID: 56YSBfxNS/ihPyVJdZRP9Q==
X-CSE-MsgGUID: jgjnS5IXQy2lM+g0lPsLtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="231238860"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 00:44:33 -0700
Date: Wed, 22 Apr 2026 10:44:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matheus Giarola <matheustpgiarola@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	matheusgiarola@usp.br, arthurpilone@usp.br,
	davidbtadokoro@ime.usp.br
Subject: Re: [PATCH v5] iio: adc: ad7280a: replace mutex_lock() with
 guard(mutex)
Message-ID: <aeh8Xu90pyUBBzj5@ashevche-desk.local>
References: <20260421190855.24132-1-matheusgiarola@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421190855.24132-1-matheusgiarola@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 21, 2026 at 04:08:55PM -0300, Matheus Giarola wrote:
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
> 
> Also, limit guard(mutex) scope in ad7280_show_balance_timer()
> to keep it locked just when necessary.
> 
> In ad7280a_write_thresh(), replace break with return on error.

...

> static ssize_t ad7280_show_balance_timer(struct iio_dev *indio_dev,

>  	unsigned int msecs;
>  	int ret;
>  
> -	mutex_lock(&st->lock);
> -	ret = ad7280_read_reg(st, chan->address >> 8,
> +	scoped_guard(mutex, &st->lock) {
> +		ret = ad7280_read_reg(st, chan->address >> 8,
>  			      (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG);
> -	mutex_unlock(&st->lock);
> +	}

Not sure if we need {} here (as it's one statement body), but the indentation
now got broken of the second line there.

What about

	u8 devaddr = chan->address >> 8;
	u8 addr = chan->address;
	// ...or use existing names in the driver for the same things

	scoped_guard(mutex, &st->lock)
		ret = ad7280_read_reg(st, devaddr, addr + AD7280A_CB1_TIMER_REG);

?

-- 
With Best Regards,
Andy Shevchenko


