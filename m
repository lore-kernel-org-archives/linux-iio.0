Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C10425BEF8;
	Mon, 16 Mar 2026 21:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773696263; cv=none; b=anttvysbzA5BkyIhaqsh81Ub5JQIa1NMDFuKOeo9IobVtl8rUejAMuskEBOidrDhNLhjzzRy9BK5xhQEhYXFvegOMdqgYJD/NaVJxPVs0zIiwPByQz9egJ0CgmG9L/koDoraMJ8gFXgLEPTDFmfr4vDxLfn7Ze2MfnUqFLguv7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773696263; c=relaxed/simple;
	bh=wDHgP/R1DcLqVXRYGBqxNShZ1t970m0AsSpKNzvquV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Whx3EXwGLXhMUaKRXrM2/pvzYaKnFB5XGbkuMQEehooOk+rHDgWK7ad2anT+KxTSHMjZEhxSyUDEdiOAWH/YW/GhSDCyDCq7BFQYxD3gsm+w2Hn7vvI39FfcZs7h0unLrMz4WOyYOVbpyzZ9fUgxznLNi+Egnu7hQDd4ONExYmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Td8NOLhy; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Td8NOLhy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773696262; x=1805232262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wDHgP/R1DcLqVXRYGBqxNShZ1t970m0AsSpKNzvquV0=;
  b=Td8NOLhyLCWjsscdWVYDWpFBK9YsXIXATTWhG04pkuq8+eUjo1HaqV1H
   2v3e8hAy6uGSdWAMd/qD02kFsG86eS7/5/4hufEq6DGgMB2rMG4eBgzGr
   Tfz9Misuz8QOcOkw74ZGfXLl4Owyzv3DAcqJPlZIjzuZTXx8kLoX342Uh
   VpD6z2TyLuKj0heHA9NDfY/16mCt7wEujwT/PxWNr4QZvOSNR6/Q4tzWe
   EmddsRBJ58XmR4Df87VBoOb73isE0ZNRSEDkGNpQjyGO81pMOTWgUiHxJ
   rcDFfEhRn+rpDH3IxZ9ISQ3yfPlPSieJLsf1hQJnATXubmbp7IrBzq+n8
   w==;
X-CSE-ConnectionGUID: oIGpbjdHSVCQ0ZhkBfmExg==
X-CSE-MsgGUID: UNENPo/LQLiAqE14wOZybQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="73904923"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="73904923"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 14:24:21 -0700
X-CSE-ConnectionGUID: B+c+LZA+RuCbFwILOexcBQ==
X-CSE-MsgGUID: EJO0iprOQ22LcAPJ58airg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="226496378"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 14:24:19 -0700
Date: Mon, 16 Mar 2026 23:24:17 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-iio@vger.kernel.org, Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: iio-mux: use flexible array member
Message-ID: <abh1AI4sjm15z1by@ashevche-desk.local>
References: <20260315224509.48111-1-rosenp@gmail.com>
 <abgQr6Ij_1Bpqb_R@ashevche-desk.local>
 <CAKxU2N-FopyQ51FVTWKzs7-u-MuEJVawxHX_t_iYBkpYMV4ezA@mail.gmail.com>
 <abhdcTpxDrXrTUqr@ashevche-desk.local>
 <CAKxU2N8xj_SX7W0KncyeJ7NeL+kuyfkQ5zzrTj9Dipt8rTJMjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N8xj_SX7W0KncyeJ7NeL+kuyfkQ5zzrTj9Dipt8rTJMjA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 16, 2026 at 02:12:35PM -0700, Rosen Penev wrote:
> On Mon, Mar 16, 2026 at 12:43 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Mon, Mar 16, 2026 at 11:11:22AM -0700, Rosen Penev wrote:
> > > On Mon, Mar 16, 2026 at 7:16 AM Andy Shevchenko
> > > <andriy.shevchenko@intel.com> wrote:
> > > > On Sun, Mar 15, 2026 at 03:45:09PM -0700, Rosen Penev wrote:

...

> > > > > -     sizeof_priv = sizeof(*mux);
> > > > > -     sizeof_priv += sizeof(*mux->child) * children;
> > > > > +     sizeof_priv = struct_size(mux, child, children);
> > > > >       sizeof_priv += sizeof(*mux->chan) * children;
> > > >
> > > > There are two arrays that are allocated at the end of the same object.
> > > > Why is mux better than the chan?
> > > It's how it's already laid out. mux first and then the other data.
> >
> > It doesn't matter, right?
> I can't really judge. This commit came from running
> 
> git grep \\\*\)\  | grep \ \+\ 1\)\;
> 
> which is the pre-C99 way of doing trailing allocations.
> 
> Shuffling this around would increase the patch size which I've been
> advised against doing elsewhere.

My point was to show that from the memory layout the mux first chan next and
vice versa have no differences. Hence the proposed patch actually changes the
status quo. What I suggested is to keep a status quo and use array_size()
instead.

	sizeof_priv = sizeof(mux);
	sizeof_priv += array_size(child);
	sizeof_priv += array_size(chan);

> > > > I rather would see two times array_size() than the above.
> >
> > > OK
> >
> > > > >       sizeof_priv += sizeof_ext_info;

-- 
With Best Regards,
Andy Shevchenko


