Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335CD1EB9E3;
	Fri, 17 Jul 2026 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311324; cv=none; b=BQdWnAA3HduYJQ2v1B82kh631BWd+PmMkp1IuF2sn8GqDd8dDvKc2TEKMpjGLNkdn0FGCZud8hROjb76iQPKkKB8TZEONQs34ZDxfwW8mw33RMYMbjX1DRLFbZDjB9sbB0SHqYYQwps7RWjFIM0ps6EJDv9OSV0oTTw7agM20XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311324; c=relaxed/simple;
	bh=T3Z+XXAhjrQIVQAtr6wUBqHX1ky/OSvZZdyJtdbvC6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pou41F2TmwUoMlVpExcU0FoL1FyfeFW/5ciiT/h/lZuE0FV6A5q9CCx9VMOC66814tBAkrFjFf/YVdAuAdl+1TCbV7q3bzlCrVT7JbIW7JuFjofdlKK3AQvyy2ecF39Oe6c1Zui5er99tLmglS5YkiLIH9P/YH2S7u8CS1a4F8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jCA32G96; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jCA32G96"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784311324; x=1815847324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T3Z+XXAhjrQIVQAtr6wUBqHX1ky/OSvZZdyJtdbvC6o=;
  b=jCA32G9677ChePHfq6RK4PZvMOlzhAt9OCxi2LX3A9j76FvQeBiea8Qw
   exNbx5BVS+zpqeYbN8WaLUonjcDQvmKKpB3b3q1oft+As3AzTM9lAXjEZ
   lPfqH9bHYfCZD9xR04gB3Vefo9f6LwEyxleURM1YQhFQdiVGocB3P+hll
   hlo19MximS+r9DJLb/dLiqNwabm7Rp+gDW1F/AIKix0dyFvGuhMhmOJii
   dvtsGcv5JuIjp7Z6rjKNFMxf8+l/23lPfz+QZDada0siXJWfWMINizOAs
   zxndq/MgXX5qrCE6SrssSDxV9MBKJoS5c1Ijf6NWa7+1u/JwkarCAkXFt
   Q==;
X-CSE-ConnectionGUID: oZ8e4zmpTiuJLg3QdQSaIQ==
X-CSE-MsgGUID: GM+uhbDjS9Sg5+bYhFV+5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="102412044"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="102412044"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 11:02:03 -0700
X-CSE-ConnectionGUID: zf9dsAbLRb2SAI7w64zOTg==
X-CSE-MsgGUID: HOAi7NkgSGmLN6QM/VywsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="253436167"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.143])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 11:02:00 -0700
Date: Fri, 17 Jul 2026 21:01:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Biren Pandya <birenpandya@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: gyro: mpu3050: fix runtime PM leak when enabling
 trigger fails
Message-ID: <alpuFgv7fYwqis_j@ashevche-desk.local>
References: <20260614071549.81920-3-birenpandya@gmail.com>
 <20260717175021.70834-2-birenpandya@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717175021.70834-2-birenpandya@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 17, 2026 at 11:20:22PM +0530, Biren Pandya wrote:
> mpu3050_drdy_trigger_set_state() calls pm_runtime_get_sync() when the
> trigger is enabled, but several error paths in the enable branch return
> directly without dropping the usage counter again. pm_runtime_get_sync()
> increments the usage counter, so every failed enable leaks a runtime PM
> reference and the device can no longer autosuspend. The driver state flag
> hw_irq_trigger is also left set after a failed enable.
> 
> Jump to a common error label that drops the reference and clears
> hw_irq_trigger, mirroring the disable path. The success path deliberately
> keeps the reference, as the device must stay resumed while the trigger is
> active.

...

> -/**
> +/*
>   * mpu3050_read_mem() - read MPU-3050 internal memory
>   * @mpu3050: device to read from
>   * @bank: target bank

Stray and actually wrong change. Please, use more brains and less AI.

-- 
With Best Regards,
Andy Shevchenko


