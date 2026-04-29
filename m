Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C136B421892;
	Wed, 29 Apr 2026 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777489726; cv=none; b=VT0POHbvnVaRIPKLqRbIdJRGJWrmsk8Y6+gat7ExEiKeStHQW1IsgkaFHpHu5DItLYOFnoeK7vaqiZZlDNtc77laUyxbL+w21d/5+KHYkD7a1XR3iHWnunGfN0POEWKc12pUMhhMhZh+7jeDMXI9F8qPqeYAl9mDXufOQ3v+hqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777489726; c=relaxed/simple;
	bh=ghmSFJJhXGI7/Bt8mt2oyKWweT7UHPInTehQ49jj5+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrjQqF+ZDqsExkMEy5RB+1iEXyFx8HtSfSpAGmS1yXb/oTIPOxbSA/tO4E25CLMCdMlJzyYHij3Y9xZLGXRejoNxZUbgOjqjD9lq1zb1piB2HzGnbbVd/wGs5yUVWNnJ90CUde/CVPXixrxeLCMdABZ9b3TiypMKB43gKxiQ+h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SRrSv50x; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SRrSv50x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777489723; x=1809025723;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ghmSFJJhXGI7/Bt8mt2oyKWweT7UHPInTehQ49jj5+c=;
  b=SRrSv50xs3teiUMLsqUJdHn/JIoczHjA9MKReOrgBxpK/kbovrOzoqIk
   WpN6xPblY+p8I3IuLOgBBwitZGmkUGxTiZzKmN5IpvT3MB6AVG/zwq0TH
   uIzMPG5E6VUiC9ulkmLx0WJTbxVhpQi1yoa2SaUh+5MNQicVt2B0p7oN4
   +vm6Us7WU9xTvErWL2nVP9VofAp8jIyO+T/dGx/RAjoToIPUcaUVtpZjk
   j7PgZtfu6FgrN2lmQ7VBWboWCvwFdmVr07vhP5FtuAnxvF0o0AG0lE4x/
   iF/kI8rLw4EITdEdqbgytg+WUPliFyBcg9EkZDMq3VGxyoxZZz5ud6gej
   A==;
X-CSE-ConnectionGUID: +U8yCd6GR+S2hFPRAOGPnQ==
X-CSE-MsgGUID: bFJegFUpRjCWuV6nagvcyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="65959744"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="65959744"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:08:35 -0700
X-CSE-ConnectionGUID: VXeOS2YLSeOXqIwwg89x4w==
X-CSE-MsgGUID: 1rTivNzLS7+pE3C+Pn0V4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="234380727"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:08:32 -0700
Date: Wed, 29 Apr 2026 22:08:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/11] iio: adc: hx711: add HX710B support
Message-ID: <afJXLrw0XyFBdt0Y@ashevche-desk.local>
References: <20260429054544.123862-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429054544.123862-1-piyushpatle228@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 11:15:33AM +0530, Piyush Patle wrote:
> Add support for the AVIA HX710B ADC, a HX711-compatible converter with
> the same GPIO interface but a different channel-selection model and a
> fixed gain of 128.
> 
> Compared to v4, this series is split more finely to match the review
> boundaries requested during review rather than because the feature
> itself grew materially:
> 
> - the DT binding work is now split into cleanup of the existing HX711
>   binding, HX711-only VSUP documentation, HX711-only RATE GPIO
>   documentation, and the HX710B binding addition
> - the driver refactoring is now split further so the trailing-pulse
>   parameterization, loop-iterator cleanup, and hx711_reset() declaration
>   cleanup all stand alone
> - the Kconfig help text, file header, and MODULE_DESCRIPTION updates now
>   sit adjacent to the final HX710B support patch instead of appearing in
>   the middle of the refactor sequence
> 
> The resulting series is longer than v4, but each patch is narrower and
> maps more directly to the requested review boundaries.
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

This is almost ready-to-push series. I have a few nit-picks here and there,
most important ones are the patch organisation (splitting) and the question
about new entries in the buffer structure.

I believe next version will be final (but wait until we settle down on the
opens).

-- 
With Best Regards,
Andy Shevchenko


