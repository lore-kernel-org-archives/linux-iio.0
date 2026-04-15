Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECA4324B2C;
	Wed, 15 Apr 2026 09:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245125; cv=none; b=AhUSqXX6DlTVdgZwQ45tpCruq6F8an5HedOJSLYqIzI7xC2QJqKuRn+K+UqP0hD0QLju3j4NIqbxuKTLO3MuhJg5gDd/87ETs/AynxDjIQq601QV7v0v6wUas//pgWdwUosmGb9ufiUr5+fy0PgUMQbTEFdolDPwNl57veaCOJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245125; c=relaxed/simple;
	bh=xcmNHAl3LN9HGd4dNRcqe7RjpVJa4GmUMprvIl0lvzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AABI26vQqiOvS49bUBWhiLQtG/whpK8wA8gA+BDvUl8TRFEBKLTON1mlm/NHYqXsXmFClShZ0eLwTdXJ+X9qK6SMDYcp09qVeUSYvDNYdSkk0w/4j4T+fNOKXMAYG57zLqbLFKl593zSlv+6ROa0L2OybwHdjGzbMFLUq6BY9ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=epFDhCv/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="epFDhCv/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776245124; x=1807781124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xcmNHAl3LN9HGd4dNRcqe7RjpVJa4GmUMprvIl0lvzc=;
  b=epFDhCv/ZlpdRMjwrNY6pgFVQwBxaGyXMFK6Xry87tknOdsshZwCMauv
   MxEdrn42Dg1sJkGrud7O6WaFegX50NN4pcitlRnAl/LsGkiwHnNX7x0ZG
   oSxwCnmpDqnOUteKSAve6P3Lsx2JZqRRx2YiXlyu+vgax9hPTBzq34Z1a
   QBkgcwppUWg7+Dtzx976rzIKOIXQeyIZhXJn9LJxUYrOIG/P2X8ufzmyz
   n30NV2IiVdPlw0byThDQa6AAIwfVKhqJkEJLtw5FyaUk0GQSr6CW/ivzH
   CcJjwPUFaQeRwPezpkUxU1KbF7NIQHoEcnwbHUXaOIoFLbdUNXphQlCMi
   Q==;
X-CSE-ConnectionGUID: qzImOkusTSivWJKkqdC14Q==
X-CSE-MsgGUID: 6+/hYWU8STqJHnI83E20vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="99858018"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="99858018"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 02:25:24 -0700
X-CSE-ConnectionGUID: 0KuYynOoSo2LmaU4SDVEqQ==
X-CSE-MsgGUID: RM+GlkoQSo6/GKrJ74l2eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="253782345"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.34])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 02:25:21 -0700
Date: Wed, 15 Apr 2026 12:25:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, tglx@kernel.org, christophe.jaillet@wanadoo.fr,
	mingo@kernel.org, nabijaczleweli@nabijaczleweli.xyz,
	kees@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/7] iio: ssp_sensors: factor out pending list
 add/remove helper(s)
Message-ID: <ad9Zf2fAIp6ggoJh@ashevche-desk.local>
References: <20260415050749.3858046-1-sanjayembedded@gmail.com>
 <20260415050749.3858046-4-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415050749.3858046-4-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 15, 2026 at 10:37:45AM +0530, Sanjay Chitroda wrote:

> The SSP SPI transfer path manipulates the pending message list in
> multiple places, each time open-coding the same locking and list
> operations.
> 
> Re-factor the pending list add and delete logic into small helper
> functions and drop use_no_irq variable to avoid duplication and
> simplify transfer flow to follow.
> 
> No functional change intended.

...

> -	/*
> -	 * check if this is a short one way message or the whole transfer has
> -	 * second part after an interrupt
> -	 */

One more thing, please, move this comment to the same condition in ssp_pending_add().
The ssp_pending_del() can survive without it as they are close to each other. Or you
can add a short one to refer to the comment in ssp_pending_add().

While moving, fix the style as well.

	/*
	 * Check if this is a short one way message or the whole transfer has
	 * second part after an interrupt.
	 */

-- 
With Best Regards,
Andy Shevchenko


