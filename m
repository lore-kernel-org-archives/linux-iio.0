Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432E143802A;
	Mon, 13 Jul 2026 16:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961088; cv=none; b=tUh2Oqwy1nUGTgHiGluzZQl53yzLiJhjhLkrtsi6wP2iPZ46ZrXktg23Ii1SjjKn1HEK1yOjU3dQBFHOUcmAjbdhVoh0wXdruVX/MXKVFd0P+JfJzp8vpAaI4Qj6CD8WVE5FT7Ptcl239ghozWMQRSQeAVlwzS6/Q2a0KsLkxkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961088; c=relaxed/simple;
	bh=sCco0kaI7YWvvlrb6Ui1LZEDzwhkKahlPxWQbJaYAFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2DwUlLhpdXJ9Hj6bysUjCBMBgcDEnk3PDfSZYPF2GIox9owjIN3yvmvaQnSF426FWynkV4wK9tA6lQmfgEkwoHzPEgy4DKplJtvxGQAL/FWq+PC+yy7qmTf/wkolPF42gMSV95yJeYoJUOMPmGSBwl1MAObIK2ceKRLpGw7DLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dGob5sz3; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dGob5sz3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783961088; x=1815497088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sCco0kaI7YWvvlrb6Ui1LZEDzwhkKahlPxWQbJaYAFA=;
  b=dGob5sz3FaGWLbeEY/Txwb8lSYTF2Bop/Z2tCklpmLfGTp2+Sj5m3YpV
   ZD6O+WOAM+DqpDT6X0Gc7CJo1dsE6L9mdrfVVdyOm/hoVpeYT4tUaA2yB
   Sg7NC3aAPvpeIJlFi10Se7anLRX1e3OuMsp8bGpo0kOKTMRqR9raN5gII
   RbGvBdbdTiMosaJPXxu9wwxaIjV3+Ui8TbaCZ/Xy3B5Y50mL29hufagIf
   3r2Y7guXATFmzk1GUR3YLTTFVoJBKskXSqRqGL1VwwosBLo4KF/L7YsqQ
   3XuZ6qXP+BmEeIl2FEKWwa1puDG6Hy7XJ+SOoFuFxQ+2JYbsqhisFFKjw
   g==;
X-CSE-ConnectionGUID: 5JmJeBiqQhq/N79lFomBvA==
X-CSE-MsgGUID: GMfVwICkS5agKG2u/k9vFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84592518"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84592518"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 09:44:47 -0700
X-CSE-ConnectionGUID: 86NaOQT5Q3ivBIxNG+ixfQ==
X-CSE-MsgGUID: KufUr2v2RQeoOg0aU6f+Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="249247198"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.88])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 09:44:43 -0700
Date: Mon, 13 Jul 2026 19:44:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v7 4/7] iio: dac: ad5686: implement new sync() op for the
 spi bus
Message-ID: <alUV-Ht2BYkhbNsO@ashevche-desk.local>
References: <20260710-ad5686-new-features-v7-0-1bcc8c280e4d@analog.com>
 <20260710-ad5686-new-features-v7-4-1bcc8c280e4d@analog.com>
 <alM8M78O9-cRSxR-@ashevche-desk.local>
 <2shq75gvzzm27rodbgmtxkbgt5n2a7dafjc2mmkttwnshmhyqr@pdytastitwfm>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2shq75gvzzm27rodbgmtxkbgt5n2a7dafjc2mmkttwnshmhyqr@pdytastitwfm>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 13, 2026 at 05:18:14PM +0100, Rodrigo Alencar wrote:
> On 12/07/26 10:03, Andy Shevchenko wrote:
> > On Fri, Jul 10, 2026 at 12:20:48PM +0100, Rodrigo Alencar via B4 Relay wrote:

...

> > >  int ad5686_probe(struct device *dev,
> > >  		 const struct ad5686_chip_info *chip_info,
> > > -		 const char *name, const struct ad5686_bus_ops *ops)
> > > +		 const char *name, const struct ad5686_bus_ops *ops,
> > > +		 void *bus_data)
> > 
> > Can't you utilise the dev->platform_data for this? I believe it's exactly
> > the case where it suits.
> 
> I could use dev_set_drvdata(), I understand that platform_data is to be injected
> by the board/platform configuration.
> 
> SPI/I2C cores do write it, from the board-info structs at device creation:
>     - drivers/spi/spi.c:835
> 	proxy->dev.platform_data = (void *) chip->platform_data; (from spi_board_info::platform_data)
>     - drivers/i2c/i2c-core-base.c:973
> 	client->dev.platform_data = info->platform_data; (from i2c_board_info::platform_data)
> 
> After device creation, the core itself doesn't touch it.

Looking at this again, there is kinda static data (the one that you know at
the probe stage) and dynamic (like memory for transfers), so static one indeed
can be part of driver_data, but the dynamic ones rather fit ad5686_state.

-- 
With Best Regards,
Andy Shevchenko


