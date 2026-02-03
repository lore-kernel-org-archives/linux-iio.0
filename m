Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31C138F232;
	Tue,  3 Feb 2026 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111823; cv=none; b=hW0fMiixMOm81NS5je1Vo6JEKeETniZosn/N4t5ZnM7tj2ub83toJ0bxySdoctUG1Y/0uasoaeey4muDA5vVwRz9VVJCgORfwKcmNkyqyCW0FEq+DzEx2t+Aasfst9WiE7w1TstamLWXT58NaWYwstnIa72SBlMBk4yps2GuWuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111823; c=relaxed/simple;
	bh=aqj2T9Lj/osD64ehMNdKR3D52rwsXU01G6ZZtQWYTnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4DXqPYIyUz5Je5v8+7nnROS00Xn1qoPchhDRug65SVsTM2hMf/VeetPq/b5UYH/0pSFoablpBKVmk6VAWtyorNrkRvpN1M/DwT2l8H2e+RK7u/Y6QWrH53LMbIdc4eDs+vG92MeRR5U+RkzZ9n6pEecmVruN6nFLD9H++4PAVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jjV2ZsB2; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jjV2ZsB2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770111822; x=1801647822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aqj2T9Lj/osD64ehMNdKR3D52rwsXU01G6ZZtQWYTnE=;
  b=jjV2ZsB2pN71QVU9Z6z/ypkv21GzY+p+i9bMo91Ca8APCtkwqHAKY4N3
   horD7389HZyWzYtSxiQoEQEbyGL50/Ivk/9umRor+VPFg2SeG3hqlmLKy
   hnMvpdtqnalYBtTaj6rxogcgLmpwsViGxF2zU0WxBATSm8cZOW28YwuBy
   E2OPNVUdWFN9k6w3tj/nB/ENuCbbivgqqj6cJfuyz23u1COCpsRDUWcYo
   qUOuQ7pbv+RXozR1HASmQepOYQgOTBM1araHVCz72pbx0xKYXycVgInlZ
   7+oZ05bi1k7sd6Mcosd43PxwHlAXywWz/Dr8jaacybTKJmleQ6L2a82SZ
   g==;
X-CSE-ConnectionGUID: rAFUk/AoQuaIlw8bqcS+mw==
X-CSE-MsgGUID: K//RA+QZQuOoWqbKNzKwKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="88700819"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="88700819"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 01:43:42 -0800
X-CSE-ConnectionGUID: M/+vltBMRUeZJSJ5/J/KHw==
X-CSE-MsgGUID: zTXVQoDhSsm85Vc1V1aAdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="209813956"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 01:43:38 -0800
Date: Tue, 3 Feb 2026 11:43:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Fabio Estevam <festevam@denx.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Eugene Zaikonnikov <ez@norphonic.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/13] iio: imu: bmi323: remove unused
 drdy_trigger_enabled
Message-ID: <aYHDR8IS3PwXn9VF@smile.fi.intel.com>
References: <cover.1770030812.git.antoniu.miclaus@analog.com>
 <682cb9e687d1fcf76eb689d7292483c91e3b5b25.1770030812.git.antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <682cb9e687d1fcf76eb689d7292483c91e3b5b25.1770030812.git.antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 02, 2026 at 01:26:01PM +0200, Antoniu Miclaus wrote:
> Remove unused drdy_trigger_enabled field from bmi323_data
> struct. The field is declared but never accessed in the
> driver.

...

> struct bmi323_data {

>  	struct iio_mount_matrix orientation;
>  	enum bmi323_irq_pin irq_pin;
>  	struct iio_trigger *trig;
> -	bool drdy_trigger_enabled;

Hmm... Not directly related to your series, but with it applied it makes sense
to revisit the structure layouts as they might be rearranged to occupy less
space.

>  	enum bmi323_state state;

For example, this enum, if moved closer to irq_pin, might result in less gap on
some architectures. (Probably not, as we use long, id est 'int' sized, enums.)

In any way, `pahole` can hint about that, but as I said, it's not for this
series.

>  	s64 fifo_tstamp, old_fifo_tstamp;
>  	u32 odrns[BMI323_SENSORS_CNT];

-- 
With Best Regards,
Andy Shevchenko


