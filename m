Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1212051CF72;
	Tue, 13 Oct 2026 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908916; cv=none; b=gGk9evYNDbcd887JHtryou3pCAM928xS+qgyt8MWIfezVS1BSoZBerG87cpk/g1U+V4lYXzfOJl+AAoSkwA1Cypks7fLlV8reisqO+6q+jpK+IJCUqrrwbgaefnVrIJYXUWiRS4HY0WgFKyK3tPwFTvg2HBQ8AmueO0+Tiuglm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908916; c=relaxed/simple;
	bh=KZ788E6IYYsK1x6zth5J68q+BTkzuIy7rFPYPq3g9h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4x2MThnYUkZSIJoSIKusVHLt5i0pRjuoSUdKSCIUmKpbpghVXfN1+eXEGAoSYRVGxPDtTSe4TFmDU3y2BEs001L6lcClndHoFTi4qVyLULjZqYRdmBoWhSbE8OVpOO9HtpcpSAXTwZKKAVYTCjJzQJs798btFN9AryTvkmpYNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BAKe8pej; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BAKe8pej"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791908915; x=1823444915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KZ788E6IYYsK1x6zth5J68q+BTkzuIy7rFPYPq3g9h8=;
  b=BAKe8pejM0hWkjx54TJoAWK79Vf1/KMJpwyV61/XI7baExxi120FyUe1
   Kckp/zaFHFG7TEO1KYncweVMdrOuPJbAqzxymzzyYEHB2m2DQKI+yILnF
   3yftwmuLNPAqMvKn+kP8SD2jQkRfSw0fb5llJGrrrBt7caOQkV5xkhsVL
   D6mjeXCgCCapNAb3NSi+47wgUOV95pspsZm3AjunfmaC3yVSymYp8MMoU
   3uHl3C+IDLaUhtMoemm03m74W+FlEkk3oWAD8xBAKo3FvyL3KMiu6RT5r
   jkBBha5kk0y7SYIE3sZtyjTmLoyTcbyqQL39o7BLH+PCymiiT4Umwxhaa
   w==;
X-CSE-ConnectionGUID: 1b7D4w21TR6pcPL2k2AEjA==
X-CSE-MsgGUID: mLTD8pXkRjifykwMo7ffpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="542033"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="542033"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 09:28:34 -0700
X-CSE-ConnectionGUID: huD3lZ1gQyan8JAdKfcD9Q==
X-CSE-MsgGUID: xhoJZanWSFWqCaUoP0kOiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1273106"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 09:28:31 -0700
Date: Tue, 13 Oct 2026 19:28:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Chang Yu <marcus.yu.56@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Hao <i.shihao.999@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: light: add AS7343 multi-spectral sensor
 driver
Message-ID: <as5cLfhdv3rA69v1@ashevche-desk.local>
References: <20261013115639.167433-1-marcus.yu.56@gmail.com>
 <20261013115639.167433-3-marcus.yu.56@gmail.com>
 <20261013143521.00006de9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013143521.00006de9@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 02:35:21PM +0200, Joshua Crofts wrote:
> On Tue, 13 Oct 2026 19:56:39 +0800
> Chang Yu <marcus.yu.56@gmail.com> wrote:
> 
> > Add a driver for the AMS AS7343 14-channel multi-spectral sensor.
> > 
> > The AS7343 is a 14-channel spectral sensor featuring 11 visible
> > channels, 1 near-infrared channel, 1 clear channel (VIS), and 1
> > flicker detection channel.
> > 
> > The driver exposes 12 spectral channels (11 visible light and 1
> > near-infrared) via sysfs. Runtime PM is implemented to stop
> > measurements when the device is suspended or torn down. Power is
> > never cut (PON=1 always) to preserve register values.
> > 
> > Future patches will add configurable gain and integration time,
> > interrupt support, buffered reads, VIS channel, and flicker
> > detection.
> > 
> > Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
> > Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> > ---
> 
> I think this is ready to be applied.

I agree. I have a few nit-picks (easy to address), after that feel also free to
add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
With Best Regards,
Andy Shevchenko


