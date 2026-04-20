Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222433815E6
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 18:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776710358; cv=none; b=WZvbwHppWDV3mDCT+QFms75CFfLGLkHGy0xKOgRGBM6qZmJtviIOnyBdms5+B5l6mI4PIMy22U0EaQHXGOJmJpPJzWGM7dZp7qGuSX9pwYlALUMHxCHmIzW70/domwqVEZ97Ed2VAs7Jbs7fwCXZBLl6Yxv0JIpIk2p18LUV3Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776710358; c=relaxed/simple;
	bh=XJqiUN1GlQ/QGRGCCPsiLrlzg+MNS8xWm8c5RhU8P+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeHqhf1co8K5S2R2JZilt0zVojSytra7XlwrI4bKN9e/lgAUr+NKwF5U7OZsprRKR6BckbrGhGK03+tSLFZMSATCiaLr9tVXuXfpA7cfXV1RtcjIptTqvq9swZ95C4tGUQ+WnMTWyw6EajbBzw3A40AO9fozVMNtSeELlKAIT/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eBK0qZC3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eBK0qZC3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776710357; x=1808246357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XJqiUN1GlQ/QGRGCCPsiLrlzg+MNS8xWm8c5RhU8P+0=;
  b=eBK0qZC31AEgMsZgDfxKRWSuc868A1WcCCB8qVlpOtLw+XLyBLcCSSGc
   XfRPTeqmQWs9i0TyOHM3ZDg4MQm/5a+wJzsOxmcGMxGyN7vsvITx9diTG
   9uFudiqw62Wp7rZPOPWcdfwhebO5Y7VMvqu23ZF+rt7df8vV0k9hNimw2
   8fOwHGCKrcUNF8AuaqvHamm5Ca4151WOKl0kmvm0og+k/14ThimPd5GE6
   1kTz5t7GmISDjsKTwl9fEBay6lVhncCTxTX1QWM1OZE9AgZX28VhjYrI3
   B3GL/tknJe6MzSPNoiXyhDXSWAeLXK0wa7+FWzYEjqnBDtOcK+0w5ux52
   g==;
X-CSE-ConnectionGUID: xj1kQLVWRH+MAmM+XHqorA==
X-CSE-MsgGUID: DPtLKM80SFef2tVVxeEkVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77758531"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="77758531"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 11:39:16 -0700
X-CSE-ConnectionGUID: Vd/EJ069QQKyr8tV2E5ACQ==
X-CSE-MsgGUID: jFaqR7klTAGuX9DpMNgeIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="227159575"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 11:39:14 -0700
Date: Mon, 20 Apr 2026 21:39:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Raffael Raiel Trindade <raffaelraiel@usp.br>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, Kim Carvalho <kim.ca@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: vcnl4000: use lock guard()
Message-ID: <aeZy0ERXjO2697R7@ashevche-desk.local>
References: <20260420180454.90611-1-raffaelraiel@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420180454.90611-1-raffaelraiel@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 20, 2026 at 03:00:31PM -0300, Raffael Raiel Trindade wrote:

> Use guard() for handling mutex lock instead of manually locking and
> unlocking. Remove gotos in error handling logic. This prevents forgotten
> locks on early exits.

...

> -	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
> +	return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
>  					regval);

Here and in all similar case the indentation went off-by-one.

-- 
With Best Regards,
Andy Shevchenko


