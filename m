Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB28D30EF83;
	Tue,  3 Feb 2026 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770119836; cv=none; b=ga2P+AHtos2GUceXlfTDp92Zo39ioI6E/6Jhy+GwDl8YOpZKaGhWlJztGSbN34PV4AFm2W2hp1iRiWhJIhTBYxU/Ws056frR4SDUkiuPEc2YQw1U+tNan7+CjjpL0axNQsFUwb6Ss6Fk6G3vv5TnX56EVbkR4zei3fYFjvxKJxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770119836; c=relaxed/simple;
	bh=RUnOUTk2GWsWt+UZmmAHOCxB8S5qdwIVX1ssHbFQ9Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vE8rfSzzhf9t+It+jGGb36KVdGZRFxrtnGWZuk6hEQKk2LL+qI90YlPoPnzcf58z7LHXevJtzgSeANPKWxz81WtqiCMgFo9DDZmvQGmldd7pYrD/zuKwHqEKgDKoXtbZ/EdiCo+9tT+CfurGs45gBgLdZ4TAWtC6qPs72INawf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QyM1pRdR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QyM1pRdR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770119835; x=1801655835;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RUnOUTk2GWsWt+UZmmAHOCxB8S5qdwIVX1ssHbFQ9Os=;
  b=QyM1pRdRgDPMvQ66+2wHQAMZApN3wuzaP1SuQjibQOG4govue4b1s6hv
   0tCrf6KFHcvPffqfAVqAeR32jUHeEwKB+iJhqg8KDuUkUMdoGQt4SWfj4
   6RAIMeLEv6rY153qBd+nMkfn+68jiw6HC/OdZDtZj9pGkbT2NIEAULCb8
   DyQwCC7ooyw0VkZApaZlLalFcUYikgak1LoJdo2iI7c3yuexKDCOf15Lm
   B1SmMDZPFxjERLOcrWgp4ejlNyCWjr/PenjN3ZbbpbGiqz+bdKKy7IhN0
   4P81vyGopqHRENMz5LgwgOBTJqfSHmsL4RoxHInwHWcBycXdQ88L11SUz
   g==;
X-CSE-ConnectionGUID: OxO1k1xyTym1VAWKOntluA==
X-CSE-MsgGUID: gr6T1gKQRP6oAM+tme1StA==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71187818"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="71187818"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:57:14 -0800
X-CSE-ConnectionGUID: hTyHqRm4QNaxFbABRAh58A==
X-CSE-MsgGUID: T9QWwV2NQ2Kr2Ul3s4LK6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="209970009"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:57:10 -0800
Date: Tue, 3 Feb 2026 13:57:08 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sander Vanheule <sander@svanheule.net>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 11/13] iio: dac: ds4424: convert to regmap
Message-ID: <aYHilKjWHmNTH3jg@smile.fi.intel.com>
References: <20260203093434.2548978-1-o.rempel@pengutronix.de>
 <20260203093434.2548978-12-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203093434.2548978-12-o.rempel@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 10:34:31AM +0100, Oleksij Rempel wrote:
> Refactor the driver to use the regmap API.
> 
> Replace the driver-specific mutex and manual shadow buffers with the
> standard regmap infrastructure for locking and caching.
> 
> This ensures the cache is populated from hardware at probe, preventing
> state desynchronization (e.g. across suspend/resume).
> 
> Define access tables to validate the different register maps of DS44x2
> and DS44x4.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +#include <linux/array_size.h>
>  #include <linux/bits.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>

>  #include <linux/kernel.h>

Side note: I expect at some point see this inclusion to be gone.

>  #include <linux/module.h>
> +#include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>

+ types.h // exempli gratia, u8 vals[] in the code

...

> +	u8 zero_buf[DS4424_MAX_DAC_CHANNELS] = { 0 };

'0' is not needed.

-- 
With Best Regards,
Andy Shevchenko


