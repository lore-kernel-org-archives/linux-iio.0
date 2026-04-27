Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFCC30C62E;
	Mon, 27 Apr 2026 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777301779; cv=none; b=J6n0E4bJipRAqpBHLyONUg7RmwTw1J8OerkC5UVh+u3KEoJgL/kBPkaPOTXu5QxdZNLRVHeOE1/KGQqcYilPEUyGzpZz59syAA4LHV7itTVTleLBO979IPX0axy5LkwizvTCG5XDZH8h4lk1DOwpzbm7r6nhgQ07qtGoyoz5+9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777301779; c=relaxed/simple;
	bh=EyOvnUmSJJ5dhqSnFUg6X1vFQKN5U0dV9mkJvvOyQhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQkDHSF6IUy+v1S1ihm9/8WWZrXZimt5YCzvKoXw0DtGraKnM7fE2pDWNUIvEyBwAw1XvwSLY79oHgV5ID/DpyV7QH/3CI5zce4WjO95Jcx4j+xgDRrtjrka68tRi8irOLsFRamGI0hBMddKa+LmRc9vA1l6SsySQC10g1KUXCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fwVDEsYu; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fwVDEsYu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777301778; x=1808837778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EyOvnUmSJJ5dhqSnFUg6X1vFQKN5U0dV9mkJvvOyQhY=;
  b=fwVDEsYuJkVSPe8+yjw6w6jM0euTtQPpEPRDfWT7GsL9vaSSbnw/mRYk
   VBZ28VHkSLNI7aB5xRcexJ8AskgvDyO8hoVPTneBDVOTUBu5IxJpyuOJy
   bCcvh61c0+0r89BCUwVBKWSugILwrnxP5BkYccCZh/8dvrvCJtRpsAQyI
   k4d/TtK9DuhYwOYBwUmalEn3ccTggJ33S+W86h7cHTkd77XFGO6T5Nsjo
   cfFIuLfWESTLdX7fyCTkFFPce4SaS3sZb9/WWCN1+iFUeQh1VIptfqTfg
   3CXmOdvjPQoPIJKCYWURyWug6iOCVv77AkUc6EXjxbF9by7yl0sCq2rR4
   Q==;
X-CSE-ConnectionGUID: jlVjhT9+TCiLyhZe6kqm9A==
X-CSE-MsgGUID: 2AnjhNRaS6WpTWTH0kDr+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="89277341"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="89277341"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 07:56:17 -0700
X-CSE-ConnectionGUID: 6nc5XVKpTvK0XZbDm+J4EQ==
X-CSE-MsgGUID: TgTYjbgcS2CP7n4lFrv9XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="231020404"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 07:56:13 -0700
Date: Mon, 27 Apr 2026 17:56:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2] iio: adc: ti-ads7138: replace kmalloc() with stack
 allocation in i2c_write_block
Message-ID: <ae95C67pCgu4Jp1B@ashevche-desk.local>
References: <20260427112705.71138-3-giorgitchankvetadze1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427112705.71138-3-giorgitchankvetadze1997@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 03:27:07PM +0400, Giorgi Tchankvetadze wrote:
> The ads7138_i2c_write_block() function currently utilizes kmalloc()
> to allocate a buffer for I2C transfers. However, the length
> parameter passed to this function is strictly 2 bytes across all
> driver invocations, making the total payload buffer size exactly 4 bytes.
> Invoking the heap allocator for a 4-byte buffer introduces

> unnecessary SLUB overhead. 

Trailing space.

> Replace the kmalloc() call with a statically sized 4-byte stack array.
> Add a boundary check returning -EINVAL to ensure future driver
> modifications do not overflow the stack buffer if a length
> greater than 2 is requested.
> Furthermore, dropping the dynamic allocation entirely removes the need to
> include <linux/slab.h> (which was the original motivation for this patch)
> and streamlines the PIO transfer path.

...

> -	ret = i2c_master_send(client, buf, len);
> +	ret = i2c_master_send(client, buf, ARRAY_SIZE(buf));

The 'buf' is of u8 type, hence sizeof() is enough.

...

> -	if (ret != len)
> +	if (ret != ARRAY_SIZE(buf))

Ditto.

-- 
With Best Regards,
Andy Shevchenko


