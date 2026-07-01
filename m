Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D8D28CF6F;
	Wed,  1 Jul 2026 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782898472; cv=none; b=hSrhnLIDJLrfjAqt3qWc2QV7LXnHaNRidbOeCRKj0VrMZ5INeUaGL/EnvvSBCzJBdWP/0A0WCE7twIZiqGFz5yjHLcMJ5gdCzWWKSCHWfoyASh4lMDcCG2CQOTI3C4zQvLSP1CAexHQIgO5W9NEgUhe4+JlvhCr+d1/JFV2AweE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782898472; c=relaxed/simple;
	bh=VdVAQH51z1JneD4lUy1OLITxgDH/WGQepnDJf3i1SLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VV0ItHtl22v+HpT1I3sArLBrZf+GAgQoHtcvaCQS2AMXRLMqnZBqi1YtIEWMMAvcD1g3ii+kToRDwG7c66WEluloZzOv0zq/hjGDN5EUqs25DHo3KjbmITjzXPb1VPDwvLdMy1y5mirWQ9sQ7kkzhbyMJ3pmAcWV7lzbEOzWh1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=auGels14; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="auGels14"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782898471; x=1814434471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VdVAQH51z1JneD4lUy1OLITxgDH/WGQepnDJf3i1SLM=;
  b=auGels149RM9ZZ6mqRgzLs5y6ZxsGFORAqiv0NwE50nAFjFXSdJMpK5W
   GIgI978KSflkliuI39VZXcx6Vnk5Rv3+//jss2ZtMqbW1B60KCvRXKTTb
   cdpNPlLv9BmJqh5oea+FlLNhTZYoTOSvKoPAptMKBKfqNUbo1oxxJgIqj
   ZHK1Wx4fdTtkZekHj7hl4SEI+juO1UKHkV8HKsNenf1Y7NIbypEzww0Aq
   FVvjM7zztDUMqwRKrk+fjpjXSM+owL9WfB7olGWKie0a199F8qIJZCoLO
   A3Yy1YuzOAjUNgzfW/tgVveu35hXy2vVkn71tk/1N9S9k9ujk4AsaRudb
   w==;
X-CSE-ConnectionGUID: biUyjRYbTsKWKLF2p9rjrw==
X-CSE-MsgGUID: oMt0VwzbRqyO+dwnSy7jfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="101052593"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="101052593"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 02:34:31 -0700
X-CSE-ConnectionGUID: 9y6Pkw4RQseSVmAMN5Onkg==
X-CSE-MsgGUID: sI1qyMCQRG2+RlL2SRKAMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="246160470"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.65])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 02:34:27 -0700
Date: Wed, 1 Jul 2026 12:34:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Lukas Metz <lukas.metz@gmx.net>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: dac: dac8163: Add driver for DAC8163
Message-ID: <akTfIdkH10Qq4G16@ashevche-desk.local>
References: <20260623-dac8163-work-v1-0-5b508158faa0@gmx.net>
 <20260623-dac8163-work-v1-1-5b508158faa0@gmx.net>
 <akP2RSriqaN8qqQT@monoceros>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <akP2RSriqaN8qqQT@monoceros>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 30, 2026 at 07:03:01PM +0200, Uwe Kleine-König wrote:
> On Tue, Jun 23, 2026 at 06:07:27PM +0200, Lukas Metz wrote:

...

> > +	{ "dac7562", (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC7562] },
> > +	{ "dac7563", (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC7563] },
> > +	{ "dac8162", (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC8162] },
> > +	{ "dac8163", (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC8163] },
> > +	{ "dac8562", (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC8562] },
> > +	{ "dac8563", (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC8563] },
> 
> please also use named initializers, i.e.
> 
> 	static const struct spi_device_id dacxx6x_id_table[] = {
> 		{ .name = "dac7562", .driver_data = (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC7562] },
> 		{ .name = "dac7563", .driver_data = (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC7563] },
> 		{ .name = "dac8162", .driver_data = (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC8162] },
> 		{ .name = "dac8163", .driver_data = (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC8163] },
> 		{ .name = "dac8562", .driver_data = (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC8562] },
> 		{ .name = "dac8563", .driver_data = (kernel_ulong_t)&dacxx6x_chip_info_table[ID_DAC8563] },
> 		{ }
> 	};

These lines are way too long in IIO. The usual approach in this case is to have
it split on per device standalone initialisers. At the end it will look like

	static const struct spi_device_id dacxx6x_id_table[] = {
		{ .name = "dac7562", .driver_data = (kernel_ulong_t)&dac7562_chip_info },
		{ .name = "dac7563", .driver_data = (kernel_ulong_t)&dac7563_chip_info },
		{ .name = "dac8162", .driver_data = (kernel_ulong_t)&dac8162_chip_info },
		{ .name = "dac8163", .driver_data = (kernel_ulong_t)&dac8163_chip_info },
		{ .name = "dac8562", .driver_data = (kernel_ulong_t)&dac8562_chip_info },
		{ .name = "dac8563", .driver_data = (kernel_ulong_t)&dac8563_chip_info },
		{ }
	};

-- 
With Best Regards,
Andy Shevchenko


