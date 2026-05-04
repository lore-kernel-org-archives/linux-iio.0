Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1483E0C6B;
	Mon,  4 May 2026 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777910068; cv=none; b=j/Rk+CfMG59bw90AnC0uTAvNI7L/KFBbduKCExb2Rmj+U1lDoHq/QJXeg7RW6WY9U66Y++njU/IxzBXiNTh7joxOokJOPfGYrfRrF+i2n97TgL0lfbgBw9FqqTf3VGpobKeZ3wmtYW/uW7Hx4NauU0UPMh/1EQ+DlIKul/YlFQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777910068; c=relaxed/simple;
	bh=mwNg+p/2mdUFbtYVu5g7Fm4FdxPwjIEWh+xceHydOOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyJf99GI30R3UwA+1zgoR824zTKLHfsmVnnsqZJQklrmYyB0WqQuP9OFMnJ8tQeKrhkZ1nmeAf2q0y9KUG8V3AgMscF00g7euBtRZMZ9YxTv1XogzEEdpxumapSp6MODhfeyPnqSHOgN65nY/QYMSsH7vbnl3x4J6b7uHHiiX6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gzb3eGZM; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gzb3eGZM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777910066; x=1809446066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mwNg+p/2mdUFbtYVu5g7Fm4FdxPwjIEWh+xceHydOOk=;
  b=Gzb3eGZMY4McNzPtkR9hUnHWEWw7WrLLJErlUGcfy1YXFo6KGmjcu8mI
   btJX/Od/vlItiTGlUT/mczVEo+5OacIzVEu+e9F3mJ3EJPWUoSzJ7JMU7
   +RDvHORBSwoKwPlL5sam/geWi+RuIq8TPc6aKV1XKpGyVwioiGpV3mVqe
   SstuQ2Amd/CTTdTaTpaB/96sEVGvHt0xYInfc4AiTC3EM5ABgcrPRXcPg
   sP/VBlBk/k69jwABbaikf4xWd+X6axflNnf+OLqbdBh0j1fE7RmEXUadQ
   FEQRzQpNNPb2MQXgnKVbdH46ZFRxzm7SEoZ0tFdZFZdlokQyyQ1KLPneP
   w==;
X-CSE-ConnectionGUID: +dAo5tquQCWyZQ9cF+kxsA==
X-CSE-MsgGUID: E1pvkwupQjSytcE1aFp0fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="104218045"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="104218045"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 08:54:25 -0700
X-CSE-ConnectionGUID: /XmlwKnBRXe0ciyuYM/JGA==
X-CSE-MsgGUID: C9xtVKSRRVWQozcPmoOXGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="258899958"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.198])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 08:54:22 -0700
Date: Mon, 4 May 2026 18:54:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/11] iio: adc: hx711: add HX710B support
Message-ID: <afjBLFSKAhFHb7uA@ashevche-desk.local>
References: <20260503120949.80292-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503120949.80292-1-piyushpatle228@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 03, 2026 at 05:39:29PM +0530, Piyush Patle wrote:
> Add support for the AVIA HX710B ADC, a HX711-compatible converter with
> the same GPIO interface but a different channel-selection model and a
> fixed gain of 128.
> 
> Compared to v5, this series is unchanged functionally and only folds in
> the remaining review nits:
> 
> - keep the per-variant probe local declarations in reversed xmas tree
>   order
> - add a preparatory split-assignment patch before the loop-iterator
>   cleanup, then keep the loop indices signed to match trailing_pulses
> - replace the 24-bit read loop bound with a named constant while
>   touching the same code
> - keep the driver wording aligned on "weigh sensor modules"
> - rename fixed_gain to has_fixed_gain and drop the channel_set cast
> 
> The DT binding split from v5 is kept as-is:
> 
> - cleanup of the existing HX711 binding text
> - HX711-only VSUP documentation
> - HX711-only RATE GPIO documentation
> - HX710B binding addition
> 
> Tested on PocketBeagle2 with an HX710B breakout module. The device
> probed successfully, all three channels returned stable raw readings,
> and alternating reads confirmed channel switching between the
> differential input and the DVDD-AVDD supply monitor path.
> 
> Build-tested with:
> - make -s W=1 drivers/iio/adc/hx711.o
> - make -s dt_binding_check \
>   DT_SCHEMA_FILES=Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> - pahole -C hx711_chip_info drivers/iio/adc/hx711.o
> 
> pahole reports hx711_chip_info as 40 bytes with no internal holes. The
> remaining 7 bytes are tail padding from 8-byte pointer alignment.

Some small issues here and there, either Jonathan is going to tweak, or if
v7 is going to address them, feel free to add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


