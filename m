Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772C242DA5B;
	Tue,  1 Sep 2026 07:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247108; cv=none; b=VepHvcTXTuHkatixsS9oNuvTEg3kStcpUb8ja2fStobLxaeYc82itOHEVNVy57AutNqO8UOo4I2hXXkPmFh2w4/gkvXLX+/Q5OX4IrsMpk7EZRXqPuxeGGFnJEe3UT7BMJ2+s0P6DHfFTNp3tNNA7rhwDNg1Z3qsL8yCY37vGwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247108; c=relaxed/simple;
	bh=nQ1Txs5VtWwa3LV7R5SsGLj9IbDYJQeJmmceT7DdqFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qG4kkrbhn27nFyjaNCQIu5Rk2yMsuo5kJ8hVNku+GxG1znn8ouDK+YxVreqbjnMscplbBIDuCO1KXusnJZZ6hya2UkwfnwcNGqyXppkEApu2YiUqytQivah+FUhr/nMPvL9COm1wWX96LI+lQ8tHEkRpf0auU6xnYgqyD4ueZNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m70veq3G; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m70veq3G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788247105; x=1819783105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=nQ1Txs5VtWwa3LV7R5SsGLj9IbDYJQeJmmceT7DdqFA=;
  b=m70veq3GFbthuqwztB3F4+K393V4Ic5LeNXDRCt51YvQhraiADg8c9T5
   Fd1BnTJzfcIZNKZ1ajpg0TAZMyTgc9d2EVlMmCrkENG3RC3DSQBQY3flX
   nZ6jN+cT9DApQhU8aORD51EXbsSTJn8GAa4r+bFXJi+9jrYmG0/ue36UU
   7l7Gj5WooRcGtHGzoy2tVjqyG+4W35ReMOxXWGhnBS/ZyHyviVm199133
   eKYu4UYnUgJxnOTIKLYmQeFZkh4ZL8g5bmwIUrHr8oEhOpYsTkJehkMUB
   OFqQByLTtdMNlC30Q/AyUETdwzxodwd3I3VL7mnp71Oc70BlwDXO6uiJ7
   Q==;
X-CSE-ConnectionGUID: 3PCgXjNwTfygnIp9UBh83w==
X-CSE-MsgGUID: n/FwF+MlT9iODPKvAb/4gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="92534044"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="92534044"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 00:18:24 -0700
X-CSE-ConnectionGUID: 6fQWQPLNTsGsO9NeARB8fA==
X-CSE-MsgGUID: KiNiqfY8RJGBKkD+8I7ZhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="292513211"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.222])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 00:18:20 -0700
Date: Tue, 1 Sep 2026 10:18:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	=?iso-8859-1?Q?Am=E9lie?= Delaunay <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/9] dmaengine: Support bus widths of 32 bytes and
 above
Message-ID: <apZ8OSzG7bEpQylL@ashevche-desk.local>
References: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
 <20260831-dmaengine-support-wider-dma-masks-v3-1-507d97496f2d@analog.com>
 <apWFa4BFoAL2AhG3@ashevche-desk.local>
 <apWjMBvGA6yo_nCZ@nsa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apWjMBvGA6yo_nCZ@nsa>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 04:56:18PM +0100, Nuno Sá wrote:
> On Mon, Aug 31, 2026 at 04:45:15PM +0300, Andy Shevchenko wrote:
> > On Mon, Aug 31, 2026 at 12:46:38PM +0100, Nuno Sá wrote:

...

> > >  F:	drivers/dma/
> > >  F:	include/dt-bindings/dma/
> > >  F:	include/linux/dma/
> > > +F:	include/linux/dma/engine/
> > >  F:	include/linux/dmaengine.h
> > >  F:	include/linux/of_dma.h
> > 
> > Unneeded, previous entry includes recursively.
> 
> Checkpatch complains so I guess we assume it's a tool issue?

Can you confirm that without this line get_maintainer.pl works? If it does,
then the problem is in checkpatch.pl (false positive).

...

> > It's possible to split this patch to two:
> > - move the existing type into a new types.h header
> > - add support for the new API
> 
> Yeah I thought about that but this still looked simple enough to go
> together but I can split in the next version.

I think the split is needed as it makes better view on the changes
(and accompanying justifications in the commit messages).

-- 
With Best Regards,
Andy Shevchenko


