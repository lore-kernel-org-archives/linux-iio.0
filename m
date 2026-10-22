Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792687235;
	b=rgcHdeaBz5TyYmy6aBaZjhewyButWXnkRmXInjXJ0wpNcGHNdYxoTsmXiHNjf8rPZcaV
	 R6jXM6fJvlZ7Lc2Jm6rj98J3JdGc98qPZL5epvpXoMecunquDHEsIZ5q4dY/O30yBkycU
	 5IVcdWBJYLXUigT5CcWyi5Hzs5avSpxCIC3eT0OanWU77y2OIE53tlIdo3RL9tBU/wr+Z
	 lngmZ8T+sUzuvSoAsVTQOn4sODqbzZdbq8EbaON31Eb1RBqZ/Y/6NgwZ1pvpPJv+2tmaG
	 bwFX3xAhPVxIe9jwWQe3sgFLHR6S4hlh3qvz7H/jG6wSkUpH3DZsa8Iv+3IPkSMuRQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687235;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Nu0uZjnjC1dudhj0yygthv/OZM3heiR+aoIBI9kPycc=;
	b=OyihatBJxYIVGJ2TcCWXV3pg1EKPPeesFZwYzEXYwkxx7LBHHgRMiZmg5wPU0CkxXbaU
	 H6dWm615VtJ2PGRrH8rcrMrQIRnkrQ5AsouUHwjliE/cHLVjLUtBxyJjB1xN0BcB1OnPK
	 /+kCu6zzn6SjnVPYAwxL2xY2IUt6qIlZ2h0joL/RvUJ2KVjba8GjJR0YXly42GsHAaZ0i
	 Kk9uDQ5Q9mrnTMZKFKxbc3VAeT6X9/HrtQkOhHBiZ+UJu2YGbSKwAuBe9kdgPzj3hd9Bz
	 J4TLAVooi4MjP/3f/jxMk/pnRI1iWejO6u3mZHas6Go/YC11DrPfkqApNNxrs7oZ8Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="CzAt/frj";
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FE0606A31F;
	Thu, 22 Oct 2026 16:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22FE0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CzAt/frj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792687234; x=1824223234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iH37BBIcnu6/dIwqjUxNoO3ZrGEAlpO5JETQSqjyYWc=;
  b=CzAt/frj8y3S8L73+p1ZtkW8/0azWpOHxvOaDmWRIaiHeAE5uMr7QtWF
   z/jHMb6H3rHrOG2ee5uO9BvHTIzprsSprnGfyiHwvxIRU264HqkKBd/FV
   ogoTSkYsdxlGHpeWnQPC5/nQOVu0lTaXxlhImP1Ex2tZ4/KnlqNiWGzAn
   2UW78QhxedVp1evaq1mKR37ntbwCnBhXnoavD2dLFYdd7HlPoN/qTn5ob
   U+xNqLve0g/zI4SXeXdzPGXxZrlcTjQLlH4Nx9XVzM3z7xxxgkbzg0faY
   9/++RibG0TA3E1yfbMItBdAM831PWM8+VQEX/nuq3O9PPUdC/eRpBqkiE
   Q==;
X-CSE-ConnectionGUID: uF6D5W3OSj6km6WQ4X6/ug==
X-CSE-MsgGUID: j1HbAsmjS5uWwUpZ39vD3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1449980"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1449980"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 09:40:33 -0700
X-CSE-ConnectionGUID: kOFHyUTvRPeABbuMkNzV0w==
X-CSE-MsgGUID: DeQuPlEQSnCtcHtp7frXuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3751327"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 09:40:32 -0700
Date: Thu, 22 Oct 2026 19:40:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: sx9324: fix out-of-bounds read of scan
Message-ID: <ato8fTSWub91Fy2R@ashevche-desk.local>
References: <20261021225417.626946-1-kapoorarnav43@gmail.com>
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
In-Reply-To: <20261021225417.626946-1-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 22, 2026 at 04:24:11AM +0530, Arnav Kapoor wrote:
> The scan period of the SX9324 is selected by the 5 bit wide
> SX9324_REG_GNRL_CTRL0_SCANPERIOD field, so it has 32 possible values.
> sx9324_scan_period_table[] however only has 16 entries, it was copied
> over from the SX9310 driver where the field is only 4 bits wide.
> 
> sx9324_wait_for_sample() indexes the table with the raw field value, so
> all the codes from 16 to 31 read past the end of the array. The default
> value of the register is SX9324_REG_GNRL_CTRL0_SCANPERIOD_100MS (0x16,
> i.e. 22), so the out-of-bounds read happens with the default
> configuration of the device. It is only avoided when the device has an
> interrupt line, as the wait is only done in the polling case.
> 
> The value read is then used as the duration of an msleep() call, so the
> sensor is polled with a completely random delay.
> 
> Fill the table with the scan periods of all 32 codes, which are the
> periods documented for the corresponding sx9324_samp_freq_table[]
> entries, and add a static assertion to keep both tables in sync.

...

>  static const unsigned int sx9324_scan_period_table[] = {
> -	2,   15,  30,  45,   60,   90,	 120,  200,
> -	400, 600, 800, 1000, 2000, 3000, 4000, 5000,
> +	1, 2, 4, 6, 8, 10, 14, 18, 22, 26, 30, 34, 38, 42, 46, 50,
> +	56, 62, 68, 74, 80, 90, 100, 200, 300, 400, 600, 800, 1000,
> +	2000, 3000, 4000,

NAK to this hunk.
Homework:
read my comments regarding formatting such arrays in linux-iio@ mailing list
for last calendar year or so and summarize the idea.

>  };

...

> +static_assert(ARRAY_SIZE(sx9324_scan_period_table) ==
> +	      ARRAY_SIZE(sx9324_samp_freq_table));

This is fine, but I would dare make it a single line.

-- 
With Best Regards,
Andy Shevchenko


