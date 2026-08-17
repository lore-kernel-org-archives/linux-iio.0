Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F3A3B5847;
	Mon, 17 Aug 2026 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786953006; cv=none; b=jV8vNRw0byHg1z1i71WxA7HaqU39oeSTqVa8JVb8gbgAdinKACGPc5Svmvf7JBu+SdVZ2qUoI4fjVRio3xT9xIT6eJWzG9k98s4rXsmwh49kTyTr+Y8F5oW5H3UhBCSrH0C801BZMXQWStfO/jml3K7yijTlr/rRQkP+UmpwAE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786953006; c=relaxed/simple;
	bh=KLkCU99Mms2Vjyz6QWFkWrSMks/i9nqk1NURodLEv1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqC46wvc9G9PRhEkfGhJbAnZRBnIkb9yZO2TABo2a/dE4Mc268s1zUmrkVdmAMPqiFHMBzLjFNucJT/kzCUto4SS+JUWD27Y2EoL30gMkVNQvzCm2B7PlZvTRINC20CEwNSAOeJWxh3jN9jLsVVE4pAuwoNGpirJxpcAqfHBy2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AraHGGoe; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AraHGGoe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786953005; x=1818489005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KLkCU99Mms2Vjyz6QWFkWrSMks/i9nqk1NURodLEv1w=;
  b=AraHGGoeayAXdqiPEXAGK3WQ0vsVtFsATk909E3NOGFqhwKDJWJscnEN
   SKH/bI+0zQoa8D15IlJDUPk8KZSE3ZmsRIIQIHw1p5+Pfwi/2gWMKAH72
   KwAdvw+GrLzgHVCPrey04Ann6xR6i23OkxpCdy/UaE9Q496pI6bLywdtj
   tgdBSyMIgds6Z9Oam8omu3YJqhzI4/bQE4P7+iUL8JbJOlWWBQ21K15b6
   d+jxRUGZRAhg5mVOc4xXGoEJiCQ1qQPxAwf0FAY921a5WMy2B/T4FnswO
   6dC7hr35D4nHzGhzP43Ezu19D5xjWGz29xV76aL1/4XY9wd0dozf4hUlf
   w==;
X-CSE-ConnectionGUID: WFWVreIDQfO0BCashz97WQ==
X-CSE-MsgGUID: jpgxxj3wSuawLdNtt9lZmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="104802604"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="104802604"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 00:50:04 -0700
X-CSE-ConnectionGUID: 7sk8iKQgTRu+Vp7hpKs6lw==
X-CSE-MsgGUID: n9wER85gSHKj3+NE6QIjPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="263504286"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 00:50:00 -0700
Date: Mon, 17 Aug 2026 10:49:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?iso-8859-1?Q?Nicol=E1s?= Antinori <nico.antinori.7@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3 2/2] iio: humidity: am2315: add support for am2320
Message-ID: <aoK9JXR8jj8i-Apj@ashevche-desk.local>
References: <cover.1786725567.git.nico.antinori.7@gmail.com>
 <83c8a41607ed07285a84dba8ed10a954226076b4.1786725567.git.nico.antinori.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83c8a41607ed07285a84dba8ed10a954226076b4.1786725567.git.nico.antinori.7@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 14, 2026 at 02:50:20PM -0300, Nicolás Antinori wrote:
> The AM2320 is fully compatible with the AM2315 sensor in terms of I2C
> communication protocol and measurement conversions.
> 
> Add the "am2320" entry to the i2c_device_id table and create
> of_device_id table.

...

> +	chip_info = i2c_get_match_data(client);
> +	if (!chip_info)
> +		return -EINVAL;

-ENODATA

...

> +static const struct of_device_id am2315_of_match[] = {
> +	{ .compatible = "aosong,am2315", .data = &am2315_chip_info },
> +	{ .compatible = "aosong,am2320", .data = &am2320_chip_info },
> +	{}

Same style as elsewhere, id est

	{ }

> +};

With the above being addressed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


