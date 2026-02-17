Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D29C1DF27F;
	Tue, 17 Feb 2026 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771335143; cv=none; b=WVq0DAxP63gHe3f0N+lS7rtF7sIJOh4fq/166nIh0enVzlHAmvurtoDLmE/SZDxc/K6GJ9pMMYkZfm4bkuWRDGIog9PQReOR7kKa6lbKUWpHVWNAoFU/d3bR2lI/SwXVZnvjRScOkUKPmA5BU0fQuYXmZIoP1y+NXgQs9E3E1Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771335143; c=relaxed/simple;
	bh=zPLfs+A6UoEnfutdGYWDC3SegbGcKZn5rwwQzrHs76E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoFiwF5Pebj9rmlE2Mj9mLoJ90+zv7uGIBNCrEjF54qCg02Ttj5PPgGFCt643tCNrNJ5Oh1U4OxXMBW5B8ZQqvfrwNZ3iPsept1EC2lhs16YpaSqs1dHcBLDBfr+n/jIBvMcDKnq+4VS8MRQfN3dlJiHkDv0tKmES+9YcHic7Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ay2C4hbH; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ay2C4hbH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771335141; x=1802871141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zPLfs+A6UoEnfutdGYWDC3SegbGcKZn5rwwQzrHs76E=;
  b=ay2C4hbHOviM6+YFpLyQvXnXQpYplWIgY+LlIw/uCaUBf8LzjHaiJXP4
   I44230Cefv3rFhgWYgDaLOGfp9+Cf0K4N2x6a7WJmwXkZ2mMxr6BTrlML
   jhu3akmuKje5FNHWEkUvoch47I+10WG3a+ed1hlRy9NoUVheH7H7fKEVB
   iUo8GsIBaL5TurYX7gHUlx7ba8ca4zgj2wGCyb7MLB7XpJUOIH07FOwcb
   8mWC8962waIllyqRZs46l6mbQ/ePGjnGRC0JLl9hRNYTibw+oqNrnKt0v
   EuochRdUu1udedRjRtEKbdkIOjt6VtkAIgkmep199dpC5pxfG/I8gvYfF
   g==;
X-CSE-ConnectionGUID: VX52lmoYRyimQaWJNvp/3Q==
X-CSE-MsgGUID: Yzm7FwzFTCKzGvuvpvz0Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="83842256"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="83842256"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 05:32:20 -0800
X-CSE-ConnectionGUID: PxU0AO+LReuWco3WhCBmBQ==
X-CSE-MsgGUID: QmY6dY6CQgaXqKU7jszaRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="213980597"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.123])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 05:32:19 -0800
Date: Tue, 17 Feb 2026 15:32:15 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: core: Simplify IIO core managed APIs
Message-ID: <aZRt38PTZYzQv8Si@smile.fi.intel.com>
References: <20260216081412.1118599-1-andriy.shevchenko@linux.intel.com>
 <525a30ed9127b689549bfaedc086638e2e3b5670.camel@gmail.com>
 <aZQcpJV2GQ8vWnA_@smile.fi.intel.com>
 <c27fd07403ed790902bc9ef5a863beeb7b7429be.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c27fd07403ed790902bc9ef5a863beeb7b7429be.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 17, 2026 at 01:29:07PM +0000, Nuno Sá wrote:
> On Tue, 2026-02-17 at 09:45 +0200, Andy Shevchenko wrote:
> > On Mon, Feb 16, 2026 at 02:31:57PM +0000, Nuno Sá wrote:
> > > On Mon, 2026-02-16 at 09:14 +0100, Andy Shevchenko wrote:

...

> > > > -	if (!buffer)
> > > > -		return -ENOMEM;
> > > > +	if (IS_ERR(buffer))
> > > > +		return PTR_ERR(buffer);
> > > 
> > > Subtle change that could have been mentioned in the commit message.
> > 
> > Actually not really a change. Currently the error code is shadowed to -ENOMEM,
> 
> Well before that was explicit. Now it also depends on the internals of  __devm_add_action().

True, but if that ever changed, we will have a new error code coming from
->probe() and that's fine. ->probe() is not stricted to the certain error codes.

> That is why I said it was subtle. But yes, no functional change.

-- 
With Best Regards,
Andy Shevchenko


