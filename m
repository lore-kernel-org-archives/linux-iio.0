Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AAB22D78A;
	Fri, 23 Jan 2026 11:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166737; cv=none; b=sN7ktXiIdszKkbGVu1zrRRY5I28iZDbLMwgKc4FoE6IC1THq/s/B8yVV6yTLkYhSgORF6/I9nzlS6+OE0y/3PVy4Aj03ZqNlXknYGb5SFtH50E1ZE809Y2FTqf+upcp1VvYfv3AGxM9Bg3CaaUvX2hIoInzChIEAoSgrgw7obsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166737; c=relaxed/simple;
	bh=So86kT8Piw/cPPuy1GrbpC9xsq75X0HK1VRKxNEaR7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQsyV0cT5gwmGH04M7TMzraQiGclxDxRmz9FEdaRzlwQ+JjXct01+EUYWSZyZyRWgZqQuurTJokWss3SiXIqWTpDLiMz8FwbFhZfgSBa1IT7QaCDaC58tAodXT5/M+V3q097DylzuWtFv48HHLM8w/MgkN7jJ2ap/1f8hbfbOvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V4/m48Xj; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V4/m48Xj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769166737; x=1800702737;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=So86kT8Piw/cPPuy1GrbpC9xsq75X0HK1VRKxNEaR7M=;
  b=V4/m48Xj96TZnsa+H3QLbvvoecAzQt86DVUyUXxof7zUUpMnwJ9ZCgwE
   NVu5yE0TWQCmQnZYucRDUk0NUYB5rBIoZ57MTpqKl58Ed7eO1oi/feKYT
   BvbnA86WycAl4qsOW0jakGwjm1I1MNAYyAebf2G+Lr5N/dEnJcWVlJVWC
   ydlZohykosQ57ufwQV4ZLgb4iGF9I8KSfE02PhVfTZgL/mfPk3QTYLDDt
   c+o7DrprPFgEVWyVVAp837FGMQNcjPH1nZh5XL1715aHRpHHwzvZEZkdt
   +UtEUOYkjS1oa98nOQW9NzVmbfoeAHSWsNTREC/hNUUi0OmgX5nwY9oYo
   w==;
X-CSE-ConnectionGUID: 2J/ScHsdSFqe3iR4MJWkRQ==
X-CSE-MsgGUID: 2w9EA8YnRm+zSat+jK/WYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="95889389"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="95889389"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 03:12:16 -0800
X-CSE-ConnectionGUID: vULgs/eqSzGFb9AvkuCWBA==
X-CSE-MsgGUID: mrLgfw8xT1CvR1hTom1UXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="212004912"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 03:12:13 -0800
Date: Fri, 23 Jan 2026 13:12:10 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: accel: adxl380: Optimize reading of FIFO
 entries in interrupt handler
Message-ID: <aXNXigqkSL6L1Jr0@smile.fi.intel.com>
References: <20260119102317.1565417-1-flavra@baylibre.com>
 <20260119102317.1565417-3-flavra@baylibre.com>
 <20260122195313.53fde73c@jic23-huawei>
 <aXMtnCnTXq96efmH@smile.fi.intel.com>
 <20260123095417.31b11fd6@jic23-huawei>
 <34d7983a594b40d6d98dce02c1cff843f689a275.camel@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34d7983a594b40d6d98dce02c1cff843f689a275.camel@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 12:09:36PM +0100, Francesco Lavra wrote:
> On Fri, 2026-01-23 at 09:54 +0000, Jonathan Cameron wrote:
> > On Fri, 23 Jan 2026 10:13:16 +0200
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > On Thu, Jan 22, 2026 at 07:53:13PM +0000, Jonathan Cameron wrote:
> > > > On Mon, 19 Jan 2026 11:23:17 +0100
> > > > Francesco Lavra <flavra@baylibre.com> wrote:
> > > >   
> > > > > In order to minimize the time required for transferring FIFO data
> > > > > from the
> > > > > sensor to the host machine, perform the read from the FIFO in a
> > > > > single call
> > > > > to regmap_bulk_read().  
> > > 
> > > > It's a call to regmap_noinc_read()  not regmap_bulk_read()
> > > > I'll fix it.  
> > > 
> > > This is interesting, does it mean the patch was never tested on the
> > > real HW?
> 
> The driver has been tested (by me) on real hardware, both before and after
> this patch.
> 
> > > Or maybe noninc is intentional?
> > > 
> > It's absolutely intentional.  The device presents a single register
> > address
> > that has the fifo behind it (which is what we added noinc for years ago).
> > So patch should definitely work.  Goes from reading that register N times
> > in
> > each call within a loop of M to reading it N x M.
> > 
> > If regcache is in use this makes a difference as avoids corrupting
> > registers
> > after this point as the address increment expected in the hardware for
> > a bulk read doesn't happen.  Without regcache it's just "documentation"
> > as
> > at least for protocols used here its the same as a bulk read on the bus.
> > 
> > So patch is fine, it just mentioned the wrong call in the description
> > I'd guess this is because someone is working with a tree that has the
> > wrong call in
> > it but might be wrong.
> 
> I have this patch applied also to older kernel versions where
> regmap_noinc_read() doesn't exist, so this is just a copy-paste error in
> the commit message. Sorry about that.

Thanks for clarifying this!

-- 
With Best Regards,
Andy Shevchenko


