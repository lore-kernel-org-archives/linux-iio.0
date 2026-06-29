Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF2D44A71D;
	Mon, 29 Jun 2026 16:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749506; cv=none; b=c7oS3bsCWPgCaV9nb34Lq84cLJHdI1nzjuPqr9cX1gPASAFfd1UO1lKXII2tNLRXRUsPB1ju/Dy6RoTb8iU15Npf88P3qnmmIvAKZLfv4cWOVBhCKr57kYNY1GtUT0m9erkw49mNhVfi5nwwEy7rf8pfJ7GpmcN5CuZjBcu+0iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749506; c=relaxed/simple;
	bh=k2rBsM5SdkD0PahKlRf1zlIPWlnImleJYr/aShQoNLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVBFpl3PadQt1LpONgHc80oxx+nY9N4wy1b8zv7TEdePQFRM4HZNdBkxjjT3ivmAp7MX4aujHqsgkOjBpHLrpaRhAfqlm0bFYvmANNPuX6vxotqp+I6l2cjR0ZZz65Tiy4WSHPDtPvWy31jZhZ2MAHSJ1mU20cPGVNzs2bQTaF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kHNpBNlX; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kHNpBNlX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782749506; x=1814285506;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k2rBsM5SdkD0PahKlRf1zlIPWlnImleJYr/aShQoNLE=;
  b=kHNpBNlXhQj4/E7S7YPuj0FpErruG3cu+qzlG7gCBnifniZj8KrOx3+I
   SmcL3gqqPIfL6ITmeJs6s7wVD1z4nUSxVkVNiw4q3hwFRt9oMzv+h/FmZ
   4hX1ZWQy1xZE8VtDPK7VPHKy9BmjiinGHXx+ztEi5birAFOEvpPvdWX9c
   u66lTe2wC4CNh80A3GjXV7J6bEFVekTkoHEAJ3bvpDhBjmrksXgSBt/ol
   CgHnshbaSYrO5rgk+TSmoBDqMhb5thdLkrp24l3chdnWPYarZ98oxhYAO
   J+oWKrImVa+qikoy2dyAXZeli22u0zZSV0+nVfJWnQwXYnseDlcZMdkuh
   Q==;
X-CSE-ConnectionGUID: xjiP8tYgRBa61Ny7fz2teg==
X-CSE-MsgGUID: eSgb4OJqTa+C4tb5aybE1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94938854"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="94938854"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 09:11:45 -0700
X-CSE-ConnectionGUID: DtAxxEOlQGegv7F6X42NZw==
X-CSE-MsgGUID: UMWxxFmBQFyUk13glEiYNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="250302466"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 09:11:41 -0700
Date: Mon, 29 Jun 2026 19:11:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, julianbraha@gmail.com
Subject: Re: [PATCH v4 2/4] iio: adc: ltc2378: Add support for LTC2378-20 and
 similar ADCs
Message-ID: <akKZOq6DV5x1FvAc@ashevche-desk.local>
References: <cover.1782397418.git.marcelo.schmitt@analog.com>
 <0abf862eeb277ae82262d09b11b1446f04c47be7.1782397418.git.marcelo.schmitt@analog.com>
 <9c6e0a74-c9c5-43ee-8eca-ae1667c51c32@baylibre.com>
 <akKHv7j22P6KczXb@debian-BULLSEYE-live-builder-AMD64>
 <3a96a20c-f435-4b98-9e95-26a28bd06e7b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a96a20c-f435-4b98-9e95-26a28bd06e7b@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 29, 2026 at 10:16:16AM -0500, David Lechner wrote:
> On 6/29/26 9:57 AM, Marcelo Schmitt wrote:

...

> It could use `_offl ? ...` in the macro for that. Not a big deal to me though.

Personally I am for a full spelling here.

...

> >>> +static int ltc2378_regulator_setup(struct device *dev, struct ltc2378_state *st)
> >>> +{
> >>> +	int ret;
> >>> +
> >>> +	ret = devm_regulator_get_enable_read_voltage(dev, "refin");
> >>> +	if (ret < 0 && ret != -ENODEV) {
> >>> +		return dev_err_probe(dev, ret, "failed to read refin regulator\n");
> >>> +	} else if (ret > 0) {
> >>
> >> Else is not needed here.
> > Why not?
> 
> The if returns unconditionally, so else is not needed. This is just a general
> principal.

Unfortunately in this case ENODEV will go further, I don't see full context,
but it may lead to something unexpected.

Personally I prefer the ladder of

	if (ret == -ENODEV)
		...
	else if (ret < 0)
		...
	else
		...

-- 
With Best Regards,
Andy Shevchenko


