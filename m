Return-Path: <SRS0=6njX=RW=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4D1C43381
	for <linux-iio@archiver.kernel.org>; Tue, 19 Mar 2019 21:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B31D2146E
	for <linux-iio@archiver.kernel.org>; Tue, 19 Mar 2019 21:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfCSVZL (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:25:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:18892 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbfCSVZL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 Mar 2019 17:25:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 14:25:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,246,1549958400"; 
   d="scan'208";a="308605472"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga005.jf.intel.com with ESMTP; 19 Mar 2019 14:25:08 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h6MEN-0000ux-0a; Tue, 19 Mar 2019 23:25:07 +0200
Date:   Tue, 19 Mar 2019 23:25:07 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Vincent Pelletier <plr.vincent@gmail.com>
Subject: Re: [PATCH v1] iio: adc: intel_mrfld_adc: Add Basin Cove ADC driver
Message-ID: <20190319212507.GM9224@smile.fi.intel.com>
References: <20190318095103.69122-1-andriy.shevchenko@linux.intel.com>
 <20190318205242.GA11257@arch>
 <20190318223728.GA9224@smile.fi.intel.com>
 <20190319190213.GB11257@arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319190213.GB11257@arch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 19, 2019 at 08:02:15PM +0100, Tomasz Duszynski wrote:
> On Tue, Mar 19, 2019 at 12:37:28AM +0200, Andy Shevchenko wrote:
> > On Mon, Mar 18, 2019 at 09:52:42PM +0100, Tomasz Duszynski wrote:
> > > On Mon, Mar 18, 2019 at 12:51:03PM +0300, Andy Shevchenko wrote:

> > > > +#include <linux/iio/iio.h>
> > > > +#include <linux/iio/driver.h>
> > > > +#include <linux/iio/machine.h>

> > > Alphabetical order is preferred.
> >
> > Ah, you meant iio.h vs. driver.h?
> >
> 
> Yes.

It won't compile in alphabetical order.

> > > > +	u8 buf[2];
> > > > +	int ret;
> >
> > > > +	ret = regmap_bulk_read(regmap, chan->address, buf, 2);
> > > > +	if (ret)
> > > > +		goto done;
> > > > +
> > > > +	*result = (buf[0] << 8) | buf[1];
> > >
> > > be/le16_to_cpu() will do it for you.
> >
> > I think get_unaligned_le16() will be better here. Otherwise we need to define
> > __le16 variable and cast around it.
> >
> 
> I was thinking about be16_to_cpu(*(__be16 *)buf).
> Given this is local array and you do not do any pointer arithmetic
> before casting I would be surprised if that caused unaligned access.

Explicit casting to bitwise types seems weird to me, that's why get_unaligned looks better.
And no, there is no unaligned access per se.

-- 
With Best Regards,
Andy Shevchenko


