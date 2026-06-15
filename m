Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143991C695;
	Mon, 15 Jun 2026 11:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781522473; cv=none; b=QQ8WOS6LXqtozVEytxEu08BH79WUZIIyALVg16ImHO7nCKZC9LIvY6MzRS7c8YS4/5GO6sr0YLTgGJ6QEQWeh4LTe6ypz7q+zmlRVYwt6DhYaZyqC2RoqUG5xnaiwMTofo2erM17hcQMMyZq+mYBqBxooAbzB3kwySj2E3QaEg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781522473; c=relaxed/simple;
	bh=oUuco3i0K38eSMot402UJs61QnUbT2+JIaR5boNplsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qv89WCL44PhDOKcAReugLtLEAouIUGDOKJmMAh563KF6sQqFzHMNPCKXttxTfgt+qKcIBcFp2BmLvZSsTmZ3z7G8L4uz4cUWxvFQcS+88ag9Ur3vT/6z526xA4RDhiLKd3cdYNpZutX+y5moLrhMAxZHp1Kq4YoWZvwHmVonuTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1UNVB2R; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1UNVB2R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781522472; x=1813058472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oUuco3i0K38eSMot402UJs61QnUbT2+JIaR5boNplsQ=;
  b=J1UNVB2RZApvvu3Gtts/5scUuGcyPJ3NoBpze8TTqZKjLyKrLHV1Yr0p
   1oqyH92PxkAh8Xb7fPK0ZNhjXN+Iolqo7/BqqbsgPDq/6Ju8Z+44qmgEs
   bPP6T25gCjnMDGrhTCXy/5Zebg2xkTUrryjopLFRpVrOmepetYSj28uMg
   60k2I7MkO/MGP7RE5QzKXRsHXAY6s0gzykk2reUzNONQxMCADPw4IngDz
   Zwl7W1SwXC8+7zpSkTcxgzQieC5QFN8ircLjVm2qWE+/X4NAEUFyloRgT
   +HgpaPs5km13nUAbhX8sZfGeXG5mpGVi+FO56kNb7yo6ieOArLJxRUzUx
   w==;
X-CSE-ConnectionGUID: 4s3oRf5QRq+UdssV1YsWaw==
X-CSE-MsgGUID: pynKRtC8QqOvjRhYZeSfeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="93750794"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="93750794"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 04:21:11 -0700
X-CSE-ConnectionGUID: +VUN7yuxSNuQPnk+/FSvKg==
X-CSE-MsgGUID: KzZJslhUQuu3pFRYoagyyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="241090446"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 04:21:08 -0700
Date: Mon, 15 Jun 2026 14:21:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V12 7/9] iio: imu: inv_icm42607: Add Accelerometer for
 icm42607
Message-ID: <ai_gIR2d9fzHLZ-G@ashevche-desk.local>
References: <20260611202607.85376-1-macroalpha82@gmail.com>
 <20260611202607.85376-8-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611202607.85376-8-macroalpha82@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 11, 2026 at 03:26:04PM -0500, Chris Morgan wrote:

> Add icm42607 accelerometer sensor for icm42607.

...

> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c

Please, please, use IWYU! So many headers are missing...
(Same comment to all files in this series.)

+ array_size.h
+ bits.h // BIT()
+ cleanup.h // guard()()
+ device/devres.h // devm_kasprintf()
+ err.h // -EINVAL, IS_ERR()

> +#include <linux/iio/iio.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>

+ types.h // s16, __be16

Also you need to have

asm/byteorder.h // be16_to_cpup()

...

> +static int inv_icm42607_accel_read_odr(struct inv_icm42607_state *st,
> +				       int *val, int *val2)
> +{
> +	unsigned int odr;
> +	unsigned int i;
> +
> +	guard(mutex)(&st->lock);
> +
> +	odr = st->conf.accel.odr;
> +
> +	for (i = 5; i < ARRAY_SIZE(inv_icm42607_accel_odr); ++i) {

Why pre-increment? Same for all other cases.

> +		if (i == odr)
> +			break;
> +	}
> +	if (i >= ARRAY_SIZE(inv_icm42607_accel_odr))
> +		return -EINVAL;
> +
> +	*val = inv_icm42607_accel_odr[i][0];
> +	*val2 = inv_icm42607_accel_odr[i][1];
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}

-- 
With Best Regards,
Andy Shevchenko


