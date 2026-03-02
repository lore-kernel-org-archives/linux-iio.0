Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9280378F39;
	Mon,  2 Mar 2026 07:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772438206; cv=none; b=QjI5LwjrgG2/niOhRjN5TyJ/i/xRiaZskVjjb0o06JpjPSHCS4pw085ntZ2MhtRjFA3I02nCRC4wnWgZHIbwMqg3wZeYJp4oZ0tt7ga1PzySlZg0PISzuGoOalPL/MWXBGmomjw0HejrU7PQuWBViw/uUbQ6xLHLuCqCYO4PKXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772438206; c=relaxed/simple;
	bh=zaO5ovtRTTRZuH1nNfwvRr3Z22dHUXijpP5i3zjZkRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNyZpiQx2WZ2xHr+qHOy09OpP7SbdHnd6KAPZX8ABeXu1WhZYMQcrfrGwin9SK+5SJAoLc2JDq8/6KacHqf7zDHeMOjzsosLo5SblNAUZhbpuqT4s3oOSyUg/vDqHPaNXYcTl7isuMIbFDRS/ugVh0Fu/UaLoUINzgEAWXNxywk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I3J2lyNg; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I3J2lyNg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772438205; x=1803974205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zaO5ovtRTTRZuH1nNfwvRr3Z22dHUXijpP5i3zjZkRY=;
  b=I3J2lyNg11/VGhhG4DsVa2jscOvh30mxSwGKvsVDuibIOJk24QKfYXdi
   3f/VU04PCTEo17OgHtdUczpnzGFIxh5lEI9tdsx1mcgt0HabQo0bAm/UF
   ds1gjKG3QFBzLPdCboUGg6jHdZASBLg1popmaUK6BAPp92jySCY1RDpZK
   KXSuEEBncxDgrIuxNUyDiEgzqr/6xcIizEu71519tkJe8hOSKk27S7hEN
   wOi3wHWuVsqOft2lzbpdER++g2WiqE+JsJdPWj1jdSlrcoHjUYhEaC0w+
   h7clM1zpQdFTC3DJ4mn+Cs6aCGKx5QegyvpVbwBfogd/DeYJc6Dku/UwF
   g==;
X-CSE-ConnectionGUID: X9pPUgTySzySvjS2u8EuJQ==
X-CSE-MsgGUID: NeVL4eg3ThyReQBVrhx3mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="83774576"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="83774576"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 23:56:45 -0800
X-CSE-ConnectionGUID: WI6j9mF4TeGm6qCTrbqI5A==
X-CSE-MsgGUID: uFEX2GKRRHeTbzTStiVkdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="216800866"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 23:56:42 -0800
Date: Mon, 2 Mar 2026 09:56:40 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: adxl380: fix FIFO watermark bit 8 always
 written as 0
Message-ID: <aaVCuE8rwFikaL5c@ashevche-desk.local>
References: <20260227124305.55271-1-antoniu.miclaus@analog.com>
 <84fae6b8-d188-4e5c-af06-b342f3d27514@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84fae6b8-d188-4e5c-af06-b342f3d27514@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Feb 28, 2026 at 10:50:00AM -0600, David Lechner wrote:
> On 2/27/26 6:43 AM, Antoniu Miclaus wrote:

...

> > +					    !!(fifo_samples & BIT(8))));
> 
> Technically, this works, but in terms of understanding the code I think
> fifo_samples >= BIT(8) would make more sense.
> 
> fifo_samples is a count, not bit flags.

I even would prefer to see in such a case

	fifo_samples > (BIT(8) - 1)

that it will define the maximum that fits the HW, or plain number

	fifo_samples > 127

-- 
With Best Regards,
Andy Shevchenko


