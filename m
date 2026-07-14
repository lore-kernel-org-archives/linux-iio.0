Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F1836AB5A;
	Tue, 14 Jul 2026 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026624; cv=none; b=eBIVpSFcWc6kZbKXMuQYTAlr0w0HwuO+MRXLoMNkcPyeGbIvQPzw5VBtRr4lTEavp3ERyz1DpFp7QmV20N1xjDf+qRwK8kSpncQTliCt/NfgQAjdGhzEf9HOozmZ6jcJztmfat53aMo7aPWIyhaQchVf1hDv0JHZTvtI9Ir7NhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026624; c=relaxed/simple;
	bh=7p88xNr3ryyi6ibpcUgmTHu4NSvfticNGxsvwZsHU88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0Mv4Ujl3OlR5zuq3ZYwKt7NZaEWOaqh5jJtOXpxYdQ8ay1gJNKVkK9LtmeYpn2ArH+/gr04z4amsbDvhB2Ta4HZUPnN/BF3voexHuAkzZVgzaxoVAvdmP1QHpXp2MrFll9CccG+pEC2LBrAjKrnShZq6f7AYcIEzQMnQHZwaho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NUD37idW; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NUD37idW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784026624; x=1815562624;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7p88xNr3ryyi6ibpcUgmTHu4NSvfticNGxsvwZsHU88=;
  b=NUD37idWn6B/7VqrzaZagY8udojXPz879B8tP/vWkueEgQ5uthxcOrqp
   bxD5cWiOjSB/cAN6ltB7INs39n/WAVnh73TaO+xTQF1fuGAGpxqVB+QBn
   KgQBPgkjBzCR5FzfK/Tt/9GKPcxgFusAMUrAgfFSbBnlbpAsNM/PEqhrX
   kz2lgrdkS+UDVgAqJDzDe2+pOGhL/MHzd1CRYUeRfVNdDwxXoAkczIhde
   AeBBgXTsA3vcoe2pc+dclk8OgGao61QvKRo2yihAr/TNLwP9xADykgS1E
   gvRR4ilTp1vkN3D+rWiqDS5+s86ZJ1fL0cW3RrCYExYBYPo9FnqWtA3TP
   g==;
X-CSE-ConnectionGUID: /O3S1yvqQBa5EAXXcMNO+A==
X-CSE-MsgGUID: v/lqaTljRIyNuNtttf7MGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84425303"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="84425303"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 03:57:03 -0700
X-CSE-ConnectionGUID: tAp4suAZQ7W8vqWtI5sRQg==
X-CSE-MsgGUID: fOFImHORQemPAJIS0pzizw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="253202539"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 03:56:59 -0700
Date: Tue, 14 Jul 2026 13:56:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH v16 04/10] iio: imu: inv_icm42607: Add inv_icm42607 Core
 Driver
Message-ID: <alYV-QAmGViGSOSv@ashevche-desk.local>
References: <20260713215842.69097-1-macroalpha82@gmail.com>
 <20260713215842.69097-5-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713215842.69097-5-macroalpha82@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 13, 2026 at 04:58:34PM -0500, Chris Morgan wrote:

> Add the core component of a new inv_icm42607 driver. This includes
> a few setup functions and the full register definition in the
> header file, as well as the bits necessary to compile and probe the
> device when used on an i2c bus.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c

> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>

> +#include <linux/device/devres.h>

When device.h is included, this one is not needed. Yeah, device.h is a mess,
but here we are now.

> +#include <linux/err.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/time.h>
> +#include <linux/types.h>

-- 
With Best Regards,
Andy Shevchenko


