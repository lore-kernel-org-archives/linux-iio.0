Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B65378D72;
	Mon,  9 Feb 2026 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770652103; cv=none; b=Avb8RSOliE8pE9FW7EylnKfhCb6aqNGfmO02FEshjHjROwyq+NkiMou8sE1Zhvi1nyZZcC6+ZAx2GimuBQKSG/hw0m0Cunw6a2YlkJGO6nwyN15WR6PMoEHHK1yDdjG7IRuHQ/SmHmdryBF33W7LLz/P6YNbDPG3QjxdNvvLFlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770652103; c=relaxed/simple;
	bh=b1r0+pb4BqBOL+hijKwyixcsftgMqG2aE47GllsbZTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxLsS6G/qo8Rk673C/rLo+S+jR9z7ZIWnbdHosV7MzxQDv/El1Z8jICWUD2CiW9zkrzKzmFevBaJmiJWR2umSXyV60o1Y2EDl6i9pM6D64Xcj/FipPYnKYjzsYKwiLgLX8MTZQik+FMTRbUpeNl7o7T+Vv+UznlXGs0USkSBBGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ABuyQX0g; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ABuyQX0g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770652103; x=1802188103;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b1r0+pb4BqBOL+hijKwyixcsftgMqG2aE47GllsbZTc=;
  b=ABuyQX0gAKjQjfrJ7PQ+ABWYu7qaJyxHSogXA7TwisfSXAq5frWzLs/v
   Ygn/IOQVgc/tYhVJIeW/lc+kyjuYnt5XabwHVqHuopWN3biZe4zKv+RcA
   qzNgnwCpe4xcLvDNTw4rt4j+lb+cjLX86R0A0wZCDyoKbRy5Qr6uMYM0l
   iR8PkhFkzIfih9mK25KzLkNcaCwIMOTvZcD8yeUr4hhEX5MUQ2O4ZW4si
   U+CdDmZOQVtRljjyXpEuoL5P0AEdCnGsRccSxdGhljxxCxdWps03XteMV
   iF6pRlLcJN0ZO8izFh0BErb+K0yiKfuNybx2zAjesbuk+47y1oHuG90IG
   Q==;
X-CSE-ConnectionGUID: FPvbropHSEaZHbj484hFbg==
X-CSE-MsgGUID: CdTkRb3mQQuM3Ry9kmA7sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="75612988"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="75612988"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 07:48:23 -0800
X-CSE-ConnectionGUID: TWviWV6EQfWVW6dzzBD3fA==
X-CSE-MsgGUID: 8NUa6r9nSxKwiuFpVQGr+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="216144473"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.128])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 07:48:19 -0800
Date: Mon, 9 Feb 2026 17:48:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kevin Tsai <ktsai@capellamicro.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: light: Add support for Capella cm36686 and
 cm36672p sensors
Message-ID: <aYoBwFW4ZDFhmlvy@smile.fi.intel.com>
References: <20260209-cm36686-v2-0-a48126d2b124@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209-cm36686-v2-0-a48126d2b124@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 09, 2026 at 04:23:40PM +0200, Erikas Bitovtas wrote:
> This patch series adds support for Capella cm36686 and cm36672p ambient
> light and proximity sensors.
> 
> Capella cm36686 is a combined ambient light and proximity sensor with
> adjustable integration time, interrupt and hysteresis support. It has
> the slave address of 0x60. cm36672p is fully compatible with cm36686,
> except that it is a proximity-only sensor.

So, can we share the code (assuming there is a driver and it already
uses or may be converted to regmap APIs)?

-- 
With Best Regards,
Andy Shevchenko


