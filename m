Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2787C3D6465;
	Tue, 28 Apr 2026 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364930; cv=none; b=laN230+fdiem+cRkaLV35RvxPnwMVFn/mPR5GyEXBiU64FmIiLW+8tK1ZCNFZBSzGFa0ODoYxgUK8EXy4irSXAZcFWZYGfpqiWPa74I94gdiYMnRe9Atiw5eR5LiCj52/TbMqdjzJNmw76K3UR5ubPGZSjr9kvSSVMgm/6KtQJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364930; c=relaxed/simple;
	bh=9XALj/vZhENdBR3dgfrTFLPoXy9IZLtniT+PtWI63wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbntaOi/ivRAFQRsYaU5qQgqYVMwF/VWHPyTNKN0RdF96zCsQI9QR4cSpd2S93QqaMebjYYKG5D/QLr9hhMWTJKQy6VXcIN62fWwUseoWe3UTxoXD8tjcXeu9lMBWgyUtVl9F9itd7UMd/pWTvTRpgRwFpkcOVmeXjxbrgs39hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NO3splCt; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NO3splCt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777364929; x=1808900929;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9XALj/vZhENdBR3dgfrTFLPoXy9IZLtniT+PtWI63wc=;
  b=NO3splCtgGxY87o5y/AlIZpjhuKXguRu3sHAiCSRiLuXr35Sx32BwJAF
   pr1y1u+NCzIJerDmQKbQvyrbKaLeIe1W8PTPtOFT5VzIagyA9oLO8Sy+f
   wQ6VjXaOxqTFrO8Z/CvjZWXAGeR7Jst6CXbovEVs/xL+shmtUnQaqPdeO
   /99+PGTbMw7auvvhmI0IkPo69RUCHmGyfbPCjFS/wp14Q0yd9wuRYQSUj
   aKB2qtZNSKQcj5IHezu6Q7Is8GyyW1uukCV6PXsSieemHZtOYDKfQohk9
   hB3rG65g/M2Fl8dydISmwwJTOwHeEn2xdXti3BaPfoQJZAcKd6z+VNABL
   Q==;
X-CSE-ConnectionGUID: cOFIJgaRSzmXdnAilk7HsQ==
X-CSE-MsgGUID: 9nvA6EknRPe+N1nsYhXsKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="89726984"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="89726984"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:28:48 -0700
X-CSE-ConnectionGUID: XXtFDx1WSli/89xB9awHGA==
X-CSE-MsgGUID: MzWw03PpSCWWrx0/+cEcBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="238874515"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:28:46 -0700
Date: Tue, 28 Apr 2026 11:28:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: songqiang1304521@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: magnetometer: rm3100: Use guard(mutex)() in
 rm3100_set_samp_freq()
Message-ID: <afBvvPhS8Hqs03Y6@ashevche-desk.local>
References: <20260428024339.45109-1-m32285159@gmail.com>
 <20260428024339.45109-4-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428024339.45109-4-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 09:43:38PM -0500, Maxwell Doose wrote:
> Replace mutex_lock() and mutex_unlock() calls in rm3100_set_samp_freq
> with the more modern guard(mutex)(). This will help modernize the
> driver and bring it up-to-date with modern available macros/functions.
> 
> While at it, remove unlock_return goto and use direct returns instead.

...

> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);

+ Blank line now.

>  	/* All cycle count registers use the same value. */
>  	ret = regmap_read(regmap, RM3100_REG_CC_X, &cycle_count);
>  	if (ret < 0)
> -		goto unlock_return;
> +		return ret;

-- 
With Best Regards,
Andy Shevchenko


