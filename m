Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F992DC79F;
	Thu, 11 Jun 2026 19:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206329; cv=none; b=rS+zW+Np/0mTuQUX+wvq77AActzijFg50Nz3U4K/RtAem5MHrnm+RjhNTnFPSlYxSOC6atLUARvtVDv7Ttg1j33gCIgKeKDrUA/bjpWV/SBszLofAk4O8bhWSrRLnnlLgywmTKhKNk/2I0+uNXiEhOpI9cq2lhM5Q/jbsN4jNHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206329; c=relaxed/simple;
	bh=reUVkLQpt9JbjliIuL4usDWFe38Ql5/YGk1pGoYi8DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azTzxwoJeiNlEq4YMBFGcLVQUQwDq8z4bJ59XBrQJPTFDH+VvgvmQE6K8dw/9cPx6JEjJ98IXn6ax2dNkuXk+ef/Cb2j8fSJoas2Oo4JHHjYF+L+EUVGeSaV+6JDCHxTENOqJu97JCTdYgB4Pe+ljJ59htzgkH+VCOoU/C4+j+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fBdqTE+Y; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fBdqTE+Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781206329; x=1812742329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=reUVkLQpt9JbjliIuL4usDWFe38Ql5/YGk1pGoYi8DE=;
  b=fBdqTE+YYSNMgsXHp0Wxs+zS84enn/YJzvyV7IdtchRvHvZwH3spqtJ3
   iF9IrbBaK0j1hFnxBMN06r8uVq9NzdU3ICg8A79JvxlxkFm36B+rcJ+8z
   Yvq9KM7XNC0wNsXvZWITGHdgiMBBsB6PRMeDGpktBeu6sKmaJTz0eC+r7
   BOQU94SH2vqb2G42xbFeOO2hbQ1mfsi2lssuMhJZ+2e2aEegOZpVaGybO
   JeEVDSKQhzeszK1cuhzaN2Jy+iIMqIfvu6OzTCACWcbaZlKnU7znyCiRN
   ESqsFowAMr6n9dTLpepzra+gmSRazJeYwqQgXZEEcweZs9x+GKGd2Jmtu
   g==;
X-CSE-ConnectionGUID: 5r6U8FkETq+/F/je4xwipw==
X-CSE-MsgGUID: e3J9SxKlSxyYWVT/bWlS4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="69577514"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="69577514"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 12:32:08 -0700
X-CSE-ConnectionGUID: lCJNRE8HTBaXnj7Lh9IUgw==
X-CSE-MsgGUID: +Jy20teMQZib86OJkKi0lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="276774015"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 12:32:05 -0700
Date: Thu, 11 Jun 2026 22:32:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Louis Adamian <adamianlouis@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: pressure: ms5637: Add variant specific
 temperature compensation
Message-ID: <aisNMmwMREF7Iga6@ashevche-desk.local>
References: <20260610020458.104818-1-adamianlouis@gmail.com>
 <20260610020458.104818-3-adamianlouis@gmail.com>
 <aimvBvJp8CsNKlPU@ashevche-desk.local>
 <20260611151026.4abf8804@louisarchdesktop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611151026.4abf8804@louisarchdesktop>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 11, 2026 at 03:10:26PM -0400, Louis Adamian wrote:
> On Wed, 10 Jun 2026 21:37:58 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Tue, Jun 09, 2026 at 10:04:58PM -0400, Louis Adamian wrote:

...

> > >  struct ms_tp_dev {
> > >  	struct i2c_client *client;  
> > 
> > >  	const struct ms_tp_hw_data *hw;
> > >  	u16 prom[MS_SENSORS_TP_PROM_WORDS_NB];
> > >  	u8 res_index;
> > > +	const struct ms_tp_comp_consts *comp_consts;  
> > 
> > Please, check with `pahole` if this is the best layout.
> 
> I will correct the packing on this per pahole's finding.
> > >  struct ms_tp_data {
> > >  	const char *name;
> > >  	const struct ms_tp_hw_data *hw;
> > > +	const struct ms_tp_comp_consts *comp_consts;
> > >  };  
> > 
> > Can this be simply embedded into ms_tp_dev (and copied there if
> > required)?
> 
> Copying in ms_tp_comp_consts provides no benefit over
> referencing the pointer; the values are per-descriptor, not
> per-instance and never modified. I'll keep the pointer (same as
> ms_tp_hw_data).

Okay, let me ask differently then: Can we use the same data type in ms_tp_dev
instead of adding basically the same fields as in ms_tp_data?

-- 
With Best Regards,
Andy Shevchenko


