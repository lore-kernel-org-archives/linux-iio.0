Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B0034F492;
	Sat,  4 Jul 2026 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783167082; cv=none; b=CjIuqVj5N6Ufa8TeoRnJLOMeKnlMT2be1KqpZyh3TTAME+iB5hY8DR4uKgb9OiPvBh+BxcWxzWtbq8UsM9ffleCMNfpsNFYH7sFeKeDXN/J9tuNXQR9WjT4nMlqyNK3rJuP+Q8U3eHqliZPs6XsEIXfb9l/LIdiVfx5NrGJF9uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783167082; c=relaxed/simple;
	bh=o9JeD/JDGwBWij4vq3aZqRQBWtP2pI+Dmp+puxSiZXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbiAomCCt8+6Da+OSIqoU5qKDp2qu5cZ08aF1JQSlCAFkD0fet9HjHcHGjEL12YHDpdzArA2r1xwW+kqTX+tBP2qom7VQ3oqEcC40yvBRoxZr0A1Au3YMCQWwXIYHpsP9h/e547aOK6xNyh1enfu+uPe+zJAipdjFgs/muuBBXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eqNUfs2t; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eqNUfs2t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783167079; x=1814703079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o9JeD/JDGwBWij4vq3aZqRQBWtP2pI+Dmp+puxSiZXY=;
  b=eqNUfs2t3rN+HJKcYpYFSb7XORk0McDP22wIRctGWG+iRHtEgJi6Rztt
   vTdZ9s7ZN8smGLO/6ZfJcN9Tj+f0Dj7Q5Qr60p9IjLLMvTFuCpHX7ZEPe
   9/JdaS4PT+SgCb3QLU0vegmzicNpKxxGlBH0Quz5P+jjP6BXyw0NhPvfk
   tEJz5LxL7NRQb2MP4Gx4LdQCqtoywe0/p1ckWov7mT8cNZHPsOq9RRb7G
   pINV1minn3pzyOksQxHJpn70UbqLPrE27byIrRzqbCLrbyOO3RzHRYknl
   MOWy+rkg+zg5H88a/+mSECVACxJKCNiZOVrKzNPyFgY7Y9+OvG++UxUWF
   A==;
X-CSE-ConnectionGUID: vbtlk0I5QwGdD6d9GCs+3A==
X-CSE-MsgGUID: EjHs0ZBuQMSHdioHuzq1hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11836"; a="106675305"
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="106675305"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 05:11:19 -0700
X-CSE-ConnectionGUID: BFVljIqYTE6uBAErj4vxrA==
X-CSE-MsgGUID: fPr+X3g2RdWPOsaPX5btMQ==
X-ExtLoop1: 1
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.218])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 05:11:16 -0700
Date: Sat, 4 Jul 2026 15:11:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: vcnl4035: Propagate regcache_sync() errors
Message-ID: <akj4Yr086hmW7AJg@ashevche-desk.local>
References: <20260704071410.18757-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704071410.18757-1-pengpeng@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jul 04, 2026 at 03:14:10PM +0800, Pengpeng Hou wrote:
> vcnl4035_runtime_suspend() marks the regmap cache dirty before runtime
> suspend. vcnl4035_runtime_resume() then syncs the cache before re-
> enabling ALS, but currently ignores a regcache_sync() failure and can
> still report resume success.
> 
> Return the regcache_sync() error so the PM core sees the failed register
> restore.

...

> -	regcache_sync(data->regmap);
> +	ret = regcache_sync(data->regmap);
> +	if (ret < 0)
> +		return ret;

When do like this, add a blank line.
Same comment to all similar patches you sent (or about to send).

>  	ret = vcnl4035_set_als_power_state(data, VCNL4035_MODE_ALS_ENABLE);
>  	if (ret < 0)
>  		return ret;

-- 
With Best Regards,
Andy Shevchenko


