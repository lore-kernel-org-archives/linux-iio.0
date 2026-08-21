Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C053DDAED;
	Fri, 21 Aug 2026 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305630; cv=none; b=TlZE3bnH9toNAkQ3XWYZrF0pSkNfKCCSE12sAAfSacZTNyBKPQB5wHUBTcFKqk5vGlUswQIa6/gtvpOEIEMD4COioYhduNMdzc/7M41DfORIfBznXAQxLof7T1qFCAG40HS0uwXIieT3dKUuHyCt7Umx7oFPTLIsod8MZ+/XCJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305630; c=relaxed/simple;
	bh=t8v2/ogFndfgh8m90+gQPp4REVawnYyCxxkJjTJIox8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQqbI61dO5pm4+lQshPUkIG23DppzruDdXElAsHY4W/rIs72aqL+5sVR+VdbScewChCfHUkpAl8HVKsP12tufnDWXHM3t3Cju4xgEg0Grq4BsVi+atmVrRAbSTgiSB2LyngXVXnDSxarvHX/fln0VJL75WpU/V2VLEHgfFwaZDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GlCLy6Hv; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GlCLy6Hv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787305625; x=1818841625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t8v2/ogFndfgh8m90+gQPp4REVawnYyCxxkJjTJIox8=;
  b=GlCLy6HvH/L09TDE8dUxKne6kVld2IpAeUx6PYNggY7nLcD7HRdeeuFr
   DrpLW6jTPy4vniat6jhFr8HCRBlXL5uO6nhsDXDZalX9Eo6RsfpleK5hN
   BEMMXFgwPPrtB9VvfP9YSw7/4MjUFS0Z4BX1OdaJo18X8bO/tlHQOvTK5
   7QqGVqvcRiv6kX6FaLr8/zV44X2HYM4dKGIMU6tkgvkHl/zTBajVyaE9p
   ZU/cKio0N/10Gy1p7rszTi4lQNtUvZKOrGLSNrHt/IFuwG6eDcoBct466
   ig5ug2/2jGRlIzNM908r74HUWk//ZAy5uc/T1obkD0XtLRadvR7GxQeah
   g==;
X-CSE-ConnectionGUID: 0jHhaKYwTYCwNr5d8yq9mg==
X-CSE-MsgGUID: YjBIosrnTxq1OM7mVbpZDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87621798"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="87621798"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 02:46:55 -0700
X-CSE-ConnectionGUID: YY5c0jAQQ7CiuzwVDXO3EQ==
X-CSE-MsgGUID: ++tW1p51QbGSL2QypOxziw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="270114138"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.241])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 02:46:49 -0700
Date: Fri, 21 Aug 2026 12:46:46 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Janani Sunil <janani.sunil@analog.com>,
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
	Janani Sunil <jan.sun97@gmail.com>, linux-spi@vger.kernel.org,
	Kent Gustavsson <nedo80@gmail.com>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v9 3/3] iio: dac: Add AD5529R DAC driver support
Message-ID: <aogehm5B7hoqmnKo@ashevche-desk.local>
References: <20260820-ad5529r-driver-v9-0-ba62e0b2a816@analog.com>
 <20260820-ad5529r-driver-v9-3-ba62e0b2a816@analog.com>
 <20260821024503.592fabc1@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821024503.592fabc1@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 21, 2026 at 02:45:03AM +0100, Jonathan Cameron wrote:
> On Thu, 20 Aug 2026 09:08:23 +0200
> Janani Sunil <janani.sunil@analog.com> wrote:
> 
> > Add support for AD5529R 16-channel, 12/16 bit Digital to Analog Converter
> > from Analog Devices.
> > 
> > The device communicates over SPI and supports per-channel output range
> > configuration. An optional external 4.096V reference can be used in
> > place of the internal reference.

> Sashiko calls out that dependency should be on CONFIG_SPI.
> 
> I didn't check it's reasoning but I believe the conclusion is correct.
> If that's all that comes up, I can tweak whilst applying.

Interestingly we have the following statistics (might be a few cases missing):

$ git grep -n 'depends on.*[[:space:]\(]SPI_MASTER' | wc -l
156
$ git grep -n 'depends on.*[[:space:]\(]SPI\([^_]*\)\?$' | wc -l
299

But reading the Kconfig I tend to agree that what we need is SPI_MASTER.
SPI might be enabled for SPI_SLAVE only, would it mean we have a usable
HW on such a configuration / platform?

> Looks good to me, but I'll leave it on list for a little longer
> as we aren't in a rush and others may well want to review.

...

> > +config AD5529R
> > +	tristate "Analog Devices AD5529R High Voltage DAC driver"
> > +	depends on SPI_MASTER
> 
> depends on SPI
> 
> > +	select REGMAP_SPI

-- 
With Best Regards,
Andy Shevchenko


