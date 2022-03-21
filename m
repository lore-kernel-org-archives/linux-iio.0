Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B873C433EF
	for <linux-iio@archiver.kernel.org>; Mon, 21 Mar 2022 10:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245239AbiCUKnR (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 21 Mar 2022 06:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346434AbiCUKmt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Mar 2022 06:42:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E756A143447
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 03:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647859284; x=1679395284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jhdSicdwMGIbWFvE/49X/UMtc13YvTS8QovENWIKxO4=;
  b=DUtXiWiEKd1abfr3kCKJCgwyXcglYl4eRq6AFkmRa5BR8fGVZSLP1S3s
   fhopKevcjj4ltj01ToUl0/i5d9nH2OMBU9VsRVoETUqbZQXCxKjjMeRLS
   JtGuFUpZnq+kQKN62BwqpVWR2u1fnyOc8VrL9oTeyOQXWtHigPJgQRdqn
   2iBhhWhStzyPfbMRcgLU4WXA3yldyoONuoiipBHM64mWrV446k2fVOBQ0
   Kybf9ihhdVVXdAfKSC5+jcHXHTwzD5n5JuYpCLalkphTuYTGa8wBAO6zz
   TrdFzdMhBjbQQrmasB0QwUiXxT0Jt+bK7eJJY0KBXFa2Mwn45qHBe9Xn6
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="257711023"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="257711023"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 03:41:24 -0700
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="518382249"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 03:41:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nWFSi-003pK2-QG;
        Mon, 21 Mar 2022 12:40:32 +0200
Date:   Mon, 21 Mar 2022 12:40:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: core: WARN in case sample bits do not fit storage
 bits
Message-ID: <YjhWIN6GsuhPskrs@smile.fi.intel.com>
References: <20220320181542.168147-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220320181542.168147-1-marex@denx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 20, 2022 at 07:15:42PM +0100, Marek Vasut wrote:
> Add runtime check to verify whether storagebits are at least as big
> as shifted realbits. This should help spot broken drivers which may
> set realbits + shift above storagebits.

Thanks!

...

>  
> +			/* Verify that sample bits fit into storage */
> +			WARN_ON(channels[i].scan_type.storagebits <
> +				channels[i].scan_type.realbits +
> +				channels[i].scan_type.shift);

Not sure WARN is a good level (it might be fatal on some setups and we won't that),
besides the fact that we may use dev_WARN(). Perhaps dev_warn() would suffice?

-- 
With Best Regards,
Andy Shevchenko


