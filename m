Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53E62472A6;
	Thu, 26 Feb 2026 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113452; cv=none; b=phAlxIt2JlBx4ne6fGEVN7wD/wcI6DbDdGkA6XrOGsEJBQkmnaEN6OvjsJRzrHdJYuVaEepfwlRLBjUMrf3aJfJrqAFPZkmjo9gKKbGguCLPKKySBIXHd0nyELwDjgeKMg0VPtm+bW5hKr2Lhyt/jzeYmsnCMnbgcaqqITTMIIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113452; c=relaxed/simple;
	bh=sTZ1cYla2hSlZHEBEZGCHkisjo3Cumvy/6LIDzvRL4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlFmGs7USVbOoX4Q7hfw73r/wFjOrc/JyB9FljnS0wOJZL0GKXv6PGHvAS8qBl4X+LlN4vPnTXuKbRZb+DwTdkeFwfRT0oSSUQX3tF25n5CDT811pxrLXsMazqWqESvm9zQqSPGEJLnP2SfFP4p9KaQuwlK+wXOXiCjG3DM4lfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T8Fz+R1K; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T8Fz+R1K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772113450; x=1803649450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sTZ1cYla2hSlZHEBEZGCHkisjo3Cumvy/6LIDzvRL4E=;
  b=T8Fz+R1Kx03EFAfX/EVROm1BLsFDp4xbgbzxZzFbx9v8cpRa4bBAzNDp
   0wSKneq2FwSdc29IAtY03GVkLE31KSSyRnLLoK67ezy1BQps3XEwGNRMV
   f/utTHn4LvaVr9VU1i5WfxQ+u/OnoNDBxQYtZTPICvjtBhRSbYx8KyIYM
   UPzTbIz8lTxzoUU8437tIOrhBicCM2jdnS9L01EjcLbF7rLIQLi5Codhv
   qM/+KjitwMFEY+jzYEF2b/MyUNgMIJmGHDiVAyxMlMmCxPgCblETWUc6Z
   HSBcAlBrs5ljztqEoQk790EQZqNAZ3RolpJQXZ0FGXUlPXiQJ/tAcx3rr
   g==;
X-CSE-ConnectionGUID: L6y7Y3ojSpmrjG75tygCxA==
X-CSE-MsgGUID: 6QlTRT68QhSlwbWnuyYTMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="95790486"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="95790486"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 05:44:10 -0800
X-CSE-ConnectionGUID: 5BECIkUOTcio21NvYGhGYw==
X-CSE-MsgGUID: J6XmRdbkT76/suYFKqtUqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="239559232"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.167])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 05:44:07 -0800
Date: Thu, 26 Feb 2026 15:44:05 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ade9000: fix wrong register in CALIBBIAS case
Message-ID: <aaBOJWYk5xvLo2FB@smile.fi.intel.com>
References: <20260226133741.437403-2-giorgitchankvetadze1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226133741.437403-2-giorgitchankvetadze1997@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 26, 2026 at 05:37:42PM +0400, Giorgi Tchankvetadze wrote:
> The switch statement in ade9000_write_raw() attempts to match
> chan->address against ADE9000_REG_AWATTOS (0x00F) to dispatch
> the calibration offset write for active power channels. However,
> chan->address is set via ADE9000_ADDR_ADJUST(ADE9000_REG_AWATT,
> num), so after masking the phase bits, tmp holds
> ADE9000_REG_AWATT (0x210), which never matches 0x00F.
> 
> As a result, writing IIO_CHAN_INFO_CALIBBIAS for IIO_POWER always
> falls through to the default case and returns -EINVAL, making
> active power offset calibration silently broken.
> 
> Fix this by matching against ADE9000_REG_AWATT instead, which is
> the actual base address stored in chan->address for watt channels.

Sounds like a good fix, but:
- needs a Fixes tag
- needs a reference to datasheet section / table / et cetera to prove the point

Also, how did you found this? Code inspection? Testing on real HW?

-- 
With Best Regards,
Andy Shevchenko


