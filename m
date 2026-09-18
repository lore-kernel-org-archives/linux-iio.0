Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE66370D69;
	Fri, 18 Sep 2026 07:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789715944; cv=none; b=XJ5f0Ak6MBNUbHxS3abgrEDzOlgiF4ySPeIlS0fJtLQWa+aeMtRH4i13S8iuVkiif7MZLsWnRkpheMl6ia4TETkCtyIKldALRkIE+WkbQ00Nbffmc3vK1lg/ABNAhcrDTeOxLCljmiXEwM/wjkDRYi6AeOldQmIinnYOKdopnZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789715944; c=relaxed/simple;
	bh=dfxlF5cxykKt1JLCGAytW/kqApoyMBeXGMrJQ5Ycbg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JF9qSjGUm0CRimbVk3tcDkDUC3IrMKUu0EIcN5zCr03AY0kIGPXjkD4srS40rhPJyMSCKIRulUvy6MlICEHcR/2J34MSMg4Dc7otBIrmWdcQxScK04LRcIFYN1bDNQfqCfyse6eDQJFxHVgxtBpS8GrX01QjHxWJxbqhtes2Abo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AO5MzpOI; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AO5MzpOI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789715942; x=1821251942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dfxlF5cxykKt1JLCGAytW/kqApoyMBeXGMrJQ5Ycbg4=;
  b=AO5MzpOIY1iqz4xALzwf6KWEZ1NoI4XqXad2JhZh2a0E8gtsn5V0uk+E
   KrhHe5HNSjyGtMyoI9gXF58hlNdftOuRFX1gSUN+hKhp1N1ywFYAzA4TP
   sHiRpffaySWyNTHAsQh8IOV2+0Pp56Emai6jqCd4lV3WK1OZ4sOln4/8m
   YrjqZjnQXIi9TbPxH1tjxFbWPqqr7kVawGSzwI/HWhtqw5WRziwSd4qJ9
   zbSn9K59UkTtTc87NJ8b803iqcTXI7bvYgL7ZQuUuHUNg4LDlbwLhYrM8
   4mHoR/UllDv8w/UUzAAuO9hd9HV56Wx4A5Jy6tEW2/AFz0pg/M1CfRlLH
   g==;
X-CSE-ConnectionGUID: RMbQHMX1TCu6yTPjrv8q1Q==
X-CSE-MsgGUID: T1+/muIFQcuV5b56AUlKtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89338051"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89338051"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 00:19:01 -0700
X-CSE-ConnectionGUID: YVxCbwO2SqqSvBOkmu44aw==
X-CSE-MsgGUID: FpOe3BXLSpad84ZaQLJXvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="276224505"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.170])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 00:18:57 -0700
Date: Fri, 18 Sep 2026 10:18:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, mfd@lists.linux.dev,
	Roman Vivchar <rva333@protonmail.com>,
	Luca Leonardo Scorcia <l.scorcia@gmail.com>
Subject: Re: [PATCH v2 0/3] iio: adc: add mt6397 PMIC AUXADC support
Message-ID: <aqzl29C_R4zwAnDK@ashevche-desk.local>
References: <20260917-rbrue-suez-upstreaming-mt6397-auxadc-v2-0-db35882a6080@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-rbrue-suez-upstreaming-mt6397-auxadc-v2-0-db35882a6080@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 17, 2026 at 09:19:49PM -0500, Ryan Brue wrote:
> The MediaTek mt6397 PMIC has a 10-bit AUXADC that nothing in-tree can
> reach. On boards built around it that ADC is the only path to the battery:
> the SoC's AUXADC is wired to board thermistors, and the charger ICs these
> boards use have no ADC at all, so without it there is no pack voltage and
> no state of charge.
> 
> Patch 1 adds the compatible to the existing MediaTek PMIC AUXADC schema and
> the header naming the channels, patch 2 the driver, patch 3 the MFD cell
> that instantiates it. The cell comes last so that no commit in between
> registers a child no driver can claim.
> 
> The mt6397 is not given mediatek,mt6359-auxadc as a fallback because the
> two are not register compatible; patch 1 has the detail.
> 
> Only the two channels a board needs for its pack are described, so patch 1
> ships a header naming them: a channel ID is an index into the driver's array
> and not the PMIC's channel number, as in mt6323-auxadc. The register
> sequences are the ones the vendor kernel's pmic_auxadc.c programs.
> 
> One note on patch 3: it adds a cell to mt6397_devs[], which Luca Leonardo
> Scorcia's MT6392 series converts to the MFD_CELL_* macros in its patch
> 4/9 [1]. Whichever of the two lands second needs a respin. Mine would
> become a single MFD_CELL_OF(), and I can do a respin if that patch arrives
> first.

