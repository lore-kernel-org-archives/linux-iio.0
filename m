Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46753D9055;
	Tue, 28 Apr 2026 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777369622; cv=none; b=qKqN5cWFU6rT5vpVKKRg+5+RpYk0pQcq1e+1XoMRMn+Qq7qKweItRKmTIW2fyLUyN6dOIF3Gkz0DfKYV42xRFhDHt2gy/zdX3IN8+zKK8YqhZgBfU/mxOJt1bi3bQuVMCNYzDV8P6EzC1CqdaIFpTMhSEWlFi/DUWYAGeoENjGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777369622; c=relaxed/simple;
	bh=zCSF+JQrZiN6b/tF1jGQMjXjbIDJcttItzfpAXQgtg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkENj1WYzu9UUU1AbfVO1Ah1aHvw1JhdddK+aKvkrjlHSgxnTdeumEsJBOnM/Le+anxSuwCBz8lYgUS2HIuLuLSC5Ez1hQVZSknsxuL+pukaonwWOltcApM87UI0YyLBgbbH833wOdU2TrsQExVAgxAhev0VdJsXlIMGOJWuP7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XWUS26YP; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWUS26YP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777369621; x=1808905621;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zCSF+JQrZiN6b/tF1jGQMjXjbIDJcttItzfpAXQgtg0=;
  b=XWUS26YP88Aor3jDodTLN1hJs6nEtFuiGlUbYl3gT0s/o3NK8X72mzJs
   56G/YZoXykdJYKOJuw6eNav6euZ54yGk3atETHY6xL3nfNMrIrBSN1008
   ab1VTut9Zq0EcMI1a3hESXbYN/sG6pEPAxZ1VxtxwErWTzYT5yKZsq8sv
   FlOwdeDtA9EIoOJUYchfseBy56h4vYhqOaAL/7r82rQxGDDITSrpZncv1
   jJrivuJ2bnb0w8foqVN6RE+eu8TvsVdxke2mDCgXAR6gJ1mloeeAp0aex
   nuBew7mVc+CF8cqVvnFcUSgT02xTVJrz/4Dz5H2Ug08XId9O3EJQ1ByKl
   A==;
X-CSE-ConnectionGUID: Dm316Rq6SVaPc/BS4BvMpQ==
X-CSE-MsgGUID: JG31WzjPThaC4e6MzRu+5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78384566"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78384566"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 02:47:00 -0700
X-CSE-ConnectionGUID: uSKIzJUQSZ+QNyAJ8tOUJw==
X-CSE-MsgGUID: 8oCAsIdIQnSYq5cUx2EW8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="230756852"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 02:46:58 -0700
Date: Tue, 28 Apr 2026 12:46:56 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v0 12/14] iio: magnetometer: ak8975: Unify messages with
 help of dev_err_probe()
Message-ID: <afCCEMmu07oRV-93@ashevche-desk.local>
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
 <20260427201412.3067235-13-andriy.shevchenko@linux.intel.com>
 <CALoEA-yjpDhTrP1Z-ZgSohjJBE8W+kBvTeeDHtcguvb4ReiV3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-yjpDhTrP1Z-ZgSohjJBE8W+kBvTeeDHtcguvb4ReiV3A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 28, 2026 at 11:21:29AM +0200, Joshua Crofts wrote:
> On Mon, 27 Apr 2026 at 22:14, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> > +       if (ret)
> > +               return dev_err_probe(dev, ret, "%s initialization fails\n", name);
> 
> Minor typo, better to have "initialization failed", but that was already
> in the original codebase.
> 
> > +       if (ret)
> > +               return dev_err_probe(dev, ret, "device register failed\n");
> 
> Same here, "failed to register device" would probably be better imo.

Hmm... Not sure about these. I would leave as is and do a separate change.
(In principle I agree that messages may be improved.)

-- 
With Best Regards,
Andy Shevchenko


