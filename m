Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEED3BE646;
	Fri, 17 Jul 2026 08:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275867; cv=none; b=SbCjyFL8Cg6Suy7RgJuKKmLe8ERkskPQlBI/aeeUCBfbHA6Xzk+Efx1yhrKWPwMoLACnap+IrYMw+gfiEHm55i0Y5tU/sHS3jooTuE9Ws4V2fCc0fR7I75eCE8hCRT7diH9QyZ19T1+AuAICihNZ4CKph0A6vQWpB8WNx35jmHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275867; c=relaxed/simple;
	bh=qUehnQl2XZn5FAct0Ga/H/Nt9FjYkTUtLcIRO8YoX6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UT1fVocSnm0CWxoHJAqev35e7W3mXGm2U8ubfp+vLG8pQkbR59QqhpFq1noDXyDbZgPg9Na9uWN8zjG1bZk/s5ZZFLh8paAFWr9x8LeskAmAn0pTydZAsRgtZhc0tiuOi2kLqYyzDe2KaNLzQ0x4wc1ipr9cZ1X5q7fLGbUmoao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BIyrfM/G; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BIyrfM/G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784275865; x=1815811865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qUehnQl2XZn5FAct0Ga/H/Nt9FjYkTUtLcIRO8YoX6o=;
  b=BIyrfM/Gtcz5/qzOb44JlpAqDeJaYz4c1UoF58Q/z77P13n6V44i7Jgu
   eel5lqkq32EBgf4HLUzpqXrh75F5709BRRIK3ch//rCxZCAgE/CQV2ULq
   UEQG6RLfyle2B4YDSyd2sZfw+otVkj898LM9FtLDht69BplyzFwkpzcJz
   MzvqcLTvb4IcAQlxLwk4/w/YHd02rlUwCDTlohwh0302h1GS6zEio5kkA
   AQI+xvcIG9E1BG0QlTagyZ+NCMndmu0BJxJsvJQdNK/D0hKwSXTvC6TDL
   I9gxBAqbu5HcNvnzBX7Aa/YR6YBXnB8UlUd+LIgRQIxl+G46v/JC3cAaK
   w==;
X-CSE-ConnectionGUID: fm8UVsHvQ8aAr8dLjHsqdg==
X-CSE-MsgGUID: ptDlWrQeT/SerF4MF+vyxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="95300484"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="95300484"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:11:04 -0700
X-CSE-ConnectionGUID: wKDCDXWdTuivXPUEv93h5w==
X-CSE-MsgGUID: +7AE6BiuQkGZIcIucC83ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="250377080"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.143])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:11:01 -0700
Date: Fri, 17 Jul 2026 11:10:59 +0300
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
Subject: Re: [PATCH 0/3] Add AD5710R/AD5711R DAC
Message-ID: <alnjk8WkaWqXlEXf@ashevche-desk.local>
References: <20260716-iio-ad5710r-upstream-v1-0-e848a4bb701f@analog.com>
 <alkbtNdOe__XP7ud@ashevche-desk.local>
 <DK0OK76VQ1QV.3U5B7UFI0UB9F@analog>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DK0OK76VQ1QV.3U5B7UFI0UB9F@analog>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 17, 2026 at 03:50:08PM +0800, Kim Seer Paller wrote:
> On Fri Jul 17, 2026 at 1:58 AM PST, Andy Shevchenko wrote:
> > On Thu, Jul 16, 2026 at 03:59:24PM +0800, Kim Seer Paller wrote:
> > > The AD5710R (16-bit) and AD5711R (12-bit) are 8-channel, low-power,
> > > configurable current/voltage output DACs with an on-chip 2.5V reference.
> > > Each channel can be independently configured as a voltage output
> > > (0V to VREF or 0V to 2xVREF) or a current output (0mA to 50mA).
> > > 
> > > This series adds support for these parts:
> > >  - ABI documentation for the high_z powerdown mode and the current-output
> > >    powerdown attributes
> > >  - device tree bindings for the AD5710R/AD5711R
> > >  - basic IIO DAC driver, supporting per-channel voltage/current output
> > >    selection, per-channel powerdown, software or hardware (LDAC) DAC
> > >    updates, optional output range doubling, internal or external
> > >    reference, and hardware reset (with a software-reset fallback).
> >
> > Why a brand new driver?
> 
> After looking more closely, the register map is the same as the AD3530R family.
> I originally kept it separate because of the functional differences: per channel
> VDAC/IDAC selection described in device tree via adi,ch-func, selectable 12/16 bit
> resolution, and current output path. But those can be fit the existing chip_info
> abstraction. Given that, I'm leaning toward extending ad3530r to support the
> ad5710r/ad5711r and dropping the standalone driver. Does that direction work for
> you? If so, I will do it in v2.

Yes, pretty much!

> > > Datasheet:
> > > https://www.analog.com/media/en/technical-documentation/data-sheets/ad5711r-ad5710r.pdf

-- 
With Best Regards,
Andy Shevchenko


