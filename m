Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99BD28BA95;
	Sun,  8 Mar 2026 21:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773004542; cv=none; b=gQLkmiGQ45ww1GFrkBEDmqjS6Z/f5UQjECkw2KSOIUZqX0E/hhTRJ2IBtZmalC6H+uwiFxfmX5YVym0wPCweY7lQ7mKv2sK1Cw7Ad1QRkTdrKFL3Qh7ekuyhifkGez2PMNWWWDGQlaGNeenk5OBYimFYFmUlMUz/uIc86m8FPro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773004542; c=relaxed/simple;
	bh=oEdkhVLE2WlzAidbNjOkULi/caZD83WfPi5rJ5s4B/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJs6E8C56Cu0Lz7MVN7DZn7H/oFPwmdnRgGD/RJr1yFyM9lF5nuAccwIbWp8McIII9nU4H30uwCQFy9Gr1vIlXTnYxcFKgcmCPukVKNhaklB2O8eM1iVuxXlKtWL9WksrBMq9Qnj+lvUl42gcOXKIULVOSb16zL3PvktnCkC7FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KNmnVd0n; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KNmnVd0n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773004540; x=1804540540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oEdkhVLE2WlzAidbNjOkULi/caZD83WfPi5rJ5s4B/s=;
  b=KNmnVd0nO6/TM9lxJgf4Ce35x5qqd98A70xs5XsBSNEuGDPTtHhVcmFl
   TlPNxnyg5QkBhajol5mNZjxhNwz3nCrQF8qsXBvrgAKKwAYYSv4e/swnI
   28afJFZHA1MC/ru6j7x/ggYeLzWlo/nqIza3PweKEgEgqm26lroovnkwu
   bmFYSutLFhEj6XLlQKpEWV6ZDX/3h7X+q3PqDDNsWl2a6I8fEoajFqSpX
   WvpuiV3z0aEu3R6Nw7UP4YMTV98B3DkhwOKXnQRKrMUGfb+t81pk2rQG6
   hDaJHFa9Z6ZoGqHaIUXZA68nu6CPqtpMTfOpiPXB41LMjU5lFrASIKPAT
   g==;
X-CSE-ConnectionGUID: 8wvQPnBqSuCgW1bQqikoYw==
X-CSE-MsgGUID: G/7lQfilR1OZjaCFzOUipQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="77634151"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="77634151"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 14:15:40 -0700
X-CSE-ConnectionGUID: Ags6SkAnTCyMTYF1GSozHQ==
X-CSE-MsgGUID: Yi8KJp2kRFqyDguAts772g==
X-ExtLoop1: 1
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.83])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 14:15:38 -0700
Date: Sun, 8 Mar 2026 23:15:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] iio: adc: ad799x: use devm_add_action_or_reset
 for regulators
Message-ID: <aa3m9y7_OW4bGAG3@ashevche-desk.local>
References: <20260308182811.33471-1-architanant5@gmail.com>
 <20260308182811.33471-4-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308182811.33471-4-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Mar 08, 2026 at 11:58:10PM +0530, Archit Anant wrote:
> Convert the manual regulator_disable() handling to use
> devm_add_action_or_reset(). This guarantees that the regulators are
> disabled in the correct reverse order of allocation during device
> teardown or probe failure.
> 
> As part of this conversion, introduce a local device pointer to
> simplify function calls and remove redundant goto labels for regulator
> cleanup, as the devm framework now handles these automatically.

Needs to be split to two:
- moving to managed resources (and here you introduce temporary variable to reduce the churn)
- simplifying the old code with that variable

-- 
With Best Regards,
Andy Shevchenko


