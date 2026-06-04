Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEB73D0C1C;
	Thu,  4 Jun 2026 06:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555172; cv=none; b=U2WN8nBYEdV7cqShmRjdm4u4Veh6ccAfkm2llkbAeSKTine0F8cLc+eCZzAtst3E6t+9BtJHygEFxI3Nw3mNvPMYkvh7FHf8Fe/HH5X6OktOzFkcY+e4XS+BjKWMUvAmJA4xqyGkE/5eUfXypE72uF7ERFFSci0e6/LFsNehsUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555172; c=relaxed/simple;
	bh=xzVX9m5EWeTlA0t35X8PZ0wtoS5SaOOtJ+LFgK+Rijc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Or8g6FVsYAlw56IYl5rLzt3yrUUTyb7vHQ7B//DFixwuuxhcCeDROl/K5odU63v7iEMFRnoAUyPYpcfphRRFcmzMU6FLXDys2341w/dXm06b/oGlsKHth3OyQN63VygtQqF8mR/LBLydkFcFK+575gPraE9zOqHzXMY+yvwkAK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0J1DHIe; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0J1DHIe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780555171; x=1812091171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xzVX9m5EWeTlA0t35X8PZ0wtoS5SaOOtJ+LFgK+Rijc=;
  b=O0J1DHIe7xuLTi+Quxjqb2i8BgD6dI9n1uMU1eOyI0ja0FQPAWJIdxZE
   65LftDpfkccAk+RXFUK2uGyflL4wfBejI3V8zrCkBUgucDvtnfJFlWFwY
   KaXqES32cr7zaxu68W6MD4R8Uvll7C//sW+r9V2RmxoFhEciQt5/mY/KB
   SXADQWnKLvTWwv049c4VIGCvDgXHORyr7bxo1L8dIzLdhvF2xT4U73Q7C
   oa3Ir3P/lh5xixR20Kd+AGd+nyblv0YfcOCuEUu+00MzdEOwtEMx5f8lp
   nkd1dVCUx+CaIiMAuOkha9NHO64vfEB3aTLaeDcN0Pd3dQ6lViwN4Y6uG
   Q==;
X-CSE-ConnectionGUID: Vg403T22Qfi3Jn/zw57Now==
X-CSE-MsgGUID: BbxqtMpnSgSKiwtH/mjgIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="92060677"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="92060677"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 23:39:31 -0700
X-CSE-ConnectionGUID: XWr2vI22TFuXZOpzlspB3A==
X-CSE-MsgGUID: xalzLok0Tn6W5NABN2fT4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="249543162"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 23:39:28 -0700
Date: Thu, 4 Jun 2026 09:39:26 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Maxwell Doose <m32285159@gmail.com>
Subject: Re: [PATCH v5 3/8] iio: light: opt3001: ensure correct parenthesis
 alignment
Message-ID: <aiEdnhETWDPUzF8M@ashevche-desk.local>
References: <20260603-opt3001-cleanup-v5-0-3ef7b926d555@gmail.com>
 <20260603-opt3001-cleanup-v5-3-3ef7b926d555@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-opt3001-cleanup-v5-3-3ef7b926d555@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 07:12:54PM +0200, Joshua Crofts wrote:
> Ensure correct parenthesis alignment per checkpatch.pl report.
> 
> No functional change.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

>  	switch (dir) {
>  	case IIO_EV_DIR_RISING:
>  		opt3001_to_iio_ret(opt, opt->high_thresh_exp,
> -				opt->high_thresh_mantissa, val, val2);
> +				   opt->high_thresh_mantissa,
> +				   val, val2);
>  		break;
>  	case IIO_EV_DIR_FALLING:
>  		opt3001_to_iio_ret(opt, opt->low_thresh_exp,
> -				opt->low_thresh_mantissa, val, val2);
> +				   opt->low_thresh_mantissa,
> +				   val, val2);
>  		break;

Not sure why you have split the last line, as in any case there is no logic
split on the previous line.

-- 
With Best Regards,
Andy Shevchenko


