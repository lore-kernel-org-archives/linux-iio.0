Return-Path: <SRS0=TPgR=R5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB55AC43381
	for <linux-iio@archiver.kernel.org>; Tue, 26 Mar 2019 13:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E222075C
	for <linux-iio@archiver.kernel.org>; Tue, 26 Mar 2019 13:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfCZNji (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:39:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:21418 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbfCZNji (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 26 Mar 2019 09:39:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 06:39:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,271,1549958400"; 
   d="scan'208";a="332155115"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga005.fm.intel.com with ESMTP; 26 Mar 2019 06:39:33 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h8mIe-0003SY-LD; Tue, 26 Mar 2019 15:39:32 +0200
Date:   Tue, 26 Mar 2019 15:39:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Tomasz Duszynski <tduszyns@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Vincent Pelletier <plr.vincent@gmail.com>
Subject: Re: [PATCH v1] iio: adc: intel_mrfld_adc: Add Basin Cove ADC driver
Message-ID: <20190326133932.GC9224@smile.fi.intel.com>
References: <20190318095103.69122-1-andriy.shevchenko@linux.intel.com>
 <20190318205242.GA11257@arch>
 <20190318223728.GA9224@smile.fi.intel.com>
 <20190319190213.GB11257@arch>
 <20190319212507.GM9224@smile.fi.intel.com>
 <20190324122244.484b6dfb@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190324122244.484b6dfb@archlinux>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 24, 2019 at 12:22:44PM +0000, Jonathan Cameron wrote:
> On Tue, 19 Mar 2019 23:25:07 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Mar 19, 2019 at 08:02:15PM +0100, Tomasz Duszynski wrote:
> > > On Tue, Mar 19, 2019 at 12:37:28AM +0200, Andy Shevchenko wrote:  
> > > > On Mon, Mar 18, 2019 at 09:52:42PM +0100, Tomasz Duszynski wrote:  
> > > > > On Mon, Mar 18, 2019 at 12:51:03PM +0300, Andy Shevchenko wrote:  
> > 
> > > > > > +#include <linux/iio/iio.h>
> > > > > > +#include <linux/iio/driver.h>
> > > > > > +#include <linux/iio/machine.h>  
> > 
> > > > > Alphabetical order is preferred.  
> > > >
> > > > Ah, you meant iio.h vs. driver.h?
> > > >  
> > > 
> > > Yes.  
> > 
> > It won't compile in alphabetical order.
> 
> That's a little worrying as this should definitely not be order dependant.
> What was the error? 
> 
> Ah, I'm guessing struct iio_dev not defined.
> If you would like to put a patch in to add that forward definition in driver.h
> that would be great.  Its an omission rather than intentional.

Done.

> Any chance of getting the whole MFD including this buildable with COMPILE_TEST?

Not possible. MFD includes the x86 architecture provided header.

> Otherwise coverage likely to be somewhat reduced (I probably won't build it
> normally for starters!)

This driver itself may be compile tested separately.

Would you like me to add something like

	depends on X86 || COMPILE_TEST

?

-- 
With Best Regards,
Andy Shevchenko


