Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C201F347BAF;
	Mon,  7 Sep 2026 04:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788755415; cv=none; b=hsCieDlwRq1zsdREa4VLd4X5xBqPddhDqYrIipeSO7tzjMKxcb+ZOOoc8qd/UP2f/CwNdEf8NmCrKNKJ5zbYpZtV8LQ/wCIZrXh3pAHWYe0wotZtmKvtyAw3vGrETaOSQGMA4V4CbTJxoQdnNzTHEX1dLyrtYUHV3VNa7tJz/Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788755415; c=relaxed/simple;
	bh=JWT1g5IjBxTLi6oiT9oR1Lied0bZA2BvuXmyJc2bDe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNMA+CqJmzFuZMVQ821LEsKo5euiS0RUGJwEEsi+qg2YmhfHCswFQK1US7vYIupUNRtbzumy81xjOytAGpU/MEtMmMj7hATNrJkkHC0CT4P78dVppoIibJKN5B3tCsEExig5j5GG9L5lz++PVaLdxUEDqmUaKnLjUfN9KChmiPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FnQhu8Fl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FnQhu8Fl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788755413; x=1820291413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JWT1g5IjBxTLi6oiT9oR1Lied0bZA2BvuXmyJc2bDe0=;
  b=FnQhu8FllmCB/hqqVT8+1hWA2nmXIuyjyZOo/l50gKU9oT6pnu+wFdX+
   2m8P5fW24vCY3qQrs0nBy5icYO/+SMNg0HUoLmfyHkpRdO0RpTLZmp9Q9
   DieCTTuVLueYqBsWZ/OycigSyDA9kQ0meiXmEoHwg96ZY1m2lJDWBL/6u
   YqAB1xK7hM4oesXo1VLNjDGFUbKcTC+HWw8b2plWk8US0l2Qkrq46yZZt
   jIVfLVMK/RlHmYXIXmnKSuSB1r6g40El+Yjvyd2W1uZ3X2kvSg801j6Sy
   wr3zePqe4uKbKZk9OM6ZMadTB9QVMaMOHB5aL2irk+voWPD5CQBsNbgyz
   A==;
X-CSE-ConnectionGUID: LCOiXsFFT3OMm/SfsY9zhg==
X-CSE-MsgGUID: IJFFa10fSWGW/E4jBluSbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="89027925"
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="89027925"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 21:30:12 -0700
X-CSE-ConnectionGUID: jXO/5VjxSWG4OdCL55MQlQ==
X-CSE-MsgGUID: fCTgfwiFShuO3gGalvWwIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="264406853"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.182])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 21:30:09 -0700
Date: Mon, 7 Sep 2026 07:30:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 0/4] Add support for AD5710R/AD5711R DAC
Message-ID: <ap49ziNqSGffGNdv@ashevche-desk.local>
References: <20260904-iio-ad5710r-upstream-v5-0-76f985b7d0ee@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904-iio-ad5710r-upstream-v5-0-76f985b7d0ee@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 04, 2026 at 04:35:23PM +0800, Kim Seer Paller wrote:
> The AD5710R (16-bit) and AD5711R (12-bit) are 8-channel, low-power,
> configurable current/voltage output DACs with an on-chip 2.5V reference.
> Each channel can be independently configured as a voltage output
> (0V to VREF or 0V to 2xVREF) or a current output (0mA to 50mA).
> 
> This series adds support for these parts:
>  - ABI documentation for the high_z powerdown mode and the current-output
>    powerdown attributes
>  - device tree bindings for the AD5710R/AD5711R
>  - basic IIO DAC driver, supporting per-channel voltage/current output
>    selection, per-channel powerdown, software or hardware (LDAC) DAC
>    updates, optional output range doubling, internal or external
>    reference, and hardware reset (with a software-reset fallback).

Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko


