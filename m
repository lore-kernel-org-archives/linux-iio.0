Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3660E44B676;
	Thu, 26 Feb 2026 20:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772137770; cv=none; b=IR3cyQyUtWELNRGXQPXtO7PhdYpM0YBq26UkHL1casBfZ5kIXl9/Y1aTWD4InI3ZjQuhhGvsqACUMrVOecvDf205W2IFvAVYEwAJnnAqTOpbo5bO4ZkWRxjbjperKzSkMQs9QIExtEmI0l2VB4lXwdQhph5ofkfrio5vpr0DXY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772137770; c=relaxed/simple;
	bh=3WvyATq46a1BxecTLJAgQK6rWZEue9Yr9i24PsNEFcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGFhJClUFVS8JHTUgsdwWjSSUVAt8/tWvFlRqlBrJbBl562oqGdqnFYVFRig9q2k9F0nlOqrHGR6p2/w7C8UDchAuVEaY0yIeqTb1PxcxYs9/ZVgrGxpaKZ5jh+NO1teGEepl6eRr89wcY2i6PrgMyEwbAUaHhKglqCLkkIc1A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JcSgUbPL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JcSgUbPL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772137769; x=1803673769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3WvyATq46a1BxecTLJAgQK6rWZEue9Yr9i24PsNEFcc=;
  b=JcSgUbPLnrzNDILUlnnSze/YeNhNPLQfC83ZcEi23k0qa2+P9GHxzTzG
   5vKaDbauAAUougxNfOcw4lIrLEyo5kIcqRV7axCsp0JRQqJ8lM1BaEYJK
   6Y5XpuxwpXwDciXBz4pJYywgruCaovx3f11UlXjdf6CIz0mXzqusPtZdO
   cqY4HrmRT4Xxj5sVKyxHJwkmUw/9f03suDpXQwVciaS5JzsF6QRT4mZZZ
   UKnw8BQHmvXsqMBnh8f8yBFwWsXLZAxExLOAYAUyrkChiE9Qx2yy6qzBX
   KxzHOh6hMGfeOfmtEsU676wmh1oPZ6sVlW9nz2ULGKbOK71FjClkR2jvh
   g==;
X-CSE-ConnectionGUID: vJYQfF0NSSeB4OPjxzYcaw==
X-CSE-MsgGUID: NaeVMBgCR3eGha0S76Zo4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="98682461"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="98682461"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 12:29:28 -0800
X-CSE-ConnectionGUID: gzeVnJd9QAyyO4ZYWcNDpg==
X-CSE-MsgGUID: MwLAcl19RL6vN1yxMsOt6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="215914103"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.167])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 12:29:27 -0800
Date: Thu, 26 Feb 2026 22:29:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: tsl2772: fix all kernel-doc warnings
Message-ID: <aaCtJE4tvVZDn1zz@smile.fi.intel.com>
References: <20260226051258.555019-1-rdunlap@infradead.org>
 <aZ_-pVTbTUkByPIJ@smile.fi.intel.com>
 <7f61d93a-37df-44fc-ab47-b0e5ff70259a@infradead.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f61d93a-37df-44fc-ab47-b0e5ff70259a@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 26, 2026 at 11:14:05AM -0800, Randy Dunlap wrote:
> On 2/26/26 12:04 AM, Andy Shevchenko wrote:
> > On Wed, Feb 25, 2026 at 09:12:57PM -0800, Randy Dunlap wrote:
> >> Use the correct kernel-doc notation for struct members to eliminate
> >> kernel-doc warnings:
> >>
> >> Warning: include/linux/platform_data/tsl2772.h:88 struct member
> >>  'prox_diode' not described in 'tsl2772_settings'
> >> Warning: include/linux/platform_data/tsl2772.h:88 struct member
> >>  'prox_power' not described in 'tsl2772_settings'
> > 
> > Hmm... I do not see any of the user of this header file.
> > Have you checked if these values are even used?
> > Perhaps we can simply kill all this?
> 
> They are used in drivers/iio/light/tsl2772.c.

It's the same driver. So it's *not* a user of the platform data.

Under 'kill' I meant the following:
- inline the content of the file to the c-file
- recheck the c-file for the unused fields and drop them for good

Alternatively converting c-file to use device properties instead
of platform data.

We have done many times in the past such transformations in other
drivers.

> > But if Jonathan wants to take this as a quick fix to make less
> > warnings appear effective immediately I'm fine with the change
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


