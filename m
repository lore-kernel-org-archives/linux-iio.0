Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC5B39F18A;
	Mon, 20 Apr 2026 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776706002; cv=none; b=H56NdWbAzT4sBVYpdl/wGsMPSFEryyOTtZaZJCA3DPWXSdsgL2A1n1tIjm1/7wrjXV/YGjYm/F7LIHTz/bJJXAIHo8Lspw6v9uSEgsiJezfMOSsOFnE63GjYej33Vv/zllSA8nQB4Ox3ug9JKv6grCNUXLkNaqNOOr9XvtapzIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776706002; c=relaxed/simple;
	bh=pX/+idWInI69yJGAkt28ov6BkECfOCkMPjQZ8bY8xOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJ0r/Mev1Yu3oARZDqg0IO74p6NBGQ0lrr4C+FoiOL0D+3TAzhyH3VRr2cFPXLM0SUi4SxLmidCiYpyAgban22XIGQT6v2IjYsUxAZ3C0HZdzc7vUXGDLevUEav9Vs76Jbavtp/TK7lyCeLPXISs/hhl+XgqS+ur5VGj67IhfGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=moLGd8/T; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="moLGd8/T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776706001; x=1808242001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pX/+idWInI69yJGAkt28ov6BkECfOCkMPjQZ8bY8xOo=;
  b=moLGd8/T3IuxY3jSSa4KMxYVxb3tDEulJ8yDQ0u1l8vpuLuP1iKOtbWk
   yf1AbZywGxa3ycCohYg/U9bvniUYgVpAtU7/RgcgyC9ed3uTZS+YgrxH+
   CJEc3kFFCYGIIJs9MgkzkXbGqPTo5LcqwunHBOUGQSaG9Y1Fkfpwj4FwU
   RO6ICsizRhS6SBdfOx3XEaCRyxuRomMHMR4Gi7+5JTz9Tcv73hUefu56I
   iSiLEZ1NNbMT2al48TzL7Nfslg7u6Wwkis7EBt09w6Nj5X3aM5spbVITO
   39vW+bwJHOh//7j20rwKeDeov6WHyjpG5cBznpZTWKht42Ch37zP57w6R
   A==;
X-CSE-ConnectionGUID: ckWIOxGRT924ZtpgURbs+w==
X-CSE-MsgGUID: IRuy7MQWRLO9jznx93pLHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77334108"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="77334108"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 10:26:41 -0700
X-CSE-ConnectionGUID: uF2Toyh4T9GwKRnkbgdxTw==
X-CSE-MsgGUID: 8x+COHeuScyvFn/+AqhLFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="231658750"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 10:26:39 -0700
Date: Mon, 20 Apr 2026 20:26:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: magnetometer: ak8975: modernize polling loops
 with iopoll() macros
Message-ID: <aeZhzETQk6afaw6y@ashevche-desk.local>
References: <20260420110804.1353-1-joshua.crofts1@gmail.com>
 <20260420110804.1353-5-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420110804.1353-5-joshua.crofts1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 20, 2026 at 11:08:04AM +0000, Joshua Crofts wrote:
> The driver currently uses while loops and msleep() for polling during
> conversion waits.
> 
> Replace the custom polling loops with readx_poll_timeout() and
> read_poll_timeout() macros from <linux/iopoll.h>. This reduces
> boilerplate, standardizes timeout handling and improves overall code
> readability, keeping the original timing and error behaviour.

...

>  	/* Wait for the conversion to complete. */
> -	while (timeout_ms) {
> -		msleep(AK8975_CONVERSION_DONE_POLL_TIME);
> -		if (gpiod_get_value(data->eoc_gpiod))
> -			break;
> -		timeout_ms -= AK8975_CONVERSION_DONE_POLL_TIME;
> -	}
> -	if (!timeout_ms) {
> +	ret = readx_poll_timeout(gpiod_get_value, data->eoc_gpiod, val, val != 0,

' != 0' is not needed, but perhaps okay in this case to explicitly hint that
this is used as boolean conditional.

> +							 AK8975_CONVERSION_DONE_POLL_TIME * 1000,
> +							 AK8975_MAX_CONVERSION_TIMEOUT * 1000);

Somebody broke the indentation...

> +

...and added unneeded blank line.

Also, use multipliers from time.h, id est USEC_PER_MSEC.

> +	if (ret) {
>  		dev_err(&client->dev, "Conversion timeout happened\n");
>  		return -EINVAL;
>  	}

...

>  static int wait_conversion_complete_polled(struct ak8975_data *data)

Same comments as per above.

-- 
With Best Regards,
Andy Shevchenko


