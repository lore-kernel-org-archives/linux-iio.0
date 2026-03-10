Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6EF38A71E;
	Tue, 10 Mar 2026 11:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142180; cv=none; b=CWdO1NIP0H8saLsc1J70esIlz/vHBjGpYgy0m0YPHrJXb9SJAARXFfpVdZgDN2vg434/42Z0oijCJPhcXqhNNhxe4Gq0pcVi+EJmZnm4EaWU5XGbFF5kVDt9LLOXAFaCsAXvtfEoN5x9fwXJVawow0Y37dbTXtedTKsrdFqcHGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142180; c=relaxed/simple;
	bh=xSl0s2zz+wo+86PP+k37aIc2ft2S7nYDHzhdwHaCql4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foswg3FA+O5ndIr8Ty/WrFl8EOEKjMV3oFTJTNZIYqZwLzqeOAQ+VkmAnXXSPOQlC8pB1OpVgg790yaVNcPDk2L+blWM8ZFK13QIkbMptrqR585+j9e0+qzNKHmH19fTiiL5amYDyGnAuKKlPjOH9pRioDV56jrJzI3dZp0Bx78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ceN8YLsS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ceN8YLsS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773142179; x=1804678179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xSl0s2zz+wo+86PP+k37aIc2ft2S7nYDHzhdwHaCql4=;
  b=ceN8YLsSKwQRbLohp2wXFzs3DWpm1iHFXD2PWF7buyTWSKbWyDlSQDxZ
   A8ZMdiEVEJuKlkgC/XjkUVUZsa/gaCrBpJxiacs4XRtTdZ7QMzEvL0NMi
   xZ8VuwHBoG12WNhJupcWmcfdbwI4+OlXfTZ5ih4U17Q2iEJTvnBi7IFKU
   rE3rLoMKdw1SwMLCK1F2KTbWoyC1QPfaGhmKRjPi3R7hHuBB++3AVoE7w
   38xMgWkD6a9lrqPQHiockaU55iiKHj7/Q/CsbAjw52Y8tBJcW31/6DWRt
   eAxtB6tNV7WPogZNneheFJ+BQ1v2mRV2vhyXK3MEmcWQN/jTV9EGHJfJ6
   g==;
X-CSE-ConnectionGUID: aa0dcxJETcWO3KScpGG5ew==
X-CSE-MsgGUID: hhT6WMjcQsKAu1DMthVbcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="73885099"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="73885099"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 04:29:39 -0700
X-CSE-ConnectionGUID: 9TiaZRgwTEe5FUQa9byevg==
X-CSE-MsgGUID: 6jslkUWMQsmiKmqKdWFrmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="250561422"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 04:29:36 -0700
Date: Tue, 10 Mar 2026 13:29:32 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Michael Harris <michaelharriscode@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] staging: iio: adt7316: remove shift/offset macros
Message-ID: <abAAnF2AUh5tjrYB@ashevche-desk.local>
References: <20260305-adt7316-correct-macros-v2-0-3702e3841c42@gmail.com>
 <20260305-adt7316-correct-macros-v2-2-3702e3841c42@gmail.com>
 <aarqg9NBUYpkFKDW@ashevche-desk.local>
 <CAHXWO3TSiWeVBU-KorRFu8t0SEc-im-xJHwZ1c=Q42OTP+TmOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHXWO3TSiWeVBU-KorRFu8t0SEc-im-xJHwZ1c=Q42OTP+TmOQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 09, 2026 at 06:32:36PM -0700, Michael Harris wrote:
> On 3/6/26 6:53 AM, Andy Shevchenko wrote:

...

> >>  #include <linux/i2c.h>
> >>  #include <linux/rtc.h>
> >>  #include <linux/module.h>
> >> +#include <linux/bitfield.h>
> >
> > Try to squeeze it to make a longest (but sparse AFAICS) ordered list of
> > inclusions. With given context
> >
> >   #include <linux/bitfield.h>
> >   #include <linux/i2c.h>
> >   #include <linux/rtc.h>
> >   #include <linux/module.h>
> >
> > gives 3 out of 4 in order.
> 
> Placing it there would put it right below slab.h, sysfs.h, and list.h.
> The includes as a whole are fairly messy and unorganized and I don't
> think there's a clean area where I could insert it. Fully reordering it
> would be out of scope for this patch series. If you prefer, I can put it
> at the top of the includes since it would be the highest alphabetically.

As I pointed out "with the given context", meaning that you might find better
place. The idea is to have the longest ordered chain even if it's interrupted
by some unordered items.

...

> >> -            data = msb << ADT7316_T_VALUE_FLOAT_OFFSET;
> >> +            data = FIELD_PREP(ADT7316_AD_MSB_MASK, msb);
> >>              data |= lsb & ADT7316_LSB_IN_TEMP_MASK;
> >
> > Ditto and so on...
> 
> The main purpose of this patch was to delete the offset/shift macros,
> so I only applied the bitfield macros to areas that were using those
> offsets or shifts. I left that existing bitwise operation there because
> it wasn't affected by the offsets or shifts. If you'd prefer, I can
> update it in this case for the sake of symmetry.

The idea is to be consistent. If we change to bitfield,h somewhere else,
it probably better to cover the whole driver at the same time.

-- 
With Best Regards,
Andy Shevchenko


