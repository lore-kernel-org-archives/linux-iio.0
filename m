Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979DF45038;
	Wed, 28 Jan 2026 22:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769638988; cv=none; b=KJXmPHNUB8vrGT2ci4emeoZC2nPc2CmkDKj5ZC7HplJNXkpW/nQLgbZ8Q+NUw5420xHU5BrWrZQ3EoGoIJW76CtvYyfQnGoo9Ygk64Jvp7egyzc+K0giqoYaDTIZv1OJ19tT5kUSg5SWNLlMz6y1rJkBzP/Z6noeCU4SnMR0PME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769638988; c=relaxed/simple;
	bh=dyuzfWsfSdhppYJlY2i7kgxah7C5dhg5M/QNSOrVGgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXEddHpGwrc9cB59z7/ojRst1x0nfVKpw4zMhcSjQUxSuc7OoF4sZTLF5N1K4pY1haA6X8lGpXejAkLYKevyIkRPYfxSMNSU9HQ/rpWKCDl5LbpRj3nCoInLThEzQBttaVBB23HRo8BsrCG5NnwjC+ZXsFh3i7HC9+3uzJTEiX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=isHPa7cJ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="isHPa7cJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769638986; x=1801174986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dyuzfWsfSdhppYJlY2i7kgxah7C5dhg5M/QNSOrVGgo=;
  b=isHPa7cJKU6JsskU8TkTxZ5F85b0L0nAGD+EIEZAsodcfAUMGlluKXq1
   0rNo9fD8/le/Ck3FfuSBakT/7CSm5wGTjHbUKB+hUvVko9+DyDfFhm298
   Kq4NVf1H4lp+9dahKbp44tWz45nIW05CKeqdz5csiuM/w1IJT5UM9IAYc
   hHYmopaF6PLxbYQheMqFiv8JKmZI2wMJtsfX1NeyffX80SxatmRsnx93N
   ihVEm58vMM9W5vHMElHOOZbet84UZA8aV0fTdnyyJDCI+FYUqZNMMVTlN
   uAiJYyxEdG41Z2/WTOJopAnMY9SfRCM14jZGmovQZnpUE9MRoRy9WyuFg
   Q==;
X-CSE-ConnectionGUID: Pb3emvNIRCW0YFf9Y4h20g==
X-CSE-MsgGUID: yBzPbTP1QgWNhoPLv6/M8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70760312"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70760312"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 14:23:05 -0800
X-CSE-ConnectionGUID: uSDnIh8USyKcyUNpCUKu4g==
X-CSE-MsgGUID: /U/pglBmSL+FfBNdpXYHvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="213252462"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.57])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 14:23:03 -0800
Date: Thu, 29 Jan 2026 00:23:01 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: raskar.shree97@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/6] iio: proximity: rfd77402: Use kernel helper for
 result polling
Message-ID: <aXqMRZqezVz8qn_3@smile.fi.intel.com>
References: <20260128-b4-rfd77402_v5-v8-0-36388fe7b95e@gmail.com>
 <20260128-b4-rfd77402_v5-v8-3-36388fe7b95e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128-b4-rfd77402_v5-v8-3-36388fe7b95e@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 28, 2026 at 11:21:50PM +0530, Shrikant Raskar via B4 Relay wrote:

> Replace the manually written polling loop with read_poll_timeout(),
> the kernel's standard helper for waiting on hardware status.This
> makes the code easier to read.
> 
> Move the polling logic into a dedicated helper function, as it will
> be reused by future updates.

...

> -static int rfd77402_measure(struct i2c_client *client)
> +static int rfd77402_wait_for_result(struct rfd77402_data *data)
>  {
> +	struct i2c_client *client = data->client;
> +	int val, ret;


Where is the newly introduced comment?

> +	ret = read_poll_timeout(i2c_smbus_read_byte_data, val,
> +				 (val < 0) || (val & RFD77402_ICSR_RESULT),
> +				 10 * USEC_PER_MSEC,
> +				 10 * 10 * USEC_PER_MSEC,
> +				 false,
> +				 client, RFD77402_ICSR);
> +	if (val < 0)
> +		return val;
> +
> +	return ret;
> +}

...

> -		/*
> -		 * As per RFD77402 datasheet section '3.1.1 Single Measure',
> -		 * the suggested timeout value for single measure is 100ms.
> -		 */

???

See above.

-- 
With Best Regards,
Andy Shevchenko


