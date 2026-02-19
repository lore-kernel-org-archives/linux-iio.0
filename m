Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A68B24A067;
	Thu, 19 Feb 2026 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771533425; cv=none; b=uu5w7sfr2iAZZcYhgSMy85ZLl9xgcUw+FqkmJElkSsMPAqJyKphAkZsjqm6AGgyQWkwcEPYxtiDOaKchF+wEzQNn7V/dF9B0cS58j9UhPwoS52vcrLkFBxrbReDuzE+A8moodeC8+8dy7LXGVgxhu0Sv6Z+L/83uOBTluhWmMFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771533425; c=relaxed/simple;
	bh=nxsFsHZAyI238+B45xz1Qnx5vVfJY4BZuw8UHOj5g8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCbY8wx2qXPH3HVkxeOcPZdu0uh41z4UQdShbNoN7hNG47j9IWopvNSqiQCf4hnyt6K3Xo6Off6NdbKUAh/V/zajZUY6SKZ95lE2d977lxRfbV8moYw+Un9bivAJ2jfBkOp6/aFCpsKGiMB24iDpnTcKPGPnFKpeYdGE9CRk/Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vx7zK/gC; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vx7zK/gC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771533424; x=1803069424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nxsFsHZAyI238+B45xz1Qnx5vVfJY4BZuw8UHOj5g8I=;
  b=Vx7zK/gCC6OwZcnJbxa03Ms0v3ZucmP9pm68EUpxmIwOjkUxH3NkbR2T
   tIJQBeZMZg2EohBLaMHUgdRQ98oXQjrhxlLu239zwBr7B+sknSpmmGvSI
   0pGx6XnHl2dNIH28Oe7naBUcsg+9hR7GjGKHtyynD795jsf+T50VM8may
   PesAZbtMQ3MNHSgQCFGqdkiVzKHpn4PAHWeFSLRlE5lYXae9jPxBeztIs
   yEZZ5Rt1FNzY2MQ0Z83ABjTq5nM07d3uXNXHPaSk3kdTPdd84kz/nCBX7
   hf+JNyE8oTB67S2pjxJ9+XUdQohUl682tV3hTHtUprw8KLkJM6Vsq/wdf
   A==;
X-CSE-ConnectionGUID: LiEHbT42RgGDiPUanBUYqg==
X-CSE-MsgGUID: ok7GnRNxQBybti+RQ8+hLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="98094984"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="98094984"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 12:37:04 -0800
X-CSE-ConnectionGUID: K8aDEFW2TpamNtUBoOHJVQ==
X-CSE-MsgGUID: JjO4XAzyQoO5vREzOYZAXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="213267674"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.114])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 12:37:01 -0800
Date: Thu, 19 Feb 2026 22:36:59 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: bhargav <rougueprince47@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: frequency: ad9523: fix implicit variable
 usage in macros
Message-ID: <aZd0a0mgtBWp5EgX@smile.fi.intel.com>
References: <aZa_QbwCumULvTf7@smile.fi.intel.com>
 <20260219203215.15566-1-rougueprince47@gmail.com>
 <20260219203215.15566-2-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219203215.15566-2-rougueprince47@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 02:02:13AM +0530, bhargav wrote:
> macros AD9523_CLK_DIST_DIV_PHASE_REV(x) and
> AD9523_CLK_DIST_DIV_REV(x) implicitly relied on variable
> named 'ret' instead of using passed argument 'x'.
> 
> Update the macros to explicitly
> use the argument 'x' for their operations.
> 
> This also resolves the following checkpatch.pl warning:
> WARNING: Argument 'x' is not used in function-like macro

...

>  #define AD9523_CLK_DIST_DIV_PHASE(x)		(((x) & 0x3F) << 18)
> -#define AD9523_CLK_DIST_DIV_PHASE_REV(x)	((ret >> 18) & 0x3F)
> +#define AD9523_CLK_DIST_DIV_PHASE_REV(x)	((x >> 18) & 0x3F)

See above, this should be '(x)' and not 'x'.

...

>  #define AD9523_CLK_DIST_DIV(x)			((((x) - 1) & 0x3FF) << 8)
> -#define AD9523_CLK_DIST_DIV_REV(x)		(((ret >> 8) & 0x3FF) + 1)
> +#define AD9523_CLK_DIST_DIV_REV(x)		(((x >> 8) & 0x3FF) + 1)

Ditto.

-- 
With Best Regards,
Andy Shevchenko


