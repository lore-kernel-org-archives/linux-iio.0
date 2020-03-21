Return-Path: <SRS0=UYdU=5G=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69F3C4332B
	for <linux-iio@archiver.kernel.org>; Sat, 21 Mar 2020 20:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C002078A
	for <linux-iio@archiver.kernel.org>; Sat, 21 Mar 2020 20:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgCUULC (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 21 Mar 2020 16:11:02 -0400
Received: from smtprelay0159.hostedemail.com ([216.40.44.159]:40818 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726777AbgCUULB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 16:11:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 357BB837F24A;
        Sat, 21 Mar 2020 20:11:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: chess81_42bd387190014
X-Filterd-Recvd-Size: 3099
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sat, 21 Mar 2020 20:10:58 +0000 (UTC)
Message-ID: <c026dcc85e8454a1ea191c20ba03ce2072271af9.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: remove Stefan Popa's email
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        jic23@kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Date:   Sat, 21 Mar 2020 13:09:10 -0700
In-Reply-To: <20200321194859.GA2813896@smile.fi.intel.com>
References: <20200317143336.6098-1-alexandru.ardelean@analog.com>
         <20200321194859.GA2813896@smile.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2020-03-21 at 21:48 +0200, Andy Shevchenko wrote:
> On Tue, Mar 17, 2020 at 04:33:36PM +0200, Alexandru Ardelean wrote:
> > The email is no longer active. This change removes Stefan's email from the
> > MAINTAINERS list and replaces it with Michael Hennerich's.
> > 
> 
> Are you planning to fix entries as parse-maintainers.pl does?
> (Maybe in a separate change, but also why not here)

I think perhaps you should not ask people to use parse-maintainers
on specific sections anymore as it's rather confusing to use and
it's best done as a one-shot by Linus one day.  I hope soon.

Linus, are you going to apply this patch to parse-maintainers
and one day run and commit the large change to MAINTAINERS?

https://lore.kernel.org/lkml/4d5291fa3fb4962b1fa55e8fd9ef421ef0c1b1e5.camel@perches.com/

$ ./scripts/parse-maintainers.pl --input=MAINTAINERS --output=MAINTAINERS

Current diffstat for -next would be:

$ git diff --shortstat MAINTAINERS
 1 file changed, 2749 insertions(+), 2749 deletions(-)

btw: your current tree is still missing this patch from
-next to fix a broken pattern in 'TI VPE/CAL DRIVERS'

commit d44535cb14c981dea66e565edf1df1df4b9e823b
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Tue Jan 28 11:58:28 2020 -0300

    media: MAINTAINERS: Sort entries in database for TI VPE/CAL
    
    Run parse-maintainers.pl and choose TI VPE/CAL record. Fix it accordingly.
    
    Note, this is urgent fix, without which parse-maintainers.pl throws
    an exception:
    
    Odd non-pattern line '  Documentation/devicetree/bindings/media/ti,cal.yaml
    ' for 'TI VPE/CAL DRIVERS' at scripts/parse-maintainers.pl line 147, <$file> line 16770.
    
    Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    Acked-by: Benoit Parrot <bparrot@ti.com>
    Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
    Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>



