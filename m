Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC173CFF50;
	Tue, 23 Jun 2026 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782211200; cv=none; b=P65aMKijuKzgo4KbmUT61C0nkqXn7+nBoUA1hb+tHxq6hjVpZsU2W6PhuFDQshKtnMAuwC6qRoLSq7TzUYoCtzh04JpUbJV5wO3d+QBkP9Mce67d+Ec3WMEtxq+UPX7G2FlkZUZ6nsbp7/V6EFA22DS2hX3CKlbxFlN82fEY9vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782211200; c=relaxed/simple;
	bh=xMsoA4x/RgSfF225VnMwFvnbNLiWJ7gEGOmTH9qPJ/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfaEocYmJ0FENs3MrUI7L/aWW+yHSQzu/OyhJgIaIgPr7CXYsmkjq4Qvr6+RGhWjpG7cZlms80nnH3Ehb32GvfD3r1EC3ltqkNoxVYqSsrfKU9ITwx959MKP85dV9lB/mJb+cekcjQg1GA2A9pYD6N5vZbPkRS9hO3k6n+0WSWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eOB8NxMN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eOB8NxMN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782211199; x=1813747199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xMsoA4x/RgSfF225VnMwFvnbNLiWJ7gEGOmTH9qPJ/0=;
  b=eOB8NxMNlsYb+fFhv6vLUWEdNbzAeFAfe0XTCSEiokyiOTXU1BdMlbxT
   MupHHzl6mFREfs77n1boHoqS2WF8z4JdX5r9Vt+TCAYhZ37Se4kiRxnTT
   C78sFrEYJEX0/WtOfutiVSLKRiZrfxdBPI5uaX0UcKqtoPtoRERo5ceIY
   ba7yqpIxd81IvZV7WAQBRHnsZcluxv2KR/Aam8pd2j5C3qyeZfzjLrgGl
   1qFYPjhPrGA8AU9idI2ls/ERje/CW/0RL/hsUxyxdYQn+J9Ks7UyyxbZP
   +ry99WLu6W6gZScWZGHGk6cny4e1f4BKnUYbh5m7RlQD0pe1AXrq9O6PA
   g==;
X-CSE-ConnectionGUID: LPPh6I6tSm62oyTtetgDbg==
X-CSE-MsgGUID: lyaiiADsSsud/gPtcuIOXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82992870"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="82992870"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:39:58 -0700
X-CSE-ConnectionGUID: 0PUDA/AkToqf8C2Ibd8r2w==
X-CSE-MsgGUID: eQKKSBo7S0q6k4l5h5y3/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="253364161"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:39:56 -0700
Date: Tue, 23 Jun 2026 13:39:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Prashant Rahul <prashantrahul23@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Shuah Khan <shuahkhan@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: adc: ti-adc0832: log buffer setup failure in
 probe
Message-ID: <ajpieVjCVunEjCX3@ashevche-desk.local>
References: <20260620174708.111470-1-prashantrahul23@gmail.com>
 <20260620174708.111470-6-prashantrahul23@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260620174708.111470-6-prashantrahul23@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jun 20, 2026 at 11:10:57PM +0530, Prashant Rahul wrote:
> Errors are logged when enabling the regulator or adding the cleanup
> action fails, but not when buffer setup fails. Log the error returned by
> the buffer setup path as well.

...

> +++ b/drivers/iio/adc/ti-adc0832.c

So does this (devm_mutex_init() is needed). But they can be done separately
from this series.

-- 
With Best Regards,
Andy Shevchenko


