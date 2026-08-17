Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375823D9545;
	Mon, 17 Aug 2026 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981166; cv=none; b=NI35p4O/zRG8IK9Pp6Vz0M0LjDoT02y/K2IQA4oKd004wWDK7uhBNvJr6WsmXOm7ZjaxT5G9o46Q9M7Tqj+LbmEj64T9X+LGS3Y+FM9d/XoCGVfPIZz1khi379SqnauipglX68bR80+w+PZmLaT56wvbe+rBVz2a6PBRn0x33g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981166; c=relaxed/simple;
	bh=2wWV6Ytbe0Bh1bmGJegI44fDS6Tpv0NX7P3ZFCHHhaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ujm29pXUaV/FdHDJq+nW9x12/3ByreObwHBRd3C3JM75yiKXduBwp98EY2+xKpCUyuEscA88KglK7BJXKZXjAh6crv9CrbhXosJsIeBliFxqdMqDbh2yn9I9jOuNlT0lRBWbyV0dU+4gdjTA3Yw0wRPAAmm8lIIBI7LT9sGtC5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZcqnmPnm; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZcqnmPnm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786981164; x=1818517164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2wWV6Ytbe0Bh1bmGJegI44fDS6Tpv0NX7P3ZFCHHhaE=;
  b=ZcqnmPnmTgG/16LtxfxZTwGgyFpVZZ/Z8jagFnIhqgW2TKt7g2WpDMbf
   7E9FmrMloBLMQWkbqLOhbYZALm3QSMkOO7J+2gQQKh27iq0m/IuyqbPRd
   daZvZolKbnUCaPhXh5QGPEwNEQfiPdqVtmRzXU9l8cSm9v4tZdMa66ww0
   zzv30ZY4+yTyB6hBgkODHfUXfoa9UoB4vuzIKkSmKNa36880zwrsw0N1w
   rLWYVJ/r2Uk3FXvdjNNDnmTHIvdmpZm20B6tiOid9dJWWCwgKmbVIF0Kz
   cc8lVfVTrlyb8tFRSI6nbAKeUAAjN+rChDMjKDZ9Z488nqF+iBK3PHcDt
   g==;
X-CSE-ConnectionGUID: tHrAlneMT5SqxNUyqu3Bew==
X-CSE-MsgGUID: qMuK8FJlQpqDfTk2m16+ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="113000953"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="113000953"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 08:39:23 -0700
X-CSE-ConnectionGUID: HomUWK/ISSaeD03zQObWmA==
X-CSE-MsgGUID: feJnVML5TEitoMc41UdRUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="264981612"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 08:39:21 -0700
Date: Mon, 17 Aug 2026 18:39:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gabriel Rondon <grondon@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	Maxwell Doose <m32285159@gmail.com>,
	Yash Suthar <yashsuthar983@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iio: accel: bmc150: use guard(mutex) for mutex
 handling
Message-ID: <aoMrJvd4oSj0HgN4@ashevche-desk.local>
References: <20260816234231.14168-1-grondon@gmail.com>
 <20260816234231.14168-4-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816234231.14168-4-grondon@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 17, 2026 at 12:42:31AM +0100, Gabriel Rondon wrote:
> Replace manual mutex_lock()/mutex_unlock() pairs with guard(mutex) and
> scoped_guard() from cleanup.h in the functions where the critical
> section covers the whole function body or a single statement. This
> simplifies the error paths by removing the explicit unlock calls
> before returning.
> 
> bmc150_accel_trigger_handler() only holds the lock around a single
> register read, so scoped_guard() is used there to keep the lock scope
> unchanged.
> 
> Call sites that take and drop the mutex several times per function
> (read_raw, write_raw) or unlock through a goto label
> (buffer_postenable/predisable) are left untouched and can be converted
> separately.

...

> static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)

>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&data->mutex);
> -	ret = regmap_bulk_read(data->regmap, BMC150_ACCEL_REG_XOUT_L,
> -			       data->scan.channels, AXIS_MAX * 2);
> -	mutex_unlock(&data->mutex);
> +	scoped_guard(mutex, &data->mutex)
> +		ret = regmap_bulk_read(data->regmap, BMC150_ACCEL_REG_XOUT_L,
> +				       data->scan.channels, AXIS_MAX * 2);
>  	if (ret < 0)
>  		goto err_read;

Not directly related to this change, but even in the original code what is
protected here by the mutex? data->scan.channels?

-- 
With Best Regards,
Andy Shevchenko


