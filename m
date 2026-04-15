Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585B62C08BC
	for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776262996; cv=none; b=uQXlbPejlOtcoe/dmMZGM8P0ajNLehmeguIHBp3fsw8/vN7MNLRih/+OTgJoFvsMLDw+JhetR+0kZ73Gu9LNbAX2Z3ur3y+8SQMBNI8kcPds3MLawaiu0+9M+GVZ6RVr3E3WVP77I89S+mjk7coqcWgsATAFZi8dp9pRg79PhCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776262996; c=relaxed/simple;
	bh=0DN+FpVIC9nfXwMbZsGzOfxyo4BK9tBv8h+ZFm+ZwPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpYWwqTchIy2LdaWgzXjLEZNSUQfGbeClx0lflIyhTtyLG/ZYmv/QWOiskk0uCk5YEtlImKyxTo1Dsd5tzjc8S9N5KscFNGLMUDwfh6QtONkWp2nSL78LPBDgB4Edzag/oAwqVSzgDZGYVqy2m/uBBQGwc+7PyIpbCOhO2fxAAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBriKLOT; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBriKLOT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776262994; x=1807798994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0DN+FpVIC9nfXwMbZsGzOfxyo4BK9tBv8h+ZFm+ZwPg=;
  b=HBriKLOT7J2Q1xvSsmX04EU4qrT7stOqepIu5Om4aHKAz09+oKDdxgst
   +HlSRAMcPeA4ptJGaAadFEt4TRau15p3Mn+JELGGK1ht6wZPSssvSwTqg
   dR3umdXmUMwLCHvQlERKSDC8mNd05FVTBaSKsDBMEe5N6zgym8FiAEV7C
   6WUBn91vmZwpkpxGY0k1z9mFZ7gJqmJoFd2Qb+ZN+R5bYuMhq+P2sMJ6N
   NY8Lgc9I7KQbGjpsWgR7KUrSHqr/4zXqSLHLYj3z9So8mYSUuPOvqlZzf
   hL6UzJGETJbkDwvg5lz9GHvtRnRWbJ6DLBKyPjfb92ZYKvHDTVwCqoP+X
   g==;
X-CSE-ConnectionGUID: KCfA5qVdTti5yS7wynMOtw==
X-CSE-MsgGUID: tNJzGzmCQBSL1HJInXVrSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="76407568"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="76407568"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 07:23:13 -0700
X-CSE-ConnectionGUID: /LkezRvXSp2DfSxxTt2SHw==
X-CSE-MsgGUID: 2Mb57wmXQFu0cazYJrIyRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="223931163"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.34])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 07:23:12 -0700
Date: Wed, 15 Apr 2026 17:23:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	Felipe Ribeiro de Souza <felipers@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7280a: use cleanup helpers guard() and
 scoped_guard() for mutex locking
Message-ID: <ad-fTZnNb3ASpLms@ashevche-desk.local>
References: <20260415112602.3938-1-lucas@ciziks.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415112602.3938-1-lucas@ciziks.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 15, 2026 at 08:25:48AM -0300, Lucas Ivars Cadima Ciziks wrote:
> Replace open-coded mutex_lock/unlock pairs with the cleanup-based
> guard() and scoped_guard() helpers in ad7280a_write_thresh(),
> ad7280_show_balance_timer(), ad7280_store_balance_sw(),
> ad7280_store_balance_timer() and ad7280_read_raw().
> 
> This removes the need for the err_unlock label and explicit
> mutex_unlock() calls, as the lock is now automatically released
> when the function returns or the guarded scope exits, regardless
> of the exit path.

...

> -	mutex_lock(&st->lock);
> +	scoped_guard(mutex, &st->lock) {

All in this scope has to be reindented by one tab level up (to the right).

>  	if (readin)
>  		st->cb_mask[devaddr] |= BIT(ch);
>  	else

>  	ret = ad7280_write(st, devaddr, AD7280A_CELL_BALANCE_REG, 0,
>  			   FIELD_PREP(AD7280A_CELL_BALANCE_CHAN_BITMAP_MSK,
>  				      st->cb_mask[devaddr]));
> -	mutex_unlock(&st->lock);
> +	}
>  
>  	return ret ? ret : len;

But why not simply guard()()?

...

> -	mutex_lock(&st->lock);
> +	scoped_guard(mutex, &st->lock) {
>  	ret = ad7280_read_reg(st, chan->address >> 8,
>  			      (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG);

Has to be reindented. {} are not needed.

> -	mutex_unlock(&st->lock);
> +	}

...

> +		scoped_guard(mutex, &st->lock) {
> +			if (chan->address == AD7280A_ALL_CELLS)
> +				ret = ad7280_read_all_channels(st, st->scan_cnt, NULL);
> +			else
> +				ret = ad7280_read_channel(st, chan->address >> 8,

> +					chan->address & 0xFF);

Broken indentation of this line.

> +		}
>  		if (ret < 0)
>  			return ret;

-- 
With Best Regards,
Andy Shevchenko


