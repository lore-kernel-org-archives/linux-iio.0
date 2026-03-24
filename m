Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F37C393DD1;
	Tue, 24 Mar 2026 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774350299; cv=none; b=Pz183vKRx/cpNyHXgvizvHhqx2EZeKF5sa/yh/coW4RFXh6Ly4dGxF0RwQuR/mbGBytg+Ai9xa3ov9ZezFP672+arVR/TgR16QQM7D0ZLumwAhrCcsLkh1H/Px3u9gZz55ccaWaZnt8/UAC/1vovJxNT0pzITs7tEHLgTg1Z3OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774350299; c=relaxed/simple;
	bh=7fgL+jbl1yX77Nmgi06PFmHDTr5zkExshmudbUrXM9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eW61kGvoMQFkLObP6aHg0wZ6qQx2IKoYD8INrYH2tvspil4o3vc7vszYZ5y7MNlzvhIiGZLX2wXfcrl42yOxvg8zW9FYCDqy+ut/xxhLv8GqY0BDllBEZaGW22n0slmNCG8UgdUKPbH/ny01yTBgsz4BkPvXEVWec0TsSJD0R6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AzoYtKsT; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AzoYtKsT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774350299; x=1805886299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7fgL+jbl1yX77Nmgi06PFmHDTr5zkExshmudbUrXM9Q=;
  b=AzoYtKsTG9RmC34h8SmAZzJFMkLmoBgbwm0tOVxQvNIfokmXrNTdyzbV
   l+DyhPrfVwIQh6mSmaLx9FGG0g4Nr6rg+msUSTzbIFrznsyoSplYMbddP
   thdZSa/xGxDJtGJhlrT9twzCVzlT70s2WLAkelIP9ZEi9ZzN7oLOa4By5
   XbfoA4AhQcBVIoNt+deHnlc/t2L+yPxjM+3bkcCH9mpXUQ8JEv5a381YS
   bXkUAvhbByEGRw72z3LWEfYvVLHLvHgzoEY+BGIhBwt1l0xQXqh8tZ9nb
   xoW7r46QpJNv/9j304HCseaYKGNmEJSK5rAIG5oIHenPjwAiQs4hpy+bQ
   w==;
X-CSE-ConnectionGUID: 2KhPGfSFTomZWprY2ilnBQ==
X-CSE-MsgGUID: 2FmmEA6tQV+aI4g6PsH/zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75242079"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75242079"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 04:04:58 -0700
X-CSE-ConnectionGUID: mtn3E9MkSBGQ1UeLE2fXcg==
X-CSE-MsgGUID: QrU9g7V0TNySo/M9fgS6rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="228379651"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.214])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 04:04:56 -0700
Date: Tue, 24 Mar 2026 13:04:53 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v8 2/6] iio: Replace 'sign' field with union in struct
 iio_scan_type
Message-ID: <acJv1RNLugS0aat9@ashevche-desk.local>
References: <20260317150316.3878107-1-flavra@baylibre.com>
 <20260317150401.3878294-1-flavra@baylibre.com>
 <4723284d-1e18-4a13-9ec1-878220af257e@baylibre.com>
 <af2128c68d2a14e1eb664ce9dc075ed02b640407.camel@baylibre.com>
 <acFvHgTo-3cxH_UP@ashevche-desk.local>
 <5c780b1be8a64f7862a421db5a1f5be861cb197c.camel@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c780b1be8a64f7862a421db5a1f5be861cb197c.camel@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 23, 2026 at 06:37:38PM +0100, Francesco Lavra wrote:
> On Mon, 2026-03-23 at 18:49 +0200, Andy Shevchenko wrote:
> > On Mon, Mar 23, 2026 at 05:04:10PM +0100, Francesco Lavra wrote:
> > > On Sat, 2026-03-21 at 12:22 -0500, David Lechner wrote:
> > > > On 3/17/26 10:04 AM, Francesco Lavra wrote:

...

> > > > > + * @IIO_SCAN_FORMAT_SIGNED_INT: Signed integer (two's complement).
> > > > > + * @IIO_SCAN_FORMAT_UNSIGNED_INT: Unsigned integer.
> > 
> > > > We could make this proper kernel doc format with one comment per
> > > > macro.
> > > 
> > > Actually, a set of related #defines can be documented with a single
> > > comment. I see a few examples doing that in include/linux/gfp_types.h
> > > and
> > > include/linux/fpga/fpga-mgr.h
> > > 
> > > > > +#define IIO_SCAN_FORMAT_SIGNED_INT     's'
> > > > > +#define IIO_SCAN_FORMAT_UNSIGNED_INT   'u'
> > 
> > ...or use enum
> > 
> > /**
> >  * ...kernel-doc for enum...
> >  */
> > enum {
> >         IIO_SCAN_FORMAT_SIGNED_INT = 's',
> >         IIO_SCAN_FORMAT_UNSIGNED_INT = 'u',
> > };
> 
> There is no standard kernel-doc format for anonymous enums.

What do you mean? We have such in kernel, for example,
drivers/pinctrl/intel/pinctrl-intel.c.

-- 
With Best Regards,
Andy Shevchenko


