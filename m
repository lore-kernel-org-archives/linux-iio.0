Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F361837F8A9;
	Mon, 27 Apr 2026 07:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777275907; cv=none; b=GLCF1nSPAVzzyjk3KiiAzNpS4YzUSMiYJ5leRsSvGgEZw6pxT12L54/HsH9K2euZXOlKqI8BsZKLw4/nhk31X53bhqxz5n9Noc49llBtOEeRNUswieacrGWyfrTdlecESsNK4iydliIZvKVAWBg/HgyO2yprJ/y59B1zEoIrbh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777275907; c=relaxed/simple;
	bh=0twFypO0Cust5Vlkw+9ZGd+TnyzE7zX+xD9com9o9bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DA1YLfxaAfur8HfqaOhzqJ8Ppk+DNbDn8QvVEjeuZOXwTdxp1N5fjxcFKUeCWobmDY3xTnxLNG7Kxu2I/rmhGbrNpI5d4GF3uPyq10y4xHy3iKF3qttMM7nagHYxIyGx7kFLbu3lujBERHlpoVeI+F4SSeXP4sx/fMn4kAbsFqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VUGMAkqR; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VUGMAkqR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777275905; x=1808811905;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0twFypO0Cust5Vlkw+9ZGd+TnyzE7zX+xD9com9o9bQ=;
  b=VUGMAkqRQ1uEmWOo/gNoq4dbscTVkQtcphQGkj1kupAyf+P2PF+v8/Sv
   fwhbWY9DAGFKScrbpo13FB9yI2XZliwieHzzA5+pqp5TjypVDKO9E+ISR
   CP/diV79ZHnv5ruV4VH0uDwXZ+RUxbjAUAF4nMJlbr796tXp8ZLROKFT6
   iGTY/l4yFFATk+IK/Gd4sxr3qNz2qUtZ8oMlzk7cJw1qobgwx6gT3caVi
   ZYl4F4J7Ninrh/0dJGtv8xHSvZFaG840u+H9mbZ1PEwcdIIwcoL5HxD1Y
   DMaULcBUaoj9Z+h3LJfJVYr92c4cRLYBr2NjuiQH0yrEsawSSjSQALtfY
   A==;
X-CSE-ConnectionGUID: 490HmJvrSyuiV3DGxF9Qaw==
X-CSE-MsgGUID: iGAkmF15SaKQJqN4o63zyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="78174375"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="78174375"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 00:45:04 -0700
X-CSE-ConnectionGUID: VANwaX7DSdCaml7GSXTQyA==
X-CSE-MsgGUID: IwC3Bq6TQAyFcJTf4E8pjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="256868919"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 00:45:01 -0700
Date: Mon, 27 Apr 2026 10:44:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Rosen Penev <rosenp@gmail.com>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: meson-saradc: fix calibration buffer leak on
 error
Message-ID: <ae8T-pU8Pf9xaCKy@ashevche-desk.local>
References: <20260426-meson_saradc-v1-1-6e96b2982c43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426-meson_saradc-v1-1-6e96b2982c43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Apr 26, 2026 at 12:07:24AM +0800, Felix Gu wrote:
> meson_sar_adc_temp_sensor_init() allocates a buffer with
> nvmem_cell_read(), but the old code leaked it if
> syscon_regmap_lookup_by_phandle() failed.

> Switch buf to __free(kfree) so all return paths release it.

__free() is defined in cleanup.h which is missing in the driver. Please add the
include to it.

-- 
With Best Regards,
Andy Shevchenko


