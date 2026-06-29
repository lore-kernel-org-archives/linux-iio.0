Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A692F8EAE
	for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782753360; cv=none; b=sRnp7wKZh4th3d/DCrXGdq/u+cqYtjuqH+q6ITAZHOlypXMo8ehgj8LCH0Hu0IGjzpEPcZFJDhy+ZGX7wXTeaBaCdXtNIsXKAocqrwJjT/VSJP+eoMSufqIOTWKPTj0ePUklJjI5sMwXfHeCkRwsJuHNQtObzEwaGa9CAdci+mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782753360; c=relaxed/simple;
	bh=qraavlxLNgq+9pzNhd1Cd5SBs7Cr4r9e5jQ765jtyaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljr1EobLbC+hlO0WSG05iAGRWfklRNzjt4KjLieFf55ns8NweI5tjDe6+F2ivUQFvf5NwA+pP4DJuRMapt6P0onL95gtGCIJzUIamueeG+9Xn8Mu3kI4eIwwlTasCmej3q2+gJTvyvpzCBwnhXrAIB8sIEZGo2llRxGEGC5wKaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YpBAv9si; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YpBAv9si"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782753358; x=1814289358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qraavlxLNgq+9pzNhd1Cd5SBs7Cr4r9e5jQ765jtyaw=;
  b=YpBAv9si+2kW0krsB+yTPguq2+6eNDyTCSGb4UxKile+9Tx6uAUi07SE
   NsV17fe8VN2iNQOdl/rViLMibSgAMWXW7SXngFnyYdUowrNQbQCVVg5Bj
   AJE2pbGvZA72h7w8+S0x2VvX+OatGndHF10hSn7wfFpyyW6c2SizMGSCZ
   Oa47aQpoI3xnvjjVHj/wP5xYD8s98UV6GvHl6E6bMtrR4DRDsNYl/+rsk
   fSRBaB6o5Bi/ZLA1/kcIj6so1/ehr9xgSgt57EJeZxDunzYyfhSsIZE1/
   F9t2Pkit9Sg0QpjJoG/P51QDhVXoYUeL34+nGS0BszGip841QT1VgqUd7
   Q==;
X-CSE-ConnectionGUID: /Ms+aVaPR6aGq67lF5VWiw==
X-CSE-MsgGUID: 3AekEw90Tqu5RQGd1X2nLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="106246903"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="106246903"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 10:15:57 -0700
X-CSE-ConnectionGUID: V/hKeoJWR3uvAq7+H3M/Lw==
X-CSE-MsgGUID: LAG6gNcDTM+dBVp2mJmyGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="247555988"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 10:15:55 -0700
Date: Mon, 29 Jun 2026 20:15:52 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Erick Henrique <erick.henrique.rodrigues@usp.br>, jic23@kernel.org,
	andy@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 2/3] iio: dac: m62332: Clean up header includes
Message-ID: <akKoSAM1apknBDkZ@ashevche-desk.local>
References: <20260628034811.152946-1-erick.henrique.rodrigues@usp.br>
 <20260628034811.152946-3-erick.henrique.rodrigues@usp.br>
 <akKfqWoHmEVUmfQ2@ashevche-desk.local>
 <20260629190706.647c0274@systembl0wer>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629190706.647c0274@systembl0wer>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 29, 2026 at 07:07:06PM +0200, Joshua Crofts wrote:
> On Mon, 29 Jun 2026 19:39:05 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Sun, Jun 28, 2026 at 12:48:10AM -0300, Erick Henrique wrote:

...

> > > +#include <linux/array_size.h>
> > > +#include <linux/bits.h>  
> > 
> > > +#include <linux/device.h>  
> > 
> > And this is for..?
> > 
> > I can assume one wants to convert the driver to use dev_get_drvdata() perhaps?
> 
> I also initially thought it's a case of an opaque struct device * pointer,
> but the driver already uses dev_get_platdata().

Ah, that explains...

-- 
With Best Regards,
Andy Shevchenko


