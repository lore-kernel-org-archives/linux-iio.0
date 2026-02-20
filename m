Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BC034B1B4;
	Fri, 20 Feb 2026 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771596524; cv=none; b=Cwddsz8BkrPP57oACwvpPY37TYPtPRxXoMo3vIUsg0Se63ZUD8/7pVOhl6BlbsAtYXGGjHUMGUd3L1uVpJ0cAtZXcGmQJVDA7QpyfO4HxfRAXpwqKQpT+yR/t5UszwSuSk176rbdgAnmsQS+OFYnLXMjicdY2RHY2APD/bdk/EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771596524; c=relaxed/simple;
	bh=a0UnTybPjpdGzAT2+YkU6EJvPN6GvdLzR05dTz1GDss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gX7zLEN8R30etA1SHmyRGN1TGJ+yIDcHY58JdtOQXATnzUmlfQBfQilNHdiLa9t2oFXGghWEZU6Etwz9BgHiHeVSoCLRhcUxN2d7kw4p7E7fJiTapCAcwjeYY67gy3Tnfp7QBA620PU7xif5eW+fuZVKAqnSRNt1vyvg1280h7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ec6h/IzK; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ec6h/IzK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771596524; x=1803132524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a0UnTybPjpdGzAT2+YkU6EJvPN6GvdLzR05dTz1GDss=;
  b=Ec6h/IzKQ6mAh8WOQtb6pZe14veZ4KKGKFIa/vU3JeH/oA08Su27znO4
   dRJS/3bQRwYrVpCEdRX4cNQIC671EQPA3SFJ68/AcMBekXFQUMC2KEifr
   f27FIzGAEGEKg7zNx1/clZHf9Hx7fPRbAiP6y5BDXz1CkuJSI9YzLYKBz
   PK6wmqKJi+xs3y7/NiOaMmgUAPEPdVApHwQKL73R49Uk1vLnYbiiNu3sF
   4GCqEsXN8LyJUpK1iQW7jyLCABX+hgYHRCZu9/fNHdWJcjeTRxsnxGsCS
   slF5INWzC1iCHH5C5tbbCehZc5+2hX3RK+3MaM7lTDJ9amKBDvEcZOHIy
   g==;
X-CSE-ConnectionGUID: M30G2N5LQ4edgRtXaYJBpQ==
X-CSE-MsgGUID: QkRfRCV/Sz+eFrOxdY2sTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="72731046"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="72731046"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 06:08:43 -0800
X-CSE-ConnectionGUID: 0wU3iMSxS2i/Zz1g9/YU8Q==
X-CSE-MsgGUID: c2B1AsnbTNSu0A0RIwPzkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="218993429"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 06:08:41 -0800
Date: Fri, 20 Feb 2026 16:08:38 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: addac: ad74413r: simplify timeout return
Message-ID: <aZhq5tu4KxrGb30M@smile.fi.intel.com>
References: <20260220131847.76968-1-antoniu.miclaus@analog.com>
 <20260220131847.76968-3-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220131847.76968-3-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 03:18:47PM +0200, Antoniu Miclaus wrote:
> Return -ETIMEDOUT directly instead of assigning it to an intermediate
> variable first.

...

>  	ret = wait_for_completion_timeout(&st->adc_data_completion,
>  					  msecs_to_jiffies(1000));
> -	if (!ret) {
> -		ret = -ETIMEDOUT;
> -		return ret;
> -	}
> +	if (!ret)
> +		return -ETIMEDOUT;

I would prefer to have just

	if (!wait_for_completion_timeout(&st->adc_data_completion,
					 msecs_to_jiffies(1000)))
		return -ETIMEDOUT;

Using ret in a different semantics might lead to subtle issues in case some
code sneaks in and out of a sudden will recognize positive value as something
else.

-- 
With Best Regards,
Andy Shevchenko


