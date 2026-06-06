Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD8E4071EC;
	Sat,  6 Jun 2026 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780770882; cv=none; b=IZxJJxxktxrRUwoyzlJqz1CNg5DvYggsQ4vE1qt4bDWamjKf2y9Vk/eHhVLiFyL6UULLTbJionZeoutkELK4vF0DIxfFNrdkuyRkxvhYJt2Ch/aObe1qGBlL2dlDfQ938Mk0JJjoocOKC1RQKPNFqSM7Uv+XZ11NQwUbc5rOF10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780770882; c=relaxed/simple;
	bh=BVtbCDETjwRv6oqgwtAGd3E5f+lXvM1CFd2TNAA81S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9fw204fScauFipYmnbdGWvvbSdDTwbFEMEDi9Rmy4dw5FCuaMii745bYV8MdkxtgGHg7I3L6nRMjl4QQ/zXaGPb3nuklxs0KhKmcBDb1VcZI39zZP/86REa3JCEzBs8/frr9cP14PDTfrNFlubqCawW19i/OgDhBYFiZIBfEQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mh+N7sc4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mh+N7sc4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780770881; x=1812306881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BVtbCDETjwRv6oqgwtAGd3E5f+lXvM1CFd2TNAA81S4=;
  b=mh+N7sc4wo+GfqeiQ5rB+5AeVOhRfVBDYjEakTBhtnOKOuIvV/iuTzD2
   3/qdFh5DjTbKalvA8x2VaVi8HmXFw9njyhDs5yDNSXAT9qV1LvVbzRP3m
   0XmsLqZlQFIIaXnyWsQImFLEmppodvoGod8ctHGJGKVi3R2hdh08sBteu
   Dmn2VZHM2hNMyL1a1iWDNktbDQlfSlC+KwRCjJ9u5h1uaxhZR5hT374CE
   slNhD49SdCw5OMM95S8c6+ObOLkSSXU3gHVrOgstlm12rbUui/mOaqN+8
   ICMNejvadF9bNvvw24FmBQ8FtdRx7GJgCI+GYyDlYHkIjx+0sHg8QH0gO
   A==;
X-CSE-ConnectionGUID: dsW9EPsLTDqWE9ua2jeS0w==
X-CSE-MsgGUID: DQUZckhfQBGIsQneRv2N3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11809"; a="85424553"
X-IronPort-AV: E=Sophos;i="6.24,191,1774335600"; 
   d="scan'208";a="85424553"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2026 11:34:40 -0700
X-CSE-ConnectionGUID: hJzLObftRJmAaHEIfhTBow==
X-CSE-MsgGUID: 42/qX45aTAOda5prBP6Gag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,191,1774335600"; 
   d="scan'208";a="238776278"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.57])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2026 11:34:37 -0700
Date: Sat, 6 Jun 2026 21:34:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salih Erim <salih.erim@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Salih Erim <erimsalih@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] iio: adc: versal-sysmon: add I2C driver
Message-ID: <aiRoOnyMG2g6BU_a@ashevche-desk.local>
References: <20260606051707.535281-1-salih.erim@amd.com>
 <20260606051707.535281-4-salih.erim@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606051707.535281-4-salih.erim@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jun 06, 2026 at 06:17:05AM +0100, Salih Erim wrote:
> Add an I2C transport driver for the Versal SysMon block. The SysMon
> provides an I2C slave interface that allows an external master to
> read voltage and temperature measurements through the same register
> map used by the MMIO path.
> 
> The I2C command frame is an 8-byte structure containing a 4-byte data
> payload, a 2-byte register offset, and a 1-byte instruction field.
> Read operations send the frame with a read instruction, then receive
> a 4-byte response containing the register value.
> 
> Events are not supported on the I2C path because there is no
> interrupt line and the I2C regmap backend cannot be called from
> atomic context.

...

> +#include <linux/bits.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/unaligned.h>

There are headers absent, please, follow IWYU principle.

IS_ERR() ? struct of_device_id ?

> +#include "versal-sysmon.h"

-- 
With Best Regards,
Andy Shevchenko


