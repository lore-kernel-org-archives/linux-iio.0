Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722393;
	b=pQRufnk1QMCdom8f+fzQ1cy+euvsTZq0nd5D2uR8XpygezKv3cmmiv9g8YGyomla/uXK
	 n/CoS16lh594xCmCF6zgUBvp6hmpCjq0t0HA57WFswlk7/dwo5+yPLo+gqzl8STYfaWJX
	 Hu41IX/gQ1WSogQ1jC7Rhk4WCRLPtRz6cTjpHd58os9rU1bei01L0dMmIq8xSQr+GV6Rg
	 X7zqUZc/lyYs2ey/HiQg/ej0/hKdGjs4ii6PWazxihhmouO1sdX3U1LxW1mw+ihP0Rd2b
	 yAsGnpa68Y1aC49hsDHnM3ZO/AaUbn5fYoH475uh9ywfLuUEuSXcTVlp88X14L0v3BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722393;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=ZUdSHGLaZ0x2ZTr7S5xk6f6VQ65wPDkIQdbNaQyecVU=;
	b=W5a149CeJ0TlZP3YrdlF1+PYZ38MKG5lJx/zZ0uQ2R5/y7JlCt9jZ/idDtodaF93m1zb
	 pH88thDjtEo6Le+/egPzMH2C4dQ6sza386WThKH//rbJer3BH/6SX4GsYeT48HZSR4PPh
	 R6F2FbBEEvCiUWrkOMryuoAhTFiNgeO2eruPB24tkyO87uAObakEXNVNiG2ZQ6eZibayc
	 CyDvMXUUXdc/WdEghfX8uKWBZq2x2cNw4n6eIvavULP730nhb+9DmjSFwQPmqdBgsy7vd
	 VJFz3hM6pUmwekdbARzuhxJeWxhjIfQQysNDUFG50EchWL1JT3X6ge7jGzOMO85cqbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mbFndIz1;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5FA6082BFF;
	Tue,  3 Nov 2026 16:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE5FA6082BFF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mbFndIz1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793722393; x=1825258393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ij5ApUrtJjGnjtt0TprVV+c5oLMaSpv55TOI5b/crAI=;
  b=mbFndIz1bUutQvFVJS646OzipwOd9+SL9YU/FGZESGV8TV0Q3Ka1MXuM
   No9AbhB0POXqH8WSOvf1aWumagBvhqpN6OmCs0BkEyRXVo1kHuqpKZlAY
   uzx9DVEO49KDc7501GW4ixSrMrdWD86jnKi0n4sBGN8+IQz/kTy3+XieD
   FwCUwi9XPSP1NavSo0eKMLoIXAaMggTndUrdNooiAeupjvQGEAJhGgVkl
   MLOJxNgn7p/e5glro2TbhYMmIBCW8Of/QFMQZdKvCixwQWHvd0Geq4Nlb
   pqPjvAezdBQ8nIpZFAqwYwdNNw2hQP55hJVZtnhT5M8WCjNj7kLEDK4Kw
   Q==;
X-CSE-ConnectionGUID: Y9q/uQuTTCWBEYu2Y00vKQ==
X-CSE-MsgGUID: uOcEEqzrSnahL+T/2iHKYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2446662"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2446662"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 08:13:12 -0800
X-CSE-ConnectionGUID: bEkUO765QH2MUg9RIn00cw==
X-CSE-MsgGUID: VlNKxX4pT5iLTAzgkZqpUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6527577"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 08:13:09 -0800
Date: Tue, 3 Nov 2026 18:13:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marius Cristea <marius.cristea@microchip.com>
Subject: Re: [PATCH v5 2/5] iio: core: add IIO_CHARGE channel type
Message-ID: <auoIEpE7KQ87wGDm@ashevche-desk.local>
References: <20261103-pac1711-v5-0-71c20101a52e@microchip.com>
 <20261103-pac1711-v5-2-71c20101a52e@microchip.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-pac1711-v5-2-71c20101a52e@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 03, 2026 at 04:37:12PM +0200, Ariana Lazar wrote:
> Add a new channel type for Coulomb counters, which accumulate current
> measurements over time. The sysfs attribute is in_chargeY_raw and after
> applying in_chargeY_scale, the value exposed is in milliCoulombs,
> following the SI convention used by the IIO subsystem.
> 
> This new channel type will first be used by the pac1711 driver to report
> Coulomb counter measurements.

> +What:		/sys/bus/iio/devices/iio:deviceX/in_charge_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_chargeY_raw
> +KernelVersion:	7.4

7.5 at the best.

> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw charge value read from the channel. The device acts as
> +		a Coulomb counter by accumulating current measurements over
> +		time. Units after application of scale are milliCoulombs. X
> +		is the IIO index of the device.

-- 
With Best Regards,
Andy Shevchenko


