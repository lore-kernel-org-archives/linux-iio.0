Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E201389118;
	Tue, 12 May 2026 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778597088; cv=none; b=UD/cmGSi/I6CrwVNmHnqNkNO6MALYS8dyyAAs/Qn0Z0TWXd9UEGOrDKCeySIF2/xhy+h7GyX5mSAqzuHNA6fjflPSPwQD2WSng1FGr6CwlvlvTiE6XWdFfupUNjsYu1syuQVN2TeRUiigrv2VzPjIVb6Yq+IbAxACVlF0LdQVrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778597088; c=relaxed/simple;
	bh=Uvtx33gVsoII9dmOYcnu/6OqaozcAFiDG6/Jts9qnYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBV/7f69w7hB33tEMSqF/PVPLUKgv8yqobfIO9YIq9we69FxPvpcniZ1Z/dBJKQcKXbXsMQ2B4ITXYZwLcaw7yHfkmpqmMnkaUu3miCZ8XM0T0xZ6N5YJAL4edxQyVqe+fRTAgIw+xSIsLrijhys7XLyd9yIUbAV8vKawaQp+HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hm2ARjLy; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hm2ARjLy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778597087; x=1810133087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Uvtx33gVsoII9dmOYcnu/6OqaozcAFiDG6/Jts9qnYU=;
  b=Hm2ARjLyFz9u98jGIlcqHdXeiDZSZJtf8Y66LZ348jqsbXWNlTvllA5b
   vdrdUom33mAmRnv61L/iZ20nyywaqjK+xmWC1kkO1ZDQ8yLfXX1fOzsf7
   cwLz6qK4bGv5Ni2EoVPjtVwNj18ibx/3FMbR2UVlhWp64Dndk19F8z7gm
   mjo8ns8HXCQjBvJCMFHAdlV30ynak3Ip5WtYdnTsBySxcIX+ldjV2Q7uO
   K7RKJl9vf1UUDKg4cqjhz+EpgN4XqMsEvP99vhq0T4fJt8Cd3HduTZ27C
   0dekLJSXRTdVbYXCkBFvV+BoRm3miHZVGe2MSIHDNGZuuxSwMdbonAiMw
   A==;
X-CSE-ConnectionGUID: R2cq2taPTRmZK6t8678XXQ==
X-CSE-MsgGUID: niKAjb5cR/aaVcgsAdpS4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79527351"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="79527351"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 07:44:47 -0700
X-CSE-ConnectionGUID: t/M+o4PeSbu2mJwAZ4K0MQ==
X-CSE-MsgGUID: XCqjoh+cQiinnlXLZQfKnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="234723680"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 07:44:44 -0700
Date: Tue, 12 May 2026 17:44:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/8] iio: magnetometer: ak8975: driver cleanup
Message-ID: <agM82tuZGvfKlSdI@ashevche-desk.local>
References: <20260511-magnetometer-fixes-post-pickup-v7-0-9d910faa28b6@gmail.com>
 <agLu6wF3JhF9zZDN@ashevche-desk.local>
 <CALoEA-y-bLur7tBnj61hXSnOdbJkco3zyAH8v_-y8+VFfVyEgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-y-bLur7tBnj61hXSnOdbJkco3zyAH8v_-y8+VFfVyEgw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 11:16:17AM +0200, Joshua Crofts wrote:
> On Tue, 12 May 2026 at 11:12, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, May 11, 2026 at 01:26:09PM +0200, Joshua Crofts via B4 Relay wrote:
> > > This series is a continuation of the previous ak8975 driver cleanup
> > > effort, as most of the patches were picked.
> > >
> > > Changes include:
> > > - using BIT() and GENMASK() macros
> > > - moving to devm_* resource management
> > > - adding a scan index enum
> > > - moving from using wait loops to iopoll functions
> > > - various code style changes
> >
> > Thanks for doing this!
> >
> > Jonathan, the same Q I had in previous version round, can we get some patches
> > applied to reduce the burden of the series? (I think of 1, 2, 7, 8 and might be
> > more.) As for the series, I think if this version is still not good enough
> > (patch 3) we need to rearrange it so that patch is going to the end (as much as
> > possible) of the series, so we want delay the 'good' ones to be applied.
> 
> IMO all patches excluding the shared resource management patch are good
> to go. I can send a new version reordered to reduce the headache.

Let's wait for Jonathan. Whatever he prefers.

-- 
With Best Regards,
Andy Shevchenko


