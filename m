Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEA53DBD71;
	Wed, 18 Mar 2026 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845388; cv=none; b=n/2DKRsgSdrCukugK3AWy9i+uHRFnbZDiryEdl8lPXvvmVaHztuayu1PnzfYaI9UEhx4Il1jYXfNQHLkk1IhHAI2cuJuhxj51CpAMX8y5fVJk6kb22fabmDEyCs95+MdsqKQbOtUhdX5sauVChZVr9EIeis1xr11FFQAlB8bG4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845388; c=relaxed/simple;
	bh=uEWPn5jGM5fD2pT2Y42/FRgelyycChFD/1jOXgQgjbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBX5Xx8suEqfC2V9fArAhZFzQodUx7gXW5YmuGUBJ85MuGHwD1iJLggm5c4Dec1cccnBjW1sKQfivFRCmZMBnL/4c01GPfD8Fpe5o4kXXjKGE5QNe72iFawk2n6Y4KMsMjW2kolBta2F6w0o2k2dSONduHQWffFOb41DO6vP4/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OY8CkSRX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OY8CkSRX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773845386; x=1805381386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uEWPn5jGM5fD2pT2Y42/FRgelyycChFD/1jOXgQgjbI=;
  b=OY8CkSRXp0/cFQutJmr3xr064M6r1tk8j8RJtQ7z83ackEVbFJs2nrHc
   3lqu/v5+eF3qjkze85j0zj0upNzoN6OH/Bs2MorrDtI0kOreq4xsuBtBC
   3fGQ6sKFZS5wDfYAxfds76E6pzS66y1WLzxTm+AFjMUeyz7SEHWGu1Z1w
   wfl2C5AxosH3M2PAAqva0tcJtkd/3LeoDSNfiK50y1Mgks/6ZFtVnPweK
   4yCKNa8mXnRyi+OMN8PU+MHKnA6NaF2kgaQVa9kYVEXG7DXo+jIkFqH0X
   fjkR+CZjpjdqVGhzHeHEhWlugEzeX3TpNK4NLKHXJWkOg4kqxEQNx9Ihp
   Q==;
X-CSE-ConnectionGUID: 8jvQnQOuSPmJ8P7TYZoUJA==
X-CSE-MsgGUID: njofDgT8TP6DlsDApEWY0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85600352"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85600352"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 07:49:45 -0700
X-CSE-ConnectionGUID: gHgxdoE1Q4KtOErVhtT/fQ==
X-CSE-MsgGUID: ZJGL+bEqRoSCy1RA9bDXdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="226783693"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.240])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 07:49:42 -0700
Date: Wed, 18 Mar 2026 16:49:39 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: ShiHao <i.shihao.999@gmail.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	mazziesaccount@gmail.com, nuno.sa@analog.com
Subject: Re: [PATCH v5 08/14] iio: resolver: fix typo from degredation to
 degradation
Message-ID: <abq7g-9GnQaFc_1K@ashevche-desk.local>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
 <20260316090023.14691-9-i.shihao.999@gmail.com>
 <abgt1yoYTnQEiAlk@ashevche-desk.local>
 <abguXZJjIXMdqcU5@ashevche-desk.local>
 <abqsaI6-hznIv7dO@fedora>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abqsaI6-hznIv7dO@fedora>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 18, 2026 at 07:15:12PM +0530, ShiHao wrote:
> On Mon, Mar 16, 2026 at 06:22:53PM +0200, Andy Shevchenko wrote:
> > On Mon, Mar 16, 2026 at 06:20:44PM +0200, Andy Shevchenko wrote:
> > > On Mon, Mar 16, 2026 at 02:30:16PM +0530, Shi Hao wrote:

...

> > > > 		/* Sine/cosine DOS overrange fault.*/
> > > 
> > > Side note: missing space after period. If this is a single issu in the entire
> > > folder, fix it here.
> > 
> > No need to resend just for this. Let Jonathan decide what to do with it.

^^^

> Just wanted to ask a quick question. Do i need to send it again?

Answer is in the above.

> Or is it going to be accepted?

I don't know. I'm not the maintainer of IIO.

-- 
With Best Regards,
Andy Shevchenko


