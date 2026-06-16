Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7B6317170;
	Tue, 16 Jun 2026 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781593682; cv=none; b=Atrqh3+dVRyGy+LgwOCJkUvByVTXm58IId1q0Y5btBBJgGJCK//BytATwnnwFjIEjo23Ith0KXKxwB7IZKT8gOE27im6Zf3qSmO1mmNVZ+0/HiXL/7bWhqEwdVX/SL5LztB4FyHCMfOsKIdNKMenPogj181B8KFy7fs0Kkb2tEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781593682; c=relaxed/simple;
	bh=6VM7jc9R1gEM32HSIpFUN3c90rfM663B27FZqdR+IAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoruMSPx5WKIvSOooi0RQMtrZN6uDLk6/sqNxa3nKilStrVzTtU9M3wJ+qay9eriKFjyUaZAobVEUcFqRQY59N2v79wmlK63EsZuSkAVyXs8TRaDRHc1FFtXjJ71kfQNHNib5Eurcpiv+95k99dbUTyKOl97zrSwc4cRu7jTACo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZV8+knmd; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZV8+knmd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781593681; x=1813129681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6VM7jc9R1gEM32HSIpFUN3c90rfM663B27FZqdR+IAU=;
  b=ZV8+knmd28i10KKqyf2viJJoOV1KoGo8QEjko2H7Bq8hQS1njsn/nonw
   MCQxCy/y9U3gZG9u33/HkzcB4Gx/GR9ym0UHTINkb/V4c8pgIhkCX3Q/3
   FgEGh19JReRIc/kEvkKpHSRGGQkyL+NRQaAX358i/lTOdFQFcAb/Cs1W5
   ToGJyTTZTTbt4MghDngpqyv/QmGLIFrK0iu0xyOoOUokb/xFEEN07TH+b
   3y/WKS8s0O1IiP/u1c3oOae2SGX5jeVZeM4XMej63IGYD4/7WTPuVl8xZ
   YolRoHnhM3ZtVYSysCno92AZg/xkvT2RTrTBkMYYUpylj9qZiOL1rX6iC
   w==;
X-CSE-ConnectionGUID: IH/CSvIwSi+erZ9yB19MOg==
X-CSE-MsgGUID: 02EIp/puQwOuj9dOKPbimw==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="93022154"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="93022154"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 00:08:01 -0700
X-CSE-ConnectionGUID: g2utfKS+TjO2va+u+sy5tw==
X-CSE-MsgGUID: bfYpWz+wRsS2RhiGl5SDuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="285803987"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 00:07:57 -0700
Date: Tue, 16 Jun 2026 10:07:55 +0300
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
Message-ID: <ajD2S8nBhRn1-C_G@ashevche-desk.local>
References: <20260611202607.85376-1-macroalpha82@gmail.com>
 <20260611202607.85376-8-macroalpha82@gmail.com>
 <ai_gIR2d9fzHLZ-G@ashevche-desk.local>
 <PH0PR19MB997338010EC6FA92E0AA63875FA5E62@PH0PR19MB997338.namprd19.prod.outlook.com>
 <ajAVI0KXkx3FM1ZX@ashevche-desk.local>
 <PH0PR19MB9973380BF26E3EF16BD2D35ED0A5E62@PH0PR19MB997338.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR19MB9973380BF26E3EF16BD2D35ED0A5E62@PH0PR19MB997338.namprd19.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 15, 2026 at 11:40:31AM -0500, Chris Morgan wrote:
> On Mon, Jun 15, 2026 at 06:07:15PM +0300, Andy Shevchenko wrote:
> > On Mon, Jun 15, 2026 at 09:51:40AM -0500, Chris Morgan wrote:
> > > On Mon, Jun 15, 2026 at 02:21:05PM +0300, Andy Shevchenko wrote:
> > > > On Thu, Jun 11, 2026 at 03:26:04PM -0500, Chris Morgan wrote:

...

> > > > > +	for (i = 5; i < ARRAY_SIZE(inv_icm42607_accel_odr); ++i) {
> > > > 
> > > > Why pre-increment? Same for all other cases.
> > > 
> > > The register starts at 5 and all values below 5 are invalid. Starting
> > > this increment at 5 ensures we don't expose invalid values to
> > > userspace.
> > 
> > It doesn't explain pre-increment. Post-increment should work as is.
> 
> The array this references starts at 5, because those correspond to the
> values written to the odr register. That said, I do see a bug because
> the odr register is from highest to smallest and this array is
> backwards in the accel and gyro code. I'll fix that.

Good we even managed to find a bug, but what I initially pointed out is simply
as ++i versus i++. When I see ++i, it rises a flag: "this code is special", but
looking closer, I see nothing special about it.

> > > > > +		if (i == odr)
> > > > > +			break;
> > > > > +	}

-- 
With Best Regards,
Andy Shevchenko


