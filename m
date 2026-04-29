Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AC926A0DD;
	Wed, 29 Apr 2026 09:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777453927; cv=none; b=VQ/WLsA3/ublPWZ52MaW/tpm2MS4xmLcuvLRd54yrQpvHy3w0y+qHo+KgHYMV15DTyCrKKOL6TXy1SeTkdIicf+c1V6hZRRp+YDNxU8n6HELRpVdobztu/jPuzcUvh7aMh1m1EpH4tuo/TudRol5Tl5bUdwaBK8MOFHuSReeoe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777453927; c=relaxed/simple;
	bh=VlRPTLknlXebDeIp646Gk/5Zlb2ztcRni1XPFGoHYwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyOP+6onXYyXa4mFevFp3xvY1UT9Diw9dcoIJnaB9l66ui32XMERYEPBflmlzXxrL3irLFmqNIxQJb8/sZPoS3nKArCnNJ30AlMXBjEhughW9i3goklIFg882rz/9IxkjxGd0pdOChu8eqkaFJzQt6bjn3itoi5lAQfXhVb3CS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LYrpOaDh; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LYrpOaDh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777453926; x=1808989926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VlRPTLknlXebDeIp646Gk/5Zlb2ztcRni1XPFGoHYwo=;
  b=LYrpOaDhVEBPQ4vrQPCDi3CrFjf2+N57d0Ci365238SLQYQs1A/XdKb0
   bO+SXZaCQfhmw63KuiMaGPzSqHhjNiLhPQGsTs7n1Cb5aVzITUXtAsiJ5
   dXLMXEAsixHjTdZBg/YuBJhSD/PUVTv48/DwKGtA5Vfl7LFPmOfIkdoLy
   K3zGfUcu+ff1TQOimdl1ydpWSFPqAixGtWiVlnl/00Y1+uZjBgrpx2sRf
   LFyD6V+eBHR2nlFFbGYyukhW3LMwXYqyHyiLdCZNzZz5AksApsairN8r1
   BHLWoYeK6KcQwbjeH8qoHrzW9FjuvVsB93vXbIkamBt5QK0pFAmaHg7MY
   g==;
X-CSE-ConnectionGUID: 8Yf3jjbAR/+p5MXztmf+/Q==
X-CSE-MsgGUID: 78yoxksoSV+dz32aDXI8qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="103833187"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="103833187"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 02:12:06 -0700
X-CSE-ConnectionGUID: PvuycbhGT/6vGaw+nkL2cg==
X-CSE-MsgGUID: yzBSUDn0TeCrRQR2gA5v1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="229862571"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 02:12:03 -0700
Date: Wed, 29 Apr 2026 12:12:01 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: songqiang1304521@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: magnetometer: rm3100: Modernize locking and
 refactor control flow
Message-ID: <afHLYbjUjE-kQGer@ashevche-desk.local>
References: <20260428222600.91322-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428222600.91322-1-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 28, 2026 at 05:26:00PM -0500, Maxwell Doose wrote:
> Replace mutex_lock() and mutex_unlock() calls in rm3100-core.c with
> the more modern guard(mutex)() family. This will help modernize the
> driver and bring it up-to-date with modern available macros/functions.
> 
> While replacing mutex_lock() and mutex_unlock(), the critical sections
> of rm3100_read_mag() and rm3100_get_samp_freq() have been extended to
> include negligible operations for cleaner logic.
> 
> Add new helper-wrapper function rm3100_guarded_regmap_bulk_read() to
> help keep rm3100_trigger_handler() switch-cases clean while maintaining
> mutex locking and avoiding re-entrancy risks from potential callbacks.
> 
> While at it, remove redundant gotos where applicable, and use direct
> returns instead.

...

> +/**
> + * rm3100_guarded_regmap_bulk_read() - Wrapper around regmap_bulk_read() with a mutex
> + *
> + * @lock: Mutex to lock while performing operations
> + * @map: Register map to read from, passed to regmap_bulk_read()
> + * @reg: First register to be read from, passed to regmap_bulk_read()
> + * @val: Pointer to store read value, in native register size for device,
> + * passed to regmap_bulk_read()
> + * @val_count: Number of registers to read, passed to regmap_bulk_read()
> + *
> + * Intended for use only in rm3100_trigger_handler().
> + *

I don't mind having kernel-doc for a static function, but if you do that,
validate. Here is "Return section is missing".

Needs to be

 * Return:

> + * A value of zero will be returned on success, a negative errno will
> + * be returned in error cases.

 * A value of zero on success, a negative errno in error cases.

> + */
> +static int rm3100_guarded_regmap_bulk_read(struct mutex *lock, struct regmap *map,

No, supply *data and not a *lock.

> +					   unsigned int reg, void *val, size_t val_count)

static int rm3100_guarded_regmap_bulk_read(struct rm3100_data *data, unsigned int reg,
					   void *val, size_t val_count)
> +{
> +	guard(mutex)(lock);
> +	return regmap_bulk_read(map, reg, val, val_count);

	guard(mutex)(&data->lock);
	return regmap_bulk_read(data->regmap, reg, val, val_count);

> +}

-- 
With Best Regards,
Andy Shevchenko


