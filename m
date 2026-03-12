Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1E63C454D;
	Thu, 12 Mar 2026 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320632; cv=none; b=nI085zbaamIdJhH64WD+Gx9LoNZDbBrVj0XqoNaY8/TPR8ds8+4PzPFm4H7Oldfj9+IY8wjjadBDGtJFZe0EcLnTIawzdN6HGM8xm82B7BdWy1dKk4KcCPa3M2xwTynOJdv52gZXeD57KTuqkHudCGERLunXrfDBN2Y3BrBWWUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320632; c=relaxed/simple;
	bh=gjypggSQBOrd2HyjZTnyYsjl2Zemo2w6kixok8o6l0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePeF3hUn3D7e4eZ6Xv8AMhYQqJ2WR9buNTVVglnspcd00akrldinGlXyYRWLnfPrK4jimAr12oNpVV/Tz2H52cOJOdWZcpVu1FDIK/qMSzuu/4gS43hE5JLRX+emErMh6GPlJEG1kS/n11Avk/jgBVHT6TlFOSTA1omR374yZFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WAYItyCr; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WAYItyCr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773320629; x=1804856629;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gjypggSQBOrd2HyjZTnyYsjl2Zemo2w6kixok8o6l0g=;
  b=WAYItyCrpCsr1P4X/p/HyGlCxAQGpscb1EU0Hvusg+X+McZ/Mnyud+W6
   I5Gp8nBjJuFEka5Zxotod/RfMiiEPMHXJhDq4FAiZxK64frl6nv9fCPmE
   9jEmDOdCFb3ndt52x5Lya7ctsdxeHJzJAPkagPfpdES8IiYa6VeAjWMkn
   f1JLCTWda1rj4MhTvDliqXLihkc7MbA2z7sr4aps8N+XEMmdfqiom+SGD
   GwRYympeOB2FAJeI6BqXUXCwMh/wBIc+IZ008NPDOr2xxcyz8UJG08nMc
   UVrgC3xJOJCVlkUtt3yxcGlfkLOJ2O9YVpnYMZU0vp0cm1V3M6M5MuCO1
   g==;
X-CSE-ConnectionGUID: UjJXg/eUSXi+VqnYtgET0Q==
X-CSE-MsgGUID: wXCdx/FwT5+C/LUTgL/NHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74110519"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="74110519"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 06:03:48 -0700
X-CSE-ConnectionGUID: 7X3sK8IDTKGoDBRigbidlA==
X-CSE-MsgGUID: x0p9F0gwRQ6r/G/39GqFOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="258721868"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 06:03:45 -0700
Date: Thu, 12 Mar 2026 15:03:42 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio: dac: ad5706r: Add support for AD5706R DAC
Message-ID: <abK5rhAP_w3GzD8u@ashevche-desk.local>
References: <20260311-dev_ad5706r-v2-0-f367063dbd1b@analog.com>
 <20260311-dev_ad5706r-v2-2-f367063dbd1b@analog.com>
 <abFVl8NhfBkvyI4I@ashevche-desk.local>
 <PH0PR03MB63519615ACE22ADE4055D2DBF144A@PH0PR03MB6351.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR03MB63519615ACE22ADE4055D2DBF144A@PH0PR03MB6351.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 12, 2026 at 02:32:21AM +0000, Torreno, Alexis Czezar wrote:

...

> > > +	st->tx_buf = cpu_to_be32((((u32)reg) << 16) |
> > > +			((u32)val << (16 - (num_bytes * 8))));
> > 
> > What the heck is this?
> 
> I'll make this more readable.

The problems with the above are:
- macro style (it's not a macro, no need so many parentheses)
- unneeded castings (C promotes types to int)
- "clever" compression of the standard patterns (see below)

> but the format goal is:
> 
> if num_bytes = 1
>     tx_buf [31:0] = [reg 31:16] [val 15:8] [ XXXX]
> if num_bytes = 2
>     tx_buf [31:0] = [reg 31:16] [      val 15:0        ]

Assuming tx->buf is of u8:

	put_unaligned_be16(reg, &st->tx_buf[0]);
	if ( == 1)
		st->tx_buf[2] = val;
	else if ( == 2)
		put_unaligned_be16(val, &st->tx_buf[2]);
	else
		ERR!

(can also be switch-case, but it will be more verbose).

-- 
With Best Regards,
Andy Shevchenko


