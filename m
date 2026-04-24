Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108D9282F36
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022858; cv=none; b=qvx+uKS/Bm1sA4tRjwqy+fR3HUCBJG3uN0xczYgCkizgSz1mEHJA4/HtiKUUWj239Hhy6VvzBZ08gncaqPDueQtuHnSjEmmAvziB20wgqVbhxgKlnfj90BXKNUjyqb8HwDZWA7cjd2tI3JlmZVuDd3aczaGb7TJgUMCB0jXEJB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022858; c=relaxed/simple;
	bh=AVGYSteaqfGhCFrva2iR+qJfStk+OsCmBgp9t9d/z0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2BcGUtcTBNrpNEpVRPGsPSTRT7b0P5CG9xq8HxhYPS7IUAtLv0Kp3z0l8N5TSZ0ICkdHpgAq7iRaMQpDt3SCWROtIVcCx0q5E95qUGqi29el6cC0//of7bqcjRMSpW5QdZDcVmC16efdhiuzVunnVd1fJAt4v0YRxhLH4H0UC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J5gSMukq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J5gSMukq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777022857; x=1808558857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AVGYSteaqfGhCFrva2iR+qJfStk+OsCmBgp9t9d/z0A=;
  b=J5gSMukqbMoqtXoy/qEjCwiOkFaS3/3wZYS4+cSuKaRXunfANO8R9Z++
   HjsUoABAnTf38zH7A8jkASVpHdraUTU06nMENhVzX5kLuqvDlbbkmWyxR
   loOf5wlH9ixSEDuTaBAqCKp+cxp0sePxLvKQQsanegPoTfotzRA5j0dr8
   hdE6NhTaVARh/D3izCJAqJehfzN0i2IzAVd6WnVUUykUaZphFf7RuJEnA
   0vBMoNpZCZutrDCxw65UPQb9iNzsX1qsryznfta8Q1W0vCdf/+FTZFpGd
   KtI8ILsDaIC0qNHZ3qe5IIF4DxPAxfgJH2pLIQKHO6RFbWbLwdL5U4BIl
   w==;
X-CSE-ConnectionGUID: NEWKwK/CRt2Uyed/lQkEVg==
X-CSE-MsgGUID: 9IWmExqlQ+m03cMtfT5DiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="88611325"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="88611325"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 02:27:36 -0700
X-CSE-ConnectionGUID: dA/uT8HDQAiu21rhIbWxzg==
X-CSE-MsgGUID: OdiECNBBSkSf80BCgydyBw==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 02:27:35 -0700
Date: Fri, 24 Apr 2026 12:27:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rafasales@usp.br
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	nuno.sa@analog.com, "Gustavo C. Arakaki" <gustavo.arakaki@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: light: ltr501: update header inclusions
Message-ID: <aes3hLTjW3VEzMha@ashevche-desk.local>
References: <20260422231305.677778-1-rafasales@usp.br>
 <20260422231305.677778-2-rafasales@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422231305.677778-2-rafasales@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 08:12:55PM -0300, rafasales@usp.br wrote:

> Update header inclusions to follow IWYU (Include What You Use)
> principle

Respect English grammar and punctuation.

Also this patch does two things: it sorts headers AND moves to IWYU. Hence this
has to be TWO patches.

...

> -#include <linux/module.h>
> -#include <linux/mod_devicetable.h>
> -#include <linux/i2c.h>
> -#include <linux/err.h>
> +#include <asm/page.h>
> +#include <asm/byteorder.h>

The general rule (independently on the folder of the headers) is that the more
generic header is the earlier it's being included. asm/* are definitely _less_
generic than linux/* ones. But at the same time they are more generic than
linux/iio/* ones for _this_ driver.

> +#include <linux/array_size.h>
> +#include <linux/bitops.h>
>  #include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/math.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/sprintf.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
>  
> -#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/trigger_consumer.h>
> -#include <linux/iio/buffer.h>
>  #include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/types.h>

-- 
With Best Regards,
Andy Shevchenko


