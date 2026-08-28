Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC522BE03C;
	Fri, 28 Aug 2026 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787914920; cv=none; b=uNrH17J1CIGedlZmS4USKBh/xGDm6CpDtDUnWXHDGcxjA8bK6Fp/ZP+C48siEg25rjfOUgM0riInSUZa6DkMpb+03GArujh23oa3NtXI6jEl1T7P/UiboO8pBOCxwIB3lu837EsK+YgJnKIpu8v79e1hbZsmzPRncDAc+/LlyrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787914920; c=relaxed/simple;
	bh=kfVFRkJOl4hr3UPH6L9mgcgVAqYIe9s+sXYvbOSaaE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ok2WO+1EgnV+ps+6W5295CFItPUPt0z7Do+SECggY92O9j/Vnje+ojOJx/31U44MOXJN2f5QluhVlT5hfTVGgYi6SWK6K/IGt/b9n7UkAaqeiOXdxiB1KI2JDqzXxHp9dX0zjAsINH2MyJ9p/qsCU1M87j4dv0/9J2oOR8vmNRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jacqH2nn; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jacqH2nn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787914918; x=1819450918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kfVFRkJOl4hr3UPH6L9mgcgVAqYIe9s+sXYvbOSaaE8=;
  b=jacqH2nnUyA0X5ma3Tgz2rKRCYe+Rnn3GBFUCWmvobrU9SV1QWnrNg5D
   GCCGTTmlQLCT56mvA9cLctBDDy58GWj9eJ9JOKc9Qf0u1B8EpsQGyWZM4
   FU5nS5i3W1kA+fI8hZc4l753a+VtHhk6MBOwwOp5dLoch3KLdTubhI88v
   ZNdUVmaG2UO3ot7BGkHxdEhrBpHJlQXKRW49rufIzbU+RpWb5iCNtmITE
   vzhGYnD4Cytw0j+5YBwt77PxnvgoijBFB9FzeufIk9uQ5QLYg3HK2bn8a
   dlUy13ddjGdCMJJgdAhaYsRezMwRJADubnBUpgkAEVl2Fyd80ntgSke98
   g==;
X-CSE-ConnectionGUID: fh90GXMVTVCrMg0rmrHZXA==
X-CSE-MsgGUID: uSQo/TNPSuGPSfueUJMtUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88447547"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="88447547"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 04:01:52 -0700
X-CSE-ConnectionGUID: qfDlHEAiS2CFU1XYg2Xxmw==
X-CSE-MsgGUID: 3newLZMSQ8ulAbIuXJbfkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="266318457"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.34])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 04:01:49 -0700
Date: Fri, 28 Aug 2026 14:01:46 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: light: rohm-bu27034: Fix infinite delay on
 error
Message-ID: <apFqmjGZKQ-qW7L7@ashevche-desk.local>
References: <cover.1787901813.git.mazziesaccount@gmail.com>
 <7f0d8efb3578cd4f23a7c70fa4a8f7a967c9df8e.1787901813.git.mazziesaccount@gmail.com>
 <apE-gauHWlJO8-5X@ashevche-desk.local>
 <5d274bfb-2570-4336-af16-60640550e6c9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d274bfb-2570-4336-af16-60640550e6c9@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 28, 2026 at 12:46:24PM +0300, Matti Vaittinen wrote:
> On 28/08/2026 10:53, Andy Shevchenko wrote:
> > On Fri, Aug 28, 2026 at 10:40:36AM +0300, Matti Vaittinen wrote:


...

> > >   	wait_ms = bu27034_get_int_time(data);
> > > +
> > > +	/*
> > > +	 * If reading the integration time fails, default to the minimum so we
> > > +	 * don't lose samples. This may waste CPU cycles, but as a hardening
> > > +	 * against theoretical, once-in-a-blue-moon error, this should be Ok.
> > > +	 */
> > > +	if (wait_ms < 0)
> > > +		wait_ms = BU27034_INT_TIME_US_MIN;
> > > +
> > >   	wait_ms /= 1000;
> > 
> > With the above being open coded the _ms feels not right.
> > I would expect the TIME_MIN to be in MS from the start
> > (and for the consistency's sake with the below) and having
> > all this to be written like
> > 
> > 	ret = bu27034_get_int_time(data);
> > 	if (ret < 0)
> > 		wait_ms = _MS_MIN;
> > 	else
> > 		wait_ms = ret / USEC_PER_MSEC;
> > 
> > >   	wait_ms -= BU27034_MEAS_WAIT_PREMATURE_MS;
> 
> I don't like using 'ret' there.
> 
> At first glance, the
> ret = bu27034_get_int_time(data);
> 
> looks like ret is containing just the success status. Furthermore,
> > 		wait_ms = ret / USEC_PER_MSEC;
> 
> forces one to go back and see WTF the 'ret' is (even if just couple of lines
> - but this is not an improvement, using ret is obfuscation).
> 
> I could change this to:

I suggested without knowing the possible ranges of the returned value.

> wait_ms = bu27034_get_int_time(data) / USEC_PER_MSEC;
> if (wait_ms < BU27034_INT_TIME_MIN_MS)
>                 wait_ms = BU27034_INT_TIME_MIN_MS;

This looks sane to me and  removes the confusion I was talking about.

> (but for me this feels like unnecessary bikeshedding than anything else.)
> 
> Well, I'll change this if I respin.

-- 
With Best Regards,
Andy Shevchenko


