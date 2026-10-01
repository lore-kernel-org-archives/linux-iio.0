Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2F52F0C46;
	Thu,  1 Oct 2026 19:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790882004; cv=none; b=gMHJZjWgjanGT7g3r1K8vsmpFtAqfj9wPOn5myvFc6fnBxuxHf5mOkAHbooCiMYhDJTjKK1bwTesYaIzeSwOEEqjJGRelOtb8YIBxwlbQwmw6Lp5qmNADNfTSADWKo9C45i8voAQhNoI2dNhFsSYgq7RvDaGXL0BqJCNucHns90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790882004; c=relaxed/simple;
	bh=Vr4V/gCzPPo+UnjwMdgsC+wmyLcsr9HE+lOJEU++tgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rnd/xzdEQyCW+tNQE3obhmNwZujPsB1U+5Fw/IaCWkM8Q5qopEjVkTN7lohESOGbeHBMWOj/uOUpnPRjhAhd+CSKytp/+TlXz6FI+0NWXzy8riafTtqRjLHrC7lCngyxahtQpqf7V6zPStKXeq4OgIMWz3ivLuTcEahr2fpWcQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDpp9pzB; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDpp9pzB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790882002; x=1822418002;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vr4V/gCzPPo+UnjwMdgsC+wmyLcsr9HE+lOJEU++tgo=;
  b=oDpp9pzBW33nDxqXALWRF2hLA9hZvgdaQQU3MDzYkMtnZUKqNq5MDlay
   Q9lA5DMNx9MkHHe4yp11PYEghBozmmwK1/GwB/WwjMQj2OLp6so0M1cnT
   uNZ4L0fCyqH+ZsgGeAnd0IlHtGYYdV74K+B1hGm+0k14fyQokeD22CCR6
   IuyAUjOvMML36DQ4ePPQlWtVup66hQp681YCCfM+ksHqPdHU/OYJJi2JW
   8NicS2F/kXn0eC6i+sj12tSPd7KfGqUT/MKhLz8gDA0MaBzFbYgbXgMTJ
   3Gxsfb8wxUxMuEmtRfbRaXKoIBkH5uc005nbBXy+7n/b40xUGea9gLHES
   w==;
X-CSE-ConnectionGUID: efP2VuxBSc2q7gZc3bAwJQ==
X-CSE-MsgGUID: o+68SeXySZaCCeoFaNhdFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="117180995"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="117180995"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 12:13:20 -0700
X-CSE-ConnectionGUID: 18tymik5T7qQu8HwzKvanA==
X-CSE-MsgGUID: S0AQYo3oQXCtbS4+WZHidA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="279834236"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.27])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 12:13:17 -0700
Date: Thu, 1 Oct 2026 22:13:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 2/3] iio: adc: add stm32 mdf support
Message-ID: <ar6wypoRS-5j9iM7@ashevche-desk.local>
References: <20261001145702.2628429-1-olivier.moysan@foss.st.com>
 <20261001145702.2628429-3-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001145702.2628429-3-olivier.moysan@foss.st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 01, 2026 at 04:56:46PM +0200, Olivier Moysan wrote:
> Add the STM32 Multi-function Digital Filter (MDF) core, serial interface
> and digital filter drivers. The MDF converts bitstreams from sigma-delta
> modulators or digital microphones into samples exposed through IIO.
> 
> Audio: capture PDM microphones via cyclic DMA for an ASoC consumer.
> Support CIC scaling and filtering, synchronized and interleaving modes.
> Audio use case requires a DMIC filter, and a separate ASoC DAI.
> 
> Analog: expose sigma-delta modulators as IIO voltage channels with
> direct reads or DMA buffering mode. STM32 timer triggers can be used as
> clock source.
> Analog use case requires an IIO backend for the SD modulator.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  drivers/iio/adc/Kconfig               |   27 +
>  drivers/iio/adc/Makefile              |    3 +
>  drivers/iio/adc/stm32-mdf-adc.c       | 2078 +++++++++++++++++++++++++
>  drivers/iio/adc/stm32-mdf-core.c      |  857 ++++++++++
>  drivers/iio/adc/stm32-mdf-serial.c    |  309 ++++
>  drivers/iio/adc/stm32-mdf.h           |  312 ++++
>  include/linux/iio/adc/stm32-mdf-adc.h |   19 +
>  7 files changed, 3605 insertions(+)

Unreviewable. Make sure the single patch is ~750 lines.


-- 
With Best Regards,
Andy Shevchenko


