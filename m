Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBDD41325F;
	Wed, 29 Apr 2026 18:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777487775; cv=none; b=mpBU2mhW+u5HD4JxCTEfj/9eUOxqnwxsAnnH67w6SbRpUMqpFEfXXwiwFewA8Y0EKhg4cPvdIqaq+GKVVQfuoJSRkScIrJpZfwT1+zNYgHmywSgSj+WNwfTyj8m5/wr0rmZDtizxWKY9y8AbZ61jc5iFmDowoObGTrKS3WGpB6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777487775; c=relaxed/simple;
	bh=zZrolC6IKbvIDlb+Lb5WPy+jjpwMTeYxMXWnoS5eB9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljMZqrxJHtiDDucvwUsEIeqKwgeijmac2Bm6+cHkUKUjRXWIu9n4QIiVSsQyCk5LZi9F4hYhcn2fCYajFxYhsjVJkMLJkwgoN4d+PM3vWzyFKCfclUp2X2nqKniqdx9ByZ2/PsqhSXLER/CVeVvQJPEfbDjQXZ6ahvlZEHwrgDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I+/cDJtp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I+/cDJtp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777487773; x=1809023773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zZrolC6IKbvIDlb+Lb5WPy+jjpwMTeYxMXWnoS5eB9s=;
  b=I+/cDJtp8y9jyEdHkWSDTNiibr6nkgvSgnHOCYDibwDkHTCQ+ewzLlVT
   9G/tFX0KiBCQHriozFu32O9FwJSgDyQotKPyA5mZ63X8lyRBDA3YwgvrB
   mEJbdXLs3XR24LXYAyd7hvHcbdV5JA6lA1lTVSDE4LYLVwt7YnjNuIZbM
   BhwfI/VwkWqkEDmfG/H6g3CaxS3c6TP/fopd00rumZ2L59+bkoM4be/FK
   qM6y6Ts8OVjh7LErrpx1mvVzrbI0IkaqnGOxQ3ap2Y8R7dicc700B4whe
   qKjwHWforGPhe9DLJLs0efNtla7CjMEKIxTeJfoUOCp5iVRXIP0U/M8DD
   A==;
X-CSE-ConnectionGUID: f6rYgAanTymgMSmpLRcNdw==
X-CSE-MsgGUID: sASV5ytiR/SJPFBMJt8M0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89889335"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="89889335"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:36:13 -0700
X-CSE-ConnectionGUID: 6A5aKknpSZ2GNyJPB9OfTA==
X-CSE-MsgGUID: BMPwEnJVT+6SzK5JNJuXMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="238320500"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:36:10 -0700
Date: Wed, 29 Apr 2026 21:36:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Jonathan Cameron <jic23@kernel.org>, Felix Gu <ustc.gu@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Arnaud Pouliquen <arnaud.pouliquen@st.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: hw-consumer: fix use-after-free in error
 path
Message-ID: <afJPlx697Yxgm015@ashevche-desk.local>
References: <20260428192636.58e4fc8b@jic23-huawei>
 <DC73DE77-89A2-4268-B07B-2CED5C1D7592@linux.dev>
 <afGs4jBXEMWDMFbE@ashevche-desk.local>
 <7ia4qznx1z3b.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ia4qznx1z3b.fsf@castle.c.googlers.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 05:00:08PM +0000, Roman Gushchin wrote:
> Andy Shevchenko <andriy.shevchenko@intel.com> writes:
> > On Tue, Apr 28, 2026 at 11:34:22AM -0700, Roman Gushchin wrote:
> >> > On Apr 28, 2026, at 11:26 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> >> > On Tue, 28 Apr 2026 18:59:28 +0300
> >> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

...

> >> >> I am also wondering should we put Reported-by with the reference to AI somehow?
> >> >> Jonathan, others, what are your opinions?
> >> > 
> >> > Would be nice to do so for these - things noticed whilst reviewing a patch
> >> > type reports.
> >> > 
> >> > Roman (+CC), any suggestions on how to do this?
> >> 
> >> I appreciate when people are recognizing Sashiko, but I don’t have any strong
> >> preference.  Many engineers are using it locally before sending patches
> >> upstream, so we’ll never know it anyway. But Reported-by/Assisted-by tags are
> >> appreciated when appropriate.
> >
> > The problem is what to put to Reported-by as an email. For example LKP bot or
> > syzbot have dedicated emails for that. What about Sashiko?
> 
> We have sashiko-bot@kernel.org !

Good to know, thanks.

> > P.S.
> > An offtopic, how can I be email notified on the reviews done by Sashiko against
> > my patches sent to Linux kernel project (mailing lists)? If you can add me
> > as andy@kernel.org, I appreciate that!
> 
> I don't have a personal opt-in at the moment,

Whenever it appears (I hope to see it rather sooner) put me first in the list
to be Cc'ed!

> it's configurable per
> mailing list. The current configuration is here:
> https://github.com/sashiko-dev/sashiko/blob/main/sashiko.dev/email_policy.toml
> 
> I generally rely on the consensus decision by corresponding maintainers.

Noted, thanks for clarification.

-- 
With Best Regards,
Andy Shevchenko


