Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4934FDA5E;
	Mon, 28 Sep 2026 21:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790632199; cv=none; b=uYLyZjECHLl+UHVWfNmc5PAHtoMjAUBNByiba7bqVDNh/Ibbq5aYlu9f/0kKaMhEP33fCThuGKVyoOZxNud6N+qb1TaTqiyDap8Ptft8cnbaATUizMJnkI2kZWs2cTh7PlY71E/IPveFOjJ9h+NrhBMCb0hB6Rz5/OUObQlkdeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790632199; c=relaxed/simple;
	bh=3A2k4B1MyyYGlKtnyMek8DNyKiLznOjV5xluhGSwX50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffTOnzkJeXI/7rljmWnW1hQq2+MdbfOgN/LHQx5yjAWiqCAIX52NjtOofj98ntMZnpICoPYDsJguKeOpACVg9PKPpLRj6xGnLSpGEalxgaMswXdIv8GH80JciF8uGvZo9GK2YkmuFV0WM++W21qS6Qoc4u5GLBheP4veElzz6DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JzdweCFF; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JzdweCFF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790632198; x=1822168198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3A2k4B1MyyYGlKtnyMek8DNyKiLznOjV5xluhGSwX50=;
  b=JzdweCFFoG13oNLxiTaYdb7GTn3MF5b9Fx7/pLQyz8WG0qkOfnfSBbx1
   K3OnbGA40p1G07r1wyAifLlFcp/UGj4eC660r+aIn6rHjVwUTQrUbNhsA
   irtHc/qlZS+mgaV0nV3gqoA/7nN8vNg5jnmTRx6Lgfb8g7Quy84YUtnNk
   Db2dMTUKi3e5wPw5K7NG8S8vUmsFDcWV8WYpnWlRP7LMnQJ3uhKeOzXnd
   LM8+pHo0nqE01hOBk4oQypq8ejjwVXXSurZqW4uZAVmmxlBltbtlwvDzZ
   nbBK9I9o0LPHjw4tTNbMWb2kdLg1NUI69TV17JXeQ8qhfKJAViI6mlcFY
   w==;
X-CSE-ConnectionGUID: nUR8NSgjQsysPdGt/OJaWQ==
X-CSE-MsgGUID: Ve/XkwB5SGOnBQHcgESlkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90295161"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="90295161"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 14:49:56 -0700
X-CSE-ConnectionGUID: agS7fjZAS8yA+UD6RGr5mQ==
X-CSE-MsgGUID: LfT05oMtSsy/cY302rRjFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="278380629"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.42])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 14:49:52 -0700
Date: Tue, 29 Sep 2026 00:49:49 +0300
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
Subject: Re: [PATCH v4 2/3] iio: adc: mt6397-auxadc: add mt6397 PMIC AUXADC
 driver
Message-ID: <arrg_SBRTPbquCFA@ashevche-desk.local>
References: <20260928-rbrue-suez-upstreaming-mt6397-auxadc-v4-0-23533a0d30e3@gmail.com>
 <20260928-rbrue-suez-upstreaming-mt6397-auxadc-v4-2-23533a0d30e3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928-rbrue-suez-upstreaming-mt6397-auxadc-v4-2-23533a0d30e3@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 28, 2026 at 03:57:20PM -0500, Ryan Brue wrote:
> The mt6397 AUXADC is a 10-bit ADC behind the SoC's PMIC wrapper. On boards
> built around this PMIC it is the only way to read the battery: the SoC's
> AUXADC is wired to board thermistors and the charger ICs these boards use
> have no ADC of their own.
> 
> Add a driver exposing the battery voltage and battery temperature
> channels. Only those two are described, so a channel ID in the device tree
> indexes the driver's channel array rather than the PMIC's channel number,
> as mt6323-auxadc does. The ready bit lives in a channel's raw result
> register, but the value comes from the chip's factory-calibrated copy.
> 
> The battery voltage is measured through ISENSE, because a board with a
> switching charger in the power path leaves BATSNS on the charger's system
> rail instead of on the pack. The thermistor only reads correctly with the
> PMIC's battery-detect bias and input buffer enabled, which take 20 ms to
> settle. Both are switched back off afterwards.
> 
> Reads average sixteen conversions in software; the chip's sample
> accumulator makes no measurable difference at any setting, so it is left
> at one sample per conversion.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


