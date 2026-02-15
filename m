Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D6412D21B;
	Sun, 15 Feb 2026 07:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771141996; cv=none; b=VfZpFHZ15qqJWrUrpKtq78zbT0KH3KfAzGJyE5J1mL9cnw8HcWupL8Re9uQ6aa55obyMIoyDXNQolSVwcOsIi+iqIb/rPuYChNcuti8G4NBO89GexenE2FUK6Q+tzb3O/Xs7M8rEGw6Azd1ZLo90yQ1z0Rj13My0wm6RQXL8EPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771141996; c=relaxed/simple;
	bh=u9+5t7rFUh67WO7LM7lgmWmrXkCdaBG6O28GUABH9YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngWIf1tgJt1QSqQyQ6b4pa5a79NpVuJ+5CJJL7UXHh7caVLNZ4hQ8SXlOfmmA8IYfOOeoM5DCGKJy6JUedm8wkFlOhFwgqnuREsDzZ0VXGZfO+g2JIefRZRmE4ym89cJMxbczZ5kP4UMwcH0U9WW/RRWwYH3tdVtWNA7l3l0VDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dU0ijf0o; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dU0ijf0o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771141994; x=1802677994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u9+5t7rFUh67WO7LM7lgmWmrXkCdaBG6O28GUABH9YI=;
  b=dU0ijf0oli48qw2wpnScfoKq1NwiwVh843GtnblbGj/mwlG8yNkKlH7a
   8EPd5Wc0eA/PDPJMIKxvGQLM/sBnOwzFbGgQkqoKN4qcTDZzo61JVZj8u
   i19BzJ8sT+/Df7C5NUqd/L4mp1KymIrgJqRZHAyJtcGow1f90wX2f3OSD
   7cgTJumtc5xZJR0MN25xqB7YtBvcsu5eaxNiAFrJ50CMkesrCj4Z49/Hz
   61sCZjhwS2kZIEPjgTBYuj40MfFpXhPVDS5REUxU6rijCVNdPPE9MS1FT
   wu+uEJSbBePXCE/ESp0dXanKVxwyTwXp2Dh+UhIuXRlK+6C1EG+NTd2hw
   g==;
X-CSE-ConnectionGUID: CIzscInoTTqq8sFTqxo6Tg==
X-CSE-MsgGUID: iudEyVpWS+6hpRinKiYieQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11701"; a="82896081"
X-IronPort-AV: E=Sophos;i="6.21,292,1763452800"; 
   d="scan'208";a="82896081"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 23:53:13 -0800
X-CSE-ConnectionGUID: sAZgT6SkR0qs7T4ohTvJOw==
X-CSE-MsgGUID: 2QHTGpHqRXuRwB9lPosiYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,292,1763452800"; 
   d="scan'208";a="218281351"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.136])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 23:53:11 -0800
Date: Sun, 15 Feb 2026 09:53:08 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: max5522: use
 devm_regulator_get_enable_read_voltage()
Message-ID: <aZF7ZCA2wQeD7iCs@smile.fi.intel.com>
References: <20260210175137.44178-1-antoniu.miclaus@analog.com>
 <aYuIftCDo5O0IF9F@smile.fi.intel.com>
 <20260214182052.14c6f8ee@jic23-huawei>
 <aZC_ab454PTqFPsO@smile.fi.intel.com>
 <ea759fc8-6664-4838-872b-c393424e4cf4@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea759fc8-6664-4838-872b-c393424e4cf4@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Feb 14, 2026 at 12:36:12PM -0600, David Lechner wrote:
> On 2/14/26 12:31 PM, Andy Shevchenko wrote:
> > On Sat, Feb 14, 2026 at 06:20:52PM +0000, Jonathan Cameron wrote:
> >> On Tue, 10 Feb 2026 21:35:26 +0200
> >> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >>> On Tue, Feb 10, 2026 at 07:51:27PM +0200, Antoniu Miclaus wrote:

...

> >>>> +	state->vref_mv = ret / 1000;  
> >>>
> >>> "1000" --> "(MICRO / MILLI)" ?
> >>> (yes, this way with the parentheses).
> >>
> >> I know I've argued against proliferation of the X_PER_Y macros
> >> but this one does seem to be very common. Maybe it's time to bring in
> >>
> >> MICROVOLTS_PER_MILLIVOLT even if it's longer than the open coded version?
> >>
> >> Andy, what do you think?  I do worry that people will see it as fine
> >> to add many many others if we start with this one though. So maybe not.
> > 
> > IIRC (sorry, if I am wrong) it was you who objected in the first place
> > and I proposed that from day 1 discussing the "(MICRO / MILLI)" approach
> > a year (?) or so ago. Answering to the Q: I am in favour of having that
> > definition.
> > 
> >> Anyhow, doesn't need to be in this series.
> > 
> > True.
> 
> How about MICRO_PER_MILLI? Then we won't have to add a new one
> for every different type of unit.

Dunno, as a physicist, I prefer the way with units.

-- 
With Best Regards,
Andy Shevchenko


