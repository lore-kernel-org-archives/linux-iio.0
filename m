Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F32C001B0
	for <linux-iio@archiver.kernel.org>; Tue, 15 Aug 2023 14:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237571AbjHOOvv (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 15 Aug 2023 10:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237800AbjHOOvo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Aug 2023 10:51:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2AEC5;
        Tue, 15 Aug 2023 07:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692111104; x=1723647104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6X0G28l1pLKS18FXAeC482NhunZuxGuMSmAYK7+ghYE=;
  b=lwxHzF2L3TAq5SrGsCohb8AyKj8O6r0shBhBlVSkrD9jjzvXdX/OuyMO
   yWX61cGT954l1BOcfRDwPgiGL2MRwnYagg504GqVHxSLUXczabX8X5E8I
   j9HUpHTT6YGIv8QjLurRIC4UINB6YB+vTenzvoz66tb3xnKCDBksY2TxN
   qwTuezFpggOc3IHWpHb9b/KEthmOfzbIYMgBUTT/APbxVQRbcqIaU3MtV
   bO9o95kxqThe3yCFy0ojfiSG8mVzA0EZgGrx+f1rCN9nwaJ5BQt4/OKgZ
   pkda4UQYaX33uB5bXmbniCa+IUkjKZpNZ5w7pqqBXu/hk2HaFh+0byxXJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="376026581"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="376026581"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 07:51:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="980383497"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="980383497"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 15 Aug 2023 07:51:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVvOV-00610g-0F;
        Tue, 15 Aug 2023 17:51:39 +0300
Date:   Tue, 15 Aug 2023 17:51:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: bmp280: Use i2c_get_match_data()
Message-ID: <ZNuQ+idDAna6XbvH@smile.fi.intel.com>
References: <20230812175808.236405-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812175808.236405-1-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 12, 2023 at 06:58:08PM +0100, Biju Das wrote:
> Replace device_get_match_data() and id lookup for retrieving match data
> by i2c_get_match_data().

...

>  	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>  
> -	chip_info = device_get_match_data(&client->dev);
> -	if (!chip_info)
> -		chip_info = (const struct bmp280_chip_info *) id->driver_data;
> +	chip_info = i2c_get_match_data(client);

Is id still in use?

-- 
With Best Regards,
Andy Shevchenko


