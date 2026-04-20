Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1862F3C872A
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 20:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776716698; cv=none; b=qCkP/cWesvTDV1dl8qyeBpt+4LShsOk9gWSzwElMYhuraD4ht08JufpIuLWGEduRVgN7+FINYqBvtrsll69XXIJ6byffdrGeBgFuFfeMV6bHmn8LR6Eb3RE4FXPSwktPDxOxAmCcl7AsiNDmUHesTfndjUr/GQbqgCZ+NA2rRBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776716698; c=relaxed/simple;
	bh=VTpjY+zn7Ef30uc3F8J42OPP0D/QGGk4sFeQ1w03UPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avxIaIKGFu+8jZ9ILw9piruGNaD/EDqaGBkEy9XKJQLcLu6tLUnTHjK7sppW//WWxtZnwa9KSWBi65cRYgBtlsZG3VzMt6eiFpTw5zRNdO3/qD6CA2ZKFIVu1piGcck5kSHRYW90oRQGmylQQglLYix4niEZ/czDKwInr1Uo6Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EMrzqvYO; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EMrzqvYO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776716696; x=1808252696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VTpjY+zn7Ef30uc3F8J42OPP0D/QGGk4sFeQ1w03UPc=;
  b=EMrzqvYOtxN0w7WGy4vHuCbx331LhKJ+swzG/Oz4/Wn+cF4RJ1cDbyxH
   yxBAtUJsjpaC/Gou5NvMH00vsydv7+OcmBeGFZ5VXy23X3oR2DBiDJawE
   Em3i8wV3ESg8ywYc7OJU1JyoW+dc52lk875pmklGhIkZSRMQo3Qt4I0E/
   yGSSiqeFuRWoC+rZHnbhCDeItzcnlUHnaRvgBeerXv6VqpJk9uQSzY76v
   EiPHkzRFydGTuFrCrg0Do/yRKvhIde/4uddPCZm+cxcgUn0NLg8n09NqB
   bLXV6S0HLzbY9u1xNeoEJPmHOTagFIN79EP9S0T8VpM+oFOBW0qOSR6mW
   g==;
X-CSE-ConnectionGUID: W3Gt+wjbRT2v2fU4CfkmJQ==
X-CSE-MsgGUID: i+N6ZTEcTsi0Lo5MPh9iKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77346569"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="77346569"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 13:24:56 -0700
X-CSE-ConnectionGUID: ByXiOcOjQpS21V/XpVEEOA==
X-CSE-MsgGUID: iKghxx+WT5eMjxlmVg3UAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="262210212"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 13:24:54 -0700
Date: Mon, 20 Apr 2026 23:24:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Machado Lage <marcelomlage@usp.br>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	nuno.sa@analog.com, Vinicius Lira <vinilira@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: mcp3422: write bit operations with
 bitfield.h macros
Message-ID: <aeaLk7Cmhp7faQYn@ashevche-desk.local>
References: <20260420191455.529923-1-marcelomlage@usp.br>
 <20260420191455.529923-3-marcelomlage@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420191455.529923-3-marcelomlage@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 20, 2026 at 04:14:55PM -0300, Marcelo Machado Lage wrote:
> Replace manual bit manipulations with FIELD_GET(), FIELD_PREP() and
> FIELD_MODIFY() calls. The resulting code is more readable and
> maintainable, and 6 macros previously defined in the header are not
> needed anymore.

...

>  	/* meaningful default configuration */
>  	config = (MCP3422_CONT_SAMPLING
> -		| MCP3422_CHANNEL_VALUE(0)
> -		| MCP3422_PGA_VALUE(MCP3422_PGA_1)
> -		| MCP3422_SAMPLE_RATE_VALUE(MCP3422_SRATE_240));
> +		| FIELD_PREP(MCP3422_CHANNEL_MASK, 0)
> +		| FIELD_PREP(MCP3422_PGA_MASK, MCP3422_PGA_1)
> +		| FIELD_PREP(MCP3422_SRATE_MASK, MCP3422_SRATE_240));

While at it, please fix the style by making the operator to be the last on
the respective lines.

	config = MCP3422_CONT_SAMPLING |
		 FIELD_PREP(MCP3422_CHANNEL_MASK, 0) |
		 FIELD_PREP(MCP3422_PGA_MASK, MCP3422_PGA_1) |
		 FIELD_PREP(MCP3422_SRATE_MASK, MCP3422_SRATE_240));

But, to me sounds better if you just resplit it it to

	config = MCP3422_CONT_SAMPLING;
	FIELD_MODIFY(...);
	FIELD_MODIFY(...);
	FIELD_MODIFY(...);

-- 
With Best Regards,
Andy Shevchenko


