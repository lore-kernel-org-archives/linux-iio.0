Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B703148B4;
	Wed, 18 Feb 2026 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771407619; cv=none; b=mPoa93MZ1ADSTA+w6zhn4WoU8T3kx5naWvBX+9KeiPn0NINo+dMVso2Kit8walMBlYelLAGKVA+oWePzV5oy/DG9bSYD+dQekMrV1b005mekTDWfdQHrGWiGyR0tH6tHZqS7ZHnk7o5Ent14n9woFvTT6ZcuR11zhJ0EXYOgNPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771407619; c=relaxed/simple;
	bh=sQo/XFFKxtOS3X6r2R7c8dsr7U5boxWgad9w41Rg2DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdzmNnt198ZqtQefQ4Z0QJiYuO7fj9wag6q1T+Uuu8Drk+nUBUnQaW0nSENsHen2SfbBquKHgYuAVOBDjPyW9TMJuMelpbO9umbZgvn0Ky8lNiht7FT0hdy86EuKfoMS7LhNvwtFHabIwfd7K/+pbt+k+OBBWh/HBAg/qg2e2g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M6yc6PJf; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M6yc6PJf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771407618; x=1802943618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=sQo/XFFKxtOS3X6r2R7c8dsr7U5boxWgad9w41Rg2DY=;
  b=M6yc6PJf4gDoihFPCO6xgTgMQUBIlH4vur/5X67c9cYcSoru0rDM51ux
   zTjoApSBDeyVMJjePR6pJ5W07tkbg304JMf5l+z3yaeRbgClOr1DPkDAN
   rSfriYCk7A228/6Q5xrP5O6ACInVtAODCRSm/C/uJdVLtst+H6pN7pwge
   4toI8b67tj1OI69OYU6kFcz+yAV3b/QCp173pNnrFxCvYz65Ofvyb2BaN
   0MtMFZaFJpZbUQtjfva06bdywPdBGXVmFDP3pYiZCz5Sm/+Vg+GEdtlpW
   vlpLCnDvFK0E+DocIz/ZSthspynhBR2pSXGGEkdXhH7VyH1Dq9k8DjBLt
   Q==;
X-CSE-ConnectionGUID: w7qhOMHdSq60m8GNnDlKhQ==
X-CSE-MsgGUID: 9cZ7Aa0xTjuwSP9LVFK39A==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="89893374"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="89893374"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 01:40:17 -0800
X-CSE-ConnectionGUID: LMe9yMB+Tg2vGFs51w5SXw==
X-CSE-MsgGUID: szCNQYpQSm+VP5YPF+VgEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="218683432"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.215])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 01:40:14 -0800
Date: Wed, 18 Feb 2026 11:40:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH v1 1/1] iio: adc: ad7192: Revert "properly check
 spi_get_device_match_data()"
Message-ID: <aZWI-80-K7xfuEBY@smile.fi.intel.com>
References: <20260217080514.1288115-1-andriy.shevchenko@linux.intel.com>
 <aebc2f13040d97e6e3b9797d3fa580198125e3f5.camel@gmail.com>
 <aZSD-3WIVwT6XYWX@smile.fi.intel.com>
 <a823c9b72fcc3b1d88ff9dd93580be6241826153.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a823c9b72fcc3b1d88ff9dd93580be6241826153.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 18, 2026 at 09:12:03AM +0000, Nuno Sá wrote:
> On Tue, 2026-02-17 at 17:06 +0200, Andy Shevchenko wrote:
> > On Tue, Feb 17, 2026 at 01:47:59PM +0000, Nuno Sá wrote:
> > > On Tue, 2026-02-17 at 09:05 +0100, Andy Shevchenko wrote:

...

> > > I'm ok with this but as long as we get some consistency agreed on. So far,
> > > IIRC, the policy was to check for the NULL case even for the cases where that
> > > was not possible to happen.
> > 
> > Is it kernel-wide policy?
> 
> Nope... Just IIO IIRC. Actually, I'm pretty sure we had patches in the past
> just adding the check.

Like you said we need clearer policy.

> But again, I'm fine with the above as long as we are consistent from now on.

Exactly!
Jonathan, David, others?

-- 
With Best Regards,
Andy Shevchenko


