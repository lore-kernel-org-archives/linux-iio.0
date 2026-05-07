Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97190309DAF;
	Thu,  7 May 2026 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778148601; cv=none; b=B8STOq0Cr0IOEU4XWFf90SxrOJkK77NQ9FqBWchOc1MDi+2q1jD+aSKIkKp76ehu0ix1MZbhRsM3sLfCFCFx9efyobu+jRES59CVKD4s8fuzbUIPDYGctXHdzSjfWqANisH3mm7DGGq7VBtmDKs1Y7UbFAblbHAR9HzWE6odh9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778148601; c=relaxed/simple;
	bh=0HV2+1ZdYgv5XEGOVe+MqzPe0Q5Qjfd72BXoLDZ5rq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQ9GHEEFj2wulK96OieYxgGcL/3zvBTx4lHob2sH9m9Km3GYotJ9IRnIdVb34ENGSf/quqojkuzfCAwrBrGVE4WeVqxphOtKJ9OWbqY1YkYnxypasUdate/td7nAVUGSIrWns9qFx3FMPKpBBln/dyfxiHXyzh9VwAQwjA4xrSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SZZ7zXzu; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SZZ7zXzu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778148597; x=1809684597;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0HV2+1ZdYgv5XEGOVe+MqzPe0Q5Qjfd72BXoLDZ5rq8=;
  b=SZZ7zXzuOHJny/D4rkLIhTkn2mFwCaszpGYBf2LvlQfOTqp45fvkFl9O
   wc3ZHtCx1OoJk2McY0DejlqC4HHeZl5wu4lttzpDo1lDJTPaxYPoK5WH5
   E5udFDQRl2Fo+SkfpCDonbYbj1y9X8rW3tQ7k1ewKNkt920choaYXl7m5
   7LBo5sapt60FrHkfcfQ+ys2gfvt5+mcS2crSJuf+VwDziTjBCB9UormmW
   06DnjqgY4WWXIhEltyaNBXo8iFGhbOR79g9bi0N/VP5HPk9APBYgHUPVr
   BRiqMh0dAIoWUTDfwkNNAd0FTy4jWiXz+aBbTkzSyB0eUZrXzoyt7l/C7
   w==;
X-CSE-ConnectionGUID: AkdoFzstQea5KLn5/OUgCQ==
X-CSE-MsgGUID: 6GX3oqwcTrG25nZHKsuZwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="89403223"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="89403223"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 03:09:54 -0700
X-CSE-ConnectionGUID: hjmYlepuSPiSH2+T4mmdbQ==
X-CSE-MsgGUID: uHyexHEKSe68TgjLsn7SRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="238218939"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.149])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 03:09:52 -0700
Date: Thu, 7 May 2026 13:09:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 14/18] iio: magnetometer: ak8975: switch to using
 managed resources
Message-ID: <afxk7mDvc_-IHVDy@ashevche-desk.local>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-14-831b9b5550fc@gmail.com>
 <20260506180925.3fb80edf@jic23-huawei>
 <CALoEA-x0baxV+9-rsN9omJ9GnLw3zp2qmU08RjzWniPOU+uxKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-x0baxV+9-rsN9omJ9GnLw3zp2qmU08RjzWniPOU+uxKw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 07, 2026 at 11:19:32AM +0200, Joshua Crofts wrote:
> On Wed, 6 May 2026 at 19:09, Jonathan Cameron <jic23@kernel.org> wrote:
> > On Tue, 05 May 2026 13:46:10 +0200
> > Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

...

> I'd just add pm_runtime_mark_last_busy() and pm_request_autosuspend() here
> to make the device suspend.

pm_runtime_put_autosuspend() is exactly doing that in one call. That's what
documentation says about, and that's correct, however it might be not so clear.

> Perhaps unrelated, however I found an issue with the pm_runtime documentation,
> as it incorrectly says that pm_runtime_mark_last_busy() is always called with an
> autosuspend function (which is not the case, looking at the definition).
> 
> "Drivers may also continue to use the non-autosuspend helper
> functions; they will
> behave normally, which means sometimes taking the autosuspend delay into
> account (see pm_runtime_idle). The autosuspend variants of the
> functions also call
> pm_runtime_mark_last_busy()."

-- 
With Best Regards,
Andy Shevchenko


