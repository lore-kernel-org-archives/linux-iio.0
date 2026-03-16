Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3D038E124;
	Mon, 16 Mar 2026 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773656864; cv=none; b=Zhk34DC6f72pIpzjIWNtVtDGJgaErYm9eSBrQkSNEs6eniexHh1eZ3lvq5rzk/3ITBTaJOPodODtD6E1Aaaw7iO+cdfY3Q/OlfwuW9owmTMrg8angTxQMDgqn4J9AnaWezHuvsFUeaU6nUNk7nwn/qOpIv7DikTBQ4CFcTXffnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773656864; c=relaxed/simple;
	bh=xHbC15Av+mVN56628rDyUUF3vqnT/6/26LWQ2kojBD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9Nxn238BfVQP5G0df2VG4X1C6fz8QKYxRc6vdZ1XhE3GSYG5fTkEJ7XGcpfutKt9M/WGaqj5acS8wM3lkMKffFLd9vGNP7CN6K0qBMO2DU9r1CYm0IHp5mLvpPHAhgC2LC8oAT6YXXv+REP4q8DGGbKJ4FRvf8Hz8aW4mw8Y2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eEheYhW7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eEheYhW7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773656864; x=1805192864;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xHbC15Av+mVN56628rDyUUF3vqnT/6/26LWQ2kojBD0=;
  b=eEheYhW77LuT2/lJtO9+KyC2QscsjYqruV8Lh4Ak7P8IArf4LFjLfVTd
   3VZBsl9g3HWjPrsaA7/CdVr3Bm2yFDERlzrDSZOrAYdCD/leqPf0rIfRA
   xspq7ktJa0xoPVVl8lBpX7N1i7tX2ow4e+Z/nOKe/XZw0cRTl+ltFQZS+
   ZNGs3uqekZF5Rbbbo9fEuhiw6N8a0lISaXLOVz9e2MT13cQ56meu2R66g
   sCDLAFg0bCfaxs/pR6B+qXR3NvwdlbiXFusxLLa/FMHD+SOv3FqR3K3CA
   wD+PXYfpYf1qOQYnzlRA4tWhNRaw43qmj+bk9jSud91Mxa2TZpNJ+ycDm
   A==;
X-CSE-ConnectionGUID: +2pFjj+dQuao+8Chv+se5g==
X-CSE-MsgGUID: 7RkcF0eERAm/+btk7uS7MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="78273244"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="78273244"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 03:27:43 -0700
X-CSE-ConnectionGUID: ROvAPVjsQ5iwvM9K1gEjnw==
X-CSE-MsgGUID: A6/44649QN2zvNLiCVt06g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="244906029"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 03:27:38 -0700
Date: Mon, 16 Mar 2026 12:27:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	Raymond Hackley <raymondhackley@protonmail.com>
Subject: Re: [PATCH v3 4/6] iio: light: vcnl4000: add support for regulators
Message-ID: <abfbGGvcfJpRdqDZ@ashevche-desk.local>
References: <20260314-vcnl4000-regulators-v3-0-3c4a48d30676@gmail.com>
 <20260314-vcnl4000-regulators-v3-4-3c4a48d30676@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314-vcnl4000-regulators-v3-4-3c4a48d30676@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Mar 14, 2026 at 06:06:33PM +0200, Erikas Bitovtas wrote:
> Add supply, I2C and cathode voltage regulators to the sensor and enable
> them. This keeps the sensor powered on even after its only supply shared
> by another device shuts down.

...

> +	ret = devm_regulator_bulk_get_enable(dev,

Below is broken indentation.

> +				      ARRAY_SIZE(regulator_names),

There is still some room on the previous line.

> +				      regulator_names);

	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
					     regulator_names);

OTOH the logical split is rather to have the last two on a single line, but
that one becomes too long, so your initial variant is okay with fixed
indentation.

	ret = devm_regulator_bulk_get_enable(dev,
					     ARRAY_SIZE(regulator_names),
					     regulator_names);


> +	if (ret < 0)

Do we need ' < 0' part?

> +		return ret;

-- 
With Best Regards,
Andy Shevchenko


