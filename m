Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F9B4B44C5;
	Mon, 19 Oct 2026 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401803; cv=none; b=J9x/ansHE1x4P+CLOf5KdYrTlBNqATeMdyiLfAvtXW3jP3uvyNFzB34VPZyg46/+4obkgdwNvIhzZFntcs6wHRQGDE/+D6QIoNaHOW9g0WaAk5ZiJm2OoVEoN/nISgmmcqXh90VL16D1tTeNReyPk/3lPP83/qAVKgKVFuqTfKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401803; c=relaxed/simple;
	bh=I9nPWRv3+3lvwszg1uS4J+C2eHUQtLbwYbzC4gJf5ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTdWKKqQpXUMfIuCHuBDor96jdJ7K6CzSttlMjRF5aYBCkc5q3h/GtP8+B5o2o5xjKhDjPUySq6GTP7XAquiFTo09Lwcm2wmHnO7dRFCQi8/yvNYVDA/oyX1TUEa0ihOut0Oss+qvyHqzQlYgvwLFUW1c5rftctcHmLTOcrjHew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L5KDTlRL; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L5KDTlRL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792401803; x=1823937803;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I9nPWRv3+3lvwszg1uS4J+C2eHUQtLbwYbzC4gJf5ck=;
  b=L5KDTlRLmInoG54n4cyQ/gk5gjkTdsxwbIq8QdkOzNpWgKuqP45OMtBE
   WSZR7I0aawaBmkhNvTeScqqYp8vkz7ejG6oKSuS6WqheDlMJ9tHFAFARP
   2nwLfioySfcmwgZpxuOv0p2ZM5OCg/cNi/RYAWWbUSembjOZR3Q27PwI3
   E1oSGsBsOwl3PWn5IrmctfTPWedxZIw5rFfE3mFDQvYxVCawba5h1gklx
   mrOgotiqYkPrMItLMQW+VWaqqU83ogUkhiK3i6aNFwJv1lgQQV8rYVCg6
   waJAbvTfsRRPmplX47iEaMusdK+Wt8JoKkGnRnOvwtFC6UNoeEtehVOfl
   w==;
X-CSE-ConnectionGUID: k7/fEk1YS92e4ddHaAq5Sg==
X-CSE-MsgGUID: pMUJS7VzR0Sx5qNfBt37Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="960331"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="960331"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 02:23:22 -0700
X-CSE-ConnectionGUID: TW5JLCuFSuGqXGuUKwNapw==
X-CSE-MsgGUID: 9ex9tOGPQ3ycr+0vKkoODg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2594965"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 02:23:19 -0700
Date: Mon, 19 Oct 2026 12:23:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Melih Emik <melihemik@noirlang.tr>, jic23@kernel.org,
	gregkh@linuxfoundation.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux@analog.com
Subject: Re: [PATCH] staging: iio: frequency: ad9832: use guard(mutex)
Message-ID: <atXhhJoQ86jOUSMS@ashevche-desk.local>
References: <20261018102604.73380-1-melihemik@noirlang.tr>
 <20261018175558.71739ebc@systembl0wer>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018175558.71739ebc@systembl0wer>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 18, 2026 at 05:55:58PM +0200, Joshua Crofts wrote:
> On Sun, 18 Oct 2026 13:26:04 +0300
> Melih Emik <melihemik@noirlang.tr> wrote:
> 
> > In ad9832_write(), manual mutex handling via mutex_lock() and
> > mutex_unlock() necessitates error-exit trampolines (goto error_ret),
> > intermediate variables, and deferred returns. This pattern is prone
> > to unlock-omission bugs during refactoring and clutters the control
> > flow.
> > 
> > Modernize the locking by using guard(mutex) from <linux/cleanup.h>.
> > Scope-based resource management automatically releases the lock upon
> > exiting the lexical scope, which enables immediate error propagation
> > at call sites, removes the error_ret label, and simplifies the control
> > flow across all switch cases.
> > 
> > Tested:
> > - Compiled with W=1 on x86_64 with zero warnings.
> > - Verified with lockdep and debug mutexes enabled
> >   (CONFIG_PROVE_LOCKING=y, CONFIG_DEBUG_MUTEXES=y).
> > - Boot-tested full bzImage in QEMU with initcall_debug, confirming
> >   successful driver initialization (ad9832_driver_init returned 0)
> >   and zero lockdep warnings.
> > - Disassembly inspected via objdump to ensure mutex_unlock on all
> >   exit paths.
> > - Verified with scripts/checkpatch.pl (0 errors, 0 warnings).
> 
> The Tested: part goes under the ---, no need to preserve this info
> in the git log.

If it was tested on a real HW, the summary (like a couple of words only)
is still good to have in the commit message to leave a trail of the actual
HW that makes the change appear.

-- 
With Best Regards,
Andy Shevchenko


