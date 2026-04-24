Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3651329C6D
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045499; cv=none; b=E93ZJL2T3IEtzvCPj1zikEx1TmZg5vSzg3B3ihrGDr5DKgYsNWMhmjx8r7K62Rk9G9mZBcX9F9ChL5kKYt0+iiqwJOyhd8jjOsVKu1busQJzkm8E+VDK+bHtop+8cS06T/Nr2xviV7pI/A7XbHfF3y6wWyD7Ci1StJ0jirAuJdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045499; c=relaxed/simple;
	bh=9jyzNzVfIZnJWvDI38Gd5sUeNo+FrCcwm9vXzFlov7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHjpmD3p399JnueWH9PeiF/fXbbqBtp0VojW2s7gXKDraX1sH/4ZF/wd5rQIupIfoM84bqu3j/kWyBCMXjqF8uCQQnJEryPdFVa3f0CZLM+NfVICCg6HaVKINdffB7+cp3zChkw+ngIZebe/KJE8GC82LV3wjzphV5y2J1Zs6wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MmYR77Fo; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MmYR77Fo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777045497; x=1808581497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9jyzNzVfIZnJWvDI38Gd5sUeNo+FrCcwm9vXzFlov7k=;
  b=MmYR77FoVO6THeql7Vu6mSzdbIf7y6WoLfow+XOFUFZhu/QtJ1V5QS5s
   1oexsZEgCfAc2iLF9XVu6h5l0oGiBL5ZP9iw6f1VGaT1xS6D5DMLKSgf7
   u9DNqOstqtfL3pD3dPpl3t4iuTPQzojqO+Aq34+v+RuGwvCYs22Me+9hu
   b9Au+mEqpWFP1UF5Loz+p6zZxhftx0v5Sw4mwY7bV3L6KvLhpM7zmW96p
   A8qOwP6lzu/gT9ljvr7q8WaHjUw2cUdv7SjofaE75SbsR6SW5SrgpXmVf
   yvikbQYVyE6dJkyVd/dLRJt4OVDMfxDPkxSm7mEo8VY9e2KBGb/W2dTMw
   w==;
X-CSE-ConnectionGUID: YqGnNkFwQkGtRMfTWhHpSQ==
X-CSE-MsgGUID: hd7Ba6G8QJ6C5gMiJcr/GQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11766"; a="95590031"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="95590031"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 08:44:57 -0700
X-CSE-ConnectionGUID: ho/yiQhISDqb8kjhRnPuUg==
X-CSE-MsgGUID: xBh4NpRNQ5+Vo8rh4BxJ0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="271107743"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 08:44:54 -0700
Date: Fri, 24 Apr 2026 18:44:52 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, nuno.sa@analog.com,
	Matheus Giarola <matheusgiarola@usp.br>,
	Felipe Ribeiro de Souza <felipers@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: adc: ad7280a: use cleanup helpers guard()
 and scoped_guard() for mutex locking
Message-ID: <aeuP9Jn0Gd-nhdBZ@ashevche-desk.local>
References: <20260424125001.17822-1-lucas@ciziks.com>
 <20260424125001.17822-3-lucas@ciziks.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424125001.17822-3-lucas@ciziks.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 24, 2026 at 09:43:40AM -0300, Lucas Ivars Cadima Ciziks wrote:
> Replace open-coded mutex_lock/unlock pairs with the cleanup-based
> guard() and scoped_guard() helpers in ad7280a_write_thresh(),
> ad7280_show_balance_timer(), ad7280_store_balance_sw(),
> ad7280_store_balance_timer() and ad7280_read_raw().
> 
> This removes the need for the err_unlock label and explicit
> mutex_unlock() calls, as the lock is now automatically released
> when the function returns or the guarded scope exits, regardless
> of the exit path.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

>  	unsigned int msecs;
>  	int ret;
>  
> -	mutex_lock(&st->lock);
> -	ret = ad7280_read_reg(st, devaddr, ch + AD7280A_CB1_TIMER_REG);
> -	mutex_unlock(&st->lock);
> +	scoped_guard(mutex, &st->lock)
> +		ret = ad7280_read_reg(st, devaddr, ch + AD7280A_CB1_TIMER_REG);

>  

Now this blank line may be removed.

>  	if (ret < 0)
>  		return ret;

-- 
With Best Regards,
Andy Shevchenko


