Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37236334C2B;
	Mon, 16 Mar 2026 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773678045; cv=none; b=f6nLukBuLb9moMH8uRWaH4w8QLmkirc2sNCFWs170GFaEFDYTMCtuYlCa2JBiQsAMLP9v2dezoycxQKPELdVqYVtcuCCE4DnSKIM0zPYs5GkM4cTckHPgYIwYXP9sPH2Jv4nI6dcMTdJNLFCqVd8C4BUrtoARm7Pwd1hU92FYbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773678045; c=relaxed/simple;
	bh=09ko8ifOyZ1vlWU1VSXExOS1ki4GLsME9cXHLg3b6+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leJXg42yL8I0vgdZE2KC7NfkZchJ2h/C1d7EF8Zx3lL+EZKczUYWxEMbt2CJFw8husBaGAit7oP8zWy91AT3HhYvxQp3BPJ0Z27frrK15UiYpd5QPSraRSMZ7Q+usVZvroEQxv0Gcix3IVBkmcHzQhwzADcJx1OiURAZGXSepHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVCuHKCW; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVCuHKCW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773678044; x=1805214044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=09ko8ifOyZ1vlWU1VSXExOS1ki4GLsME9cXHLg3b6+8=;
  b=cVCuHKCW7gVVfAVIuYqYCc4DTuA/Dp+vqSdxxU2VhnbviIID4R7de/qC
   J5tbc+ADtf4bGgiDInlv0fxoux2BUPMig0Oz1+Mwl2+Kh7OVQOr1DYKIJ
   7+bmKA8itUc3bNA/OM8eAImv5fvXyH7qZIklNqk3rvRs/AwRA1UwVkYG+
   7+YiQIS1lh2bSpKcAaVRFrXiun97BAwO18eKOOaDtCiiTZnwbEp3QcXdi
   jP3hzHK3CYBhst9XhgV9zosgsjh+ZtR89CDKQyuM9Hqt4dbjx1L4GWqvc
   /94ZcE9SqZkIGLW4rD1zBoAo0CgOSEpIwHOMow9rprV8JWNudEqoh2qdW
   Q==;
X-CSE-ConnectionGUID: u4rwzysZQsWcumVZxPEoLw==
X-CSE-MsgGUID: CcUmdfdETOyR5BEJ5ARgtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86177517"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="86177517"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 09:20:44 -0700
X-CSE-ConnectionGUID: OjZ2XXu9S5S1SydCYgw6Zg==
X-CSE-MsgGUID: j3Su7eSzROi4RBtDjJkkUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="222049213"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 09:20:42 -0700
Date: Mon, 16 Mar 2026 18:20:39 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	mazziesaccount@gmail.com, nuno.sa@analog.com
Subject: Re: [PATCH v5 08/14] iio: resolver: fix typo from degredation to
 degradation
Message-ID: <abgt1yoYTnQEiAlk@ashevche-desk.local>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
 <20260316090023.14691-9-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316090023.14691-9-i.shihao.999@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 16, 2026 at 02:30:16PM +0530, Shi Hao wrote:
> Fix incorrect spelling from degredation to degradation.

...

> 		/* Sine/cosine DOS overrange fault.*/

Side note: missing space after period. If this is a single issu in the entire
folder, fix it here.

...

> -		/* Degredation of signal overrange threshold. */
> +		/* Degradation of signal overrange threshold. */


(Left for the sake of context.)

-- 
With Best Regards,
Andy Shevchenko


