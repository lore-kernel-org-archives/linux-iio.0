Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A8B1E492D;
	Wed, 19 Aug 2026 04:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787114543; cv=none; b=ro2cbeRLjzJ/rz5tEHD1hOmKsp9Tsi3C5if6Ai3btnwyLSe2AyaoecklZFX3rIYb327lXzpefGOqYldacZXUUfEnfLxBesVuOWWQK1BEMqi/E/K4Eg65N4aRDI5SjI8vLL6c+IVuEwzW2E/BtOGD6uA19ua03gHv+xgG/VjvvqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787114543; c=relaxed/simple;
	bh=zGAfl6njJ2yv5Zb+YU1vfmsT5kSSXG+UJib3TjnSnSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIy8dEgj6I6S26GaSt8xjzYXSoVG0OJxhrljq+qU5+XT2Rksq/XI4zBTGY8b5tzZXX7PApDD8hkt50f2PcXCQAU7F1gcq29irXvx/lA8XlSptVCO4IkjGLirkP88exwOtASXULFIdx5ev3k31DvFstdtfYBgarX+yKYM/nMxLRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W6QC24tk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W6QC24tk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787114540; x=1818650540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zGAfl6njJ2yv5Zb+YU1vfmsT5kSSXG+UJib3TjnSnSY=;
  b=W6QC24tkv8JYS5D4Kc++fNhUYKW4dUAUdL+aiOAlvJj2Lx1GilZstb1a
   Vw8JvlcZwpBfzZmoV3YS38gdlaPAmi8CcOt1WYqKkOfcB/qkQtViHYEAv
   a67ph1qWDh/98GqzFOHBXpiLbWVDU/UtM4xFstYX6ncy6avZ/2PXXYJxK
   roGFjquIQabObcvMuOr00hjOetxOxMHX/0cnqxPMyzkjQUvlLfYCdcqUq
   RK8qV1U5ac+M6qPq0FxRuTce5EF9Z2iQzEvZUy3Mg5YnbaVFNQ+Dik7O3
   r6VGhJcsRo9oehSr7J9FuNVRDDOLJfC/93xpLLVHVPaHQ0VwfSx3kgyum
   g==;
X-CSE-ConnectionGUID: N93NNs54QeCgzkLWtgUcLQ==
X-CSE-MsgGUID: 6uczi2WzTICLWSoq1JJv1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="86733259"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="86733259"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 21:42:19 -0700
X-CSE-ConnectionGUID: EO2jpSA9TJuhc7PK6kOYKQ==
X-CSE-MsgGUID: sdwCRwdiS2+TbcABRr8+UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="269704719"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.106])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 21:42:16 -0700
Date: Wed, 19 Aug 2026 07:42:13 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/4] iio: light: veml6031x00: add support for events
 and trigger
Message-ID: <aoU0JSmv7FWGW_Ms@ashevche-desk.local>
References: <20260818-veml6031x00-v7-0-2b0de0f20edf@gmail.com>
 <20260818-veml6031x00-v7-4-2b0de0f20edf@gmail.com>
 <aoRltgy0AYZ_Vcum@ashevche-desk.local>
 <DKS790BEXVON.1FP9LQUPNTYDE@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKS790BEXVON.1FP9LQUPNTYDE@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 18, 2026 at 06:10:51PM +0200, Javier Carrasco wrote:
> On Tue Aug 18, 2026 at 4:01 PM CEST, Andy Shevchenko wrote:

...

> >> +	ret = pm_runtime_get_if_active(dev);
> >> +	if (ret <= 0)
> >
> > < 0 seems too much to me. If there is disabled runtime PM (and supposedly
> > device is always on) this prevents from getting events.
> 
> I am not sure if I get this. A reference is unconditionally acquired
> when events are enabled as well as in buffer_preenable, and also in the
> probe before interrupts are enabled. Runtime PM should be active at this
> point. If not, the interrupt should not come from the device, even if it
> was on (e.g. before autosuspend kicks in). But maybe I am missing
>  something?

The device maybe in these states here:
- powered off (by runtime PM) ret == 0
- powered on (by some previous activity) ret > 0
- always on (PM is disabled by user space, for example) ret < 0

Are you telling that the third case is impossible? (Note that autosuspend in
this case is irrelevant.)

...

> >> +static int veml6031x00_hw_init(struct veml6031x00_data *data)
> >> +{
> >> +	struct regmap *map = data->regmap;
> >> +	struct device *dev = regmap_get_device(map);
> >
> >> +	__le16 regval = 0;
> >
> > Redundant assignment.
> 
> regval is assigned here to write that value in the first instruction
> (regmap_bulk_write()) after the variable declaration.

I see, then make it clear by splitting assignment.

> >> +	int ret, val;
> >
> > Why is 'val' signed?

	regval = 0;

> >> +	ret = regmap_bulk_write(map, VEML6031X00_REG_WL_L, &regval, sizeof(regval));
> 
> Here.

> >> +	if (ret)
> >> +		return dev_err_probe(dev, ret, "Failed to set low threshold\n");
> >> +
> >> +	regval = cpu_to_le16(U16_MAX);
> >> +	ret = regmap_bulk_write(map, VEML6031X00_REG_WH_L, &regval, sizeof(regval));
> >> +	if (ret)
> >> +		return dev_err_probe(dev, ret, "Failed to set high threshold\n");
> >> +
> >> +	ret = regmap_field_write(data->rf.int_en, 0);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	ret = regmap_read(map, VEML6031X00_REG_INT, &val);
> >> +	if (ret)
> >> +		return dev_err_probe(dev, ret, "Failed to clear interrupts\n");
> >> +
> >> +	return 0;
> >> +}

-- 
With Best Regards,
Andy Shevchenko


