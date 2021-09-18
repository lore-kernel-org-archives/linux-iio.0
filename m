Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94FEC433EF
	for <linux-iio@archiver.kernel.org>; Sat, 18 Sep 2021 18:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FA72610E9
	for <linux-iio@archiver.kernel.org>; Sat, 18 Sep 2021 18:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbhIRSJz (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 Sep 2021 14:09:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235868AbhIRSJz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Sep 2021 14:09:55 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CD5561100;
        Sat, 18 Sep 2021 18:08:29 +0000 (UTC)
Date:   Sat, 18 Sep 2021 19:12:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Karol Wrona <k.wrona@samsung.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: ssp_sensors: add more range checking in
 ssp_parse_dataframe()
Message-ID: <20210918191208.4cacd004@jic23-huawei>
In-Reply-To: <20210913073709.GT1935@kadam>
References: <20210909091336.GA26312@kili>
        <20210911164253.260be729@jic23-huawei>
        <20210913073709.GT1935@kadam>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Sep 2021 10:37:09 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Sat, Sep 11, 2021 at 04:42:53PM +0100, Jonathan Cameron wrote:
> > On Thu, 9 Sep 2021 12:13:36 +0300
> > Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >   
> > > The "idx" is validated at the start of the loop but it gets incremented
> > > during the iteration so it needs to be checked again.
> > > 
> > > Fixes: 50dd64d57eee ("iio: common: ssp_sensors: Add sensorhub driver")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>  
> > 
> > This is only a fix if we assume that the len value check is there
> > as a protection against buffer overrun rather than as a termination condition
> > that occurs when parsing a valid record.
> > 
> > There is more paranoid checking in ssp_print_mc_debug() so it seems we aren't assuming
> > valid data in there at least.
> > 
> > Still is this perhaps a case of hardening rather than a fix or am I missing something?
> >   
> 
> Yeah.  This is from static analysis.  It's not a bug that probably
> affects real life.
> 
> I guess it's debatable if it should get a Fixes tag, but I feel like
> everything should be written in a hardened way.  Plus with the Fixes tag
> it will get backported.
> 
> > As an aside, if that ssp_print_mcu_debug() reads a negative char it is then
> > returned directly so we get a random small negative number as the error code which
> > isn't going to be very useful.  
> 
> That's true.  I will send that as a separate fix though.  Definitely
> with a Fixes tag on that.  ;)

Ok. Applied to fixes-togreg branch of iio.igt and marked for stable.
Hardening this can't do us any harm as far as I can tell and it is a good thing
to do then it is sensible to backport it.

Thanks,

Jonathan

> 
> regards,
> dan carpenter
> 

