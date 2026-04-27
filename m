Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F583D34A3;
	Mon, 27 Apr 2026 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777299396; cv=none; b=SQMHsqKhBvvfLCPmpRIom7BLh+vK7lJSSo0mULub/N+FUIfzjFp5c64nKpSl+owztELbbUXyNZhOkCo2QQsK8FIttsd6Uh3SzfCn6kjZB9b4/QJ1hVewQRzpvlzCNjq0yLUFXTi+V+at6KANSBm5hYSwyP00FQ8n7EOEwqSdHOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777299396; c=relaxed/simple;
	bh=q1LupePjywxyi2F4aBtrRLmCYzd1XCs8KFcnZxQbbGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8T0yyW1215vThg4zqHdkqB9bQ6A+6jqwOnipC3XhjSghp2rEBfbBv1MfMBFkyc9fdFB4sXVfUgPAPYLUk9rPu5Q4BFYrOaQ2JxlBpnxm1hcgSo0wzT+no2UeK8hAFp1dT4fcBG+dm6IS35zGRHwUqSguu8qbintlgwejaG2hEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PHfztKqI; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PHfztKqI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777299394; x=1808835394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q1LupePjywxyi2F4aBtrRLmCYzd1XCs8KFcnZxQbbGE=;
  b=PHfztKqI8h0hXgI6JflI5MxHx8eoL/P/hyTC896QCAigKwRGY3my1QMG
   tQsv9RhlLHFoSvmJWtOUI2nKfCbapIkLqwsWRnrDX8PKLjw4G+xKZQkEN
   6l3B2Uj/+kUunI44X5xlk4T0D4YVLh9J0FLixWBvPjgJ5XOKsrYesKVG3
   Qw+HyWTQk9n9Ny8IEgIMBZ3R5h7frF8yMePuM/PlsEaYPyA+MAmuqDEjt
   rwU0g9AebC+lLw2lTDeLTFYLFVfo9hXBOt+YBMIznFamvvV3fnAIg0oTe
   ZMhT1Qb86gaLBlDyTJtaHwhxCJgPHMoPXJP4BUZNg5myUxKRDQrELDCdq
   w==;
X-CSE-ConnectionGUID: dDpAAbCRTZmPu2uO1hkxRQ==
X-CSE-MsgGUID: jKoA++ulSGOH9jHYWNPZHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77214254"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="77214254"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 07:16:34 -0700
X-CSE-ConnectionGUID: a+X/MIgWTvyd/g539CET9A==
X-CSE-MsgGUID: 9NpgQSQPQwKdCVVfF1dYTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="256959036"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 07:16:31 -0700
Date: Mon, 27 Apr 2026 17:16:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/7] iio: adc: hx711: pass iio_chan_spec to
 hx711_reset_read()
Message-ID: <ae9vvCyqqlEuGKud@ashevche-desk.local>
References: <20260427100950.33936-1-piyushpatle228@gmail.com>
 <20260427100950.33936-7-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427100950.33936-7-piyushpatle228@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 03:39:37PM +0530, Piyush Patle wrote:
> Change hx711_reset_read() to accept a const struct iio_chan_spec *
> instead of a plain integer channel index. This lets the HX710B support
> patch pass the full channel descriptor (including chan->address for the

s/patch/change in the future/

> trailing pulse count) without adding a wrapper or a separate code path
> for each call site.
> 
> Update the two callers: hx711_read_raw() already has the iio_chan_spec *
> from its own parameter, and hx711_trigger() passes &indio_dev->channels[i].
> 
> No functional change.

...

>  	iio_for_each_active_channel(indio_dev, i) {
>  		hx711_data->buffer.channel[j] = hx711_reset_read(hx711_data,
> -					indio_dev->channels[i].channel);
> +						&indio_dev->channels[i]);

Re-indent this to be

		hx711_data->buffer.channel[j] =
			hx711_reset_read(hx711_data, &indio_dev->channels[i]);

>  		j++;
>  	}

-- 
With Best Regards,
Andy Shevchenko


