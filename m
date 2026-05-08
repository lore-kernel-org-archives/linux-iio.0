Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7113C36F430;
	Fri,  8 May 2026 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234610; cv=none; b=IFj0ThKi0wHBTj4AXYCcfsDWzKQJox7mo/jGEpoJ6eKaN2NvPh7sI+lQtwuhzBh98cGg00JsyVrW0GUbKTVjjNCEJVJhME4SqhVjAd4KMnsU2b9mKbPNLshKzXawak1m0U7VyTM7+B1joEnzFRrGJ4AFHiWcddx+nulJtAhWD94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234610; c=relaxed/simple;
	bh=4H7LvL/xgunIBQphvOlxfGy+9zpWlf5Ce0dNPB6LKik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+hle+BKd7NiqZMMtQ8i9UGcfukGeyUwXEkD7XXM0rf7xSm08LBaS9GJqfWsL5VqyXjbqrZZVImxJ2b1H3pRZeL3XEylGz6hE0zAJweOm1u9PYXwHDquwc7nAfhKXinWVANkI7VM0JQDIjtnJqI4WpdAeV4ZrBWurRPrmaBEmIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zkn1wbPv; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zkn1wbPv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778234608; x=1809770608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4H7LvL/xgunIBQphvOlxfGy+9zpWlf5Ce0dNPB6LKik=;
  b=Zkn1wbPvoTGCrZBViVuLv0udMArzaxbqhrn6nJ7j6AUGTTI9Pjb3MnZO
   McJ29VqMtCaB9TFXkRn65VOUrZdI1F8zETxgPER0moRiOgGs5jkopsIbq
   m4OZ5n6Lsh6leZe5FjxUYLqAqXcA0BY4tfLe7Ot+P36EE9xOCzgyXjtwa
   1OWgc4qeXF+e1X77Z7bVPcuACxA3YYQdBCqkfnBqKyjMWYWWWmGF1pgau
   2xr5eYuveCpYsxBFI6I3WYsNuMh8PjFbr2hG0BtHBzJruWZzOs0bCBsO4
   fPbw4+WJFl15WmfPPRrs7758WFn2YTdQCMCtxT75/mezNbMorVkYDf4tY
   g==;
X-CSE-ConnectionGUID: Jk35TtXoTs2sso2PYk28uA==
X-CSE-MsgGUID: VoGaMysFQH2XiFbnQapPlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="90301920"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="90301920"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 03:03:27 -0700
X-CSE-ConnectionGUID: oEfY9IX5SFyxHL9zngRdeg==
X-CSE-MsgGUID: hy7qaQGAQHuIsbWTWJgJEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="274845385"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.237])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 03:03:24 -0700
Date: Fri, 8 May 2026 13:03:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Vladislav Kulikov <vlad.kulikov.c@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: magnetometer: add MEMSIC MMC5983MA driver
Message-ID: <af206U20Fvky1g30@ashevche-desk.local>
References: <20260507205033.951990-1-vlad.kulikov.c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507205033.951990-1-vlad.kulikov.c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 07, 2026 at 08:50:30PM +0000, Vladislav Kulikov wrote:
> Add an IIO driver for the MEMSIC MMC5983MA 3-axis magnetometer over
> I2C. The driver provides raw magnetic field readings with
> per-measurement SET/RESET offset cancellation, giving 18-bit output
> with a full-scale range of +/-8 Gauss.
> 
> Tested on a Raspberry Pi 2B with the sensor on I2C-1 at 0x30.
> 
> The initial driver implements the validated I2C single-measurement path.
> Other chip features are left for future work:
> 
> - SPI transport: the binding describes SPI wiring, but driver support is
>   left for follow-up validation of the SPI command and SET/RESET
>   sequencing.
> - Temperature channel: left until the temperature output behavior is
>   better validated.
> - Continuous measurement mode and Auto SET/RESET: left until the
>   interaction between CMM, TM_M, Meas_M_Done, and SET/RESET sequencing
>   is better understood.
> - Saturation/self-test bits and BW/decimation tuning: not exposed until
>   their behavior can be described reliably through stable IIO ABI.
> 
> The driver uses a conservative 500 us post-SET/RESET delay before
> starting the following measurement. The datasheet describes a 500 ns
> SET/RESET coil pulse, but testing showed that a longer software delay is
> needed before taking the next measurement.

My comment from v1 still applies. Note, when sending a new version of a driver
like this, give approximately as many days as hundreds of LoC in it.
The bare minimum 24h anyway.

-- 
With Best Regards,
Andy Shevchenko


