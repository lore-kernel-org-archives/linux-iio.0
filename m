Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFA5312825;
	Tue, 11 Aug 2026 05:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786426852; cv=none; b=bI7+ZTcZ4CVrAHqHpbuaBMxtrv0XfboPm6AKEqGrP777F2rFYhMAzdg41cCYnPP0VtF4D+qQfwEPBti9pjD12fsqofRrF+j4tdwLUeJIIPvDg78Dv1TQK5PG8w4pQvDQZ14MQsreCrxwjN95dk7WGN9HhnDOhJxmmW9/9ftRX9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786426852; c=relaxed/simple;
	bh=tHsoL52w1GHQ9mRSzluEJw0tU8h8Rh+KBSfo1zMYViU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzVkrxXIokHzQ9JdYHZ/AX1Kod+m24EC92qPLnarxj8X7SXmk1SilWWhF7LOccW3kDuHEa/VgZqwBR3piNU3fgo9vURCTCvwFimT+9ZZRYNqCZiH2Dz+rnfkcEjGkHEtTU7a4NjW/l2WtiwSkNyWDsSI15k181v5aoKGll3hxyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HWcUgHj8; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HWcUgHj8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786426851; x=1817962851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tHsoL52w1GHQ9mRSzluEJw0tU8h8Rh+KBSfo1zMYViU=;
  b=HWcUgHj8Y/FrqiIZaV224PJBJgEDqbiqJ/gXfmXAUhKvVgHmAQ6n7G33
   Z9wbesSooem85u5+0UF6vrbM+dWLJaS8kQyclS9mZh5Zq0d9MweBvSgDt
   0Yq9gkcxQPJLNSGSdLKEdeGFalD8LPnk1mp0vY0b5h5WwriBc581HI6rW
   M0X9g47HBlYZkf7CvVURkdoXEWwajCbKy477f7ZoUQ3FWRN4bsdGZZIYq
   g1QkSBeCFKv4KOY63GOibNmvDrznkkgJnShIF2DRCMQPfTCHspAuuQimx
   Sr/daO1YI/5Qo+j07XUsIeu/AMxkO0nlHGnhfxpgSl0A+3kAzEBFFNOtK
   w==;
X-CSE-ConnectionGUID: WNFFBkhnRnacqJewNCmJjg==
X-CSE-MsgGUID: RWWHlJJhQqGANxGnPvygWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86071614"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="86071614"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 22:40:50 -0700
X-CSE-ConnectionGUID: ESKiThMSRSmAznu4+Keepg==
X-CSE-MsgGUID: AbjZtyeTRLiJ3yCf+blZyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="257016188"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 22:40:46 -0700
Date: Tue, 11 Aug 2026 08:40:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] iio: light: add support for veml6031x00 ALS series
Message-ID: <anq13MUjEkayDnQn@ashevche-desk.local>
References: <20260807-veml6031x00-v5-0-e60876fb3640@gmail.com>
 <20260807-veml6031x00-v5-2-e60876fb3640@gmail.com>
 <annUbQQn2TzzuFNC@ashevche-desk.local>
 <DKLN31OCJZ98.3JFEAVU1AM0F9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKLN31OCJZ98.3JFEAVU1AM0F9@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 11, 2026 at 01:06:42AM +0200, Javier Carrasco wrote:
> On Mon Aug 10, 2026 at 3:38 PM CEST, Andy Shevchenko wrote:
> > On Fri, Aug 07, 2026 at 03:51:53PM +0200, Javier Carrasco wrote:

...

> > + array_size.h // ARRAY_SIZE()
> >
> >> +#include <linux/bitfield.h>
> >
> > Is this in use?
> 
> This one is in use for FIELD_PREP()

Ah, I missed that.

> > + bits.h // BIT()
> >
> >> +#include <linux/cleanup.h>
> >> +#include <linux/delay.h>
> >
> >> +#include <linux/device.h>
> >
> > Oh, the whole headers hell is loaded just due to dev_get_drvdata() it seems...
> 
> I will rely on <linux/i2c.h> instead, which is also what I am going to do
> to get rid of <linux/mod_devicetable.h> as Uwe suggested.

Sure, but device.h is still required as you use it.

> >> +#include <linux/err.h>
> >> +#include <linux/i2c.h>
> >> +#include <linux/limits.h>
> >
> > I missed probably it, but is it used?
> 
> This one is used for U16_MAX.

Good!

> >> +#include <linux/module.h>
> >> +#include <linux/mod_devicetable.h>
> >> +#include <linux/mutex.h>
> >
> >> +#include <linux/pm.h>
> 
> The rest of your comments need no reply from my side.

-- 
With Best Regards,
Andy Shevchenko


