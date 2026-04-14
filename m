Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D9C397E9D;
	Tue, 14 Apr 2026 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159076; cv=none; b=IlQ+fhfq5sGCM/9DZElDciCGQc6YquDe0xkaGqw6bgN5u6hRfhMGdnBP6YoXaQWRcoN4ERMyEsxvhC/H5nOYI0Wmf/sKL+M/MeMp6702MWmpmGRKv7IoqbJBph+hwoUBJDZedkHDbztWcINSx/OfkOmSlr5yEto7MG/h896Y0jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159076; c=relaxed/simple;
	bh=abl20JDx6bagNJSy1bhe+N9jkg8MU1E+XHYCwNvxLbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rd5pzBID6HdcKOkuwhl8Mo6WKjshXGnLAI+d9EH3x2w+JjcASE3eqsh6FRH+xhHkOmuNPyY+MscAfntc4igXUVn3160k4l0HmrcZVbCvlXyvUNB0F/4IZ2KpEYH/QeA5/HmCLCsGd8wXl7nYtB62locwhhXgisu6cxcMAS3naE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SKtY7DAR; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SKtY7DAR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776159075; x=1807695075;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=abl20JDx6bagNJSy1bhe+N9jkg8MU1E+XHYCwNvxLbc=;
  b=SKtY7DARq97259TE1qZEAoyU75F3kSLrEIDQcXMXfIamuAoO5+WmWgGF
   wkyWqXSQoUjhAeWYh90/F3/yUCwsYjqOC/PZYx8+y1lWtujdhMabZFiIM
   qQbMO1fnJgW6jI48fAYImkzddxFrshldVzL44ZCCfrYWyQJnadHByMjGK
   fguKqNWofp1Rex6+gLrcDmZIYWDY6DOEZIao82Ge3JqCwLStHZEEvjdu2
   6IQthS/m19VhwVruSWULUpA6qqR3zZM/Se8Q6VRRq/2YcXz8Tr9K1yzOS
   d3aFyL8ff3zOKj3T6uSqHhyGzxIbzZ5rXWg0jJ7tskF1OTPOJKiNPZVDJ
   Q==;
X-CSE-ConnectionGUID: xTaeNfpxQdy1jWvRp6Y/Nw==
X-CSE-MsgGUID: OrsCRnzqRJKcmqsxLYVSZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="77222028"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77222028"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 02:31:14 -0700
X-CSE-ConnectionGUID: 6/7nLVadSRW3DYieRZdzyw==
X-CSE-MsgGUID: 4hnEFu1ZTCG5GgLOSvHN2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="225741180"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 02:31:11 -0700
Date: Tue, 14 Apr 2026 12:31:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: adc: ad7191: Don't check for specific errors
 when parsing properties
Message-ID: <ad4JXGgVLkwjLHwb@ashevche-desk.local>
References: <20260219143936.2276366-1-andriy.shevchenko@linux.intel.com>
 <c59c19d923d369eac2a0a46405e13e41836591c2.camel@gmail.com>
 <CAHp75VcpuxP=3cGuVrJoSuirQ3vPNR9LLWkf5CyaGcghJ2hzag@mail.gmail.com>
 <abkv_76b1cue1bGK@ashevche-desk.local>
 <20260412153040.0e6f2d7f@jic23-huawei>
 <ad4Dd2hlVdw16xgg@nsa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad4Dd2hlVdw16xgg@nsa>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 14, 2026 at 10:10:38AM +0100, Nuno Sá wrote:
> On Sun, Apr 12, 2026 at 03:30:40PM +0100, Jonathan Cameron wrote:
> > On Tue, 17 Mar 2026 12:42:07 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> > I left this one for a while to see if the discussion would continue but seems not.
> > I'm not sure it is always the case, but in this particular example I think the
> > resulting code is a little nicer to read so applied.
> > 
> > So for me, case by case basis for this sort of change.
> 
> Yeah, I missed this one! Anyways seems the way will be to explicitly
> use device_property_present() to check property presence. Still don't
> love the dual call thing so I might just stop checking for -EINVAL (was
> not doing it religiously anyways).
> 
> Maybe we could have a set of optional variants of the API like
> device_property_read_*_optional() kind of thing where we just return 0
> if the property is not present. But might also be too noisy...

I think that's what usually Sakari likes (tons of wrappers for each case :-).
I prefer be on the compromise side.

-- 
With Best Regards,
Andy Shevchenko


