Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297C8365A19;
	Mon, 11 May 2026 11:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778497902; cv=none; b=NTzljEizIaBCYRA7bI5Qy7/uwQt5WrhP1cRGjkOjyoiVj8N8lZjVgxjQpK/Eo8NAT//DHDUD7nVVo03j3zjOu0cz4TpvTkYrozqO6jiYpyceSHWPa6R9SMBKC6SpifSDLoLKvhmwPW1HTaWfZHwinkYcuPt/UGbQI4pmTM5yjYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778497902; c=relaxed/simple;
	bh=JkTO9blcVCvZK1W2Z018jx7UWK6xSuWZtvIKb7skA/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwWQkC2x8gXSwfHXvwivzdvAr9GqTcl1RQBSGlMkmI6JltXgb5646cpHV0ScHQmPfTAnQNYQWNxRzl0BqI2CmRmBrMVRJb06nfwkZxV4RlS6ozlr6Sj/N5wz8rBZScmMxfJ4DwCiHzX7m9WykcpFw8u30nulspJbLerSvXfyfOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jzMoXiBe; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jzMoXiBe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778497901; x=1810033901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JkTO9blcVCvZK1W2Z018jx7UWK6xSuWZtvIKb7skA/g=;
  b=jzMoXiBecC4HLuesE0r4CaLsqDKFBWCW06CW55qH1fbpaDLpnwwfBVq8
   aCrKdDhZM1LKnDU7m+9Nl6YqIJIadYgbuNOaHUy+IToY/XxSHmt7Chobk
   lKsQlzl9Wz5VRMDkC6jZ4E+uoWtwCoDEr0YB/eCkiHOePhKDbK3MgpbVF
   dIBvdt+8TdBorZIlYitpnE2yViSJYIbHaT3vE2+sdgRV2OlDPenJwvH8X
   JgGv7Y6ShXRLpKGJxTnATkAWCs9XboeQ2N3EbDzNQrV3V+VZi9+z0o6UP
   dF0ismiuZK56RVf8as2WDXBbKgP5Jd5uR6ZbgVWCYZEPL+JskHs1Fxsn5
   Q==;
X-CSE-ConnectionGUID: 9ixyvI35Rkm7F9dl6XUPBg==
X-CSE-MsgGUID: WKsjFZA1ST+bpiX+nPuajg==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="90481907"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="90481907"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 04:11:40 -0700
X-CSE-ConnectionGUID: sdzafNOHTWCtiacdqXAmvg==
X-CSE-MsgGUID: AdhlLOD1SCqMKRC8ORNGhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="242407112"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 04:11:38 -0700
Date: Mon, 11 May 2026 14:11:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] iio: light: opt3001: remove unnecessary comments
Message-ID: <agG5aPwGcxm2IrxA@ashevche-desk.local>
References: <20260511-opt3001-cleanup-v1-0-f7879dc3455c@gmail.com>
 <20260511-opt3001-cleanup-v1-6-f7879dc3455c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-opt3001-cleanup-v1-6-f7879dc3455c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 12:04:11PM +0200, Joshua Crofts via B4 Relay wrote:

> Remove unnecessary comments as code is self explanatory.

I won't touch the first two. They might still help to easy navigate in the code
for anybody who reads it in the first time.

...

> -	{ } /* Terminating Entry */
> +	{ }

Only this one makes sense to me, but since it's just comment, I would dare to
kill 'em all in each of the subfolders of IIO in a single patch (id est one
patch for all in iio/adc, one for iio/dac, and so on).

-- 
With Best Regards,
Andy Shevchenko


