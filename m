Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3A3220F49;
	Mon, 22 Jun 2026 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124216; cv=none; b=mtn12+3VUiVmwop1zO/fM/w5RbZjm+nI7Cquj3Zt5Eu0gcAHn/4qCk4HrMkhp3zuSeBWRhN9l2wrGDGH7osEixNy6TrHlpUf4Zh4PF7zcjp+zvspesEKl2dfdHschvdUP6DG49oHnN92URXnwNDTKb61MMpxlW1I4vBsER9hfQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124216; c=relaxed/simple;
	bh=FJeZG+m1mchVGjrA1q01vDxxhd70qwb1xE7SJS9unBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEpzLoJCNpboYoYFZvLtZZOEptNPpce7lHyXVYm78jeTBfE4iwfCiwR6HeAbCshBQonPhe3gwFc4fe5EsZeNBTsejRt2RgC1Vl8IQCZXedfWNeULujTZIZK3l4Sg4NKpq39qYdRQbTnOUai5sEtmHyjmsms3hhZhBmKHjDHGxcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NedRZCAm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NedRZCAm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782124215; x=1813660215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FJeZG+m1mchVGjrA1q01vDxxhd70qwb1xE7SJS9unBI=;
  b=NedRZCAmkfcuq8Tx1n6Yu2jIkmyoxrfr+PnGVrj4UH3cmn5KoVS9bHEn
   6fC29g/BpD3FTjZZYb8jvgj2rht0w8e2DzzRkGjuWjsNTNW+d2i20rzzI
   gQkPKMjNE/3VZu/s9A0DSmEj71Dy047UfsuF0IRWfTC1z9kSij/GMMhW7
   jVA283lljtwtME5htlh0F5gQGHqf3X7/d3NLjeqzqxUvN2nKt1RVChRNz
   FlSt+uS5YkgjvL2vCIj4JipRug51jUM/L9v+kqjIg6FXupkqgpCbLWcb4
   kbRqL02yqi3e61AvZEF+RQoU3n6C8GNbdcNc1rBhiQ9ok86myyybe4jp3
   g==;
X-CSE-ConnectionGUID: h4Tsdkh1QeOlCSTYr8GFvg==
X-CSE-MsgGUID: 7ea45d6YR1axQLYRHUz2Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="82734961"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="82734961"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 03:30:14 -0700
X-CSE-ConnectionGUID: sUnZa20WSSixihtieadx4g==
X-CSE-MsgGUID: tqMC/Dt0SryN7SOficVxPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="249293780"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.152])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 03:30:12 -0700
Date: Mon, 22 Jun 2026 13:30:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 03/13] iio: adc: ti-tsc2046: Drop unused member from
 private data
Message-ID: <ajkOsT8QCAL-0_hK@ashevche-desk.local>
References: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
 <f90ca5b6d8b694ccd0649d36d590e5d64ae52d9d.1781883685.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f90ca5b6d8b694ccd0649d36d590e5d64ae52d9d.1781883685.git.u.kleine-koenig@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 19, 2026 at 05:54:31PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> .dcfg is a write only field and thus it can be dropped.

Why isn't squashed with the previous one? Also, what about struct field and the
accompanying data type definition?

-- 
With Best Regards,
Andy Shevchenko


