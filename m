Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C04F3FB070;
	Wed, 13 May 2026 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669893; cv=none; b=fKtRSyWJkaniyhVYskKVC+vH54sxghkVo0Iy0VAfIHTZZylnP52T2P/GTUab2hpxdYaUgy60tgOZjKFs4vdm5Cd0KDyr//jG4ORREaZHChcsqrua6hB/zbMqdH5N+qBdYWyo0Ayj8313Mti63wuV9/lS7DupsBTqqdoFA5C5Nw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669893; c=relaxed/simple;
	bh=qstERaPbkDaY7OQd0D2LxaO8ynBNl3nLhjwc91dVYqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C96wZtdT21x0RKDaow1WSTaKpJjTld05oS1yjbD1fzfGLqtc5KZcRtklZ3WR+ZcwsWVVlEkmN3yW/M8uHRjwR4qoDdatuunz2qkw3lnHrUHYE+KXyLtGQ4lHvlcRWsHfsaiT6kHaRlD06Fd+V+nQz1tkDpCvgGjoMcONPvYhOu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ne062H5U; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ne062H5U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778669893; x=1810205893;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qstERaPbkDaY7OQd0D2LxaO8ynBNl3nLhjwc91dVYqg=;
  b=ne062H5UCiEkH0KQ7sjtBIO5sQ63cOlPFn8lYXs00F+dIZKXwKJBZwLn
   DCKEuaZiAvrUNeu1+yHc74TtNB8njz9XhOZ32UmIOrNZ4HSI/E0ADosOn
   MoO/3Jxr0rMeiYn3EAvasPCd4RDGixnx8MuBl4l5tiyAW4tBJ27KsndaG
   xe9ww1u+DdpzlTRqpsHjYkOVoL0lo+cSQ3nxgoT949QsxSl54b7k2+rQC
   0cqIakk7rVjibl2BfOEzp1+1NsvjKjU+349uTVo8slzW3mts5wEmJUVc/
   DGzvC09bcHYKZr9LdKgbAFoKHpNph37pbINE38dQQrYghwODM3bMLYmyD
   g==;
X-CSE-ConnectionGUID: rRjMwe8kTlCs1Yo94mKPtQ==
X-CSE-MsgGUID: AEYZpaS4Tz67yF7sCydMPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="97020020"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="97020020"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 03:58:12 -0700
X-CSE-ConnectionGUID: OuWWmcCvRXalzrs3Ovl+Xw==
X-CSE-MsgGUID: Otz8OZTXTECwaHuBSkF4yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="243006980"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 03:58:08 -0700
Date: Wed, 13 May 2026 13:58:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2 2/5] iio: light: tcs3472: convert remaining locking to
 guard(mutex)
Message-ID: <agRZPnr97HPFcW8-@ashevche-desk.local>
References: <20260512223215.25596-1-aldocontelk@gmail.com>
 <20260512223215.25596-3-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512223215.25596-3-aldocontelk@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 13, 2026 at 12:32:12AM +0200, Aldo Conte wrote:
> Convert the locking in tcs3472_read_event(), tcs3472_write_event(),
> tcs3472_read_event_config(), tcs3472_write_event_config(),
> tcs3472_powerdown() and tcs3472_resume() to use guard(mutex)
> instead of explicit mutex_lock()/mutex_unlock() pairs.
> 
> This avoids manual unlock calls on each return path, drops the goto
> in tcs3472_write_event(), and removes 'ret' variables only needed to
> return after the unlock.
> 
> No functional change.

...

> Suggested-by: Andy Shevchenko <andy@kernel.org>

Not appropriate tag, I suggested only changes (as you pointed out below) to
your idea and initial contribution.

> ---
> v2:
> (Suggested by Andy)
> - Moved earlier in the series to avoid introducing manual locking in the devm
>   patch that would then be converted here.
> - Dropped "found by code inspection" (this is a cleanup, not a bug)
> - Test details moved to cover letter

...

Code wise LGTM.

-- 
With Best Regards,
Andy Shevchenko


