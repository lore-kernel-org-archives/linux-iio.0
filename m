Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E291443DEC8;
	Fri,  2 Oct 2026 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926497; cv=none; b=X+pBVC8LuvPFPi/elTeAUK28xg3lbJgoR8HXJx0dpSP3wBm58NWlAapnOu83oRaXJ8ZN+7T2U8XleFTgc+2vuMuYw5rOjes9Ma3IOtrYS9k9MnKXbUigA9qK0TPU4YGCZ6RRAKTWsR76SXrLkVtOMzhwvvLp3eSw1yNLgj4d+Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926497; c=relaxed/simple;
	bh=LAqCXjWcEhA+NMDRpZZ0gzroQBLg4coCBF1VGUyHcCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9rEzLfN059ovwILwpIygg2gata5hwc8GhZHJp2KHkhW0UxpRGzJXbxjBRUp/1fZsI154aHx0FFMeWdpUQkuLNQ2zbuK/kHL36M1urGp5evB8s3Cy32rOs4udo3pUvlCibjcokO+CgxvoVRIsYlmM4UhGibTgxHyf5C7LlcjbsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GZxPd0af; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GZxPd0af"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790926495; x=1822462495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LAqCXjWcEhA+NMDRpZZ0gzroQBLg4coCBF1VGUyHcCk=;
  b=GZxPd0af6IhSL8v7dDPP+PVt662hWR21GCxxX4P0WIxkazec+FsRa1l/
   /1Or+v3BowusaTiPuiXwbIOtTwmCn/ZcCWiLmdeArzwgohcqiRidA/qgS
   OO50o3crssygSQLaRTKD34RyNcAWzT/rd/mPseBMqgtoAODy5pTe6D3KN
   D0JGJ4flAN9c4S7ClkmxfOEB9FaSP2yNFETuI5o7vvYTrb4J/OtFrvBNq
   KvscOcl2bjYKEOAInMujlgHU6xiL0eCVOPoMQPLpYYo+ux0nUwIiPyKPp
   g7apRLOZ3pSqeIXy4mH8lZ51VD4IbsVRZk+N/oavbvQzwKqXfcyKj+JmL
   A==;
X-CSE-ConnectionGUID: 55SvnYiNSxmMExk6Snmn3A==
X-CSE-MsgGUID: L8ZO2XFoT163PuUT7ynHrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="101022378"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="101022378"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 00:34:54 -0700
X-CSE-ConnectionGUID: x+xxJ71wS42dlwxUAsn9Xw==
X-CSE-MsgGUID: 5nLUqPeIQmuQ3TadL1+U6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="279450625"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 00:34:50 -0700
Date: Fri, 2 Oct 2026 10:34:46 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: adc: exynos_adc: add Exynos850 support
Message-ID: <ar9elr1_tuFhJi1r@ashevche-desk.local>
References: <20261001-exynos850_adc-v1-0-791b3516bb9d@linaro.org>
 <20261001-exynos850_adc-v1-2-791b3516bb9d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-exynos850_adc-v1-2-791b3516bb9d@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 01, 2026 at 04:09:13AM +0100, Alexey Klimov wrote:
> The Exynos850 ADC controller located inside the CMGP block differs from
> other Exynos ADC controllers, mainly in its register layout.
> Specifically, the data register sits at offset 0x08.
> 
> Abstract the read_value() operation in driver data exynos_adc_data to
> support SoC-dependent data register read callbacks.
> Add the exynos850_adc_data struct that describes Exynos850 ADC ops.
> It also requires its own hardware initialization and exit routines.
> Add them as well.

Split this to at least two patches:
- add .read_value() callback and switch existing users
- add new user

-- 
With Best Regards,
Andy Shevchenko


