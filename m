Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC41C3A9616
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776413991; cv=none; b=C52vAbgiqLfwZKL/xV9bJ4JXZuVgJGiWzxpKm7udET9Px7HK+QNGRl954tSdhn8PNv3S27VJVtCzaxIePcchioSa0pMIO9plf3sWQ8cOwkHkR7rjAAE7xigKEOW8rozz49cETZrn1n7goR9vI8pHqvN95A4x6Jay4BSGiemndPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776413991; c=relaxed/simple;
	bh=MGC4kSUiHfnHQMwWn4jxyXKewq3gV/DEQC+816I7QCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfGnbs4eRowitiksphcBMPiLTbzlBny7NkKSo+RjXO6ukZJEJFeOM0TPlJQPlhZ/co5xxYXzxPgtx1Qisur857Z+dbgY0WDlbMQbM6AHp1VY4hM3kuyIDH/j7cGr08TtrCK5d/99HoUT3+fahND2WcTqsQLRT0LUzicIrOME/oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Scz6Mi//; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Scz6Mi//"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776413991; x=1807949991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MGC4kSUiHfnHQMwWn4jxyXKewq3gV/DEQC+816I7QCs=;
  b=Scz6Mi//zyelqF+slMQUgGyQ21JJOiR3qu6j1tXyRfQK/cRrBQraU+at
   0yG2u5vGF7Nv9m04aS+rR5fmIHHJRLxLARaDynkYwu5bMF+rCs/+v6DIP
   CgTOCWVuZjjf1vxrM5vKIB5DIIRP2ci/K+ucC/i+fl70OYWQiiYGZKvdF
   f8NFJJ/eLZJ0LTYPJYzOB5hvxTM7sc/eKS4iiefqlYJaCvIbjBT4IihZG
   azKqk6Debdo9WEf6rGYkgrIErHUf0+AyCgjB3l84FLa+V8SgXqkc49gIJ
   JAHlQXlR0dEq2elyzNNKMqPra4hKkLp8vGcW7LAE6SHc3yAJRKfT4+N/A
   Q==;
X-CSE-ConnectionGUID: R9pmGwO3Rci/WjjWmMym6A==
X-CSE-MsgGUID: KcRyRwARTh6ShsVd5RvWCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100074230"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100074230"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 01:19:50 -0700
X-CSE-ConnectionGUID: lX4AmPAcTW+LxKD+pqHuaQ==
X-CSE-MsgGUID: hpUo9I9CQXuZaGyW9A/rew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="231237206"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 01:19:49 -0700
Date: Fri, 17 Apr 2026 11:19:46 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Raffael Raiel Trindade <raffaelraiel@usp.br>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, Kim Carvalho <kim.ca@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: light: vcnl4000: use lock guard()
Message-ID: <aeHtInsmJeapbJyo@ashevche-desk.local>
References: <20260416211651.9625-1-raffaelraiel@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416211651.9625-1-raffaelraiel@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 16, 2026 at 06:16:48PM -0300, Raffael Raiel Trindade wrote:

> Use guard() for handling mutex lock instead of manually locking and
> unlocking. Remove gotos in error handling logic. This prevents forgotten
> locks on early exits.

...

>  	ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF, ret);
>  
> -out:
> -	mutex_unlock(&data->vcnl4000_lock);
> -
>  	return ret;

It's now

	return i2c_smbus_...;

Ditto for other similar cases below.

-- 
With Best Regards,
Andy Shevchenko


