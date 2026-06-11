Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BF92E8B98
	for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 05:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781156302; cv=none; b=YKksETQlQ6ssF1he3BSCTVdeXTU9wk8Ieq8ERtLJr6Uloz2+ztk9rm4AS/DmEVTl+NnWXC7FnfvXLkYes5q0zYz6vZLvHwD2hBLFSWgjkZ32d47tLyqScOXF0VMEYgOy4Y4EmJnZUSzPlXqsz4X4zvp81HyKCwa5pd1p8wY5WD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781156302; c=relaxed/simple;
	bh=AarmvC7Mz26BvWZGJaNXVHm1cFoMe4K9LemHQABCtEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4uM9fQtBZkDPBkuzozn//OHXLznQ9i99hqE7xc4LNbiR0mmSoX2efVpK0Q6z9YvZp1+PAaAX6u41L1QILKGOv3xDbaDOcJxfe3zBIuIPAT+FsHFChPtmepUYxzAc0RpbIQv6UQa0oyiqMs/iudrZiZMHQRcECOhB423xzqtcfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I+miWUgA; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I+miWUgA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781156301; x=1812692301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AarmvC7Mz26BvWZGJaNXVHm1cFoMe4K9LemHQABCtEE=;
  b=I+miWUgA+6KEpYmpYOVzfBdUd8lbY3GuKX/FKlPk2aEE9ZZE6SUvQ5aL
   4d6oVboa6uUCGuSiGQ6R2N4mJEqNJF2vYUlMfW/JSpT0Dywb08fU9DVGF
   5DcKURUHeP1lP7xv+9k5zehv6ooxxeNjaFi8VhEhjyH12zoDPDd4Rz0tP
   I29MAoeDvirHqzcVU8Qj1s8NBYgePvg96B/xHEwXNacjO3QkmfBqAcdPa
   cmtof2VOtdklt4aZLJjQqFUt4+Z/4rC0n6K4WrDn6x5DnFLUEVH3EFXGr
   Geck9n1BxsYKSeezL2ZzD+KC8qtTcvWYYbvwLh9XHTe8cUCcaKFI1XxRE
   g==;
X-CSE-ConnectionGUID: OflC8pwoSjqf1KvSKOvLVA==
X-CSE-MsgGUID: zN7goqykSPeiSHJ6Y02Owg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="92283534"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="92283534"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 22:38:21 -0700
X-CSE-ConnectionGUID: +5j2PMl8TxivX8WfEYFhEg==
X-CSE-MsgGUID: NsFpn8OBTQyTjPJ52hHK9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="240034931"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 22:38:18 -0700
Date: Thu, 11 Jun 2026 08:38:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: core-trigger: correct CONFIG_IIO_TRIGGER macro name
 in #endif comment
Message-ID: <aipJyK_-QH7LiVnt@ashevche-desk.local>
References: <20260610040501.204967-1-enelsonmoore@gmail.com>
 <ailpoosKZwGskxUo@ashevche-desk.local>
 <20260610155921.0000655c@gmail.com>
 <CADkSEUj1WgANDfQD_8RKM+sWgWgJZ-f9p9jRuniQYs7RA=Eg7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADkSEUj1WgANDfQD_8RKM+sWgWgJZ-f9p9jRuniQYs7RA=Eg7A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 10, 2026 at 12:18:34PM -0700, Ethan Nelson-Moore wrote:
> On Wed, Jun 10, 2026 at 6:59 AM Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> > On Wed, 10 Jun 2026 16:41:54 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > (Btw, did you do that manually or using some scripts?)
> 
> I used a script I am writing. It attempts to filter out enums,
> changelog entries, and example/dummy values, which makes the list
> significantly shorter, although it does so by committing the cardinal
> sin of parsing C using grep :). It also has an easily editable list of
> known false positives. Once I reduce the rate of false positives to an
> acceptable level (I notably need to exclude typedefs), I will post the
> script on GitHub.

Okay. When modifying C code (not text or comments), consider using coccinelle.

-- 
With Best Regards,
Andy Shevchenko


