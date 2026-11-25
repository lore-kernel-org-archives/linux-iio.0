Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603425;
	b=l8Pbdgjb2p1x+Dz2+/wyoPS/xgEzlQyu9MaeZKglqTCH5BPnkvSpi/pkGQITUDcTirkG
	 wTL4OE2f/M0Dqzvo90tqBzluSxlhu6DKhSvNzkwRSzwo3OFTVi6OHJs8Z0uTJisvSScSI
	 xd323tSai4Qffk3gdeDd/5dHy5XqQae4WUPbuoWHOq6wiYEhtNWVYlwmSPgCOdGT3cdua
	 Xb0iBEmQxFzgL1L+9GJ2as9Sn3PUHXSmZVjpTfyoU2KgPnpq4xPBjJdYMpZbTdn+bq2PD
	 vwRmy2F+v4F7TikEeZsgOMqH0aKI+kdNNpVdb9/GDooryQAAXScLqW0EtMY3A/8BX5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603425;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=9QDqLSd6pFJm2iqcQeawtZNmBX0VjqXvKJwruEHJkpk=;
	b=qBlYA2r81WqOtbRMfFcUv6bDHjaQ9fqKJfWEXmdiZMocxm/0U/yPUvxjkKDbH7dpb7Hm
	 Hq0RzEUJuzvxvbrdSYE+1w6HnS76GWtyVRAOMhmkMmegqNKjjXRP4cA+KmjEs9fu/6aVl
	 t9cCqqQTKQO32AryVT9cpvmeInHhwvRHnuRRoUtz4qko+TNAsXgQnX7K9KcoGm/Msl7jw
	 SdTBZTxHJxhmDuNIoXmK7GXMQMnfVeGFFDdIA+YbIp8RD0shlclXbj9G1Byu3vJ8WqpbI
	 pbTLKqPr7NCZ577Lwtk4Cof+BsQdV3wFf1Wd4EKsCHpM5bbWyt6oKIXN5FSCuZCW4Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k6FoqpV2;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE36606A31E;
	Wed, 25 Nov 2026 10:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AE36606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k6FoqpV2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795603426; x=1827139426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cf+II+B3XkUCRJs9q5OPFzPSx+9NXKQDRCtkLaUO+vQ=;
  b=k6FoqpV2k98kX3nOhVj38kuD5uma+baDoWmXC1Ky4SGw1f06irqwcjZg
   oFbuAXOO88Dk6shND17v6WH+nF3vE9lAT+VIUlP2KPGwm77Ax840Ipx/0
   ihmEz16Dl3ot8vWQ1Psz4Oaklr48W4eQVw13jSLTPuK57kyeirNfhUshE
   i5wNixSor15mUmw3Sx1WACddWfKsU2hHwLfyXL/Xh/Nc0211sfgFqJdMi
   ASkjrqyJJwY2QrfEzL+suW3ykjsZqxJOy8EiQAY3JxdpTcabjZMoHnTPn
   vhSx81wHtkMwqTisKPe14gfvinTUOH8sV1JohOH3SoFYsf31BCRW8wT3y
   Q==;
X-CSE-ConnectionGUID: l8Qhgh5XTIKJ93weP4yNTQ==
X-CSE-MsgGUID: +lB2exjlTJa0ZnPoQXaJXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4480401"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4480401"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 02:43:45 -0800
X-CSE-ConnectionGUID: 4EgpQ/b4S9OvLv1jw0AlkA==
X-CSE-MsgGUID: tmONsi+DTruzdxs+jLD+Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11622841"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 02:43:42 -0800
Date: Wed, 25 Nov 2026 12:43:39 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux@analog.com,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6/6] iio: adc: ad7793: add firmware support and drop
 platform data
Message-ID: <awa728YWKMfpwe8c@ashevche-desk.local>
References: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
 <20261125-iio-adi-legacy-platdata-v1-6-54e4c8830b57@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261125-iio-adi-legacy-platdata-v1-6-54e4c8830b57@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 25, 2026 at 10:19:22AM +0000, Nuno Sá wrote:
> The driver refuses to probe without struct ad7793_platform_data, and
> there are no in-tree users of it. That means the driver can not be used
> at all on a modern system.
> 
> Get the configuration from firmware properties instead, following the
> new binding, and drop the platform data header:
> 
> - The reference is REFIN (REFIN1) if refin-supply is present, REFIN2 if
>   refin2-supply is present, and the internal 1.17 V reference otherwise.
>   Parts without an internal reference need refin-supply.
> - An external clock on the CLK pin is used if given. A 128 kHz clock
>   is divided by 2 internally.
> - The input buffer stays enabled (as it is at power-up) unless
>   adi,buffer-disable is set, and unipolar coding is used unless bipolar
>   is set.
> - The bias voltage generator, the burnout currents and the excitation
>   current sources get their own properties.
> 
> While at it, also enable the AVDD and DVDD supplies, add an OF match
> table and fold the platform data checks into the property parsing.

First of all, can this be split to a few smaller changes?
I will look at the rest later on.

-- 
With Best Regards,
Andy Shevchenko


