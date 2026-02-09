Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04847309DDC;
	Mon,  9 Feb 2026 10:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770633318; cv=none; b=WXsA1Hb+05FPvMMfC+I4Az2CkGknorKZ8nQfy3zMArv7Mkjn/c7gIUomE9oEX14HqHAhstLTtRwjYkPSR+cYG5A6GZKe42YgKOunAuS5MmLrRShUz5DzfIWLQh9gvATv2M9P1g7eJ7zZYzBSbg+q9WpIsKmgWoPT4WRWbfj0lto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770633318; c=relaxed/simple;
	bh=WvsfdJ+ue6Mtpy/LELCmBQXU1/dKfYVF5vU6urZbX4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVJTfZxa5Uo6cVq0h5fw7OYP4RW1fCqzfjYkDGaVYHIkIDVZmLrb7OgGyKK/Sjt+bIx3g/C+1U72WdqPkEqJTsRb8fv/w2nIa1G6aPWvu0tsF6rkOJjwykHRM/JOn0vv5WavFkI116lvUsecJ6CJo1h8fLwLskpQ/oC+lzpEyRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDBX0Zik; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDBX0Zik"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770633319; x=1802169319;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WvsfdJ+ue6Mtpy/LELCmBQXU1/dKfYVF5vU6urZbX4A=;
  b=SDBX0Zik7ny88QXRlUsX1iNA/siq8iN0Q4n8oO6CHG2TRtJCYI7t26f2
   1MDiMX2/2dBHM+jWsPZ/Lncb7UDVXElwaKwwO5GFljg8rAs74Ct5S/dEb
   lNgdgPzd3gsRZPMef7/JfK9LfY7Z8nM20MD2Pg74B6JW2QxzQ3ADtO6lA
   FySVUZvnSHj7XCMZ6gbRgCiwYpqLGtvvotKqVxIHwnTCzrIuRJ7SEQ/hq
   d8n0/mbU11XIHMyR25jx5tyZ14Lwbj0sbxygImvOZkmVmmY3Xi1aSsesc
   87rAQ2h8oVn4zmq5HNDpMsYRs8MmJVc/FfdH0OyxGY9sLouvd+sFz20/A
   w==;
X-CSE-ConnectionGUID: x+mDjdOFSk6NhWJ8AoMmKA==
X-CSE-MsgGUID: 8ZadD6itT1S4vLHj9CkJcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="89159771"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="89159771"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 02:35:18 -0800
X-CSE-ConnectionGUID: GMcjnr7ARamS7sjvi+yqgw==
X-CSE-MsgGUID: KgpDIGJgReKrvC44fCBsiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="234491363"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.128])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 02:35:15 -0800
Date: Mon, 9 Feb 2026 12:35:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/5] iio: adc: ad9467: check for backend capabilities
Message-ID: <aYm4YLcKzDnGGS9V@smile.fi.intel.com>
References: <20260205-b4-ad9467-optional-backend-v6-0-7ca20c40c59a@vaisala.com>
 <20260205-b4-ad9467-optional-backend-v6-5-7ca20c40c59a@vaisala.com>
 <aYTGkAf7Ue7goDnw@smile.fi.intel.com>
 <56254198-c45d-427b-bcfb-fa9c60f11e71@vaisala.com>
 <aYmdn4sHxxD1KK0k@smile.fi.intel.com>
 <c3f7ce0e-4661-4542-9ea0-168d28a483c8@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3f7ce0e-4661-4542-9ea0-168d28a483c8@vaisala.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 09, 2026 at 12:01:07PM +0200, Tomas Melin wrote:
> On 09/02/2026 10:41, Andy Shevchenko wrote:
> > On Mon, Feb 09, 2026 at 09:24:09AM +0200, Tomas Melin wrote:
> >> On 05/02/2026 18:34, Andy Shevchenko wrote:
> >>> On Thu, Feb 05, 2026 at 12:24:11PM +0000, Tomas Melin wrote:

...

> >>>> +		ret = devm_iio_backend_request_buffer(&spi->dev, st->back,
> >>>> +						      indio_dev);
> >>>
> >>> With
> >>>
> >>> 	struct device *dev = &spi->dev;
> >>>
> >>> at the top, this one becomes exactly a 80 character line.
> >>> And in general it will help cleaning up the rest afterwards.
> >>
> >> Given it seems it would still be 81 characters long I would like to
> >> leave this change as it also creates a bit of noise.
> > 
> > 		ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> > 
> > We have different arithmetics for sure, I have it 80.
> 
> Indeed this seems to be the case, different editors count this
> differently :D

It depends if your cursor is under the last character or after, and depending
on the meaning of the value: position of the cursor versus the line length
it may be off-by-one.

In VIM in the default mode it shows the position under the cursor and with
starting column number equal to 1 the line length is calculated as

	position of the cursor - 1 + 1

I believe I have in the bar the length of the line in bytes and columns
(these numbers are different due to tabs versus spaces)

> > "There are *two* problems in programming: naming, cache invalidation,
> >  and off-by-one error."

-- 
With Best Regards,
Andy Shevchenko


