Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C08F36C0CF;
	Wed,  6 May 2026 07:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778052775; cv=none; b=BcmUsFWJ7MeqyhFUlr52UYAnybJ6h8u+QdumiBrIUPlgLxeDcIZ7rftLg0Fns+BztS7/s4FSfKTH9NuWCn9cJN/6ORhHZkVrfPvPVoVDWBBdHxRpt9yhCXLqQc2l+YBG8Gi5yiKwU4nLd9gZS6EZr5ybqgol+DJwJpM6FqGrNKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778052775; c=relaxed/simple;
	bh=OYuIHyZuFCm01aD+H29CBGD3pbcgWqAfgY5ezI86Fdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUfwXkour5JsKWzWXDQKFcvejtPW2J7GqM79Ncfmv+T6Bx+LNV76leVfjd1hI8PUFa6F+sGbfnyunKN+Dx2zugHraEwenj9E6hlLB2skviYyjLnVFvD/3LgC39s22+J8UPtj0YzO2axWwrWgImkhCKxv8p8kc0fBzgNx/Yzyy9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QBOrQSXL; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QBOrQSXL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778052774; x=1809588774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OYuIHyZuFCm01aD+H29CBGD3pbcgWqAfgY5ezI86Fdg=;
  b=QBOrQSXLltVSDRyZuV0hFV8QQxOR6LWXwWKMuNL7unMrKjcGycFxpjJA
   tIsnmMkVGBh70fdqDCNflzl7l0+YHQIydX8GDcncXZCfEt2k6+tgqclAG
   581wDUSmspmVmzTCpcPlU/gwRwLmE2SO7R6T0uPdkPwZrXR18eQ9GLFti
   KrWVV+YnytanE59AnoZAHmhX9X0QUXoguoS1wZzv4l2ngOpW83XhpmNxh
   nQbH+0Ux87fugtJx2kh4MOgbugUgRyiB4TmD20GMMNk6G/FVjIYnvW2+V
   Qh0yt0RzKG/tNOrpdwEJo7oQkS1Xj3D0K5D3h/+LyrpvEpPFPuJjYMJNf
   g==;
X-CSE-ConnectionGUID: VycC3ZFNRwK/AmwIFuiXnQ==
X-CSE-MsgGUID: iMyBTnGRQNS3Ppp7HpX9ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="89284008"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="89284008"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 00:32:54 -0700
X-CSE-ConnectionGUID: oTG9904AQ4GJluGAZA1e3w==
X-CSE-MsgGUID: QzxmcHvlTJKLOyapBNbmBA==
X-ExtLoop1: 1
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 00:32:51 -0700
Date: Wed, 6 May 2026 10:32:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/18] iio: magnetometer: ak8975: pass conversion
 timeouts as arguments
Message-ID: <afruoZ4Oq0Sz7QEA@ashevche-desk.local>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-6-831b9b5550fc@gmail.com>
 <afrg7uXqyKs9il1Z@ashevche-desk.local>
 <CALoEA-z+K8FzgwbYfi_aJ3oL6qi2TyXFDYKpmn1Mmjw8XApvNA@mail.gmail.com>
 <afrrzM67n7NQWdE3@ashevche-desk.local>
 <CALoEA-w88c3565-U49ic+FDG1mfpohWzMjZmTus+Nj037W0Sow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-w88c3565-U49ic+FDG1mfpohWzMjZmTus+Nj037W0Sow@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 06, 2026 at 09:28:06AM +0200, Joshua Crofts wrote:
> On Wed, 6 May 2026 at 09:20, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, May 06, 2026 at 09:02:15AM +0200, Joshua Crofts wrote:
> > > On Wed, 6 May 2026 at 08:34, Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Tue, May 05, 2026 at 01:46:02PM +0200, Joshua Crofts via B4 Relay wrote:

...

> > > Fair, probably a badly resolved merge conflict.
> >
> > Hmm... Usually what we use is interactive rebase. Very powerful tool!
> >
> >         `git rebase --rebase-merges --interactive $SHA`
> 
> I see, well I use `git rebase -i HEAD~no_of_commits_in_series`

Good that you are already onboard!

> and sometimes I move a different thing by accident.

Yeah, this is usually unrelated to the tools, human factor, you know :-)

> It does get a bit
> crowded with 18 patches (yours were fine but I also had to do some
> resolution after moving the order)
> 
> > where $SHA is the same one that you used as --base for the series.
> >
> > In conjunction with
> >
> >         `git reset HEAD~1; git commit -s --interactive -c ORIG_HEAD`
> >
> > technique, you can easily move parts between patches.
> >
> > (There are even more advanced techniques, but I'm an old-school guy.)
> 
> Good to know, thanks!

You're welcome!

-- 
With Best Regards,
Andy Shevchenko


