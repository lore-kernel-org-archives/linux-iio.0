Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B553FE37A;
	Wed, 30 Sep 2026 08:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790758560; cv=none; b=BSzjoi6iSAA5jVVu2sX1OnlKeYdJop/k2PXJcoV8Gdrc0+Im5ZGmmcVaGpZ/HCk//UiO9j3EPgswIseSxtIDdO7+fpH6khDoZV4kq0tTMHebx2zDMA9WqXBNgO128U6N/EOwDuG85UQprVGBj7sAES+JTC0GnxM/y5OjMWEvcis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790758560; c=relaxed/simple;
	bh=N8NsL8xAHAPT4V/vU/YLBwC3KZGQnQwHOH/YRxi5FD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfB4fnFDjMKPyMCWaL+XMrcU9JCIP4rzQhGoYVEVGoN2lGzNlDAMG+luRvFJe5AWZjGQdC7j5aLJH4D7qo/jGL2TpBD0Klo8Onk+57MlQDCqKJUMOX2OS+YUS1DgQSVe4yiu0jeSaWbEg/XvBnXMDGKLG1qzKKYAa+8hdr7/J2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HIc/XfPO; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HIc/XfPO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790758559; x=1822294559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N8NsL8xAHAPT4V/vU/YLBwC3KZGQnQwHOH/YRxi5FD0=;
  b=HIc/XfPODDf77c9lZcyil3HPJ9b+QhBhJw27GvDMk2U/NButGLw+tGbF
   ZA0Fofz7MPL3M1/Se+W92WF2YbPGz6UckabgjlU66oo5IDetGj14BQ2VQ
   acdIGrmUALf+WmDXNSo4MfFJG7U7vEos1VGwhddWRkdjnHb8KnE2bhS8S
   0ySi6svUW2cuvV1DSnNleBIkmTBAGIoeSWqvjNz/KZ3Ht6jBcfHismMvn
   v8JNl2l19w+zOrkxhF55jDbP3p5FI1CVh0WhqKzpxoEqB5N3GRl2xhotF
   rbuidsMnLe6HvNlfuxN0nVi8ws5RBj+Sp4SaYup/E14arnNXXEx5tpkev
   g==;
X-CSE-ConnectionGUID: 03YPbstVTwKGjDRpdFKZ4w==
X-CSE-MsgGUID: uRBsS0tTTMy7TinDT6c6mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="100821300"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="100821300"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 01:55:58 -0700
X-CSE-ConnectionGUID: XJq7Q+H9Q+W2I+MxFuJnMw==
X-CSE-MsgGUID: J068ASCjQj6XHEzHq4hWEQ==
X-ExtLoop1: 1
Received: from spandruv-desk1.amr.corp.intel.com (HELO localhost) ([10.245.245.137])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 01:55:54 -0700
Date: Wed, 30 Sep 2026 11:55:52 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Marek Vasut <marex@nabladev.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Cheick Traore <cheick.traore-ext@st.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v2 07/14] iio: adc: stm32-adc: add support for stm32mp25
Message-ID: <arzOmLhyaqSdcKqW@ashevche-desk.local>
References: <20260923-adc-stm32mp25-v1-v2-0-46bc019537c6@foss.st.com>
 <20260923-adc-stm32mp25-v1-v2-7-46bc019537c6@foss.st.com>
 <arWPjx-JKt1IZCZl@ashevche-desk.local>
 <8fd19ab1-6ec4-49d7-aadc-accec6e71410@foss.st.com>
 <arzJYg3cg73vYCOE@ashevche-desk.local>
 <d83e2c8e-452a-4dfd-823a-624fe211837f@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d83e2c8e-452a-4dfd-823a-624fe211837f@foss.st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 30, 2026 at 10:44:12AM +0200, Fabrice Gasnier wrote:
> On 9/30/26 10:33, Andy Shevchenko wrote:

...

> Sorry if I'm a bit confused :-), just to be sure, the preferred style should be as below ?

Yes, in case if you want to update the whole ID table.

> static const struct of_device_id stm32_adc_of_match[] = {
> 	{ .compatible = "st,stm32f4-adc-core", .data = (void *)&stm32f4_adc_priv_cfg },
> 	{ .compatible = "st,stm32h7-adc-core", .data = (void *)&stm32h7_adc_priv_cfg },
> 	{ .compatible = "st,stm32mp1-adc-core",	.data = (void *)&stm32mp1_adc_priv_cfg },
> 	{ .compatible = "st,stm32mp13-adc-core", .data = (void *)&stm32mp13_adc_priv_cfg },
> 	{ }
> };

The rationale for the trailing comma is:
1) no need (doesn't make sense) to have it on a terminator entry;
2) do add it for non-terminator entry to avoid a churn in the future;
3) do not add it for any case when the whole array is located on a single line.

-- 
With Best Regards,
Andy Shevchenko


