Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081621;
	b=m19QaS35oukCEE1bHfidGQ0vw2zgiRrI5ilsvq1rFHRWS9d1A2t6JTeV/EZYJKsJ91mN
	 okcItbmgXPr4mo3d7iUz9BqylI9+95OsgXlBIEu1UDRayNQZOa3igOv+qIFRJqxky7PPY
	 fct0pwYA1XA4X/ZQAqm07c5TxK9GOJBbfHPpsLg2klCMmcf+xlEMq6/O7NpJx05ubscN5
	 4XzjYDTYAT4Hq1JH57TgQEYCDb5ARHKNhbS2gGWE8Stk3s4N165N6fjUjqpaUanF/vc/1
	 DVKEIotlwRei/WhzL1FL03WAIbwidy99FwTGZkDk04EjNEuRfdRXfMOdtmDBNhHEu+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081621;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=5c4uV7mvPRdsWqyoBIakiehhvZY9CAKKXw/b5wficVc=;
	b=5PjvH8VbWIXbU9Hn9F1HForDq55k8A3oKt9Ehg1Vb6KzoxmrKbfa0TNCp3MLlPNuGxq+
	 BpEhxtTTvr0M1DTOZVyHS4GAM5k+x2H7y0hV53n/E9lDjgrwSA9qByY4wiWzxoHy2jm+2
	 Mnadu4xaKPUf61LOZQI9Wb0C3a2OjxLVnv3AXyNu4UhXuEE08uAHIMbFcMDpELsvGgRGd
	 OKVOkX0naynwGQokIAu3oKAN0WEHI94oaRWo8qwzrzwPW5bYtVKwLTNie02Tm06f+9ehi
	 IzA0TgQoJbjwx+mo8rezXdeK+32AfOgRMfb2wcmuUwmVRU8/ctmmWarhGbiHj0vO5Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AHXUtA5r;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5AD606A325;
	Thu, 19 Nov 2026 09:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA5AD606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AHXUtA5r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795081621; x=1826617621;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7mHcXdZZKw6Z2DUpEns+BF30dNcEFZel6mJdIj+KfD4=;
  b=AHXUtA5riuZmzQ7EzsccQ1JfpK6BrYGcu7HA81X37AP5UoG3yV7puyzm
   Mg7C+r24bbm5pd+oQZxbd6E5YidYRd96WuP6FRMg3AZlxx1jsTr5xJ8Ia
   WWEJxs3dVS0fP53UM9adT4v4VDcqaTHXoLmIpu5ZXtnO5A2rH9E0tovhS
   rp0nueXHkoC6U925QvNkGkA9H3luJEEbV+G4oSFxljgvYyMkqyzv0R96g
   vVZzS1hT0FrGS87cyKqs42qBtTIt7FBRCADamCOd93w0jR8W7u9G5KmL2
   7RYpZNnvrmFD+SLn/t/2DQ+c4qHoc18g0YqBaxAvfYeKWhz3zvt4snMyq
   g==;
X-CSE-ConnectionGUID: gAMH61exTqCUp+stxLA0gA==
X-CSE-MsgGUID: nFbNXsYFRvOSDfm75wRB/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3815751"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3815751"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 01:47:00 -0800
X-CSE-ConnectionGUID: 0Yoidr2kTcS9B8FLlb9MbA==
X-CSE-MsgGUID: 5OZNs9egTZK+UsNWZUgqsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10383963"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 01:46:57 -0800
Date: Thu, 19 Nov 2026 11:46:55 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: bh1745: fix 16-bit register accesses
Message-ID: <av7Fj0N8hUJpVxkT@ashevche-desk.local>
References: <20261117110327.198084-1-kapoorarnav43@gmail.com>
 <avxi4BBJ_Ztg-aN7@ashevche-desk.local>
 <820865f9-2ef5-4316-abbe-5c44c7df55ce@gmail.com>
 <av2PPiin8mJiJD_q@ashevche-desk.local>
 <c1a68be0-36ed-4671-82a6-8aafb1855c4e@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1a68be0-36ed-4671-82a6-8aafb1855c4e@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 18, 2026 at 04:17:00PM +0200, Matti Vaittinen wrote:
> On 18/11/2026 13:42, Andy Shevchenko wrote:
> > On Wed, Nov 18, 2026 at 12:31:59PM +0200, Matti Vaittinen wrote:
> > > On 17/11/2026 16:21, Andy Shevchenko wrote:
> > > > + Cc: Matti (even he is not listed as maintainer) for possible another pair of
> > > > eyes and/or having an answer why this was missed at the time of the driver
> > > > submission (from my perspective this patch is correct).
> > > 
> > > Thanks for the heads-up Andy. Unfortunately, I have never worked with this
> > > IC, and I don't think we have it in the ROHM Finland office (but I'll check
> > > this just in case. It'd be nice to have this covered in my test setup).
> > > 
> > > What comes to missing this in reviews... Well, I suppose the reviewers are
> > > just humans, or if they're not, then they might have concentrated on other
> > > important things, like styling, instead of the real functionality.
> > > 
> > > On my own behalf, I was away for 1.5 months when the series was applied, and
> > > I only looked at the GTS-helpers usage when I did my shallow and badly
> > > belated review. (Furthermore, I am 100% human, so I might have just missed
> > > this even if I had all the time in the world to do the review).
> > 
> > Yeah, I don't know how ROHM is big, but in other companies usually there is
> > an internal mailing list is set for reviews. Maybe that helps?
> 
> I took a look to the Wikipedia. ROHM isn't that big. 2017 it has been around
> 21k
> people, and I have a feeling (no facts) that size is still about the same.
> 
> List might help, if we had more than 1 upstream Linux developers... :)

I see. Let's survive with the current tools!

> (I actually did request a list when I started at ROHM - and we had something
> for a couple of years. Unfortunately, I was the only one ever using that.
> After a company IT-change accidentally killed the list I never requested a
> new one. Still, even when we had the list, the bd1745 patches wouldn't
> probably have emerged to it. The get_maintainers.pl folks use to get
> relevant reviewers, wouldn't have known to add that list for a new driver
> with no 'rohm' -prefix.)

-- 
With Best Regards,
Andy Shevchenko


