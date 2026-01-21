Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEF3346779;
	Wed, 21 Jan 2026 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768986326; cv=none; b=oTpxzyXTtpcZdJcmQNj0ANpmzf81LG0V9K02IiV6CV8iwyhtgAlSXYIBCHyNmJ7by1YRoHACaJFjijfDOx1hVFQO9wgB4NX5FlL+xCY9WdhVlxolxWRvfc33SBtKNYe85tN73Xvelp0lM/at5zilBV5DVEcmEq8r/VHMgvXGD60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768986326; c=relaxed/simple;
	bh=sMTpOwhueXQDzg/cjnGKh1SVdh5y13SvYkxS2tJDRlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLnZhjMtrZhKQjT5xgUTrHt+5NiJaSVXkU5FVMKyLKgulUNd3eJg5cRSiYkseiEHM8gR8TUL1MsJxbp9HzzsBqwhS2IEyG2qZ/3VgLgG3Hs0faZsTXLNI9Q00QLs3je+VFaQbaTTXzxAav5kf1uB+SyG9d+MSszWT7DMfBP+PDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fOsBVelJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fOsBVelJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768986324; x=1800522324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sMTpOwhueXQDzg/cjnGKh1SVdh5y13SvYkxS2tJDRlk=;
  b=fOsBVelJFR2xJ95v7btr8kbX3fsDoDHTVErYFJQOoWxsKRIhwnlmt1+l
   DI01Yn75X8VQ02WhxARD9pfD4WbEm/iSiXl6wt8JOMjMuK1UTVYqrQnyq
   myp81340oB9eoMmFmcXJmHqgS3S0IXnLp19gVQWqaKwf5ZyD13Iog4aEI
   C9rXQoAjQuzv9VMLBvjwcmE9DAsw7qdn2lJEDxVM7YU6RxrCiME/RoLCZ
   vgLF3IPUg7xSvwnq2VuUPZF9oXXVsG7RJEwLM+a6Aoj//Ex5SCqjuAI+c
   /Vvvd+JIV8YzhugXsmBklKoNZ1KKVv3Y/ghFWOmNJFRj00pymIO/jtFIn
   g==;
X-CSE-ConnectionGUID: LL+IzzaSTv2qPPMCy6IhoQ==
X-CSE-MsgGUID: U6O1H61fT3iYPjP6q/9/tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="70302340"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="70302340"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 01:05:23 -0800
X-CSE-ConnectionGUID: AKpYF1+3Rie6Oj8EsVr/lw==
X-CSE-MsgGUID: 2WQelj6qQPu+O2uhwOXVtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="211249812"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.73])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 01:05:21 -0800
Date: Wed, 21 Jan 2026 11:05:19 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: raskar.shree97@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/5] iio: proximity: rfd77402: Use kernel helper for
 result polling
Message-ID: <aXCWz6O2CdU_Sp8r@smile.fi.intel.com>
References: <20260121-b4-rfd77402_v5-v6-0-5b944d0605dd@gmail.com>
 <20260121-b4-rfd77402_v5-v6-2-5b944d0605dd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121-b4-rfd77402_v5-v6-2-5b944d0605dd@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 21, 2026 at 02:05:42AM +0530, Shrikant Raskar via B4 Relay wrote:

> Replace the manually written polling loop with read_poll_timeout(),
> the kernel's standard helper for waiting on hardware status.
> Move the polling logic into a dedicated helper function, as it will
> be reused by future updates.
> 
> This makes the code easier to read and avoids repeating the same
> polling code in the driver.

It has some repetitions, I would rephrase as:

  Replace the manually written polling loop with read_poll_timeout(),
  the kernel's standard helper for waiting on hardware status. This
  makes the code easier to read.

  Move the polling logic into a dedicated helper function, as it will
  be reused by future updates.

(also mind the blank lines and paragraphs).

...

> +static int rfd77402_wait_for_result(struct rfd77402_data *data)
>  {
> +	struct i2c_client *client = data->client;

> +	int ret;

I would named it "data" to distinguish from the usual returned code of the calls,
so like in more verbose case

	int data;
	int ret;

	ret = read_poll_timeout(..., data, data & ..., ...);
	if (data < 0)
		return data;
	if (ret)
		return ret;

> +	return read_poll_timeout(i2c_smbus_read_byte_data, ret,
> +				 ret & RFD77402_ICSR_RESULT,

'data' (ex-"ret") may be negative and this will be triggered.
I think you want 'data < 0 || (data & RFD77402_ICSR_RESULT)

> +				 10 * USEC_PER_MSEC,
> +				 10 * 10 * USEC_PER_MSEC,

This makes sleeps shorter by 2. Why?

> +				 false,
> +				 client, RFD77402_ICSR);
> +}

-- 
With Best Regards,
Andy Shevchenko


