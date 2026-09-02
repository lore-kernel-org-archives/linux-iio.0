Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC9E31F98E;
	Wed,  2 Sep 2026 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346974; cv=none; b=DidBOLAV6IBfeJApCLPtfXVfXHt9wRLJqmiGySJcV4T6aH5mFIobfoRjS20zlWsf1hU1X2bcfD1y6Li6YY75Ztiv+3qiOfEHlgx4YTLYoQF/s+1178p+HGqNOa0Aa7CMLX8cpCnsDZ16KFS/R3ChEcRyK4DmhG9OuZ5aQp7vRLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346974; c=relaxed/simple;
	bh=QDIu2KNP99Ja5J5CxxlX8SGwIhLbH5hz3Yi2K4FYpdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cI/otYGnc/85JFMk/HETA8Gje3d15mq14UBd3NRCjKHkrqUsKND+giM3k2zzW1MMVfrNqb6veNx5KXyzYrVUEI11j43XhDjy1GSvDe/Uk7hQlCuqIeFimqDJYIM6H6+Q18LzPgnuCWA2cDyZjMxp++wkOlarF2shUpV4314Hgo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=INES5aQF; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="INES5aQF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788346973; x=1819882973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QDIu2KNP99Ja5J5CxxlX8SGwIhLbH5hz3Yi2K4FYpdA=;
  b=INES5aQFbwT0ddH2UAlkKUtN2qaG0WCTc892ZPymiXWtwJ0gdenaHHEZ
   3sfq/03DWG69AXn69BVbgUUsOL8p2DcYXL+EUKeJqDy4fjXkVzpK+BWel
   N+Q61rfv2RLYMK1QH3e/1RczeqBH94oQHGZWulQGmxHqfxpcPYCsAtRue
   0lyzTGf/FTHcrD7DyNj+ihBCf2NeFskg4oYIuFs1q710xY+8bwMw8nP9Z
   qFPEMHBKePWaNbz2adjNE3vx3p/rYAgB8wm9gaDnpbAyo03Tzlhog04d9
   9fMzPqCbSgSTVCOIJWOLhw64YK8LtXOnu9LBnaXQvsyav8OLrT7t5kcbo
   g==;
X-CSE-ConnectionGUID: RVfhUA/vTmW7MdKda5CX5g==
X-CSE-MsgGUID: MebetcACRK64KdEsY27Dxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="111571203"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="111571203"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 04:02:52 -0700
X-CSE-ConnectionGUID: nDsLt4K9RA+MtI2/zg1M2Q==
X-CSE-MsgGUID: OfBGuYvRRB+9nYzVNAP5KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="269395361"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.118])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 04:02:44 -0700
Date: Wed, 2 Sep 2026 14:02:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Janani Sunil <jan.sun97@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Janani Sunil <janani.sunil@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-spi@vger.kernel.org, Kent Gustavsson <nedo80@gmail.com>,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 3/3] iio: dac: Add AD5529R DAC driver support
Message-ID: <apgCUiOL3Of9P_e1@ashevche-desk.local>
References: <20260827-ad5529r-driver-v10-0-38f2be07b824@analog.com>
 <20260827-ad5529r-driver-v10-3-38f2be07b824@analog.com>
 <178813261957.2788519.4929586195765891569.b4-review@b4>
 <0c5a657d-e134-49a7-b2cd-82f293685cb7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c5a657d-e134-49a7-b2cd-82f293685cb7@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 02, 2026 at 10:48:58AM +0200, Janani Sunil wrote:
> On 8/31/26 01:30, Jonathan Cameron wrote:

...

> > Why do we need those outer () ?

> The outer parenthesis are required by checkpatch for macros with complex
> values. The same pattern is also used by AD3552R_CH_DAC() in
> drivers/iio/dac/ad3552r.c

checkpatch is wrong.

-- 
With Best Regards,
Andy Shevchenko


