Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400253FFFAE;
	Mon, 15 Jun 2026 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536042; cv=none; b=aIWYwjGar8Rv91I5pSJwUDKDJrybZCd2stm0rmPE1W32j8aGQn9qs7S2q96diZY1n2DHvJu2WLUTYpDMaYyJlDAEqN4pMMUSBOIONkPynbwNmHC9VhtHSzTvg4Xx4mPrfVq1sksssu1yfj6f7PhE8OIcjDvVKTFSmu0aYX0TOLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536042; c=relaxed/simple;
	bh=uiAE3DrABHH7e71lglagUwCkfeV2Wyg2fOEmzICA5SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=firww214Y/rGxTaCVO91kh3mWtSCdqo7eVoVHQV+EkEUKxexSdx1C6i5TqFfLO+MXI0FJ5MkbScf/+DC7T/aIuxs4JZa0S1ft+ZeQOUq0o3i9V2DdwCSC+FXdeBkC+J0fvWd47wBOk2tLNFq/mK/n2dFZfmNVIX62r8Or0RGREs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T06QmcMW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T06QmcMW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781536042; x=1813072042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uiAE3DrABHH7e71lglagUwCkfeV2Wyg2fOEmzICA5SE=;
  b=T06QmcMWcJZL0aZjyj9VpY+Ji4qyln77U+hSmm29oWdtVZA36KYmx/IB
   4HdTRc3DAVwsKUvuWk6Z0BMTtMgEr9mepJ6XRDQDqDZKKQ4J/g3IBDaJD
   MWWv5xz13xjErLVj2kSjlInnWgyqF/VcgV9CNh9kCjVR7BPUpRuSq/9ty
   1kV4nKtnG47mC6MqwLlOD5B8vg2ZViHYGhcs1bDnX+jFgEg4ixrx7YzMn
   lGMqo6MoqcLHegp5S2FU2LDOB1G/ouetdxvn2J49bga865lU8GJYMDCKa
   gydtBX3fdErtNn8a0tva/oK/i55OEX1AhPM0410IQoLI6gjPX7y+W4sPr
   w==;
X-CSE-ConnectionGUID: TjRAbWlbR8O7Ff9KqqhmUQ==
X-CSE-MsgGUID: 8M6Y4zZcQA+1oIKL6/6i2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="92597632"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="92597632"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 08:07:21 -0700
X-CSE-ConnectionGUID: N+PeBC7IS4OdlpDxJ9qoew==
X-CSE-MsgGUID: 0GUukcqfSAm6WeP+JN9jUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="285607289"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 08:07:17 -0700
Date: Mon, 15 Jun 2026 18:07:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jic23@kernel.org, jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org
Subject: Re: [PATCH V12 7/9] iio: imu: inv_icm42607: Add Accelerometer for
 icm42607
Message-ID: <ajAVI0KXkx3FM1ZX@ashevche-desk.local>
References: <20260611202607.85376-1-macroalpha82@gmail.com>
 <20260611202607.85376-8-macroalpha82@gmail.com>
 <ai_gIR2d9fzHLZ-G@ashevche-desk.local>
 <PH0PR19MB997338010EC6FA92E0AA63875FA5E62@PH0PR19MB997338.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR19MB997338010EC6FA92E0AA63875FA5E62@PH0PR19MB997338.namprd19.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 15, 2026 at 09:51:40AM -0500, Chris Morgan wrote:
> On Mon, Jun 15, 2026 at 02:21:05PM +0300, Andy Shevchenko wrote:
> > On Thu, Jun 11, 2026 at 03:26:04PM -0500, Chris Morgan wrote:

...

> > Please, please, use IWYU! So many headers are missing...
> > (Same comment to all files in this series.)
> > 
> > + array_size.h
> > + bits.h // BIT()
> > + cleanup.h // guard()()
> > + device/devres.h // devm_kasprintf()
> > + err.h // -EINVAL, IS_ERR()
> > 
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <linux/regmap.h>
> > 
> > + types.h // s16, __be16
> > 
> > Also you need to have
> > 
> > asm/byteorder.h // be16_to_cpup()
> 
> How are you running IWYU against the builds? So far I've tried but I
> can't seem to get it to run properly. 

Sorry, I meant "use IWYU principle". I don't run the tool, I just looked into
the code.

...

> > > +	for (i = 5; i < ARRAY_SIZE(inv_icm42607_accel_odr); ++i) {
> > 
> > Why pre-increment? Same for all other cases.
> 
> The register starts at 5 and all values below 5 are invalid. Starting
> this increment at 5 ensures we don't expose invalid values to
> userspace.

It doesn't explain pre-increment. Post-increment should work as is.

> > > +		if (i == odr)
> > > +			break;
> > > +	}

-- 
With Best Regards,
Andy Shevchenko


