Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC803955EC;
	Tue, 23 Jun 2026 19:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782244534; cv=none; b=bi3hgndWt6IPix57uurHOt+ECy+WM2gAgNU+EiUQ2Q271H+j0Eoq9JQqhfzsMilF5+2cvO+aYK5Ea09+guWDIh9uoBSxmTMwSAVFF91ZZs1s+cfi4xskxJtcjrUorgy21e/4E4eItw6tZHebY3KSVjAPG53aKGSUDijW0oISUs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782244534; c=relaxed/simple;
	bh=QTZiGZS7R721gQVW/QNAUhG8Ak6czgg68oZehd7P+rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swZdjfe8tdBvs2WJu726819qWrtAibVJt/PFVEXlo0XroY3fUZx8piqUZZCwLOx1NASzPF52B54bejZnRojL4M+tt/m9i8pCbgzM0M42+mCAFbUwzPZIRNtsZMda5KDlGaiNGUUW49ceO+UY+9N128+9CUVmrN4hGy3OBNnzmfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bRO6j/rs; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bRO6j/rs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782244534; x=1813780534;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QTZiGZS7R721gQVW/QNAUhG8Ak6czgg68oZehd7P+rg=;
  b=bRO6j/rsMRI4SLyzu7evp9abcTjVn3uVXhqPlkPCWRi5il+Kb9ewEq++
   6ARvcOg3aw1jf6RDAcMR/V9RNUMmM4teU7c0YdqJHUD/ZkZiGvTG5/lKq
   P2GONFYluXQzeZ9QBiX+XC1i5ZRXqSMK1eBYXo8dTyvWeQGH7NOwd4YRg
   83bi+wfS18b2uJwBdo4yrJYPF9sR7otupavAE9fXSHLPJ0g9DZfFRC4i9
   Wuh8pP//kWZ+UuyxISEdacaplADz4+LUJXLIo58YwwNKaZNcsgrvmxi/t
   jchzUwnNjQZZTVGP0qTMvKCzPJw5fBo5n6ywvCF1Dqvzvw4k38teHgI6a
   Q==;
X-CSE-ConnectionGUID: qkdgI7BrRyCr4qEEft31fQ==
X-CSE-MsgGUID: 3WZNpueQSE+UHPUSWaCN9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="86835216"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="86835216"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 12:55:33 -0700
X-CSE-ConnectionGUID: E7Liq5qsSqaXxqxlJXh2fg==
X-CSE-MsgGUID: DMscg9X6ShGsOF6j4WukCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="273303759"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 12:55:29 -0700
Date: Tue, 23 Jun 2026 22:55:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Prashant Rahul <prashantrahul23@gmail.com>, linux-iio@vger.kernel.org,
	Shuah Khan <shuahkhan@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: adc: ti-adc161s626: log buffer setup failure
 in probe
Message-ID: <ajrkrwlev-wETPJ6@ashevche-desk.local>
References: <20260620174708.111470-1-prashantrahul23@gmail.com>
 <20260620174708.111470-5-prashantrahul23@gmail.com>
 <20260623203636.69a7429a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623203636.69a7429a@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 23, 2026 at 08:36:36PM +0100, Jonathan Cameron wrote:
> On Sat, 20 Jun 2026 23:10:56 +0530
> Prashant Rahul <prashantrahul23@gmail.com> wrote:
> 
> > Errors are logged when enabling the regulator or adding the cleanup
> > action fails, but not when buffer setup fails. Log the error returned by
> > the buffer setup path as well.
> Why this particular one but not the devm_iio_device_register() below it?
> Both pretty much only fail on driver bugs.  Or out of memory for
> which dev_err_probe() doesn't print anything anyway (on basis that
> is normally pretty noisy).

For the record, I need to withdraw my tag as I haven't noticed that this series
just adds tons of dead code (based on -ENOMEM returned value).

-- 
With Best Regards,
Andy Shevchenko


