Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D4E27B32C;
	Thu, 29 Jan 2026 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769702214; cv=none; b=YL8YxfoK+2tQE7jJ1nRX/bkf0yQbYIIyuEE0DSq1dIVRSeTKlvkwOS/Z+NrZjw0xnQsWdO4nArvaWUZ5NimoyoowKtruinwpPdSA4LBfLtUK7gz0C8QUgU0jaRd3Qesy/2ezY4QEebjUh7SUe9yXnZOcpVynHfDuBFYDIb9D85A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769702214; c=relaxed/simple;
	bh=kOoe7rxqZj0owlWCQcjCMy3HxVAC6avOkRR2d8M/YNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQt1GXmx7AKBzYdVCqZWvAZ7Hz4LOQHmcgAAfyFi6fw/msaQKpjr3Rt3R/7XOsuYOJep1PhBg/mM745dJZH1B1j9hWIz4Ot2kvEjO7uzPrnGlPqMvWe/O5qHpsS8rmNOc+mmCZ3HLdOqDdKPLlwSkSWR/YElJ5SS9b+vH2tU+/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B5UfRQEa; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B5UfRQEa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769702214; x=1801238214;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kOoe7rxqZj0owlWCQcjCMy3HxVAC6avOkRR2d8M/YNY=;
  b=B5UfRQEa5KQ8a0oRAI8HovGUW3CYuAmpJ9odvEF40NLiZNR7p94pufFg
   om47N0BEgcI3kEGhjTjgdOwYGouUX66zCm1k4HF3xeERjiGpzNTms5LuF
   OYUfw5G3u+dfMkYqT8awPF/8Dvp8UELZXbfrabAOKL31DMDRMgbzicL6M
   qDAOGzjbPV8lY2XZAjdZvATS0ajI/udHzCkBIL7DLhlHkqLd0hIpQSdWv
   UbS1qqHbQsuLdcr4QTikysLTYMxTAel7iCNsmye8Lc9ankFlQo+I+5cWZ
   T6JZh48msFPWk4rYB51Ucm8+AxnG4Nh1+5gwbHcnri0dEAWRlXUxiMSr7
   A==;
X-CSE-ConnectionGUID: dqh4qpPSRPSsT/8nvc5zFA==
X-CSE-MsgGUID: 1bhENYBdSP+x97HQZdHUlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="74567947"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="74567947"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 07:56:53 -0800
X-CSE-ConnectionGUID: v/9GeqEcSwy/XocJD622kA==
X-CSE-MsgGUID: I7eZzG+0ROCoOwrJSatDag==
X-ExtLoop1: 1
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.155])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 07:56:49 -0800
Date: Thu, 29 Jan 2026 17:56:47 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Message-ID: <aXuDPzyMJGSIL3UD@smile.fi.intel.com>
References: <20260129152731.154368-1-antoniu.miclaus@analog.com>
 <20260129152731.154368-3-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129152731.154368-3-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 29, 2026 at 05:27:30PM +0200, Antoniu Miclaus wrote:
> Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC with
> integrated fully differential amplifiers (FDA).
> 
> The AD4880 has two independent ADC channels, each with its own SPI
> configuration interface. The driver uses spi_new_ancillary_device() to
> create an additional SPI device for the second channel, allowing both
> channels to share the same SPI bus with different chip selects.

> Key changes:
> - Add AD4880 chip info with 2 channels
> - Extend state structure to support arrays of regmaps and backends
> - Refactor setup into per-channel function
> - Add adi,aux-spi-cs property for secondary channel chip select
> - Add channel index parameter to channel macro for scan_index support
> - Make all IIO attributes per-channel (filter_type, oversampling_ratio,
>   sampling_frequency) for independent channel configuration

Can something be split as prerequisite?

Overall, making

	struct regmap *map = ...->...[ch];

will help to make many lines of code easier to read.

-- 
With Best Regards,
Andy Shevchenko


