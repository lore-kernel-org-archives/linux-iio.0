Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCAC379EF5;
	Tue, 28 Apr 2026 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777359824; cv=none; b=O0ujIcpx7S08THjDWh7WJ4Iyh+mQCaAQYy7QGA8Mp3qexBRLKfAufhLqAEmFHV5VVyGIx2ffa+QAyRJq5OMLdeFQyU+Uxg7LMjMOTnIkkxvDfFqjrLCXwhxH8Ke7jNzfwFey56sTwBUdXARVKkMMmU5ktj4C87SCmkmo5t4mcxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777359824; c=relaxed/simple;
	bh=0e5M4yc3ess685BkE8ZzQE3e/UHaVHX93aWRiTbZf7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/sRqm4yUcMPQaDGJNXkUHEtwSYkZ72hyRy4IKxp81431tQf/mdwkj/iyNPOkPY167csxCRbmMWp7RSZmVEUsKfEDr5f8h2eQwQIEiV+sc1BAFOi68a+wMl1BQxS1TJWjJhL/y/6IWqKbpXzwr4orJLj3XaaxAAtRFnA38ObJmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mr3SK2iy; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mr3SK2iy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777359824; x=1808895824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0e5M4yc3ess685BkE8ZzQE3e/UHaVHX93aWRiTbZf7M=;
  b=mr3SK2iyz48NlZa8HCaE2Qg0uR/Xh9DCnDBc1ZtEigS/N70eHGe2JoCr
   OQt/8aJdBIqPW7fU8CaYbILwLid4lUzeBIgZeMWpJtqj1CpQknUEzysVL
   v2x2r/9Wd09mQXFZJpPJx661eKC3QJQCxFHzaJ3mgh6VglAg7xgps92YD
   +9xxzv6GBEjmPn974nuJpN5YvFFHLaXjbY7RbKHpCwR9QJEMqwQcpw5u8
   tlO2z66BaBbEYlk+kPyzO2uRFfIGfMkz61Aec6Jr9udtdNPNaERMus/pU
   O1lf7NqXDUzXWQutIwn2dv37jmuK87KoAf8DH59K+XHcV4LgqPFDwKFT8
   Q==;
X-CSE-ConnectionGUID: W1Yo4adjSKGyUFr69Gr2tQ==
X-CSE-MsgGUID: AZuyfLSJRLKYunHGfUHC7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="89346584"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="89346584"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:03:43 -0700
X-CSE-ConnectionGUID: +MnDoOurTHKlqO7mMNy0tA==
X-CSE-MsgGUID: 6mVg+Y40S3C+o1gAvDUW8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="230704571"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:03:41 -0700
Date: Tue, 28 Apr 2026 10:03:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v0 00/14] iio: magnetometer: ak8975: Additional changes
 to the driver
Message-ID: <afBbylL3Ygt9GEYy@ashevche-desk.local>
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
 <CALoEA-wCTEUA44ST5eg1EyHQTEop=wHn12NGddyqzPMa+EUZ1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-wCTEUA44ST5eg1EyHQTEop=wHn12NGddyqzPMa+EUZ1g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 28, 2026 at 08:37:22AM +0200, Joshua Crofts wrote:
> On Mon, 27 Apr 2026 at 22:14, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > This series is an attempt to make the driver less a rabbit hole.
> > It's a continuation of what Joshua Crofts started doing. Hence
> > it is based on his work and first three "patches" here are supposed
> > to be folded to his series accordingly.
> >
> > I have compile-tested them, but I haven't done full double check of
> > the correctness from functional point of view. Joshua, please do that
> > before incorporating into your series. Yes, my patches are assumed to
> > become the part of Joshua's whatever next version of the series, that's
> > why mine is marked as v0.
> >
> > Should not be taken directly by the maintainers, but any comments, review
> > are highly appreciated.
> 
> When you said a few changes, I didn't expect an 11-part series :). I'll go over
> them and am them to my branch. I might check out the guard()() and chip_info
> changes.

On top of that also one may consider to switching to use reset-gpio instead of
poking "reset" GPIO directly. But this sounds like too many for one go, let's
make this 17 patch series go (6 yours + 11 mine).

-- 
With Best Regards,
Andy Shevchenko


