Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4703E2D3733;
	Tue, 28 Apr 2026 07:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777362952; cv=none; b=ngUTx3Y7uqcfwJeLvT67BQHq9S8sSk4lNDqT38pW/IiVuB57EWKJ97KR6N1fafhc4l1KqWndsr72/CayS1sQcBiNIY6FIu18Eh706DIxWjtBnzQxWH25CMHDuve+V+IVIMzstHcNaXRbmECIeLm6wZ9Myso5h97Pr37zfOtpcvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777362952; c=relaxed/simple;
	bh=kOM3fZrpE9I/V+AblzHm3qHnvAK9BzKpEwAbGvl9o/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLimN9HQNaWAZivBAffWNhv8p1Om/bMtvB4B/q3axJ370q0JzhmT5eP10vVAe7/Jvz/dY76rflSbxJzfeAhXZNCGXrq8J7dwP8r/FAB9Kcui9vB5kNBCv88L8UxdW66wSgiUC8L7qYmaJsOmTO0rvq6FXeIOXH5H65/GpSF0AOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dJ76vPBi; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dJ76vPBi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777362950; x=1808898950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kOM3fZrpE9I/V+AblzHm3qHnvAK9BzKpEwAbGvl9o/Y=;
  b=dJ76vPBi+F0wbcOVnnrtlMUS0HjJvWMv3HpT6rmpagyl8H/luBzaeGAe
   Xl9DBV4IhipYIeleYNI1Wh3hR+9FslzQkp+ty/mFvr/W4VYizg6hHMpQ3
   IYtjWHMIGabVu0HpoXGXNnLOz2MJCbP6/4TB1psFQwH2LSBnV/BZ96iJP
   yliR5cZ1eJCBCy+3XrLTQpm1yrmRzH4W12n+8+xP/0RA3+8gjwrQYxuLF
   EXnYP8iySGqfuxHsIOFXB5GtjwNaUaznG0xZMToiX+c3iUr3uS1ZQw2cX
   86dQbzSk8SBvfpmFmg+eLjieqtiQkMEx9PS+TOcSQzBvS27jsm7iJ+fQw
   w==;
X-CSE-ConnectionGUID: /N3gjOwiTG+bZiVdG+MYtw==
X-CSE-MsgGUID: jHvVHITMS0Sl6UIh3wi84w==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="65792274"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="65792274"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:55:50 -0700
X-CSE-ConnectionGUID: Xj4sdta9Q9uQztvubsPcwQ==
X-CSE-MsgGUID: KJqI8x+DTricsSu8jsrMiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="233012707"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:55:47 -0700
Date: Tue, 28 Apr 2026 10:55:45 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: dac: max5821: fix return value check in
 powerdown sync
Message-ID: <afBoARByF0W3gS6k@ashevche-desk.local>
References: <20260427213319.25767-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427213319.25767-1-salah.triki@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 10:33:19PM +0100, Salah Triki wrote:
> The function max5821_sync_powerdown_mode() returned the result of
> i2c_master_send() directly. If a partial transfer occurred, it would
> be incorrectly treated as a success by the caller.
> 
> While the caller currently handles the positive return value of 2 as
> success, this patch refactors the function to return 0 on full success
> and -EIO on short writes. This ensures robust error handling for
> incomplete transfers and improves code maintainability by using
> sizeof(outbuf).

Makes sense, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


