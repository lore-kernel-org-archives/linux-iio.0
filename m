Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3184835C6A7;
	Sat,  3 Oct 2026 19:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791054850; cv=none; b=BrDG6k/KSTEvUAmBiObhc1s73zqRWCkbY840Za1SN5TkPLltCszTsqS2yJ5RsfbzE5C0USyJtUDeRbPv3LstvSZgPViRIGbwnMg7qP1mLWzWvbuSITouLzuKzjJ5p0FySswEdmLU3N7/pEnlSBow1ewbeaie+uS6dy/RYLqI6q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791054850; c=relaxed/simple;
	bh=KhgmOyAqjo/llGROourjFLvSd3sC7KcQpwY5Z6BnsCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9V+d6IYrpbMmvzUPyxOfCnL+EbReRi7okjfFuk0nDi8EAbAarzueh21v4uujdN7MqVlySp5/twh5Dr6TtSP7Gyw29e6Ri1N/Gn4VDAI5db6ILySRRjuTQlPw3/fg+ta99zKZYYiLEqkRK5P+qmAL+ESHY/Lam2CsCEp50+jms4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UyWyh7Gp; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UyWyh7Gp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791054849; x=1822590849;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KhgmOyAqjo/llGROourjFLvSd3sC7KcQpwY5Z6BnsCY=;
  b=UyWyh7GpjeuS/czkNtHuHV/o5+XXTrLoxrX2WG3Vy9b4pQlsMpkqzksj
   CpIzpNSUf/Qxq1NPQnqxD0xScclhG1Z0VAl4IyKDpjcvGpw4tDS9Ks5cZ
   zTGhntIP1ERpo9pz8b+3dOOw1fgB6r0Xcquj/AxHXzPlhIj/ciTxiLdg9
   bvce80Ag829x5YWCLQ4z6S87kVz/eevQ3+nTz5Ko5PerDLvAreSM+/H+s
   8YWYzT/o7eXH1QrM2nSRDvzF69Jg/HDmWUjGp6ThUz5eCwuwlJCPILIln
   py2F4Q6A49ZtRNE6Z9/Ui8NiSxYO4q/FSCoiITr7awZXS9NcWvh7JMjzI
   A==;
X-CSE-ConnectionGUID: m6fCXqXETteS2TAt7P4nMQ==
X-CSE-MsgGUID: 5AQnYGEUSNyz+XOvwOmaqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="90840975"
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="90840975"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 12:14:08 -0700
X-CSE-ConnectionGUID: 5kjAKhlISJmucsEP+Z1HUw==
X-CSE-MsgGUID: ddJqhZl7TPmfEZAML0iz8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="276562823"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.78])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 12:14:05 -0700
Date: Sat, 3 Oct 2026 22:14:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: pressure: add Sensirion SDP31 driver
Message-ID: <asFT-mYqD9PKNKEQ@ashevche-desk.local>
References: <20261003160949.4657-1-m.abubakar365@yahoo.com>
 <20261003160949.4657-3-m.abubakar365@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003160949.4657-3-m.abubakar365@yahoo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 03, 2026 at 09:09:49PM +0500, Muhammad Abu Bakar wrote:
> Add an IIO driver for the Sensirion SDP3x family of differential pressure
> sensors (SDP31, SDP32 and SDP33). The devices are accessed over I2C and
> report differential pressure and temperature. Each measurement is
> validated using the sensor's CRC-8 checksum. The scale factor is read
> from the sensor at runtime, so all three parts are supported.
> 
> Tested on an SDP31 connected to a Raspberry Pi 4 I2C bus.

With the nit-picks addressed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> Assisted-by: Claude:claude-opus-4-8
> Assisted-by: Claude:claude-opus-5-5

Assisted-by: LLM

> Signed-off-by: Muhammad Abu Bakar <m.abubakar365@yahoo.com>

...

> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/crc8.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>

> +#include <linux/mod_devicetable.h>

Not in the new code.

> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/once.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>

...

> +static int sdp31_read_measurement(struct sdp31_data *data, s16 *pressure,
> +				  s16 *temp)

Better to split on logical boundary

static int sdp31_read_measurement(struct sdp31_data *data,
				  s16 *pressure, s16 *temp)
-- 
With Best Regards,
Andy Shevchenko


