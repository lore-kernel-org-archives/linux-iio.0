Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6293D3BE63E;
	Wed, 25 Mar 2026 12:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440786; cv=none; b=WgrzImShNaaSnawPV2+IqF0sk48/gOPBxmztb1eAQuI2IlUKMqTufqym6r6i03gY6l4PxQKSSy60MHyZYLaYnwW0Ki7Xd9TwP0rE0jSdYb/u9NUD8UI2bm/x+R5yeAui227IpyAypBa9bKSSa5PVUwMZhf3wOcxOIVQdAHonAv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440786; c=relaxed/simple;
	bh=4b6xUiTXHzePN0g2sCrkKE5vlCv6hPj3JaThR6jfupU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZdfyA5xO1ylJaAUOtZd1gQJ+cHdY9L/kRg8xL5SGhxz3oy6Ew04ZPc7Lc5QTOGYfGNWg+B7dVKz428OmAOUdvAiThnXgtpUNDSYmSfOsrwLduUQJNbGZY6l9vWE51ET12B8YmgfUkik/rTuYl8tQUFClybsD0ZRonMxKaUIYNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MiKVgoiX; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MiKVgoiX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774440786; x=1805976786;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4b6xUiTXHzePN0g2sCrkKE5vlCv6hPj3JaThR6jfupU=;
  b=MiKVgoiXEh8/Vnu6jljIPBSVA9kFLHfHO0IHxbwqX0+bLIgisjL5H37R
   5BpoI9EgUVM2i1J/ccpU5M2k5xvh44eVv/SGZTH9P7OqU2q+C7OdKk4Zd
   MP7zX6TME72mSjWZguWPLHfteQjKuk/7GhwhO/vslnsaMZiG59ZOVPPvJ
   I4LnbNegqo8kSSGMT5SyxUPIviNsa26DU1CY3DTw/GaU3Te2M+stRqAIB
   pW3r5fmbsbS8u6LibPZG9QRoU9ij/lI+nT3WBaN+Ra6tJ7CgXc5MVrBFE
   H7QAsKZ65IzjT3gzCWPYT6O90tckZe1IRQJ8m2bgEK4qcsmOVchHkfq4R
   A==;
X-CSE-ConnectionGUID: XzqdgDxjReKAdotDMlUUcg==
X-CSE-MsgGUID: aEATqpJzRL6z0rkNACtL9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75191082"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75191082"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 05:13:05 -0700
X-CSE-ConnectionGUID: XCyAjOpnSdu6xvnYQ34lTA==
X-CSE-MsgGUID: l0NW04geQQ6AC7iIyLNypw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="218089774"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.32])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 05:13:01 -0700
Date: Wed, 25 Mar 2026 14:12:59 +0200
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
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Message-ID: <acPRSzrHUtSEx-J3@ashevche-desk.local>
References: <20260318-dev_ad5706r-v3-0-5d078f41e988@analog.com>
 <20260318-dev_ad5706r-v3-2-5d078f41e988@analog.com>
 <abpfdELI33a0Ncl3@ashevche-desk.local>
 <PH0PR03MB6351A1A32896F5CFF05A4C10F14FA@PH0PR03MB6351.namprd03.prod.outlook.com>
 <abugoaMtEV75Fyk8@ashevche-desk.local>
 <PH0PR03MB63519301C13837DBD94535E2F149A@PH0PR03MB6351.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR03MB63519301C13837DBD94535E2F149A@PH0PR03MB6351.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 25, 2026 at 01:07:44AM +0000, Torreno, Alexis Czezar wrote:
> > > > > Changes since v1:
> > > > >   - Removed PWM, GPIO, clock generator, debugfs, regmap,
> > > > > IIO_BUFFER
> > > >
> > > > Why was regmap removed?! Was it not used?
> > >
> > > As far as I understand it, regmap also gives access to debugfs. When I
> > > removed debugfs I also added regmap as removed.
> > 
> > Not only debugfs, and it's unrelated to the any custom debugfs interfaces in
> > the driver, it's just a feature out-of-the-box of regmap.
> > 
> > > For the spi write/read I am not using regmap as the device has some
> > > features that I think regmap_read/write couldn't support. Namely the
> > > variable data width, as the device only accepts exact amount of clock
> > > cycles. Future patches will also add variable SPI speed.
> > 
> > We have a lot of flexibility in regmap core. Do you think it can be improved /
> > extended to cover the cases like yours?
> 
> To neatly summarize, my needs are: (in future patches)
> 1. SPI read/write can have different frequencies and runtime changeable

How does it related to regmap? Is it dependent on the register?

> 2. SPI data bits needs to be exactly 8bits or 16bits depending on register width

This is solved very easily with regmap, no problem at all (two regmaps with
configuration for 8-bit and 16-bit registers), I believe we have even driver
in kernel that does exactly this.

> 3. DAC Device reads SPI command bits [14:12] for communication, not just chip select

Okay, but I'm not sure how this is a limitation...

> For regmap to be used
> 1. regmap_config would need new read_speed and write_speed entries.
> 2. val_bits must now be changeable depending on the need.
> 3. I think the read/write_flag_mask can do this.
> 
> 1) is relatively easy I think, but am not sure with 2) as it might break other regmap core code
> that already assumes it to be fixed.
> Feels like a lot of work for a niche amount of devices, I may still lean on the opinion of
> keeping regmap as is.

Okay, I leave it to others, for the simplicity we can leave driver as is, but
make sure you put the summary of this into the cover letter, so we will be
crystal clear why regmap hasn't been chosen.

-- 
With Best Regards,
Andy Shevchenko


