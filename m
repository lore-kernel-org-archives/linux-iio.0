Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A3638F631;
	Wed,  8 Apr 2026 20:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775679781; cv=none; b=VzIojIS5X0Wv963JAS2+pz39dywxhroXU48qdy/D/XOhjx8jvjguDyPJAwS7dKLVXvs4aEVIVeLfZyOIWrE6OUIlPwnxjpb/WNEHdNA1id3eiyLCajgSoFQL97PKr93VffUS1nb2X4PuY7S370dBduzdtO2/iT+Q+64TRzuHETA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775679781; c=relaxed/simple;
	bh=VUFwOj/FVdk/FR2jBio22zpgSI5ih3T54pCzFLhEqhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FV/k3B90ECxTcv12He/k9lVA58XgfZnjeUCWQdHEHQ1kfEzp/6Q963uyFqMgvmKOFczMEMk2o+ka9rJDK0lyh2am730ELNM5lfIca/L4TSUSe74EvXl6EOJIv4Tzr3ZtRTPgGxBiv9C8b19u41T6FqbEd/oJ3d7VNv24rI0Vh3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fa1ZLQMP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fa1ZLQMP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775679780; x=1807215780;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VUFwOj/FVdk/FR2jBio22zpgSI5ih3T54pCzFLhEqhA=;
  b=fa1ZLQMPoiQNwp3PwavM0iKN40Qfzz/+9DZAiL8O/BEr70mGd1PPO6wZ
   LTMAsoXkGynuRcSmPMFT8EiT35Pc1LxZjP8HX8fTKqOXxStGLDMgHkC+C
   lXivxuZbcki13h/oLNWf4F5dlnKae31wd1ff9J3EMoEvuF9ugJqnVEQ1j
   +Bxep9lx6geOMy2860RYBf6SBpQOT0mof02Sn/pZCgkF2k+bVOC286Ibe
   4su1HrecF1fItjNvEeoD9VZfG7x7dcWj42g4AQYkDWyxhipacTZxgg1OI
   buqOKyM+MofCt1xsvTjBJZ8d9XUsPbq4+bBoMAvbIa/5nXA3w6LS7tltS
   g==;
X-CSE-ConnectionGUID: bO5BeBRdTYu8JSo0kYJjlA==
X-CSE-MsgGUID: C80csI74Ro6jZ+Q6sfOqZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="75713502"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="75713502"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 13:22:59 -0700
X-CSE-ConnectionGUID: 4KhitTcURxCjh7jeottJhQ==
X-CSE-MsgGUID: P8QdYX3NRputom0bD1CKrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="230237204"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.72])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 13:22:57 -0700
Date: Wed, 8 Apr 2026 23:22:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Ariana Lazar <ariana.lazar@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: dac: mcp47feb02: add MCP48FEB02 SPI driver to
 MCP47FEB02 I2C driver
Message-ID: <ada5HqdM4AqsAQK1@ashevche-desk.local>
References: <20260403-mcp47feb02-fix2-v1-0-da60c773550e@microchip.com>
 <20260403-mcp47feb02-fix2-v1-2-da60c773550e@microchip.com>
 <1e05b8f9-e95e-458d-9179-ac8268023ae5@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e05b8f9-e95e-458d-9179-ac8268023ae5@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Apr 04, 2026 at 08:49:55AM -0500, David Lechner wrote:
> On 4/3/26 5:50 AM, Ariana Lazar wrote:
> > This is the iio driver for Microchip MCP48FxBy1/2/4/8 series of
> > buffered voltage output Digital-to-Analog Converters with nonvolatile or
> > volatile memory on top of MCP47FEB02. The families support up to 8
> > output channels and have 8-bit, 10-bit or 12-bit resolution.
> > 
> > The MCP47FEB02 driver was split into three modules: mcp47feb02-core.c,
> > mcp47feb02-i2c.c and mcp47feb02-spi.c in order to support both DAC families
> > - I2C (MCP47F(E/V)BXX) and SPI (MCP48F(E/V)BXX).

...

> > Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")

Really?! (See also below)

...

> >  obj-$(CONFIG_MCP47FEB02) += mcp47feb02.o
> 
> Shouldn't we be removing this old file?

> The patch series would be eaiser to understand if it was split into
> one commit to split the existing driver into two files and then
> another commit to add support for the new parts.

Exactly! We do not expect to have this huge contribution as a fix, it just
a normal development and hence the existing code needs to be refactored.

> > +mcp47feb02-objs := mcp47feb02-core.o
> > +obj-$(CONFIG_MCP47FEB02_I2C) += mcp47feb02-i2c.o
> > +obj-$(CONFIG_MCP47FEB02_SPI) += mcp47feb02-spi.o

-- 
With Best Regards,
Andy Shevchenko


