Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA82E345741;
	Wed, 22 Apr 2026 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776847748; cv=none; b=r6evHUXFb18XsT/W9nC3nMDcdKdsQj3LMo7qZXqYcTbRmlVy8uqHDuYQ1eIz9iUUwQq+rBzlV7y4I8200zaO0EKVCYMVf5KSlK+5f8HJspW1c7Rpjt9LAC3D4EBoUyRMk+F6QqMz4yd42EXIgFqMTUCw9q4IwhizwJUVbOf0KLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776847748; c=relaxed/simple;
	bh=7FNas1t9bRQUI7dRfS7D9nG1KwAa1FDDwB6gibiLsQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nj2EFc/UssB2apOatBLjG9KtM7w2xp/5rTWcsXi0DE1dAhh2SdcoTwOOw1Wd/zXiuzD56L2CcBR8DGoRW2gxdPklNCVx6IyFIMc/RcEyq9BDl9axN7BVW/SCOkD2ybUvd+GP5xlReRma+k07w/gUx/apTS1NINvWgP0h/NIcfd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfNcWUn+; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfNcWUn+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776847747; x=1808383747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7FNas1t9bRQUI7dRfS7D9nG1KwAa1FDDwB6gibiLsQg=;
  b=mfNcWUn++Y3N9CqUVm+PPXhBmrzSTYSjoSG4oaA1pLJWwEwCi2IBIbEr
   Ud6JQEsIddvKBulOa9VJsDQxXHSqB5wwAKdQx5ChYWoG3mIuXpmkJnULB
   VqssLQhzBh2HDxpAknPpBilq95ZRDK2R9zMq3oFOcRlcrXWwmDGrXTrlj
   Etd4AQt3yWKdb/gat7H/F2V862lbvfgL2eCwh7B6VPTXegry8CI/q7SMN
   zEBlfYzRVbjn7YECpOrEGtrjgOe/lf8/fYvdo/8lQPiOqAaI3MFL/Q6qB
   fBvZpYw85q0gImuzl0doHh6aYvkRX4GC4W0JkOuq/poYNYktsd6AprVrd
   w==;
X-CSE-ConnectionGUID: htMItE/yRhiR6mnszPb7Dw==
X-CSE-MsgGUID: YFlamddgR8WRgBf0RClGuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="65331933"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="65331933"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 01:49:03 -0700
X-CSE-ConnectionGUID: Bb3THQCuQca3lAr/SlMcBQ==
X-CSE-MsgGUID: EF59dY7oTPKEjNt0WxVWTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="229127109"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 01:49:00 -0700
Date: Wed, 22 Apr 2026 11:48:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Felipe Ribeiro de Souza <felipers@ime.usp.br>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	nuno.sa@analog.com, paul@crapouillou.net,
	Lucas Ivars Cadima Ciziks <lucas@ciziks.com>,
	linux-iio@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: ingenic-adc: use guard()() to handle
 synchronisation
Message-ID: <aeiLeVFFs9UT4AGr@ashevche-desk.local>
References: <20260421221629.70401-1-felipers@ime.usp.br>
 <20260421221629.70401-3-felipers@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421221629.70401-3-felipers@ime.usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 21, 2026 at 07:14:59PM -0300, Felipe Ribeiro de Souza wrote:
> Replace mutex_lock() and mutex_unlock() calls with guard()()
> in functions ingenic_adc_set_adcmd(), ingenic_adc_set_config(),
> ingenic_adc_enable(), ingenic_adc_capture() and
> ingenic_adc_read_chan_locked().
> 
> This removes the need to call the unlock function, as the lock is
> automatically released when the function return or the scope exits
> for any other case.

...

>  #include <dt-bindings/iio/adc/ingenic,adc.h>

For better readability I would make the above to be a group by adding a blank
line here. 

> +#include <linux/cleanup.h>
>  #include <linux/clk.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>

-- 
With Best Regards,
Andy Shevchenko


