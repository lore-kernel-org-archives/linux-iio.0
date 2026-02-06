Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9702E541E;
	Fri,  6 Feb 2026 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770371997; cv=none; b=cy/bVwDarNK9do0TavsmLJlexyBHK+02GhjSQCdf/FsZvQUQClPD1SlQOUaVAYLZyyCOI2UBFdnYVS80+EhOqxUOXknKhCvrxDFHbkjXu2gYtsKbNAM+e0f+pti53EPFKdzKSFPO3wEocl3iWsovHdo04w+PFUvDGKdv0vun2es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770371997; c=relaxed/simple;
	bh=Ioc9p5YtiEcqW35zdtv23sb8Ov+SAaY8D3LlCTi6cxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKj0uw/81M4bFag639Dx2ReM7VWGtFAmup/Lo1roOivrxXB92B1RxEaLF7goGh8GrqmJUUJ02djX9HbkpDekv2a8MdjjhXRJBJQi1pqQVDkNfpbngC1yrNAs7wPjr42nxeR4ei7L68wrL/H5KOsB3bxnlrFkj17/BOL+dSPPyOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mADMgl+v; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mADMgl+v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770371996; x=1801907996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ioc9p5YtiEcqW35zdtv23sb8Ov+SAaY8D3LlCTi6cxM=;
  b=mADMgl+vjJ5TZnOR6xyQ9nA381S0/vfr0NCyX5LJSkh9dyRdVGwxpIC/
   ZKNO52SBZwazt77HoXpxqu4KTWB61xtHQXoSGoeUWctpHzolhQnmr2TnG
   MAMEvtFdo5sTDs+UB8HJLj6proFSeigmaQycqxkIMiVwAmpwQgfwdUCFl
   KESWY1GXaeBWurmqsbRc1OEC4mRM2YIK0aMMuEcO2yl9zRKxCh6tkIU40
   YuUaG5aQ84AX7RQIRd2d9g2q2vvmG6VnRAxlpcqpR8pTfUxUhrjVPOnN7
   +i07Kpxw7Rzu8UnYZQtU/sjJvSAYnnhzzM8/PY3V46r2KfjiP8Utj0pas
   A==;
X-CSE-ConnectionGUID: QtyTshI2SgGsqh9mfDIFGw==
X-CSE-MsgGUID: MTJaaWLPQpqgrFajCFm6kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="71471989"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="71471989"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 01:59:55 -0800
X-CSE-ConnectionGUID: 7XfmnIOyRe+izLyvUeZh0g==
X-CSE-MsgGUID: MvymTBfvR0yl9xgGOwXM7A==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.202])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 01:59:51 -0800
Date: Fri, 6 Feb 2026 11:59:50 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 06/13] iio: dac: ds4424: use device match data for
 chip info
Message-ID: <aYW7lt26Tn-6Fgno@smile.fi.intel.com>
References: <20260203093434.2548978-1-o.rempel@pengutronix.de>
 <20260203093434.2548978-7-o.rempel@pengutronix.de>
 <aYHH69gXyuwmQR03@smile.fi.intel.com>
 <aYHLRvfJH54XumUA@pengutronix.de>
 <aYHhO7pJPEew7QMC@smile.fi.intel.com>
 <aYHjQhO92yxoy_9o@pengutronix.de>
 <aYIMgEEDd8ZfLv71@smile.fi.intel.com>
 <20260205204325.5bd09d97@jic23-huawei>
 <aYWe0-2KMLijFVh6@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYWe0-2KMLijFVh6@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 06, 2026 at 08:57:07AM +0100, Oleksij Rempel wrote:
> On Thu, Feb 05, 2026 at 08:43:25PM +0000, Jonathan Cameron wrote:
> > On Tue, 3 Feb 2026 16:56:00 +0200
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

...

> > > Just do not introduce that change (change of the ->name field) in the original
> > > patch, in that case no revert churn would be needed.
> > > 
> > I think this got dealt with in discussion of next version but
> > safest route is just have an extra copy of the name in the
> > chip_info structure.  Then we know it's stable against different
> > firmware types etc.
> 
> Something like this?

Yes, but make it in the patch that introduces DT support.

-- 
With Best Regards,
Andy Shevchenko


