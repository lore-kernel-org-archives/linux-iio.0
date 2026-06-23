Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B56636D9F9;
	Tue, 23 Jun 2026 10:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782210939; cv=none; b=FwMW3QlStDfoAfk28PQ6smo1sJ3JB0ku8ezFmWfWy41lUjdqe2PV18uhdCYSsZAxjFJE6n5O0GzTx1poqCiDweholvmzrtTetjbkM92tuDQ8mTXtyy46FWOKmF8o5x1E/rhmFL7DGcU2c2KBbLe2TgKTctMlYoVp2/j8RqPM6RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782210939; c=relaxed/simple;
	bh=uMCq02OtwkUbUeRsGdaor+w5d/7gKF27OcuuXzabcHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgkKjB2AGO8STTbTPD+JopVg2Zz8mDPrnzgHo3Y8uvlR68YBQq3VUA9tkOR9pqv0g5zOmbDWE3R9It5msZkAYJmnlXk9g/5ely3mRZTl3B+jkmlRT5ZEO2h6tq9d+ngJU709HR9eAQZqKLk2zch3vsYzQCawJtb/PWl31h9zWI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WSN8UE7y; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WSN8UE7y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782210937; x=1813746937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uMCq02OtwkUbUeRsGdaor+w5d/7gKF27OcuuXzabcHE=;
  b=WSN8UE7yoXInUC8d1+tUPK9BtBYTvoYaU9ZGgwoJO1oGCLWc8UK63/NB
   S3VeQUjeZI3fM9ccKIrhVm93mhZd0jrY5ibNoxCXtWz1SOcG2ANalYlsv
   q+FeiTLZa/QY5U3kprycb7nPopLalQ7V6wOAo4j8mGjX2mo4qfzRrPBq5
   mgFgkZY471plZg+2H5XFiXsV8ofKkDU5ZnoBjcYKDqGopndv1S0TVTBgQ
   46vPCwdtLb7NWs3hbVZggXR+3J8P9ZfnoLSdyxgI2rEnwqqUB4+fh2zuz
   AUWGT6ekk97mtAyzMnppnS/tTgxyCwh9PyKKfyQp32Lp6B4hOP7U+AQ31
   g==;
X-CSE-ConnectionGUID: IwiNoJo3R6mwyhzMRQ1DQg==
X-CSE-MsgGUID: xH5N1Yt8Qx+FDfz4cHPnFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="100499926"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="100499926"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:35:37 -0700
X-CSE-ConnectionGUID: JZuiQIhuTxaex5GvIthnyA==
X-CSE-MsgGUID: ouLcjHXURrGHFZKTDG2zog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="249520544"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:35:34 -0700
Date: Tue, 23 Jun 2026 13:35:31 +0300
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
Subject: Re: [PATCH v2 0/5] Using dev_err_probe as it simplifies error
 handling and ensures consistent error reporting.
Message-ID: <ajphc846fvz-ZmYs@ashevche-desk.local>
References: <20260620174708.111470-1-prashantrahul23@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260620174708.111470-1-prashantrahul23@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jun 20, 2026 at 11:10:52PM +0530, Prashant Rahul wrote:
> Errors are logged when enabling the regulator or adding the cleanup action
> fails, but not when buffer setup fails. This adds that missing log.

OK.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


