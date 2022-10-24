Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DD7FA3743
	for <linux-iio@archiver.kernel.org>; Mon, 24 Oct 2022 11:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiJXLot (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 24 Oct 2022 07:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiJXLoY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 07:44:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACAF74CEE
        for <linux-iio@vger.kernel.org>; Mon, 24 Oct 2022 04:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666611724; x=1698147724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0LLmBlfq8lLDqJ/pk2/fCmOggGp2OZSSrBy7MA+QNuA=;
  b=IRRGwE1mtBI+xf4htj1jv1Ld2waj5Qf1+/CJUK24rmDpE362WlMPipY5
   huMIqKPbMopODGLR3UZYGOBs3J2vXzlAdZb5wV8eNJm/haQWof1lxNDms
   9pEEAYtX5Ug9blWVeV21XAvwPOOqoDFgUxguDou54ddHlyTkEFiceGbgv
   +DFlyZcZ2Jo5rnkQYRpy6J0p5L4jmQx4f8UmFg6x222KZEK78jB7NO2ee
   HZaZaRSb4HYORPt19BfH7WLIkwXoWA05ba+5OdCa0JMSm8s3ePvrIPbld
   OQlcdT5Ue7drz4djcXIMzzxepRNcMjcKsCytOdikc4TgGdUKVc0rkqok3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="308489571"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="308489571"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 04:40:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="960396955"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="960396955"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 24 Oct 2022 04:40:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1omvoa-001PyF-0p;
        Mon, 24 Oct 2022 14:40:20 +0300
Date:   Mon, 24 Oct 2022 14:40:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Miaoqian Lin <linmq006@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        Wolfram Sang <wsa@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>, kernel@pengutronix.de,
        Yang Yingliang <yangyingliang@huawei.com>,
        wangjianli <wangjianli@cdjrlc.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 10/23] iio: accel: kxcjk-1013: Convert to i2c's .probe_new
Message-ID: <Y1Z5pMPrkUP64q1l@smile.fi.intel.com>
References: <20221023132302.911644-1-u.kleine-koenig@pengutronix.de>
 <20221023132302.911644-11-u.kleine-koenig@pengutronix.de>
 <Y1WQoyek5KBwDqCd@smile.fi.intel.com>
 <20221024070518.dnrhsijfphbhs2la@pengutronix.de>
 <Y1ZPVw1qBx1MkZgY@smile.fi.intel.com>
 <20221024091456.vuw3mqcokfrbrozh@pengutronix.de>
 <Y1Ze2gw3hNgp6FT5@smile.fi.intel.com>
 <39f4b8f21f19361e2b87b581f11a348222ea3dd2.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39f4b8f21f19361e2b87b581f11a348222ea3dd2.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 24, 2022 at 12:22:19PM +0200, Nuno Sá wrote:
> On Mon, 2022-10-24 at 12:46 +0300, Andy Shevchenko wrote:
> > On Mon, Oct 24, 2022 at 11:14:56AM +0200, Uwe Kleine-König wrote:

...

> > > There is no win in postponing, is there?[1] What would be your
> > > preferred
> > > way to rework?
> > 
> > My understand of the probe_new is that an attempt to unify i2c with
> > how spi
> > does. So, why not teach i2c_match_id() to handle this nicely for the
> > caller?
> > 
> > This will allow to leave tables where they are (or move closer to
> > struct
> > driver), reduce churn with the using of current i2c_match_id() as you
> > showed the long line to get that table. This might need a new API to
> > avoid
> > changing many drivers at once. But it's business as usual.
> 
> I guess something like spi_get_device_id()

Right, that one I have had in mind when responding.

-- 
With Best Regards,
Andy Shevchenko


