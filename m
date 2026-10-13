Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D704FD268;
	Tue, 13 Oct 2026 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903333; cv=none; b=dNL0XUzQ6rA8lWeN0OjfRJx3s78S2NhCJe6h2E62O//hhGUKJ5bJfPvI+vf/fRC6DKx/tQfG/eeBB1T2RGEHWrv8k6hnl5w8aBg4YDxkDYEYz3P7xE7TFzvCITFAz3rDZzPPWbtKDhoNNaWri5rwoMW1csHWRciZfFix6XiKJPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903333; c=relaxed/simple;
	bh=Xo0m7VVIUaPwtcfmUqqVROtWZL9F448ygMk93cgJv9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTtIP+hI3DRsjLRb+QZ5N9P//92lkSedL3kRReVJ/1iXt2NzRPp0b4Ee4tYLG86iNwRZOm8vWIz3GtddI74oLs7OQr2L7TlPmKJpK9kEeao07z5MuDXoaSRxfg704TtSFALOLwWMSisqCPsE1wFdfresjsVqj/9gPMgDAg+n3X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fX+oCmtl; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fX+oCmtl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791903333; x=1823439333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xo0m7VVIUaPwtcfmUqqVROtWZL9F448ygMk93cgJv9A=;
  b=fX+oCmtlpKND+O8a/5/L9lmU1PEnKq8zLGssQzszrjpDqIqGQjmsnfD3
   IkDqKf2crtO3XJdN6JdGKTEOP4pqT4EUIyXi6ZXkiB0RBopX5SZTZz+/K
   QSMFclx1kE/kpO210l/1mcjjszLdZtwUrKnb49Zm+Y+xkCg7IrpCgyaxo
   mVLjcDqh65w7hDkqf2WXviyA1p+YYwlCq1QTH2IOeo38bZDzbPxS1hn51
   t5u+qoKimaly9CgQWvW5kyFUNO64aIFqZVsluj8kCA6kAENBHYVyD3E44
   l6crsgmhFfac4WCq8KpJ+TpU4WdP59khls2Z3iFYa0pAiALPR1q1szh54
   A==;
X-CSE-ConnectionGUID: xGjomppiQKKVXKu/gW8lzA==
X-CSE-MsgGUID: xjkl5iNfQrikAA54z2t+DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="532643"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="532643"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 07:55:32 -0700
X-CSE-ConnectionGUID: 53eLxZZ8TTWVFx0/oZLHtg==
X-CSE-MsgGUID: Fed9jcBtSe2kApKT/xbO3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1125043"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 07:55:27 -0700
Date: Tue, 13 Oct 2026 17:55:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 2/8] iio: adc: rzt2h: Wait for the analog part to stop
 after a forced stop
Message-ID: <as5GXPcMKe-CBLXK@ashevche-desk.local>
References: <20261009184122.1378797-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261009184122.1378797-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009184122.1378797-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 09, 2026 at 07:41:16PM +0100, Prabhakar wrote:

> When ADCSR.ADST is cleared to forcibly stop a conversion, the analog part
> of the A/D converter can take up to 2 ADCLK cycles to stop operating.
> 
> Wait for the write to ADCSR to complete and allow the analog part to stop
> before reconfiguring or restarting the converter.

...

> +	/*
> +	 * When a conversion is forcibly stopped, the analog part of the A/D
> +	 * converter takes up to 2 ADCLK cycles to stop operating. Read back
> +	 * ADCSR to make sure the write has reached the hardware before
> +	 * starting the delay.
> +	 */
> +	readw(adc->base + RZT2H_ADCSR_REG);
> +	ndelay(DIV_ROUND_UP(RZT2H_ADC_STOP_CYCLES * NSEC_PER_SEC,
> +			    adc->adclk_rate));

A single line (84 characters) is okay in this case.

	ndelay(DIV_ROUND_UP(RZT2H_ADC_STOP_CYCLES * NSEC_PER_SEC, adc->adclk_rate));

-- 
With Best Regards,
Andy Shevchenko


