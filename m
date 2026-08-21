Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34001320A04;
	Fri, 21 Aug 2026 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787319075; cv=none; b=JamOxmhkGFCP4QzpX4kr/Vz2HNIvzic6T8jOq1imvnLmbOQF5Aj+BQkZxhiRns4Ww6S9H2S4TP1akipUwHU4+UYXeepT/iHBUxjXX5+fQtv3GwQxuJOVRPLRC9SkPwc5pUOUyK6iNzhGC+mad8T9pPRVuMvxDwfPjJz8SCdGiv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787319075; c=relaxed/simple;
	bh=PZkuqHJlDi2QPVHLhknsnlTMYMxnJFqePAk6ExvybgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGuh1o4pKcPJBB4WarC86qLshQeYrVLY6xjbWQm7Dm/TdE7Eh1GXC+BJodwEX97im7uhAETtb+yIW9MnNa8df3IIgnWe4WisFho1pVYO24/ca5xYTkx9b+vF+lOPhN1ZXPQdyaTgbMFQLcxW3+ZVwxfabScDSG9aTn4+gmaRb1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lx3/DDO+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lx3/DDO+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787319074; x=1818855074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PZkuqHJlDi2QPVHLhknsnlTMYMxnJFqePAk6ExvybgQ=;
  b=Lx3/DDO+dw8Uw9/a22WOF6tKBRCKLRTFAdMUn779kyXdCTfEvmbhv5l/
   x0e5KmwW08IwFqEw2CSp8g0J/5oSu2l/WrVr02EOc8UmzrXXSAHv838lS
   cK1FPw4Ghc946YH0WhnoCvzMww++mTVLraI+1X9r6PGUpmrwWjfTzL6z3
   Rp4GFZbZIL70Zya/iJJzF02VyASwy7vasffOK8ISZZddesbi5fHNivwth
   7GC2M76tUWTM/O2X0MwKxknpUPMDx62Dx65imoz4uVLAnuJ9n2h3G6oIF
   qZ09d5w9CmePE+n9C9vmomldJ+s/aBqSUEmBDCOhgthlhbJEQPPLnMsvn
   Q==;
X-CSE-ConnectionGUID: XqT9XohgQ0SdU5Rdn8POFA==
X-CSE-MsgGUID: ixUQsyPUQiai7AZZ4Dnf5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="105247820"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="105247820"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 06:31:13 -0700
X-CSE-ConnectionGUID: oEnTow1zRlib6Op2PGqNQg==
X-CSE-MsgGUID: XpgNQvKmS8iZWS8YkZD0nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="260186323"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.241])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 06:31:10 -0700
Date: Fri, 21 Aug 2026 16:31:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	skhan@linuxfoundation.org, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/6] iio: dac: ad5504: introduce local lock to protect
 state and spi transfers
Message-ID: <aohTG8UxkmHSUzzh@ashevche-desk.local>
References: <20260821102452.37407-1-0rayn.dev@gmail.com>
 <20260821102452.37407-6-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821102452.37407-6-0rayn.dev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 21, 2026 at 06:24:47AM -0400, Taha Ed-Dafili wrote:
> The driver lacks locking, exposing concurrent access to the shared DMA
> SPI buffers, the non-atomic CTRL+NOOP write sequence in powerdown, and
> the pwr_down_mask/pwr_down_mode state variables.
> 
> Introduce a mutex via devm_mutex_init() and guard(mutex) at the IIO
> callbacks to serialize access. In read_raw() and write_raw(), scope the
> lock to IIO_CHAN_INFO_RAW only since IIO_CHAN_INFO_SCALE reads vref_mv
> which is immutable after probe.

...

> static ssize_t ad5504_write_dac_powerdown(struct iio_dev *indio_dev,

>  	int ret;
>  	struct ad5504_state *st = iio_priv(indio_dev);
>  
> +	guard(mutex)(&st->lock);
> +
>  	ret = kstrtobool(buf, &pwr_down);
>  	if (ret)
>  		return ret;

This part is not needed to be under the mutex. So, first convert the input,
then acquire the lock.

-- 
With Best Regards,
Andy Shevchenko


