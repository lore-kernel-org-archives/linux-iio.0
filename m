Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EE43438B2;
	Tue, 23 Jun 2026 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782211049; cv=none; b=tw7EIhVDQLqjOsJSi+KeRVYIlq6F6wFyFCfU+z19Brx7mAjYMkDzKy43rveYC7CgbbbBbUK3WsEqWm8vIBK8moE2jz06Yk2OZXkiAu2FyX4S8xlX8TJRmEfmY7QIDK3P/OSaPqyU9ZaAvgR3DN8UALN+fRlnOBSu0fNCMOP5VeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782211049; c=relaxed/simple;
	bh=tt21quhq1bnTz2myQPWdbnSP3DiPbWvKSDX19pu5FU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgIVmp9rJBSiMWcZuQltooOV50vYe0eo5zIPiKA3IG3mS9HXPOATxSR349iw6gilef7ECk4YkKqDyXQ1Bz2/SLoKiTgfWHQz0rnmTtXap7SRO3HtYi1ERcchFe1X/fpiqzSjSI2TsGwI1wIlFcbjzb9FsNHHQFSircduk6Z6noE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GbuLzoLi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GbuLzoLi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782211048; x=1813747048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tt21quhq1bnTz2myQPWdbnSP3DiPbWvKSDX19pu5FU8=;
  b=GbuLzoLigx/fPlzXJhgt09xCFXzX71O5ieNix8XAGBO/p3wLepvsgWQS
   oYWxuBvz7mKdC6JOOU/ZQrFmr03fhiQRqEVNjtkLjDp5UYxK+BAB231kX
   WNc6QL2Np86PMzxdXDXrZjQK5dN+5vVOI9mK45BSZUiiPxwlpRQuri5UT
   GzXnOCw1N2QX673yx/DgQaFdYBu2ysQErLTUtRo82QFBvkgJWNSRIxckB
   FgcCaH8Uq+1KBBvhFqroHdy0ntzInCyMa5QqdaN/23ezJN+dBaHuT9SKo
   Kd202zyJV5TpSZD2QMMLAJhTu4SfAZG9Br/8FAcZtGXCOCJOrhujJJKXI
   w==;
X-CSE-ConnectionGUID: U1F3MbEtT3+A/IpVWcMwmA==
X-CSE-MsgGUID: Dveyzt2MTTGzYJYTKWGp1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="100500127"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="100500127"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:37:27 -0700
X-CSE-ConnectionGUID: KeCHpar/QOSsF5WwB2qg/w==
X-CSE-MsgGUID: ibiAHDZmQZat0CswkZzrcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="254460532"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:37:24 -0700
Date: Tue, 23 Jun 2026 13:37:22 +0300
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
Subject: Re: [PATCH v2 2/5] iio: adc: ti-adc084s021: use dev_err_probe for
 probe time error
Message-ID: <ajph4syu53_junOF@ashevche-desk.local>
References: <20260620174708.111470-1-prashantrahul23@gmail.com>
 <20260620174708.111470-3-prashantrahul23@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260620174708.111470-3-prashantrahul23@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jun 20, 2026 at 11:10:54PM +0530, Prashant Rahul wrote:
> This simplifies error handling and ensures consistent error reporting.

...

> +++ b/drivers/iio/adc/ti-adc084s021.c

Side note: this also needs devm_mutex_init().

-- 
With Best Regards,
Andy Shevchenko


