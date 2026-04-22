Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131A43C3457;
	Wed, 22 Apr 2026 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850539; cv=none; b=l8QkZmUnE9NN6fSvqiD/Uj+koMhMGcVsUXzVdCCrGGKh4Ck05Szq8XcHXEsP+hFGKOVLeA6Zsl5Nb6cR0d+Ax1Lqiixww8aXpgR9g7xRkqi42rMpq+bQGzsdmMhy/PAXHsbAfqHrDJZskKFKmLG2fvwlzj+X0pg7+8CENTye5rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850539; c=relaxed/simple;
	bh=n07PEKD3PScgeIbzLt/7E4fo6qLDgqbeCd12s14ztA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AL3U7GR63J0gjjMMq1m8umbB3ZUcSSzqVNPdqYuOZV//QoJQNjCKbb6J1vUWuCuxmPlu2lMgVSVLBOCS9QdiZWRK7RorvVOZ1pxfuzHKrtu5VoOv6NhROz4zbXSXz2q9nPMcgMDm2VqPwtcq3EdmfXZ8SPG8OUGKngEMy/mxbLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y0JsDNvM; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y0JsDNvM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776850538; x=1808386538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n07PEKD3PScgeIbzLt/7E4fo6qLDgqbeCd12s14ztA4=;
  b=Y0JsDNvMNRVZ4RPTN3VJ/C3Sk6lGfNya4yRwW23Hyl4nvBkXmjIWXTvQ
   n+Y5f5L22nAmTB4owRhJEtiI5N+PuYGsZxntHEyF3WJB5kURuyX6AzQeu
   zH3WxR9wr6zZ49kyZdxGXZr6068YzJVEB2v4NdYED3HE2t3efhPETTR7F
   IhXRgIYoM1tgARxv8Qfv6xjurmGItC351TwGC1Cr12zsPTd3oy1v/Ae3q
   hcFzDMa15kQRtrNVeT57Bx+1fLlfZBF4f6ZE4wUM+2By0MTobCesGTqo6
   7KolzYjfHPQJ++ylfqjX5x4s8QlYqfbMThqig2v8prRzRPUR4mMvEFbm/
   w==;
X-CSE-ConnectionGUID: svZNIS/VSDa07sn8yqIt4w==
X-CSE-MsgGUID: sQzNUzl/TGa8d5qSy3l2cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="65335316"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="65335316"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:35:37 -0700
X-CSE-ConnectionGUID: 0tJweWKeSS2u/zegGtoQLA==
X-CSE-MsgGUID: QJaKhzwtRYarmWihei0YCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="231417101"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:35:35 -0700
Date: Wed, 22 Apr 2026 12:35:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: magnetometer: ak8975: change 'u8*' to 'u8 *'
 in cast
Message-ID: <aeiWZUf4MuccE0XC@ashevche-desk.local>
References: <20260421100722.1296-1-joshua.crofts1@gmail.com>
 <20260421100722.1296-4-joshua.crofts1@gmail.com>
 <aeiMPrBs4BJE0H_k@ashevche-desk.local>
 <CALoEA-w7T-15paJ2j2kGyaWjeK9FpHynS+vD0rpv1dBKEo3gcg@mail.gmail.com>
 <aeiTh6uw6yLW-D43@ashevche-desk.local>
 <aeiTzA73ePa_cNVh@ashevche-desk.local>
 <CALoEA-zyWpNMLXJ9FGgYNCyFiDcO+F9VWMSDToGeV+fkDOUAWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-zyWpNMLXJ9FGgYNCyFiDcO+F9VWMSDToGeV+fkDOUAWA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 11:27:54AM +0200, Joshua Crofts wrote:
> On Wed, 22 Apr 2026 at 11:24, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:

...

> > And to make it crystal clear, the double quotes should *not* appear
> > in the commit message from this example :-)
> 
> This was unnecessary, lol.

I know, that's why smiley at the end.

-- 
With Best Regards,
Andy Shevchenko


