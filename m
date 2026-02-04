Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD8E38BF64;
	Wed,  4 Feb 2026 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770199278; cv=none; b=FpMZwDaL2ihgDY85hzBZns7emYrsVvXeDp5ujSe299ki03KVApCcsYVxHkMCXsKggD6SRLDE9Ylb81l8LujSZhk/6FZDtvUY7DdKdDixjTTm2rlmWCwEg9D4qDGVEKS5/2K7Md1or8JEzMl7aEgjMUw22WmveZWvCrTXVjCU0pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770199278; c=relaxed/simple;
	bh=Au9sii3UFbb/1EmMnEB0DyNZydZn8tbtO0BpZYyntNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dr8sAB5ukvybidbi1LzaPsIayj/1xxO4NJMZU9w8MbL67rHKGeJ38EzzkWvtg+rSpEFP7ZB+mf4jJilOV+tCrJu8UJdEHUuPp6lrZccV0atttYwXe7VFd5Y9CKRnEUPoZPO4urZZiy0DPoOXT/zqIzTXo2gLWY3us9eauCXY8qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ls/9c3vn; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ls/9c3vn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770199279; x=1801735279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Au9sii3UFbb/1EmMnEB0DyNZydZn8tbtO0BpZYyntNQ=;
  b=Ls/9c3vnoCz87mDiGDhOxCllKBDosQ/d3W+kAh71LoH10Vfx9RD4P9oO
   +ecQ/c5ycQj2MCNaDlyWr80k97GYf0CdskHOlq0Q4seQWiIB/YHG60elt
   IikMLdTcVx/05oSMS5IurBrfHXzcNCVl4CFzc4PdycmWzojOaJh9kvDwA
   Ug8PUiXbfYFQraVVP3JY05IvAuk3iZaSul9KrVq0cdD9muR5iXrZc1Vv7
   i6vPABAe/ysQ3prxnwdyvzk5bQdrR4MtX55aY59dCkqRqjemc9bmcVMlX
   zrd6JvphFANb5NGAhtx0W/5R1n0Mzye3EgZTprNaWw7j/cQW9rko2Z7G4
   w==;
X-CSE-ConnectionGUID: Gkp5DY1lQYWjcfQo4CxPuQ==
X-CSE-MsgGUID: ZJnD2d3rRiqNGnFVZ0HpaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82494591"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="82494591"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 02:01:18 -0800
X-CSE-ConnectionGUID: TO60Dqc3RsCuPPw8cCctDw==
X-CSE-MsgGUID: VJxYm7oNQP22RJCSqOCrAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="214292663"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.188])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 02:01:15 -0800
Date: Wed, 4 Feb 2026 12:01:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	error27@gmail.com
Subject: Re: [PATCH v4 next 3/6] iio: sca3000: make stop_all_interrupts()
 return void
Message-ID: <aYMY6AHtc45l4kb3@smile.fi.intel.com>
References: <20260204061219.791037-1-harshit.m.mogalapalli@oracle.com>
 <20260204061219.791037-4-harshit.m.mogalapalli@oracle.com>
 <aYMLeAaQm35-4Sgl@smile.fi.intel.com>
 <6423132f-37b1-4db8-a654-437804b2f31c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6423132f-37b1-4db8-a654-437804b2f31c@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 04, 2026 at 02:50:54PM +0530, Harshit Mogalapalli wrote:
> On 04/02/26 14:33, Andy Shevchenko wrote:
> > On Tue, Feb 03, 2026 at 10:11:58PM -0800, Harshit Mogalapalli wrote:

...

> > >   	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
> > >   	if (ret)
> > > -		goto error_ret;
> > 
> > > -error_ret:
> > > +		goto out_unlock;
> > 
> > > +out_unlock:
> > 
> > While this is correct change semantically, it's not needed as very soon
> > the other patch drops this for good, hence leave the label name unmodified.
> 
> Agree, I was doubtful on which is the preferred approach as its not really a
> return anymore. But thanks for explaining.

The common sense says that we need to avoid ping-pong coding (*) in the series.

*It's when one patch in the series adds the code that's going to be deleted or
heavily modified just later in the very same series.

-- 
With Best Regards,
Andy Shevchenko


