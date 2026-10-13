Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EC4534446;
	Tue, 13 Oct 2026 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916040; cv=none; b=MR//pdG+rYanmS1HD/1K5l8ZS4lLPLrv4C9SyCCfMkpybZ83dwypWlIEXxsR8N8uteznpgGssX72NNWQisM1xMnj9a9LkI+gXidT1U6QfLWV+0doH4XUoD7K/0LVqGwmdH/a1qQbVpQCwZiNCUu/JGanZyFUmMWApp06QM0rRVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916040; c=relaxed/simple;
	bh=xZ2tm/mdnd39cWxp/pJ7Hc8WkveUlEwiADbIMIazK3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdJH53+f5A5MzOaD4GTLnQBlj5i5kryofxmuphxWs7LpX6ZAYJls18GL7xFCu9BM7JmGIzGTuJN0aQYdklCVILYAr0HFpmDWJAQSwubloLYDHWvay2luSUmjPpPUl0dJppVom1NmCHaXwEgOTxV2U5g/h6a/k7FzYNEzpxy10wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=crRxTGni; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="crRxTGni"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791916038; x=1823452038;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xZ2tm/mdnd39cWxp/pJ7Hc8WkveUlEwiADbIMIazK3g=;
  b=crRxTGniUy67cfbsRt/6AK1nqWUG0WNioObKtLH+6yEZdlJ0WGZdXPd5
   s3WZDZF4imG7q0ugCaWfEhqxCE/awBXIWIM3zMSrhYg6gVzUknz57aCpU
   c8staRUxDTLdfHAFdg0wo7EZNzLQacaVudoKeU8T/SVQwSj3XsVcviNCa
   aGkrl5A6l98wzVs8S0PefUnrrcp7IVUhoZucmnhpZPKbADvrb5OoIsGgC
   Mcp9iB//v1g1bvhFpEcoJtFpSWUUEwomcAK5Rp3PnIcIFB5Uk7bCrikyt
   NGCDykvZePvyJOYj/8EPqePsnot2oVUIOBs+ajUZ/WowK6kvo7puQtuXG
   Q==;
X-CSE-ConnectionGUID: KtjWySj8Q2ae7xrcj2GGrg==
X-CSE-MsgGUID: W3A/XbTUTWaO8NRAlBFR3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="552064"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="552064"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 11:27:18 -0700
X-CSE-ConnectionGUID: 4pB0HU06SX+cbBcb8gLDGQ==
X-CSE-MsgGUID: McYFGcH8TmqeQ9DUwQWlOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1566799"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 11:27:16 -0700
Date: Tue, 13 Oct 2026 21:27:13 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jan Remes <ciakval@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joe Sandom <joe.g.sandom@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jan Remes <jan.remes@mycroftmind.com>
Subject: Re: [PATCH 4/4] iio: light: tsl2591: improve lux calculation
 precision
Message-ID: <as54AR7AhIgOu2p4@ashevche-desk.local>
References: <20261013143943.436816-1-ciakval@gmail.com>
 <20261013143943.436816-5-ciakval@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013143943.436816-5-ciakval@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 04:39:43PM +0200, Jan Remes wrote:

> The lux calculation computes the ratio CH1 / CH0 as a truncated integer
> (CH1 * 1000 / CH0) before using it. When CH1 is close to CH0, the
> truncation makes the result off by up to ~35%, e.g. CH0 = 56097,
> CH1 = 55973 at LOW gain and 100ms gives 1.517 lux instead of 1.118 lux.
> 
> The formula (CH0 - CH1) * (1 - CH1 / CH0) / CPL is equal to
> 
>    (CH0 - CH1)^2 * DF / (CH0 * ATIME_ms * AGAIN)
> 
> which needs no intermediate ratio. Compute it like that, with a single
> division at the end.
> 
> Also report the result in micro-lux instead of milli-lux. At MAX gain
> and 600ms one count is well below 1 mlx, so the milli-lux resolution
> throws away information. The numerator still fits into u64.

...

> static int tsl2591_read_channel_data(struct iio_dev *indio_dev,

>  	int int_time_fval, gain_multi;
>  	u16 als_ch0, als_ch1, als_max;
>  	u64 lux;
> -	u32 rem;
> +	u32 diff, rem;

Keep that to be in reversed xmas tree order.

>  	int ret;

-- 
With Best Regards,
Andy Shevchenko


