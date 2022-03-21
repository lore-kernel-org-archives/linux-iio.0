Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F517C433EF
	for <linux-iio@archiver.kernel.org>; Mon, 21 Mar 2022 16:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346327AbiCUQNb (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 21 Mar 2022 12:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350918AbiCUQNK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Mar 2022 12:13:10 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B86129CB3
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 09:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647879105; x=1679415105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=suBf5rMuiKQnYbkP+bHskGhfRepJv4phrQSx14COVtY=;
  b=eZlvGe3+Dgf6y75ag1vH5rd4Bu8YHy/wuxaIAXw6ItJtAsJy0HzhfLzZ
   XihKXjQ7e4DTR5MmsKpOrbJXuzjfu7HKteRg/sKqYkSR/Rg4xGq5RAkd/
   E/JRlgDx8adkvD+N2okxlW54AjKcYaGBdyLrP04uMdg/zNRSF4cN/uVTD
   CouUyj92erMTKJBWTx32IWVjxW5uJGcZdXqHOc3uON9c4EWYh4NNC/w6s
   KWmkXglkkCAzheAx1VOKk9bGrEztd4viBcUqSbeg6jIGpEUm/zqQzxXir
   pQQmD5R3jwVFymjiO6q9qPuV7b37Vj8U+s7uUVzNJC2vjbeypCvRtNind
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="318299286"
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="318299286"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 09:11:22 -0700
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="518493367"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 09:11:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nWKcF-0040eA-Vx;
        Mon, 21 Mar 2022 18:10:43 +0200
Date:   Mon, 21 Mar 2022 18:10:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: core: WARN in case sample bits do not fit storage
 bits
Message-ID: <Yjijg7m+TnaMs519@smile.fi.intel.com>
References: <20220320181542.168147-1-marex@denx.de>
 <YjhWIN6GsuhPskrs@smile.fi.intel.com>
 <8b6f00be-c520-45c3-4497-d0fc310ff52f@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b6f00be-c520-45c3-4497-d0fc310ff52f@denx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 21, 2022 at 03:46:51PM +0100, Marek Vasut wrote:
> On 3/21/22 11:40, Andy Shevchenko wrote:
> > On Sun, Mar 20, 2022 at 07:15:42PM +0100, Marek Vasut wrote:
> > > Add runtime check to verify whether storagebits are at least as big
> > > as shifted realbits. This should help spot broken drivers which may
> > > set realbits + shift above storagebits.
> > 
> > Thanks!
> > 
> > ...
> > 
> > > +			/* Verify that sample bits fit into storage */
> > > +			WARN_ON(channels[i].scan_type.storagebits <
> > > +				channels[i].scan_type.realbits +
> > > +				channels[i].scan_type.shift);
> > 
> > Not sure WARN is a good level (it might be fatal on some setups and we won't that),
> > besides the fact that we may use dev_WARN(). Perhaps dev_warn() would suffice?
> 
> I was actually thinking about BUG(), but that might crash existing systems.
> I think we want a strong indicator that something wrong is going on which
> must be fixed and the splat produced by WARN_ON() is a good indicator of
> that. It also does not crash existing systems,

It does crash _some_ of them, unfortunately.

> so even if existing users get
> a warning now, they won't get an unbootable system and can report that
> warning.

-- 
With Best Regards,
Andy Shevchenko


