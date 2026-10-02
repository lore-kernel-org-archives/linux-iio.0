Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BA946C4C6;
	Fri,  2 Oct 2026 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790933020; cv=none; b=isLTWQzC5rXjEq+y9ytTJqWjkxPrIvuazcGO3146tS/vO0RVkiI/x4FfzV/VeLY2eCbcMegUbnXyB//k1qB74xPMphLaDoDaa6TmmHNYju1+Q/QS1bszrJbnS89J8gFb1xC0VvVSwwO1DH/ZAIRT6wR+IC2QDRA7k1EV/zspe6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790933020; c=relaxed/simple;
	bh=zmuLiQbd8QxL0tTNDCxKS9p6kykYRAuOi0Tb34sjbfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7TYQTVPRXed5R8w2QylJDdsrcazpHLggS1FglYa/fYIek0Wbl3dgGn/nlKuQlmCni4rHdWippNyrqmwHXSiiMEp0ezLlNcrdhSDB5KC2Mh2visxzPChFB7zJGU6dcxxeoFiYmyfxAFPw9r8/7XYerd17JFM/KDXZa9usKychsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jpMBUfB4; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jpMBUfB4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790933020; x=1822469020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zmuLiQbd8QxL0tTNDCxKS9p6kykYRAuOi0Tb34sjbfc=;
  b=jpMBUfB4oIMr9qCvufF8Qp84ebrX3qwOQqFVCKMRAUEmYFna/1cMpmNB
   EzelK9oxZ8ZDS4Fqx/r2L5j9vJD/E57lk82699Mzy+yH7i3mOtzuE1LZ6
   3Kcvn6//wcGo8/ejQN8ayHDzx2pG75jvve9UvY9uW872tyCZtDd6MuWTL
   VPrLIxrJ+MbGBojCYm1k4LO0J1mYInz+CjaOGXMYtyNf6R7QBkUgPHM/6
   h3VW9talKJKQd1wfORzE9J7VrALj88TnkKZoAjC4u5AIRbn+F9vQ4i8Zz
   81g5ZPMxNBSrm0UVpa2RJVo8cJrR4oU2T0aVArHzRTYLnww3fKh2U2C90
   g==;
X-CSE-ConnectionGUID: X0nQVC5TRgmFVU7Pj3p5ug==
X-CSE-MsgGUID: yDSMBzzHSo65ptyQBLEA8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90729044"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90729044"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 02:23:39 -0700
X-CSE-ConnectionGUID: hROUSMktQSiu7M7VaSE+0A==
X-CSE-MsgGUID: eSOna0UeRCqJhAwhBhROrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="302464757"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 02:23:35 -0700
Date: Fri, 2 Oct 2026 12:23:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: adc: aspeed: Fix SCU lookup for multi-SCU
 AST2700
Message-ID: <ar94FZ2kEJZzJJb3@ashevche-desk.local>
References: <20261001-ast27xx-adc-upstream-v2-0-2f9c15cc0064@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-ast27xx-adc-upstream-v2-0-2f9c15cc0064@aspeedtech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 01, 2026 at 05:50:35PM +0800, Billy Tsai wrote:
> The ADC's reference-voltage trimming data lives in a SCU register. The
> driver has always located that SCU with a global, name-based
> device-tree search, which works as long as a platform only has a
> single node named "syscon". AST2700 splits its SCU into two
> instances, syscon0 and syscon1, that share that same node name and
> differ only by label and unit address, so the lookup always resolves
> to syscon0 even when the ADC's trimming data lives in syscon1.
> 
> This series adds an explicit "aspeed,trim-syscon" phandle property so multi-SCU
> platforms can point the ADC at the right SCU, keeps the existing
> global lookup as a fallback for single-SCU platforms and already
> deployed device trees, and wires the new property up on AST2700.
> 
> Patch summary:
> 1. dt-bindings: iio: adc: Add syscon property for multi-SCU SoCs
> 2. iio: adc: aspeed: Use syscon phandle for trimming data when available
> 3. arm64: dts: aspeed: Add syscon phandle to AST2700 ADC nodes
> 
> Assisted-by: Claude:claude-sonnet-5

Assisted-by: LLM
(as documented)

-- 
With Best Regards,
Andy Shevchenko


