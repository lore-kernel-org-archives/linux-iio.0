Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27BE26FD9A;
	Mon, 16 Mar 2026 19:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773690231; cv=none; b=hcA4Iw0onxN4UtwiXy0srHkKcDl6/k9LLnmj1GLlew7oL1m9jhufMjDyBrDdxZAQo76oVspiF6Q7BkpfdxVRxUBk+c0Tu10yRgRikiYpTda9E51hhWhgGjwXYaM3ZAYArWGyaQLgTjwGU5I7SPxX742I647eM8IcAY9JzamrjxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773690231; c=relaxed/simple;
	bh=9EOvQeWvAok3eHSz6mJOHYtoVWoIaUvkXMA7rxyyRk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiMy2IeHKtgpcSm1pYaJ6yCEa7Nu8As9bcudAw63N6IDeJukwG56cIPd3Ykdc91bXGyOLIKVvWL7to2BwPzyF5G+FhaUt/KFKPleGkP+AmBmFzN0EM1a4GcNQOReHlroidXHmvlfJHy0TZsycBOVCYw7/RO1fvLuo4O8gvcG8gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m46iRo6+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m46iRo6+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773690230; x=1805226230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9EOvQeWvAok3eHSz6mJOHYtoVWoIaUvkXMA7rxyyRk0=;
  b=m46iRo6+Vjvb+1K+F5CmMCQNtZVvtHIYnEUTrnJu8LBTpx0O1fr4pal7
   tLMiX9jS8Xi1qCwIMJUJUzkfGLseeE0XjhKBFLrLB6wWLLnQrA6mIEJBI
   xPJGg9V3E9tjG2T3RvMJ6IXnbx3lqLusnHVHbXwGVVJqrmkRbt0CX8wOW
   AhNHUD2VaJ5tZ2GjgbtB0N1UOeiFARtYpvzQHKRDxU66tOkBsT2Nb9dIA
   +XTQA+QVtB6c5wVJefBkyOr/rF9kohVAJ+lvHySo5KBUNRLRADyeWrGiu
   ZZHV+Gkyr8u5w58g503crgFwNsRR4pZbo2VseytLMH+tXSkIlXv9BsTU1
   w==;
X-CSE-ConnectionGUID: dYRLEM8KSqCMyqjolZRHtQ==
X-CSE-MsgGUID: /cNdsYV7TJ21HoR/EG10Zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="85343602"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="85343602"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 12:43:49 -0700
X-CSE-ConnectionGUID: ZDhO+ACNTGS2lSeiH/9IXQ==
X-CSE-MsgGUID: Y/PKa7MZR3aqF5nasT1Bqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="218234089"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 12:43:47 -0700
Date: Mon, 16 Mar 2026 21:43:45 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-iio@vger.kernel.org, Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: iio-mux: use flexible array member
Message-ID: <abhdcTpxDrXrTUqr@ashevche-desk.local>
References: <20260315224509.48111-1-rosenp@gmail.com>
 <abgQr6Ij_1Bpqb_R@ashevche-desk.local>
 <CAKxU2N-FopyQ51FVTWKzs7-u-MuEJVawxHX_t_iYBkpYMV4ezA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N-FopyQ51FVTWKzs7-u-MuEJVawxHX_t_iYBkpYMV4ezA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 16, 2026 at 11:11:22AM -0700, Rosen Penev wrote:
> On Mon, Mar 16, 2026 at 7:16 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Sun, Mar 15, 2026 at 03:45:09PM -0700, Rosen Penev wrote:

...

> > > -     sizeof_priv = sizeof(*mux);
> > > -     sizeof_priv += sizeof(*mux->child) * children;
> > > +     sizeof_priv = struct_size(mux, child, children);
> > >       sizeof_priv += sizeof(*mux->chan) * children;
> >
> > There are two arrays that are allocated at the end of the same object.
> > Why is mux better than the chan?
> It's how it's already laid out. mux first and then the other data.

It doesn't matter, right?

> > I rather would see two times array_size() than the above.

> OK

> > >       sizeof_priv += sizeof_ext_info;

-- 
With Best Regards,
Andy Shevchenko