> Cc'd Luca.

Instead of this, just put the real Cc: email tag here
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>

> Tested on an Amazon Fire HD 10 (2017), an mt8173 with an mt6397. Both
> channels are exercised: the battery channel by a fuel gauge, which reads 817
> counts, 3830 mV with the pack at rest, and the thermistor channel by an
> ntc-thermistor consuming it.
> 
> A new driver was created here, instead of modifying an existing driver such
> as mt6323-auxadc or mt6359-auxadc, for the following reasons:
> 
>  - Both mt6323-auxadc and mt6359-auxadc select channels through a request
>    register (1 bit per channel), while mt6397 uses a 4-bit numeric field
>    CHSEL in CON1 (10:7), and then pulses a START bit (CON1 bit 0).
> 
>  - For mt6323-auxadc, which is the closest I could find to the mt6397
>    (CON0..CON27), it has 13 more registers than the mt6397 (CON0..CON14).
>    It uses CON22 for its request register, and reads the result value
>    from the same register as the ready bit. We don't do that - the mt6397
>    has a factory calibrated value for each channel at 0x16 higher than the
>    raw value. mt6323 also has a 1800 mV / 15 bit scale / resolution while
>    we have 1200 mV / 10 bits. We also have some per-channel preparation
>    that we have to do before the burst, that the mt6323 doesn't have to
>    do.
> 
>  - For mt6359-auxadc, it has a more generic framework for describing the
>    AUXADC, but it assumes requests are channel-per-bit, and so we would
>    have to basically ignore req_idx, req_mask, rdy_idx, and rdy_mask.
> 
>  - We also have our own software sampling, which the vendor does too
>    (Amazon Fire OS based on Linux 3.18). We'd have to have our own
>    sampling callback to do it.
> 
> I have two things in the driver different from the vendor (Amazon
> Fire OS based on a 3.18 kernel). Verified with over 150 interleaved reads
> per setting:
> 
>  - Leaving the ISENSE input enabled between reads, as the vendor does,
>    makes no difference to the value, so the driver switches it off again
>    and leaves both ADC input enables clear when idle.
> 
>  - The chip's sample accumulator makes no difference at 4, 8, 16 or 31
>    samples and costs no measurable time, so it is left at one. Software
>    averaging helps, but only by about a quarter: 0.92 LSB standard
>    deviation for one conversion against 0.67 for sixteen, where independent
>    samples would have given 0.23. Conversions in a burst are correlated.
> 
> The reading was checked against the charger, which regulates the pack to
> a programmed voltage in constant-voltage mode. Over twelve such voltages
> from 3904 to 4080 mV, and charge currents from 111 to 778 mA, the driver's
> reading is a mean of 0.9 mV from the regulated value, well inside
> the charger's regulation tolerance. That also settles reading the chip's
> trimmed result register rather than the raw one - the raw register is
> 20.7 mV low at every one of the twelve points.
> 
> [1] https://lore.kernel.org/all/20260902193351.185771-5-l.scorcia@gmail.com/

-- 
With Best Regards,
Andy Shevchenko


