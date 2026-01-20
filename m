Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57CE3ED121
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 22:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768949538; cv=none; b=MwLb1C9wmLxM3RdjhpclDB2jSsLf7x2R7rH6hwCyhhfJuQmWYqmzW8r7AANgvhiTbfbRE2h80tiKe2WPTqjBlbr++xKpWpHcMhQkiS/DJEZraQODxwPXsyTwftnf/wzMUS8uwOm2deBs38nW5YVjaocWmFvm00hRrFELVHxs6YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768949538; c=relaxed/simple;
	bh=QXUSlm4aUM7Oi9ZGMiU5peWwKF6FDchlejeHBBFZJMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DS29YN+COJEEwIwkw2tp2oIF14t6Xi6C4DJlonae9VgWyq6yHYEaP6Lq5CMW9FyUjvZlr5o2uMNEexw4LG8itcB4FpzXG8Yav98DXvkCMJVSyUP/QuHWuvbHhzeVr/i0LpTo1kFQmYjKxiR22Hv4rkqp0B/Rs7BGk5M2UQ7oRFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=muKetcER; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="muKetcER"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768949537; x=1800485537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QXUSlm4aUM7Oi9ZGMiU5peWwKF6FDchlejeHBBFZJMY=;
  b=muKetcERMAkIRxZBCSHhUn6vvfbOFHkhecL4C5AZ3oxNwGKsoCDfOW3h
   R+iRRCOTasqhhZLJijGBOibBKU9SToaYCZwSjne+/bD56t/k6wrfxODtW
   ZgZAqM03HihGMzEFF6PZmll4M9jU6tL2WS5YT39Z5mIRUv2pt5JeUXVP+
   ZOzAG6S1R2TxhvxtMVIdUGEX/duMDBCgTQcM7JOVbpFmQkXP9E3dWNV51
   Nu3TzrI9AJ0JjOv81t1oVjp35ozgsnj6LDIV9oFjO9R+7t7R6V9bvyQAV
   9sZBekBbqgvmuBxB4UyzByXwbS+10jft2Y3Q3Mwz/JtWgwjLMzHsyqViN
   w==;
X-CSE-ConnectionGUID: EUJw+P8FT1K53to654cBuA==
X-CSE-MsgGUID: tXF1nDoXS3K0RISxewt5bQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="57733409"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="57733409"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 14:52:16 -0800
X-CSE-ConnectionGUID: u8bPt/vHQvWntTdWn4OWhQ==
X-CSE-MsgGUID: 9/rwtIMYQJ+qVjTGDIzDSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="210705311"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.240])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 14:52:13 -0800
Date: Wed, 21 Jan 2026 00:52:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Liam Beguin <liambeguin@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 04/11] iio: adc: max1027: Improve include relevance
Message-ID: <aXAHG1Ieug6vzKlR@smile.fi.intel.com>
References: <20260119212110.726941-1-jic23@kernel.org>
 <20260119212110.726941-5-jic23@kernel.org>
 <aW81S3XcVBnuYI71@smile.fi.intel.com>
 <20260120221040.35735609@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120221040.35735609@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 20, 2026 at 10:10:40PM +0000, Jonathan Cameron wrote:
> On Tue, 20 Jan 2026 09:56:59 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Mon, Jan 19, 2026 at 09:21:03PM +0000, Jonathan Cameron wrote:

...

> > >   #include <linux/device.h>            // for dev_err, dev_name, devm_kmal. ..  
> > 
> > Not good, we also should treat device.h as "include everything" and try to
> > avoid that, above comment hints like
> > 
> > dev_printk.h
> > device/devres.h
> 
> It's there for
> spi->dev.driver->name used for some reason as the irq name.

Ah, I see...

> I considered fixing that but felt it was out of scope for this series.

Sure thing!

> I'll add a comment as iwyu forgot to mention use of struct device ;)

-- 
With Best Regards,
Andy Shevchenko


