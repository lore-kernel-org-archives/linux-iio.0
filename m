Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E2654856D;
	Thu, 15 Oct 2026 18:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792090260; cv=none; b=dtpjuBCgaTAl0tTvNFd83AxTe5FOfCscpZm5ziw618+5/eUopDbogEIMThs/nnkDR2kiA6d7Wok2KwEfDdDmSKhQjqIeo+7lwKOyOvtmuJz4NSIHZS90gTDxEJ6Ii1LcRil+S1hFyfUEmcn5cP7tZ3Y1ybAIOlk7h1YERyvvyL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792090260; c=relaxed/simple;
	bh=syEajtdnVGr81HLILeR+mXc8E8UZTA3uXwPRrCpSewM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcDSkVRnokT9ziKLc1wgELLLtrUXVmiAWA7vfloo/3f2SndUpESGUhCY4zzl/NbCGrsokTj1JWnn//MwPPgXiVx2DktnrYEgv/8iGkeTStGtFHYfdnAQ9knneev4fGEY3PuGrCFDLBa6x/oZMp274hkQnhtDA2lGGgGkEgv9GrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cG1iUwXp; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cG1iUwXp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792090257; x=1823626257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=syEajtdnVGr81HLILeR+mXc8E8UZTA3uXwPRrCpSewM=;
  b=cG1iUwXp459JGn+BIGacvbCrxBRbLq1cmSvOhmBGb7bcZu9CMXbnkk6V
   HvzYtZweokAtv6VHrjNkuu3RUvisymKJl+rDTi00lHcUWRgjzq6nXCWzR
   bM/4KeRRoutroAo3tiMM/t30ioS0UHXuVrCMS1fT0kFPV+3xTXIwK0Qpj
   x8/+Cc019ppN4uEf/8kfuXFXz2Uu5GrlDp7ZLNxA9L63ejY0O6mdjSKG2
   w7M4RtIMSKaltWZHNwLokRYHZnER9KCB2QH6HnXlRUSaIH2H7LV/CTNEi
   dzElWnsRWX2WbqNnw5gHmVtmkZJOV1jMUFxoRLnyGgLsn73E646ynjoak
   A==;
X-CSE-ConnectionGUID: NON/aWwRSnOtIzWe9XdIjg==
X-CSE-MsgGUID: 0uvwJqu9QJSIAdZUf8EZTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="882058"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="882058"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:50:56 -0700
X-CSE-ConnectionGUID: wUJZBujDRGqTYFLdeNRQzA==
X-CSE-MsgGUID: s3TbkpgzTFS9yj0XyQnEog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1770326"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:50:51 -0700
Date: Thu, 15 Oct 2026 21:50:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: radu.sabau@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/6] iio: imu: adis: Add optional self_test callback
 and fix custom reset dispatch
Message-ID: <atEgiFbe3B3yiMfp@ashevche-desk.local>
References: <20261015-adis16607-v3-0-f972d4efee85@analog.com>
 <20261015-adis16607-v3-1-f972d4efee85@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-adis16607-v3-1-f972d4efee85@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 15, 2026 at 12:32:58PM +0300, Radu Sabau via B4 Relay wrote:

> Add an optional self_test callback to struct adis_data, for devices
> whose self-test doesn't fit the generic mask-write/sleep/check-status
> sequence. Purely additive: defaults to NULL, no change for existing
> drivers.
> 
> Also fix __adis_initial_startup()'s no-reset-gpio path: it called
> __adis_reset() directly instead of adis->ops->reset(), silently
> ignoring any driver's custom reset implementation. Invisible until now
> since adis_default_ops.reset is __adis_reset() itself. Dispatch
> through adis->ops->reset() instead, adding the settle-time sleep at
> the call site for custom ops (documented not to sleep internally)
> while skipping it for the default op (which already sleeps
> internally).

...

> -		ret = __adis_reset(adis);
> +		ret = adis->ops->reset(adis);
> +		if (ret)
> +			return ret;
> +		/*
> +		 * __adis_reset() already sleeps the settle time internally.
> +		 * Custom reset ops are documented (struct adis_ops::reset)
> +		 * not to, so sleep here for them.
> +		 */
> +		if (adis->ops->reset != __adis_reset)
> +			msleep(timeouts->sw_reset_ms);

Can't we simply stubbed ->reset to a wrapper on top of the msleep()?

...

>  static inline int adis_reset(struct adis *adis)
>  {
> +	int ret;
> +
>  	guard(mutex)(&adis->state_lock);
> -	return __adis_reset(adis);
> +
> +	ret = adis->ops->reset(adis);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * __adis_reset() already sleeps the settle time internally. Custom
> +	 * reset ops are documented (struct adis_ops::reset) not to, so sleep
> +	 * here for them.
> +	 */
> +	if (adis->ops->reset != __adis_reset)
> +		msleep(adis->data->timeouts->sw_reset_ms);

It doesn't look scalable to have this accompanying each ->reset() call.

> +	return 0;
>  }

-- 
With Best Regards,
Andy Shevchenko


