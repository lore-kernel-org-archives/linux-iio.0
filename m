Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1167437CD55
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777023736; cv=none; b=PD8NBB2Y0/Gwc87AqqOZM/CgYPFQ9jfLLtz22iIEmnXJvtik1GO0TSKS8qTwCfQF9SL0J8WCjg5oeJaXVq2od6eubTJsebk5FU6yWmIdvCpD6wSzo1u8N2kfyKTsWF4koJzVxQLux9hFwid+9dASLoKmEmRORp3BaAANV1M1LyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777023736; c=relaxed/simple;
	bh=pkjUQaA6VaBs1RsmRIUPX5gDOn/6WzM+mIOP4P179LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqF/+DgeiH2rLGLxeHx0JHVnemhc+HqMowgf7mUgC6QNLg/JABWPnhnVKpamIcLU5udYkNHZIE1uT2xITWoQtxY9LuUZE7Kr/vESRjGYH9uH0I4p21bJ4l1NbjWAaAWz4Dl5sW2lTEI+/yLO4gXrKgGr5KpA8OjIEu1SvfNHa1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xvt5IaMu; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xvt5IaMu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777023735; x=1808559735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pkjUQaA6VaBs1RsmRIUPX5gDOn/6WzM+mIOP4P179LM=;
  b=Xvt5IaMuZR7WmLd8q5UDP3nS0DsbtPsG3F7QkuwSE/xRTjn6NdFrZGQe
   SsSDmtJc5TCEGSvNctvnR0ZkT5AGTVagXnEXoXYTMbZkIjGSQtJnk3SGi
   z/+4tWk3xspSm0Gs9k3l4K4K9qPFVtwVihxlGXSR9o/DuSjmpw06Mc+V8
   1FBY3A8jvgjpBC4/9Vk0tKJFTJRbEzDjxUSnuyBQlnyIrPSsv/0TIa6dE
   FYcTJSyUwy4OtfTGqkH83uDqF2QtNEFdqd2lR/qy5DiQP5uCWM+gm5IfS
   mAhX4LnL02jW/VhtyTmuKlMwMUQXW1I+cVfutEPSwshKNzGQ60dAfT1yu
   g==;
X-CSE-ConnectionGUID: Uz/b9a79Q7CIyAdpCBw46A==
X-CSE-MsgGUID: ObuhLM6xTe2HUGC90aQMzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="88612282"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="88612282"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 02:42:14 -0700
X-CSE-ConnectionGUID: LXj+gcS+RA6+PXM0VKZOpg==
X-CSE-MsgGUID: Yoxjn8kTRE6JuTyY3+2roA==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 02:42:12 -0700
Date: Fri, 24 Apr 2026 12:42:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	Matheus Giarola <matheusgiarola@usp.br>,
	Felipe Ribeiro de Souza <felipers@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v4] iio: adc: ad7280a: use cleanup helpers guard() and
 scoped_guard() for mutex locking
Message-ID: <aes68EaF7HkJn24T@ashevche-desk.local>
References: <20260423133322.13298-1-lucas@ciziks.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423133322.13298-1-lucas@ciziks.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 23, 2026 at 10:26:48AM -0300, Lucas Ivars Cadima Ciziks wrote:
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

>  	switch (m) {
> -	case IIO_CHAN_INFO_RAW:
> -		mutex_lock(&st->lock);
> +	case IIO_CHAN_INFO_RAW: {
> +		guard(mutex)(&st->lock);
> +
>  		if (chan->address == AD7280A_ALL_CELLS)
>  			ret = ad7280_read_all_channels(st, st->scan_cnt, NULL);
>  		else
>  			ret = ad7280_read_channel(st, chan->address >> 8,
>  						  chan->address & 0xFF);
> -		mutex_unlock(&st->lock);

Same idea of splitting devaddr + ch variables can be made for this entire
switch-case...

>  		if (ret < 0)
>  			return ret;

>  		*val = ret;
>  
>  		return IIO_VAL_INT;
> +	}
>  	case IIO_CHAN_INFO_SCALE:
>  		if ((chan->address & 0xFF) <= AD7280A_CELL_VOLTAGE_6_REG)

...as I assume that would benefit this code as well.
Perhaps it should be done as preparatory patch.

>  			*val = 4000;

-- 
With Best Regards,
Andy Shevchenko


