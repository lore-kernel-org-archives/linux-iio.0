Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA43F388E60;
	Fri, 17 Apr 2026 08:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776412916; cv=none; b=XfH0hocjA9qdWOVkRg+Wp17OFCE6IUcBUBb3F75dE8nOxwMQ2CJMIMWtQV0EoPw2V0i84n3tqe0np/MGFR5jtbLNot5Kr9Rqt/VyWulvAFTsouQiiSvjn3/RxyScKBMEzAL+WVrdMCa70p5QKxBeLEgRT448D3tIJ6el6cCkyk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776412916; c=relaxed/simple;
	bh=D3XsKtf/DWrxBLu1AcgfGhF6zzU3o81w6oIhyh5xwOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuqDSwzxXN5AtAXmuevJIrsddY0lJcHuHLxDF1mW3KFqGN7Yk13Tt6jFZSENxmw2AAoO6fiGF/IOcpR4pulVG3UOsEshoyhFtrH8NRlIKkdXA4r633Lh5kQyf2mz2gm09U5J0gzHOcJYZBWiDJZJnuOgw+Ywr/O2csA3m5Jw9o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yj1+szGk; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yj1+szGk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776412913; x=1807948913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D3XsKtf/DWrxBLu1AcgfGhF6zzU3o81w6oIhyh5xwOU=;
  b=Yj1+szGkux5ejJGVk9fIjfnlkeFJXBTcO9A6+YOgiDK+3BHHzxI+Ffh0
   VOCDMJ+uNiWOlJiLmwx656ly7GSWN1zILWabvS6S/PMfb5Sj9MXNCHLCg
   fBmPdyCMZUH0DvUDKkEkNTEJHSssJdLlTDonS3eM5PgYFGfLVFZT0kcjx
   fIha3yCuSizZUc59a5o44hOTuZPmrL+b2LsZ6g/w6EnOt6mPmJg6tzDQE
   KfJlBL/VWviFscvrOvXQbOgVSfFsDl60wn297wpELAn8yHDDXjURYGj0E
   3C5kjW0bBng+IHhy1y4l7slyfL+zoakmyjdQaY2NHGrRUZ8eyvL0hlLsA
   A==;
X-CSE-ConnectionGUID: JROjbd+tRNC8tw1JrBpc8Q==
X-CSE-MsgGUID: 9q5+xQnrSqKhcaU3GYyUOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100072833"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100072833"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 01:01:53 -0700
X-CSE-ConnectionGUID: ot7oOc28QkKKr0WR1EZLiw==
X-CSE-MsgGUID: ePIeW+7dTtGaoF/0CnVc+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="230902678"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 01:01:51 -0700
Date: Fri, 17 Apr 2026 11:01:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Felipe Ribeiro de Souza <felipers@ime.usp.br>
Cc: paul@crapouillou.net, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org,
	Lucas Ivars Cadima Ciziks <lucas@ciziks.com>,
	linux-mips@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ingenic-adc: use guard(mutex)(&lock) to handle
 synchronisation
Message-ID: <aeHo7NFgvWe_3kPQ@ashevche-desk.local>
References: <20260416011815.9140-1-felipers@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416011815.9140-1-felipers@ime.usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 15, 2026 at 10:18:11PM -0300, Felipe Ribeiro de Souza wrote:
> Replace mutex_lock(&lock) and mutex_unlock(&lock) calls with
> guard(mutex)(&lock) in functions ingenic_adc_set_adcmd,
> ingenic_adc_set_config, ingenic_adc_enable, ingenic_adc_capture
> and ingenic_adc_read_chan_info_raw.

We refer to the functions as func().

> This removes the need to call the unlock function, as the lock is
> automatically released when the function return or the scope exits
> for any other case.

...

>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
> +#include <linux/cleanup.h>

Preserve ordering.

...

>  	/* We cannot sample the aux channels in parallel. */
> -	mutex_lock(&adc->aux_lock);
> +	guard(mutex)(&adc->lock);

	...

>  	ret = IIO_VAL_INT;
>  out:
> -	mutex_unlock(&adc->aux_lock);
>  	clk_disable(adc->clk);

Not sure about this. At bare minimum you should elaborate on this change in the
commit message.

>  	return ret;

-- 
With Best Regards,
Andy Shevchenko


