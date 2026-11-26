Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702918;
	b=TfKtpihjMNycQ15AdkaR0Fof40zp8+7JBoMrE9xGstSEpiFo0pPSG2g/yO/vW3iAWu3z
	 UNwxBrQIl5rDQkO5veiem98KujPwr2r14VDax495TgnLbwK7heoVqXm0nsM7CV7Yo8D43
	 7opKh4rJjcBPEv2hX1xM/WgeA0jLDsHHOvBPP4/3/LUdnzzYLvH7S3j6LRt/RE80Ts3K2
	 RnZD1BKGgC+COLtyvcDs1tBqR9yCMynUjNErMIaIfwY4EfryuMM+xC0YAiGoHhNSXNENW
	 BDGuB334CBL7UsYUzWtA6KpT2Yo8RcxvOXM2T42jYCNjRQ8EdkaVmNggl1Ty/GND+Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702918;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=U+4pL6qLvvaN/MhyEDL7roP9YywTVS8pAuir7owH1T4=;
	b=X12zxpIUbGZ8vQYRj71CR04bjLEbwJhnmeQzTuZyaov5NScjtLMYWJnYO186tegOAjuV
	 Mc3BlwKr+2ogsEy0voVnswtdZOVqc4S8wKJQqocVgj2HPMu48ZVtfdyGb1WwFW/fw/oZF
	 qFyevHKeiHmI9qHBbJcjM3iWVbJb//cwBuiln+kVZ/OeLItw34v9g3pQKcZvyDelhonY6
	 3ljguGv2gmzceAT5WGNVEvXbPX9WBAaDsqENIicF+voc5e6DL4J6DiGXnpVIw6yECiOtO
	 dMbzx6KoFjMgHnPW2ejr+kSxjihbxiZ+wqdrBSsKplSiKXH05AjgQKaL2SlBQ/b/T5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HuUMdNUl;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E09606A31E;
	Thu, 26 Nov 2026 14:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23E09606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HuUMdNUl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795702919; x=1827238919;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8E/3GjBkO3qFHAhQ6seGTlGhA2dd1h8qEzfPoxUikwM=;
  b=HuUMdNUlOxy5GB5vz16dFT3HyDfnZqbg5lhZ8R5wG9czd+osOpLDyOXM
   mz7JOMaQqD+9tlwxVMzTqk+/cUrwvvoOTmRiIeXNs6C9QE/aLZvufri1h
   ayy2oLRJgOsvoL+MvtbhMbdhSlFoAOCdwrbvmO5mqWl+bWEvYORE3qJJM
   JjTN2Mp1RuP8UIKtPqJp5HiGOQl2dIqprpdgXIqITZuKoEmeKSyxqsdYs
   XaGlE2CSBdcfmn0OEwjrjbuoXrx6LvM4CUYg0jXe1H+4vR8plDEqWh2cG
   AbSEwL9UbP1fm+YfEXX8xv+8mJ4/EGnQWwmmI6Zx01p7zrIuzFkCetp2a
   A==;
X-CSE-ConnectionGUID: DZRbWyfqTiWzdd2pJE4CZQ==
X-CSE-MsgGUID: 8eAk0uQJR2iFLQOTwN6jcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4498002"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4498002"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 06:21:58 -0800
X-CSE-ConnectionGUID: BAPLiANfQDyy66/S57hlZg==
X-CSE-MsgGUID: shslAUAQQJqkv8Gj5IR+vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="11964080"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.208])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 06:21:55 -0800
Date: Thu, 26 Nov 2026 16:21:52 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Robert Ijtsma <robertijtsma@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/2] iio: light: add support for ams OSRAM TCS3430
Message-ID: <awhAgM77M7I8chR3@ashevche-desk.local>
References: <20261126-iio-tcs3430-v2-0-6c5329d20919@gmail.com>
 <awg91DruXE0fZ8l-@ashevche-desk.local>
 <20261126141415.116a2eb352e6@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126141415.116a2eb352e6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 26, 2026 at 03:14:15PM +0100, Robert Ijtsma wrote:
> On Thu, Nov 26, 2026 at 04:10:28PM +0200, Andy Shevchenko wrote:
> > On Thu, Nov 26, 2026 at 09:11:46AM +0100, Robert Ijtsma via B4 Relay wrote:
> > > Add Devicetree binding documentation and an IIO driver for the ams OSRAM
> > > TCS3430 ambient light and CIE 1931 XYZ tristimulus color sensor.
> > > 
> > > Tested on Microsoft Surface Pro X SQ2 (SC8180X), where the sensor is
> > > connected on I2C at 0x39 and used for ambient light sensing.
> > 
> > It's still unclear why a branch new driver. Can you elaborate on this?
> 
> Sure. Compared to the existing ams/TAOS color and ALS drivers in
> drivers/iio/light/, the TCS3430 differs in both register interface and
> sensing architecture:
> 
> - tcs3414 and tcs3472 are older TAOS RGBC (Red/Green/Blue/Clear) devices
>   using the legacy 0x80 COMMAND-bit SMBus protocol (register offsets
>   0x00..0x1b), different ATIME/gain encodings (e.g. tcs3414 fixed
>   12/100/400 ms steps; tcs3472 countdown (256 - ATIME) * 2.4 ms, max 64x
>   gain), and RGBC channels.
> - as73211 is an unrelated MAZeT/JENCOLOR XYZ/UV sensor family (I2C
>   0x74..0x77) with banked config/output register spaces (0x00..0x08), a
>   1.024 MHz clock divider, temperature channel, and 1x..2048x gain.
> - TCS3430 uses ams's direct-addressed 0x80..0xdd register map (no COMMAND
>   bit in register addresses: ENABLE at 0x80, ATIME at 0x81 as
>   (ATIME + 1) * 2.78 ms, CFG1 at 0x90, ID at 0x92, 16-bit Z/Y/IR1/X data
>   registers at 0x94..0x9b, CFG2 HGAIN bit at 0x9f for 128x gain, CFG3 at
>   0xab, INTENAB at 0xdd) and outputs CIE 1931 tristimulus Z/Y/IR1/X
>   channels plus photopic Y illuminance.
> 
> I will also note this distinction in the commit message / Kconfig help
> when preparing v3 (alongside adding MODULE_IMPORT_NS("IIO_GTS_HELPER")
> for CONFIG_TCS3430=m builds).

Kconfig help probably don't need this info.

-- 
With Best Regards,
Andy Shevchenko


