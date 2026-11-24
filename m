Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795518477;
	b=VlGcaMOkUNt02gXwSsUYkkJuzRWliX0d6Hp3mOwGtMfrkW0cqNQMP4EjaFp8/igLtK4y
	 f/35VNTfmVnUcGy35KerwDr9HZ1CU6lybbixvhKOPB/rZ9DC9UOKniP0IJQ3gYHyevnDk
	 8zbmRFg3DrwsHBvl86A6RdSDXV5eMoTNfZuGJmmUwnbhB4OflbJBWGcPYbezscNXchAeQ
	 zgXl9dhgZJ/3LabhJzWmBACx9nmN6nutyatZm2nLt1WiNnZbe8nxrpvqCz4K41WftYpiA
	 f3MkxoJRoDrmQcFfQ72DrPYG+9htxT4CQu+2J4AerGcjdjISYrpFyDwwhwMAxer4ItA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795518477;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=5NpROjfn9S19F+PP+SU4tu7Dh10hYCyLji15RDL3+e8=;
	b=W9GdzdRl4KLslUu1b8mS8fX70Fmpv5jib4mf9Xqi9NcPVhqXRL+Eic62f8HmDC9nMOMn
	 P0ohtiMHco42mqO1UbuODIn5Gz1yAhg+llEZ9kYUkbLAvlVXyQMBnx4XS9wF/vm0gGcaz
	 TyMsSqaFSk1pIisXXNkPkQky3tBsfgEBB3O1DIUC6BOosos5WHw7rWn1essK9HjFNuQIp
	 DXGJCLMzInH6FBLP668BT3LJZjovt4KQ6UzP64kqwfZgx6ZfvsO+diwAaZ0cA3A32iphu
	 qhJ3BnwOWmwwffBPrpTI0ri8bmtISZoRiHeaZBcee8DfBb1oD9DLouelga/tumbGzPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cFxOp516;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815D6606A31E;
	Tue, 24 Nov 2026 11:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 815D6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cFxOp516
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795518478; x=1827054478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uXO0MdgcqEofUAk5uNBXc+ZK1bEtIEm0MeHVCxyP08c=;
  b=cFxOp516v7CLgcfyTuA6UnEOPwiMbYrleTykjGfvuT5vB0j74hv2/ObP
   8UbQNYFbnfIml+wZv4gqJAWdjj0omVdYQqwsSWC8KSpvPZ7eNMgaLh8Nd
   NtJnEN+u0k6ZYUnF3IUBhc5BjlGcaHaVkJfA3DYzNfl7a+7fgr12HA/Xi
   8ok79a5fEXjEHmUdt3fdR+bhqelyvXsCWfqsLY+YCEYXrPZp2d7NIYFVI
   5Q+K8F/1cx+HJZuKXpLMXWZaEi+Cg+TcBYFciOMvC3GJNb6G/sa+rJOmV
   guaqKxWhwlR86x0lugUX/EUiyNGagwwCHGy0FBmVjEVOc5zwC7SG4bc3I
   w==;
X-CSE-ConnectionGUID: AnRpyvijQEymZZiz+L+VAA==
X-CSE-MsgGUID: hMZB8FoxRpmrq3EGn5lDlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4263552"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4263552"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 03:07:57 -0800
X-CSE-ConnectionGUID: UQ11Q+3oRjmI4ajNLNUSAg==
X-CSE-MsgGUID: Jf3P03WtTz2lDztrGH6FHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11870354"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 03:07:54 -0800
Date: Tue, 24 Nov 2026 13:07:52 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <crofts@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: Re: [PATCH v1 1/1] iio: core: Split debugfs routines
Message-ID: <awVwCFJjjrMoiWCB@ashevche-desk.local>
References: <20261124094502.557175-1-andriy.shevchenko@linux.intel.com>
 <09328c36-a32f-488b-a2c9-76fab784d259@kernel.org>
 <awVq-mE1H2g01yS4@ashevche-desk.local>
 <awVsI5KfsvEruJYG@ashevche-desk.local>
 <508193e9-0157-4ff6-8276-760463ec5e60@kernel.org>
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
In-Reply-To: <508193e9-0157-4ff6-8276-760463ec5e60@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 24, 2026 at 11:55:49AM +0100, Joshua Crofts wrote:
> On 24-Nov-26 11:51, Andy Shevchenko wrote:
> > On Tue, Nov 24, 2026 at 12:46:22PM +0200, Andy Shevchenko wrote:
> >> On Tue, Nov 24, 2026 at 11:17:01AM +0100, Joshua Crofts wrote:
> >> > On 24-Nov-26 10:44, Andy Shevchenko wrote:

...

> >> > > +#if defined(CONFIG_DEBUG_FS)
> >> > 
> >> > Veeery small nit, but why not #ifdef CONFIG_DEBUG_FS? It's not
> >> > as if you're checking for multiple defines.
> >> 
> >> Or even IS_ENABLED()?  Let me check if we have a precedent in IIO, I will use
> >> then the same or most used style.
> > 
> > FWIW, iio core uses exactly this form for DEBUG_FS test, so for the consistency
> > I leave it as it, and if required we can fix this later.
> > 
> > $ git grep -n '^#if.*DEBUG' -- drivers/iio/ include/linux/iio/
> > drivers/iio/gyro/adis16136.c:66:#ifdef CONFIG_DEBUG_FS
> > drivers/iio/humidity/dht11.c:87:#ifdef CONFIG_DYNAMIC_DEBUG
> > drivers/iio/humidity/dht11.c:235:#ifdef CONFIG_DYNAMIC_DEBUG
> > drivers/iio/iio_core.h:19:#if defined(CONFIG_DEBUG_FS)
> > drivers/iio/imu/adis.c:227:#ifdef CONFIG_DEBUG_FS
> > include/linux/iio/iio-opaque.h:73:#if defined(CONFIG_DEBUG_FS)
> > include/linux/iio/iio.h:1010:#if defined(CONFIG_DEBUG_FS)
> > include/linux/iio/imu/adis.h:573:#ifdef CONFIG_DEBUG_FS
> 
> Fair enough. It's just a style preference I guess, hence the very small nit.

Yep, and even if I also think about plain #ifdef the consistency would prevail
over the style.

-- 
With Best Regards,
Andy Shevchenko


