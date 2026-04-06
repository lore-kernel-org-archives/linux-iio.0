Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3214731F987;
	Mon,  6 Apr 2026 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775500350; cv=none; b=b9EdHvkn/tmnMBLoN/cZKGN8d35nxXNwdwrLnn+U5rNvMragRnyNS12QXBDOZHkIv/UVHccSLnN2nJoVtkcfcpMPqlSfEGsqKXvn4xG0pArwwLS5tEgLV+VRhnJXhlxT4eLd2sGicqAv1RxAN/zC0obt0yIKr5pwD23wkuo91bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775500350; c=relaxed/simple;
	bh=mRvcgifm/AktIi3My4k3BEDKPpqyw8q5/lvuiNW98OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcxgSenGLNNY5fte/LW1HiWo+q2XeYGXw3x5d+RX0d6YiEirCzE/obaeRLJNa/e7ucyIfK8BvWsPYaQ1gVs+hOkebw+GY+KxRc0PaS4/bzjGxx1QpGRDdPBIkV62XezOPp5fRXDMICTjUcxFqtqjOfmCzGW7WaD9DKahI/yBE3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XegBjLNc; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XegBjLNc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775500349; x=1807036349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mRvcgifm/AktIi3My4k3BEDKPpqyw8q5/lvuiNW98OU=;
  b=XegBjLNcefMZIhxuDaxMzauXQvadc8hWtO1pcT6sJlrhitk885CSCGK2
   BPpef44f5Ei5tRjrfhPWg22ouSuR0WkQzRZaBkYaUvH85dunpGyrylW/C
   uQdD1mTKgiHvSV2nxJ3wvx/ib1uOAyH32x6CptZtOdIeXL+K+Gx9c9Z1C
   uHHcv9Xb1O9pVL7oBRK++LTxSAD4vH/BkQahiVuNsep1TiLrR3lb/M9Cv
   wh4rFY+qsVKXPtBNy6A/r4dbVYQzxAAVHJPDuW/PYsNvDMAmdROpJLf4b
   HBqJpYzvvgrjtkj6HtqvfyR12iLnBdHhBzprKtfcCo49wBPPeHFNVaQBE
   w==;
X-CSE-ConnectionGUID: Nh1/RAiyQQuCbhkc5U+oGg==
X-CSE-MsgGUID: WHQ4ixrFSBmDoDviZmKS1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="94035288"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="94035288"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 11:32:29 -0700
X-CSE-ConnectionGUID: cYX+WabTRW6WKMOHF5N76g==
X-CSE-MsgGUID: lQRF+0mCSSeap8/67nWlNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="232343414"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.73])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 11:32:25 -0700
Date: Mon, 6 Apr 2026 21:32:22 +0300
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
Subject: Re: [PATCH v4 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Message-ID: <adP8NnvAjAxDOJ-x@ashevche-desk.local>
References: <20260401-dev_ad5706r-v4-0-a785184a8d53@analog.com>
 <20260401-dev_ad5706r-v4-2-a785184a8d53@analog.com>
 <ac0yEfGzqsbkZh86@ashevche-desk.local>
 <PH0PR03MB63516A449873005315ACFF02F15DA@PH0PR03MB6351.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR03MB63516A449873005315ACFF02F15DA@PH0PR03MB6351.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 06, 2026 at 07:04:44AM +0000, Torreno, Alexis Czezar wrote:
> > On Wed, Apr 01, 2026 at 06:20:04PM +0800, Alexis Czezar Torreno wrote:

...

> > > +static int ad5706r_regmap_write(void *context, const void *data,
> > > +size_t count) {
> > > +	struct ad5706r_state *st = context;
> > > +	unsigned int num_bytes;
> > 
> > Currently only 1 and 2 bytes are supported, right? Any updates are planned on
> > this in the future?
> 
> Yes only 1 and 2 bytes, no future extension. Should I make num_bytes a 'u8'?
> 
> > > +	u16 reg;

> > > +	cmd = AD5706R_RD_MASK | (reg & AD5706R_ADDR_MASK);
> > > +	put_unaligned_be16(cmd, st->tx_buf);
> > 
> > > +	memset(st->tx_buf + 2, 0, num_bytes);
> > 
> > I would use &st->tx_buf[2] here and below for the sake of consistency with
> > put_unaligned_*().
> 
> Will edit for consistnency.
> 
> > > +	ret = spi_sync_transfer(st->spi, &xfer, 1);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* Ignore the first two bytes (echo during command) */
> > > +	if (num_bytes == AD5706R_SINGLE_BYTE_LEN)
> > > +		put_unaligned_be16(st->rx_buf[2], val_buf);
> > 
> > The comment wants to explain why it's required to put 2 bytes anyway.
> 
> Will add clearer comments for this
> 
> > > +	else
> > > +		memcpy(val_buf, st->rx_buf + 2, num_bytes);
> > 
> > However with the above question in mind, if it's all about 1 or 2 bytes, can't we
> > simply use the same approach everywhere, like put_unaligned_*()?
> 
> For consistency, put_unaligned_*() can work. 
> 
> Although since rx_buf is u8, this line:
> 
>      memcpy(val_buf, &st->rx_buf[2], num_bytes);
> 
> Will look like this for 2 bytes:
> 
>     x = get_unaligned_be16( &st->rx_buf[2] )
>     put_unaligned_be16( x, val_buf )
> 
> I suppose the mem* commands looks cleaner

We optimise it a bit, so what you are going to have is something like

	if (num_bytes == 1)
		x = &st->rx_buf[2];
	else if (num_bytes == 2)
		x = get_unaligned...(...);
	else
		return -EINVAL;

	put_unaligned...(...);

-- 
With Best Regards,
Andy Shevchenko


