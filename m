Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC90C48BE8
	for <linux-iio@archiver.kernel.org>; Thu, 10 Mar 2022 14:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244311AbiCJOeb (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 10 Mar 2022 09:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245760AbiCJOax (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Mar 2022 09:30:53 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8D1184B6C
        for <linux-iio@vger.kernel.org>; Thu, 10 Mar 2022 06:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646922411; x=1678458411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DPgWreFPcZnQbWMDPy9UQBwMVcg0pe/u4Yyqvs5fXWA=;
  b=fKQz85RYyNw41T6HPyd4kjjo0FKUKRw64vsO+nw1gSdtxccA6UoQsuCz
   Swzawiu09Utqz7HLOHFSTQd918gMr5QCVF81LK7Eq64PqbqqhYxbdgC5F
   PnNdMXR5sQwrNEyLCw/zyDEzTnXdIGijZvnQnD+JEcDvzV1rvs1tvbzkF
   ESU48E5VCiCXDWAjSHc+1VBtAo7jQqFxUXqqHXvhdgk/ioMv37wQqEl9z
   GFPKaUAxx0BndcYtFCTlukBge69Xe2o/fC6Wf97iTl4XAs+F///qGGJA2
   ilg45sRJwjanbBSpAt+Ck24qxAs1Vg/nHzoQhzAz32v7u0odHdH7BnEw5
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="315979332"
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="315979332"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 06:26:27 -0800
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="510911251"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 06:26:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nSJjb-00Ejtv-Hk;
        Thu, 10 Mar 2022 16:25:43 +0200
Date:   Thu, 10 Mar 2022 16:25:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 4/6] iio: adc: ti-ads1015: Deduplicate channel macros
Message-ID: <YioKZ6EZvYHOOFMe@smile.fi.intel.com>
References: <20220310003402.490478-1-marex@denx.de>
 <20220310003402.490478-4-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310003402.490478-4-marex@denx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 10, 2022 at 01:34:00AM +0100, Marek Vasut wrote:
> These macros differ only in the number of valid bits of each ADC sample
> and the shift of those bits, i.e. ADS1015 is 12bit ADC shifted by 4 left,
> ADS1115 is 16bit ADC shifted by 0. No functional change.

> Signed-off-by: Marek Vasut <marex@denx.de>

...

> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>

You may consider using --cc parameter in `git send-email` to avoid this noise
in the commit messages.

...

> -		.realbits = 12,					\
> +		.realbits = (_realbits),			\
>  		.storagebits = 16,				\

This seems inconsistent a bit. What if the next chip wants to have more than
16 bits in realbits?

...

> -		.realbits = 16,					\
> +		.realbits = (_realbits),			\
>  		.storagebits = 16,				\

Ditto.

I see two options:
1) add static assert to make sure realbits <= storagebits;
2) make it also configurable.

-- 
With Best Regards,
Andy Shevchenko


