Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355891A9F90;
	Thu, 11 Jun 2026 19:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781205816; cv=none; b=ZrWrldJo+ZisOKcJVOLY+SsayxaVwnsq05a1L7RmZexDuLEnQHT8hc7XJc3cMnwzDA/3TvqbsitXyfgjjmwMJDainIo+ypjCi5WUbhCj6sKiqCjXHx9Nizox7NXNvyIwWwZrZuZc4G10moPEh3j49TgCNqK1x0cDNPzj92W8aY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781205816; c=relaxed/simple;
	bh=YZDO8h7V0vs7r99ZkuvpwwaaqacVHjEOBPyrvfYgyQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXKKWej0EX+nLKKwfNe+xxixnoA8TM3uJ0RmXNQw1MlRZRG7igHsuVSjcvbMMix7vdoIM1VmrCNasr7NylD1GuA0/5ZNHv1AioocO4oL1I+BkvlSX9HWJADomSi1wBZBaEliSg007JZIaZGGFMS2YaMrK8Jz9HzHYHPDm6DPq78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZQ+I/TB; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZQ+I/TB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781205814; x=1812741814;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YZDO8h7V0vs7r99ZkuvpwwaaqacVHjEOBPyrvfYgyQw=;
  b=QZQ+I/TBdE9V7CqKs3lSUYutyep5qSBIpIREIbQ0J2pQXFcKfNaKLyh8
   UFLOOxlXrLWQCQjrqLd/oXUldhIkigM9tJWwTsrFJEJdEDFI0igeTLG77
   A0ATNRyIYzkR3kQVLbUM+kuGj7i2xEG/feNJSQptYxvbjvRSnAH3RyNPb
   WyHES8KbO7ku0m7z36Ejb82su/1q5BroQ5wNcCHEKZtGs4Hoi2UkKfOnr
   Dcn1veoqbkLDqt8XcvNWAGcUEd+hR0negLovBtP2Kal+2/ubqxDbfM+zW
   bBIloqCzGOjWUd76b/2gqbHP29uszEAaj7E07QUjsD/DL63eJrE4RJMEq
   A==;
X-CSE-ConnectionGUID: svQWrwERQH+KYujnf12vQA==
X-CSE-MsgGUID: NXxotUk+Qiu+CuwEPmX14w==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="84600529"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="84600529"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 12:23:33 -0700
X-CSE-ConnectionGUID: K5vdESQfQzu8w8d7oQFUJA==
X-CSE-MsgGUID: PTcyCsTfTu6GZ1U8yZGpmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="244147916"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 12:23:33 -0700
Date: Thu, 11 Jun 2026 22:23:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Siratul Islam <email@sirat.me>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: proximity: cleanup fixes for vl53l1x-i2c
Message-ID: <aisLMs0Y5na9G-Qc@ashevche-desk.local>
References: <20260611134245.30042-1-email@sirat.me>
 <20260611134245.30042-3-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611134245.30042-3-email@sirat.me>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 11, 2026 at 07:42:30PM +0600, Siratul Islam wrote:
> Extract data-ready polling into a helper, fix regmap_read_poll_timeout()
> argument alignment, and add field definitions for BIT(0).
> No functional changes.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +static int vl53l1x_wait_data_ready(struct vl53l1x_data *data)
> +{
> +	unsigned int val;
> +
> +	/* 1ms poll, 1s timeout covers max timing budgets (per ST Ultra Lite Driver) */
> +	return regmap_read_poll_timeout(data->regmap,
> +					VL53L1X_REG_GPIO__TIO_HV_STATUS,
> +					val, (val & VL53L1X_GPIO__TIO_HV_STATUS_DATA_READY) !=
> +					data->gpio_polarity,

I would put it this way
					val,
					(val & VL53L1X_GPIO__TIO_HV_STATUS_DATA_READY) != data->gpio_polarity,

but it goes over even 100! So up to Jonathan.

> +					1 * USEC_PER_MSEC, 1 * USEC_PER_SEC);
> +}

-- 
With Best Regards,
Andy Shevchenko


