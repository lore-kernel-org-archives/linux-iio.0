Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CEA3CA481;
	Wed,  4 Mar 2026 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633186; cv=none; b=Wzz4QNsSQnpTitgyh2HGSWn5Bmu5hOsZm1lwy5ruh10oKl/2KqCNWY3YNKst+O2WdrDr3JTnYzjqr0v3Ny4RJNtuQpphrQm2LB7GdJXiGhaEmbSJoj4BNksUsSevstkR43nNoxE8Q8RjIoxO3SRd4QHpZ1Uyk/b/yaCCAQwoQrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633186; c=relaxed/simple;
	bh=c/DrTetWTu2ye6OExrODNGH43MFgWWCcVbqrBQNQJDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPkVdbE9Z3N0rfvkdEwv+EyRIefdbM3r/dzm39y7VwxonUtkPOD8Rdo8pzYS8yDf0+uhyNvQa2DEQhIbCUA6qYtm0PHtjCbv0kWtZv8TULPiR1n5DqSNQi9wY9wouvwIvRpZ8KEeXa2ZaPb8L+iVnmimNONWEizGd11GIfIa/08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1nmZr9n; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1nmZr9n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772633186; x=1804169186;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c/DrTetWTu2ye6OExrODNGH43MFgWWCcVbqrBQNQJDg=;
  b=H1nmZr9nhtHIR9446+Q18dT6HHZBaDhcDcprtnVNjKl8W4IROP55o+Dl
   KMKjp05L2phwTqkn4ES/5q51/+Y7Z3HKxj7i/MXHpURukPq4depBe+rvT
   xQTqEHpsB8ynX+wofZQ4aT8lJr97NscO8HVv1CnY5CITHmZ1ur+VrC+fU
   2eLnT84ZhuuSqvksMR3cscjh+o294vte2FGAamjM596xIYPa1zg3eeBXW
   HZir2XQwWkdKfUBrR92wGz1WIscnwpxXmy1Gumb5r8U5Q70gn6JjvEKUx
   2r+MHcne5aZ9pE8EC3jlN7LL2Mf1Ql2S3tv90brytsD616ztRcwommxNN
   w==;
X-CSE-ConnectionGUID: pi/XJug5QYujLdOS7n826A==
X-CSE-MsgGUID: PEu76Sl1QwS3jnx7J9Oz9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="84782021"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="84782021"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 06:06:25 -0800
X-CSE-ConnectionGUID: x4zkOw8cQJquG13vWHB4jg==
X-CSE-MsgGUID: mFrNDdrJSR+MsTeC41Fo6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="256232892"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.127])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 06:06:22 -0800
Date: Wed, 4 Mar 2026 16:06:19 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: frequency: admv1013: fix NULL pointer
 dereference on str
Message-ID: <aag8W8b5koqF3XQl@ashevche-desk.local>
References: <20260303095228.7494-1-antoniu.miclaus@analog.com>
 <aabHFq2PZssgpK2G@ashevche-desk.local>
 <CY4PR03MB33997EEE3782905E1362AB279B7FA@CY4PR03MB3399.namprd03.prod.outlook.com>
 <aaboHofKArsITTqt@ashevche-desk.local>
 <CY4PR03MB33992767510003C39CA7E7959B7CA@CY4PR03MB3399.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR03MB33992767510003C39CA7E7959B7CA@CY4PR03MB3399.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 04, 2026 at 09:52:46AM +0000, Miclaus, Antoniu wrote:
> > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Sent: Tuesday, March 3, 2026 3:55 PM
> > On Tue, Mar 03, 2026 at 12:01:31PM +0000, Miclaus, Antoniu wrote:
> > > > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > > Sent: Tuesday, March 3, 2026 1:34 PM
> > > > On Tue, Mar 03, 2026 at 11:52:28AM +0200, Antoniu Miclaus wrote:

...

> > > > > +static const char * const admv1013_quad_se_modes[] = { "diff", "se-
> > pos",
> > > > "se-neg" };
> > > >
> > > > Taking into account the indices are not sequential, this may require another
> > > > enumerator.
> > > >
> > > > Ideally you need to list all possible modes and choose only supported by
> > > > assigning an empty string to unsupported ones.
> > > >
> > > > I haven't checked datasheet to understand why only 6, 9, 12 are in use.
> > > > Maybe they can be simply 1, 2, 3 with a formula like 3 + x * 3 ? Dunno.
> > > >
> > >
> > > static const char * const admv1013_input_modes[] = {
> > >        [ADMV1013_IQ_MODE] = "iq",
> > >        [ADMV1013_IF_MODE] = "if",
> > > };
> > >
> > > static const char * const admv1013_quad_se_modes[] = {
> > >        [ADMV1013_QUAD_SE_DIFF] = "diff",
> > >        [ADMV1013_QUAD_SE_POS] = "se-pos",
> > >        [ADMV1013_QUAD_SE_NEG] = "se-neg",
> > > };
> > >
> > > static const unsigned int admv1013_quad_se_regvals[] = {
> > >        [ADMV1013_QUAD_SE_DIFF] = ADMV1013_SE_MODE_DIFF,
> > >        [ADMV1013_QUAD_SE_POS] = ADMV1013_SE_MODE_POS,
> > >        [ADMV1013_QUAD_SE_NEG] = ADMV1013_SE_MODE_NEG,
> > > };
> > >
> > > Does this make sense?
> > 
> > Yes, if there is an explanation why we have 6,9,12 to begin with. Can
> > somebody
> > study the available datasheets and come up with the explanations?
> 
> There are the values accepted by the QUAD_SE_MODE bitfield.
> 
> https://www.analog.com/media/en/technical-documentation/data-sheets/admv1013.pdf
> Page 37 of 39, Table 15.  

Thanks!

So, looking at the code and the datasheet I think we need to do the following.

Apply the rule that each HW related enum has to be defined with explicit
value. But looking at the code, I think we need to do exactly the opposite,
id est treat all enums as Linux driver ones. With this

1. Drop values from the given enum

  enum {
        ADMV1013_SE_MODE_POS,
        ADMV1013_SE_MODE_NEG,
        ADMV1013_SE_MODE_DIFF,
  };

2. Use it directly as indices for string arrays.
3. Use plain numbers in the mapping switch when assigning the values in
the similar way like it's done for other registers in other functions,
exempli gratia quad filters.

This will make consistent code among different bitfields used in the driver
and makes easier to use string arrays without double enums, et cetera.

-- 
With Best Regards,
Andy Shevchenko


