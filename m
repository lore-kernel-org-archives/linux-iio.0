Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DCE17A2E8;
	Thu,  3 Sep 2026 07:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421714; cv=none; b=WNCRV9XleFVO2cnAcUa/eXiMMkHX9fiIxkiZA/Ac9xMgFsuRmQ1B0kiHBjypY+f9osfkGtKBtCxGH00C2ZpN4TlmWRMy+YZ1VvKe4RFwm2oFOO3Zv7i9YI89xLcP658K4hqC4hYjIPTjpnODjzNAt9Tkzf2EuXccHodhivpVAxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421714; c=relaxed/simple;
	bh=nZcsEyOd0w/xfXPiEz+f0Vm+pf2OCD0+8TRjmLwE9JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgjxjxeHLbgNZHLYk2PzLLcO+FXVMJ3qIpTO7jDFwa34x3Pd5WRTJRrODh/gwTWXGvzB5fqF4/XaTf/bIEZolsSSAB8E+VSbbOCcB2ylkougvVs/PHQpmgKK7V4e3iAmijYnqoVTgcqKBYODZ1nX7N+McX7mkf2V3ers/20xWCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SnDKRGd7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SnDKRGd7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788421712; x=1819957712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nZcsEyOd0w/xfXPiEz+f0Vm+pf2OCD0+8TRjmLwE9JU=;
  b=SnDKRGd7iNwl4ihzEtrvTMvpai2jdSPVo4mkXPRbExRgxYv0MLrz7HCy
   xW13HwZyxpgvXSuqG0EMZkdV6y4IFM9rT29qS23QEKzqPb1a8MTXIVDPQ
   z1ePEaByWsOANTrVh8aCDquEczlInP17AbhiuvzowEYEwMLLmZF07xu7s
   gzdJcRjJTtQgfi37WOfZFl5hkixREyMq6uGIM7md6Egf2Fj+5wyKzDnOo
   7eTGWU6f4PMT3rftYimsSup6OmTGzLy9K+9OJMUpfmRjKTv7pcXjDvJTS
   enJ6K3fngZxcaVd2QD+5D6ewGCyzAy/rUF+yksPP9ZnHiAf8fJyH0F9ac
   w==;
X-CSE-ConnectionGUID: +zyHKsbOTLymEwKHm0I4lQ==
X-CSE-MsgGUID: +HQk3ej2S/OgQgAkd/6bEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="106414013"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="106414013"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 00:48:32 -0700
X-CSE-ConnectionGUID: QLhh+7NeQGGr/ZiAV9ON7g==
X-CSE-MsgGUID: cKVhVhdkRaqON8xytojhwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="307848955"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 00:48:29 -0700
Date: Thu, 3 Sep 2026 10:48:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tsz Shan Chan <tsz.chan.dev@gmail.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tsz Shan Chan <tchan@jacques.com.au>
Subject: Re: [PATCH v2] iio: light: apds9306: fix default sampling frequency
 definition
Message-ID: <apkmS32q9UI-qQw1@ashevche-desk.local>
References: <20260903-apds9306-v2-1-e8673986ae56@jacques.com.au>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903-apds9306-v2-1-e8673986ae56@jacques.com.au>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 03, 2026 at 05:05:35PM +1000, Tsz Shan Chan wrote:
> APDS9306_SAMP_FREQ_10HZ is defined as 0.
> 
> According to the datasheet (Broadcom AV02-4755EN,
> https://docs.broadcom.com/doc/AV02-4755EN, page 11, ALS_MEAS_RATE),

Make it a tag

> bits[2:0] set the measurement rate:
> - 000: 25ms  (40Hz)
> - 001: 20ms  (20Hz)
> - 010: 100ms (10Hz)
> 
> Change APDS9306_SAMP_FREQ_10HZ from 0 to 2 to write the correct value
> for 10Hz.

Datasheet: $URL

> Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
> Signed-off-by: Tsz Shan Chan <tchan@jacques.com.au>

With that being addressed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


