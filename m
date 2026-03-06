Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48BA38B7CA;
	Fri,  6 Mar 2026 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798638; cv=none; b=dqesMj4LJGo6+rz33S5JgSpHaLHdzKiLElwIQP4KAS13yUq/pPkb7kyLu9JzmSy3EhFDQQfkQ6S++7Kb9r3xsl6DGXJMdbV6VFWkhtegbnwK4BH4989LvJ4iDbna2XLZwxelY66JrDCZ/TVoz5BeNNw1eO8hz3r7eP9WQW4cAMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798638; c=relaxed/simple;
	bh=gKAhrG6osj0Yj9FTaSi6GfVAj7PCKjuw4ROpN2kSugo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipYywktPyvypm7MUHsv/xXlDK/O4qYW/X7tdd3YdPDVm6/RnWN685UyUk2XHThQt8VcIX5U+a4uzOYQwNtVx2iDOXmlfMAqmNYjqksARknLwbM+KqL5Y/C2h4IXpFXMch/fXKg5QT5w6SmVED+zrlrq4RnEf7LtCuxuMwliQypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N0sM/3d0; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N0sM/3d0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772798635; x=1804334635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gKAhrG6osj0Yj9FTaSi6GfVAj7PCKjuw4ROpN2kSugo=;
  b=N0sM/3d0VQ2JDc6ovYYKWTevVlOYa76Vy8wQuECv8Do4ryCoaFPdY3qO
   k0YQAgA5oIJ1/2YiLG8ixGnpqODF6p7xkvZ1FYU+mrJMj481nFI1VeD9s
   M2ykkxw+CJyf0KeszmEFeYAtqhuWiHJn1vzF92JCppmxoHgeAJdRegs26
   C9lTwa45ZNJ84jWV9oUjm0YY5OmTBO9pzc4M0V/ACot+/a43ERk01oCyL
   skl8b3UrycY9m+F7vEZmgmBaAwBOgnUrbsyGVqkTDFV8KdOFAJ8y8sE4a
   UVP2YHZ+1NOSp7/pWFoEVULPhCJ4a27Z21+V31Wo63fthfmz9imom/EmG
   A==;
X-CSE-ConnectionGUID: 7Mld4oD2RdWK05Y7f0KoyA==
X-CSE-MsgGUID: PTx5rUzwSnCAKN4z5jIn1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="73604893"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="73604893"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 04:03:52 -0800
X-CSE-ConnectionGUID: 2dHbatulSZ+uW6vLwIjowQ==
X-CSE-MsgGUID: 68TePeuWTIqhrbk3s2LHtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="215689694"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.1])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 04:03:50 -0800
Date: Fri, 6 Mar 2026 14:03:47 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: mcp47feb02: Fix Vref validation [1-999] case
Message-ID: <aarCo-3Sh99u-WtZ@ashevche-desk.local>
References: <20260305-mcp47feb02-fix1-v1-1-64b613260e09@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-mcp47feb02-fix1-v1-1-64b613260e09@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 05, 2026 at 12:48:39PM +0200, Ariana Lazar wrote:
> Store reference voltages in uV instead of mV to avoid invalid error code
> in dev_err_probe call. Vref variables store the actual value returned by

dev_err_probe()

> devm_regulator_get_enable_read_voltage function instead of the results of

devm_regulator_get_enable_read_voltage()


> dividing it by MILLI. The corner case [1-999] divided by MILLI of the
> voltage reference variable value would become 0 is covered too.
> 
> Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
> Link: https://lore.kernel.org/all/aYXvP5FLA5BvkoVX@stanley.mountain/

> 

Shouldn't be a blank line in the tag block.

...

> +	int vref1_uV = 0;
> +	int vref_uV = 0;

Better to split assignments and make them when they are needed.

-- 
With Best Regards,
Andy Shevchenko


