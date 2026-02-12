Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D906A001;
	Thu, 12 Feb 2026 20:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770926703; cv=none; b=OTZk4w4AobQ7eQItVE1Wu7tnmZilxBlj3HAmxfrO72bhhblzN2z65DI2KYngoATG5K6IBxM6N3PzHrLfuyO8MdTAWqTtNcM+5paeBhd22dkdh+B4fhrs1GcAYs2ghBt9BBhuv549TT8OBEnKkTbWCLZ37Y6C3pE6Yda/wQv6pFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770926703; c=relaxed/simple;
	bh=uyTy8rtGm67fhbLp1EoWNhIRmFKTSkTNcIevE479EaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brhykPLVu30EfITeYLJH0uiMXJcfLKKrbEVN0ozIw3Z67Ylm4iemsNecLPZ4wVdxOLQck+DbWBxQBBI0GWJ36HgmnRzEXr4RxIs1tiN9CicM9opqXRKEW4PfB3vj498o81EKi520byBGJdANRCiRB+94WRWPE7tcmAHMUGLJ1S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QBcF5xEx; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QBcF5xEx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770926703; x=1802462703;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uyTy8rtGm67fhbLp1EoWNhIRmFKTSkTNcIevE479EaY=;
  b=QBcF5xEx3kuE6f51d4jXxgSi9Mxj00vhQT9lD4ogJbUWf1LiJAd1nvv8
   hq3i/H9iSJBdJDh3qvIlVIY7fyMbRj2I9MSEGVfiSItaOLNCd255Dfw/A
   PNWjnAyEEzvCtB6rc5DaiLXUYXiOBH65Xt40EPmoah9pndcnrQqwz2WUO
   icy+ZPdY/atQqPV+gdaW0jTVzYY4qWc3hoOHNBSInEqx7NS5gmqeNsMaT
   3e407F5Obre1diEGvCXbnUbkdd7ZmOXALcCKxgBd+s345J3HXTSKDktoO
   A4hivoF7r7/UkFlNdcFE7d/QEGAOL1OqOew+p5wUoSjwZYtjetT8QdE0R
   g==;
X-CSE-ConnectionGUID: yUgNaK06Tdm//DEg0WP1yA==
X-CSE-MsgGUID: xKzpfqm1QH+LRJgEr7maKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83553917"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="83553917"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 12:05:02 -0800
X-CSE-ConnectionGUID: L1BYOUiwQtebn8s5qOCiVQ==
X-CSE-MsgGUID: odSCEUENT6SSVO8DABrKEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="235688431"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.145])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 12:04:59 -0800
Date: Thu, 12 Feb 2026 22:04:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Conor Dooley <conor@kernel.org>
Cc: Ariana Lazar <ariana.lazar@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: add support for Microchip
 MCP48FEB02
Message-ID: <aY4yaVP2TQFRI1E4@smile.fi.intel.com>
References: <20260212-mcp48feb02-v1-0-ce5843db65db@microchip.com>
 <20260212-mcp48feb02-v1-1-ce5843db65db@microchip.com>
 <20260212-germless-favoring-c27ab4c53128@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212-germless-favoring-c27ab4c53128@spud>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 12, 2026 at 06:00:06PM +0000, Conor Dooley wrote:
> On Thu, Feb 12, 2026 at 02:48:34PM +0200, Ariana Lazar wrote:
> > This is the device tree schema for iio driver for Microchip
> > MCP48FxBy1/2/4/8 series of buffered voltage output Digital-to-Analog
> > Converters with nonvolatile or volatile memory and an SPI Interface.
> > 
> > The families support up to 8 output channels.
> > 
> > The devices can be 8-bit, 10-bit and 12-bit.
> > 
> > Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> 
> Other than the interface, what's actually different between this and the
> 47? Could they share the same binding?

If that is the case, I don't think we even need a brand new driver, the
existing one should be refactored to adapt SPI interface.

-- 
With Best Regards,
Andy Shevchenko


