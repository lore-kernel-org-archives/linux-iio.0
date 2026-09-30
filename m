Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612EA4718E9;
	Wed, 30 Sep 2026 09:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760231; cv=none; b=eGiL5ipr3ujYNyjNXw0k62gZN8Mj7uZPW5RFe/Br7WUOVnaJK5jh9IYRnpk/ioeScoqq+PJqWywjg6iMjH3gt9NdTYanJxjFTTOk4Yv5U4dRIM4im94GzydNg2iBZ2ENvKEa3Zf7WVgFwGfOsQPBePQ5QSWDV8qaVEMOwrQrNh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760231; c=relaxed/simple;
	bh=cq/BXhOtaid1stWAPe/hJ661uiAvoRSE8cCpjYuRQ1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vg5ayhHJvPKBUKFfqJu+O6D+wnukU+udpGOzJQkgWCRP2Mnkvl+G8J+Zy7/jiebASZxubQVFShYpvJd3KJ5WPjLaOYsmSg4w5G/PCjRqMRxdKhuDbVT8HzykoGpu6GT4fkh3DdLbT/OIK/XIexht649gRB6k2OvMYU586Zi/PEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OTmt7kmM; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OTmt7kmM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790760230; x=1822296230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cq/BXhOtaid1stWAPe/hJ661uiAvoRSE8cCpjYuRQ1A=;
  b=OTmt7kmM0/qJ/uh5/Wmfs+lKdc1h4gEqBjuGguURQPQIau6r+5T54gjm
   5QsJDg3cJkVo0eqFD6OtaWnlAos3MaWlq4Dl++Ja2LNVudXpzu3hKd29D
   1zzM3bwavGhHrfYMgyTIjpL31zuqoL/DkiZG9JL76tjBxqfY8R+qxoHVR
   AboL1UyI8mXVt+D1cIiOrRw1+txvomemNtt88fOzmaEWyIhrboizmbfRg
   5JLH7W2O3FZNERUlvJKnXwnMZoBt4oY8bnnMo/WgZFFAOHlDbqHc2Az7E
   q7LHTj4Vzk9qBxfv7098GdpJ6wv02sqLrkht6dpapUwbAETG+cH2a6LXx
   g==;
X-CSE-ConnectionGUID: TCrVodawRHma8evh5d3bTA==
X-CSE-MsgGUID: JvDjPvRNTBWVxmOKqrYJWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="117023008"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="117023008"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 02:23:49 -0700
X-CSE-ConnectionGUID: 0asZAznXSlaX6nh7cxKpLg==
X-CSE-MsgGUID: Xf8MHHLSQm6w4w5ig8JiPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="305150934"
Received: from spandruv-desk1.amr.corp.intel.com (HELO localhost) ([10.245.245.137])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 02:23:46 -0700
Date: Wed, 30 Sep 2026 12:23:42 +0300
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
Subject: Re: [PATCH 2/8] iio: adc: rzt2h: Wait for the analog part to stop
 after a forced stop
Message-ID: <arzVHnMtKqQx5rdZ@ashevche-desk.local>
References: <20260929124248.237032-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260929124248.237032-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929124248.237032-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 29, 2026 at 01:42:42PM +0100, Prabhakar wrote:

> When ADCSR.ADST is cleared to forcibly stop a conversion, the analog part
> of the A/D converter can take up to 2 ADCLK cycles to stop operating.
> 
> Wait for the write to ADCSR to complete and allow the analog part to stop
> before reconfiguring or restarting the converter.

...

> +	/*
> +	 * When a conversion is forcibly stopped, the analog part of the A/D
> +	 * converter takes up to 2 ADCLK cycles to stop operating.
> +	 */
> +	ndelay(DIV_ROUND_UP_ULL((u64)RZT2H_ADC_STOP_CYCLES * NSEC_PER_SEC,
> +				adc->adclk_rate));

I do not see the point in having _ULL (64-bit) division. Do you?

-- 
With Best Regards,
Andy Shevchenko


