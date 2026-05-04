Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CCC39B4A9;
	Mon,  4 May 2026 11:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777892515; cv=none; b=DwQGEqqpd31iBvOWvAFl0nlkXb+QVi0AXt+9ugJ5Yxd/fDv6WxIDH197Gf6dq0GHkygUmfkTcP2OWe2FU2+s5aVhLiXO3gWecsspKoTA9eMpb3mau8CIC6fFgCWMzHAvkVzdKP5YRsAQ/Nj8R51jKPwnhnhyGoxhnGbTGg69bh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777892515; c=relaxed/simple;
	bh=DkzG33rodDPhwK5LNeMG8LBrJ7OibLqTfYYobbvWxYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlYPGmbobxzLw6YCfNhEegQn6X5Mnpow5bXcLoRgHoab3tqk0E0kJuP0zc8mvP/bb6D1AxyE921FvM1GSoCdGjUo46G35FkIFwHbE1ZH6ZbLh7hWsX7LA1AoS6r1rhBeFXQNY45ousWouWyt7LMrlonQLxeGBCXJNnVyjn3bW3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIcfIYvy; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIcfIYvy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777892515; x=1809428515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DkzG33rodDPhwK5LNeMG8LBrJ7OibLqTfYYobbvWxYc=;
  b=kIcfIYvyL/Ou8r/2SnY/jhCQzErbjw9t1HI+encinFlKDfixdGumkteM
   weC5tjBAZ344ny2V5UKkCkByorEbk3zNr2gJvGgS06HZB6KSmG0hC0AKa
   yvCLeixGD/JD9LVse44e75QbeSPYURXTkaN7SE1ruDY3rwwlBxN3SWmsj
   rH6dU28B4OEm6kHulGqK19qgwRgpDCu7WpPtiR2UlHRPzoKUdxMnAvLaq
   Zsn1Nss+7B3cHPfbSVuUmcwkYXcwcGVxNapInXW3j804DAR3AUFu2Pvch
   hYHwfTBJwK4K6QlZ95AVJxxHloL5mNw4vE1ainkrQ4HTqWUJEe9zYVl3R
   w==;
X-CSE-ConnectionGUID: nqXnMj7DT9OHPxCKDeBp5w==
X-CSE-MsgGUID: VkBDVFJNRQmqWLPLOfarOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="89054115"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="89054115"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 04:01:54 -0700
X-CSE-ConnectionGUID: exL47zitSbOO+kSttH68Gw==
X-CSE-MsgGUID: 1trCrEQ3RbGqCn0J0bb36w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="240471881"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 04:01:51 -0700
Date: Mon, 4 May 2026 14:01:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/17] iio: magnetometer: ak8975: modernize and
 cleanup driver
Message-ID: <afh8nZ8fsyeXYbtz@ashevche-desk.local>
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 11:48:12AM +0200, Joshua Crofts via B4 Relay wrote:
> This series modernizes and cleans up the ak8975 driver, migrating to
> more modern kernel APIs and cleaning up legacy code. Patches 7 through
> 17 were provided by Andy Shevchenko.
> 
> The series was compile-tested and ran in QEMU with i2c-stub and
> no issues were found.
> 
> The patch regarding switching to devm_* functions might have to
> go through an additional revision, otherwise everything else seems
> good to go.
> 
> Changes include:
>  - replacing usleep_range() with fsleep() for optimization
>  - migrating to iopoll macros for better device polling
>  - removing unused headers and adding new ones
>  - checkpatch.pl fixes
>  - switching driver to use devm_* functions
> 
> v2:
>  - PATCH 1: reverted alphabetical header ordering per logical change
>    separation
>  - PATCH 2: added newline between fsleep() and return
>  - PATCH 3: fixed open parenthesis formatting
>  - PATCH 4: fixed whitespace issues, added <linux/time.h> for
>    USEC_PER_MSEC macro
> v3:
>  - PATCH 1 & 2: split alphabetical ordering and header removal into two
>    separate patches
>  - PATCH 4: commit message fix
>  - PATCH 5 & 6: split error handling and polling loop replacement into
>    two separate patches
> v4:
>  - PATCH 7-17: am Andy's changes into this series
>  - PATCH 2, 5, 6: fixup Andy's changes to existing patches

Co-developed for those is too strong. Just use your SoB only.
You may use my Reviewed-by though.

Taking this into account, you can wait a day and send a new version with that
and --base fixed. Also it gives me and others a chance to briefly look into
the contents and see if everything looks okay.

-- 
With Best Regards,
Andy Shevchenko


