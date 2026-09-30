Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBB530DD1B;
	Wed, 30 Sep 2026 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760508; cv=none; b=h02mpB+Jbj91oJ7NxJH8r2SR7NhCrEMnEAdXslgYl0M7hx2xZqVCKh+HPQfID7RLmVewqgaxdXUNzIBF/2Uux14aLdsZ+qacnPDC9QDItNZvL9TVU7Sps7tw5vfBItilIMNAX98JkRf0HIBLmWPAunDSfKMDprUQklkZQrqtQEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760508; c=relaxed/simple;
	bh=2sVhLXEz5arjedlrDjdVeFteZRtyWTF64QrSqVTZ5ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1BqhIutBQwltMUsllmnFPCFIWtmB5Y/UhgTOi1efuVxDu5DXWTRnYzrs2z69/0+7Sr0gZ5spATyY5ObJ0vSy3ERcGnsmdEZhOtPXBt5VznfCyJAL9SkDwAuQY3kNoVFikbbPHMGSniT4BleIL/uMFSqxxjuKU1kArc1Br00Ra8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BaPk+Cpa; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BaPk+Cpa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790760507; x=1822296507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2sVhLXEz5arjedlrDjdVeFteZRtyWTF64QrSqVTZ5ko=;
  b=BaPk+CpaqbiJkJBIjU2WWy/hV6nKvw0DBv4Img6cRpzY2PACpRSD7Xn8
   CXs2AC/CJAOdyNC59b6akF+vB8Knd7ufYxfaax+KyLt7a5YacXRv//8C1
   7smkauJgbUWyI9mKhM0Kbhfn0kgo/f3jJ0qppr+o7R3WKk+WdF7CZWs+8
   hgyqOhMAEonkZoD18FpxWSrzwP0uy1huyuCS8ZIEXNwJkRIyn9ubapZj5
   IgMW8yipVZVEvJ+cdUPk84AxJZXdfgHNoIrtjopq0I3TERSOSaFmXy0ld
   eq2gqM9hcukILzpMuEam+ZUu7ZNWfuT8zYGkAIDYApHzXjnMV0bTpEF/N
   Q==;
X-CSE-ConnectionGUID: 3XUXLoIjS/OZ+I4wNvsdwA==
X-CSE-MsgGUID: u2d2di39STee4IJG97nxPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="79060542"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="79060542"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 02:28:24 -0700
X-CSE-ConnectionGUID: kNSOxO7LRpS/D74JgsvEDQ==
X-CSE-MsgGUID: IZvfOd80ShS2WB4o6QrsiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="313577291"
Received: from spandruv-desk1.amr.corp.intel.com (HELO localhost) ([10.245.245.137])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 02:28:20 -0700
Date: Wed, 30 Sep 2026 12:28:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 7/8] iio: adc: rzt2h: Use scan type for ADC scale
Message-ID: <arzWMViKacekCSdS@ashevche-desk.local>
References: <20260929124248.237032-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260929124248.237032-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929124248.237032-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 29, 2026 at 01:42:47PM +0100, Prabhakar wrote:

> Prepare the driver for RZ/V2H(P) support, where the ADC supports both
> 12-bit and 8-bit conversion resolutions.
> 
> Use the current IIO scan type to determine the ADC resolution when
> reporting the scale instead of assuming a fixed 12-bit resolution.

...

> +#define RZT2H_ADC_VREF_MV		1800

_mV (yes, as it's called officially for millivolts).

-- 
With Best Regards,
Andy Shevchenko


