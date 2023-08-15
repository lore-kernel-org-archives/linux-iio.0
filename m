Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF1EC07E8C
	for <linux-iio@archiver.kernel.org>; Tue, 15 Aug 2023 07:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjHOHMJ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 15 Aug 2023 03:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbjHOHLm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Aug 2023 03:11:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230D910D4;
        Tue, 15 Aug 2023 00:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692083501; x=1723619501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gEhBwplaLZTSuZVqRiboa/ft5i2NmyjCjxVw3eHGEso=;
  b=Yl9x4tWbE+mArOA0VujF76taEl4j9PSjnRm9itJnItmhFISFUA9GGNq9
   O2iOd2qllBcTZeSY3DoiuHdcUxHmg2P/soApH58flqy7TD+FUDpNYsK/l
   8Jgx+jNL8XSM/HLldctaatIqixkqvUQrYZKuR3z4JCzHKiFKBhMVsyjxC
   k6Qym/61cKfVtbz96zpaacxFZS5k8+Iv4Tov/q9IJAZRAP1tEKD5gfud0
   gxU33sfKbq43C74pRFWEUlQSTqgDAkAgplAw6WpuqI+HWNTjE4ZLMV6w+
   YMkhuJamjwLfHqdDKcEFzWQsXR9EZaftNklDYh80tFam124g+jigyXFRC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="374990258"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="374990258"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 00:11:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="799105334"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="799105334"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 15 Aug 2023 00:11:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVoDH-007p0A-22;
        Tue, 15 Aug 2023 10:11:35 +0300
Date:   Tue, 15 Aug 2023 10:11:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max1363: Use i2c_get_match_data()
Message-ID: <ZNslJ44ivDGKR6b1@smile.fi.intel.com>
References: <20230812072419.42645-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812072419.42645-1-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 12, 2023 at 08:24:19AM +0100, Biju Das wrote:
> Replace device_get_match_data() and i2c_match_id() by
> i2c_get_match_data() by making similar I2C and DT-based matching
> table.

...

> +#define MAX1363_ID_TABLE(_name, cfg) {				\
> +	.name = _name,						\
> +	.driver_data = (kernel_ulong_t)&max1363_chip_info_tbl[cfg],	\
> +}

Just use them directly, like in 4 lines each instead of a single one.

	{
		.name = max1361,
		.driver_data = (kernel_ulong_t)&max1363_chip_info_tbl[max1361]
	},

or this, but it's almost 100 characters.

	{ .name = "max1361", .driver_data = (kernel_ulong_t)&max1363_chip_info_tbl[max1361] },


Otherwise I prefer to see something like a generic macro in i2c.h

	I2C_DEVICE_DATA()

(in analogue with PCI_DEVICE_DATA).

-- 
With Best Regards,
Andy Shevchenko


