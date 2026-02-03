Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2DF2C08A1;
	Tue,  3 Feb 2026 09:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111893; cv=none; b=QSY0xaTnSJdt16e90FUui6Gibf3wSMRnxRuHdvmtbrNzyVTr2qYv+FGwoF8QtMmcPZ+HXEO5koruV4/a0nQZjx4y1ZmgNKcaK/vREv/9vpTcRFlwN8tUqpfLxz+sNLMHTwO1tKV9vTja106h55SoATwMoNGeL61Wsq7cA1t9700=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111893; c=relaxed/simple;
	bh=VM87jGY3lHpSlcYYmhHoPIon/XDYoiqqoVm4S4uAkrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnTkZX+uqtN93fKRjmvMNr9MIKzvWoxsM517LgemNW2d3+3LjxZErzPYea7f45qPgdjr7+L4TskgyoifwIA1w6S4/9Gnl+ooT88AIl/553rvVhh60OpNC0rNSWZy9VT8nuFDVjTjWek5p0qEoMM9t5KNGFVDYncqsANSoy9KGis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EdydWpbU; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EdydWpbU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770111892; x=1801647892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VM87jGY3lHpSlcYYmhHoPIon/XDYoiqqoVm4S4uAkrE=;
  b=EdydWpbUERk1uLS2N0GrILhWZjTWDSMPaJh/v3ZW/CZnoAty6aSlOiNk
   Wovax0T6LosXtMK6l4tCSmX2/pepI58VrR0ZBheHEPk0I01ldn1Uao3iM
   vJvYNQTI4VwoKw97kLGJEN9UdsUYHum+gMqJDldvS081pFKmh1kRRnQKm
   MWmIsrwl4psvbnPZPVW0rXj5hoOj5oWjlzCcEmpx4SNDUOEMSv5qWRjbE
   UAsyeCQY1ZM01pSdCQnaFRLlLnmFt8UlseLr14FYppOr4pw0NWEDub0hx
   A5gaHMnEbpNx0OXyqr8lSdxObUfcgjGGd2VtSjImRpvr5FqlppE6/hV8R
   A==;
X-CSE-ConnectionGUID: 40n/T74AQa6rhUiz/ny+Fw==
X-CSE-MsgGUID: Oix0uoLjTUazuPPwn9FOZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="88700897"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="88700897"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 01:44:51 -0800
X-CSE-ConnectionGUID: k0Ds7MloSq2eOZdEttdgDQ==
X-CSE-MsgGUID: fvMuBnYsSI2oh+yV7Y0zLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="209814197"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 01:44:47 -0800
Date: Tue, 3 Feb 2026 11:44:45 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Fabio Estevam <festevam@denx.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Eugene Zaikonnikov <ez@norphonic.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/13] iio: remove unused struct fields across drivers
Message-ID: <aYHDjUVQTSa4Oyrl@smile.fi.intel.com>
References: <cover.1770030812.git.antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770030812.git.antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 02, 2026 at 01:25:50PM +0200, Antoniu Miclaus wrote:
> This series removes unused struct fields found across various IIO
> drivers. These fields were either left over from previous refactoring,
> or were added during development but never actually used.
> 
> Removing them reduces memory footprint slightly and improves code
> clarity by eliminating dead struct members that could confuse future
> readers.
> 
> Each patch is independent and can be merged separately as they touch
> different drivers with no dependencies between them.

Assuming it applies cleanly and compiles,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
and I see in some cases it gains space.

-- 
With Best Regards,
Andy Shevchenko


