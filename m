Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426EBC433B4
	for <linux-iio@archiver.kernel.org>; Thu, 13 May 2021 16:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1522A6143B
	for <linux-iio@archiver.kernel.org>; Thu, 13 May 2021 16:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbhEMQ5i (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 13 May 2021 12:57:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhEMQ5h (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 12:57:37 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68CB5613CA;
        Thu, 13 May 2021 16:56:25 +0000 (UTC)
Date:   Thu, 13 May 2021 17:57:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: Re: [PATCH 21/28] iio: light: vcnl4000: Use
 pm_runtime_resume_and_get() to replace open coding.
Message-ID: <20210513175734.64fcbbf3@jic23-huawei>
In-Reply-To: <20210512163636.67a1ac15@coco.lan>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-22-jic23@kernel.org>
        <20210512163636.67a1ac15@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 May 2021 16:36:36 +0200
Mauro Carvalho Chehab <mchehab@kernel.org> wrote:

> Em Sun,  9 May 2021 12:33:47 +0100
> Jonathan Cameron <jic23@kernel.org> escreveu:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Found using coccicheck script under review at:
> > https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/
> > 
> > This is a prequel to taking a closer look at the runtime pm in IIO drivers
> > in general.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Mathieu Othacehe <m.othacehe@gmail.com>  
> 
> LGTM.
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to poke at.

Thanks,

Jonathan

> 
> > ---
> >  drivers/iio/light/vcnl4000.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> > index 4a61865d01cd..01772327a947 100644
> > --- a/drivers/iio/light/vcnl4000.c
> > +++ b/drivers/iio/light/vcnl4000.c
> > @@ -413,9 +413,7 @@ static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)
> >  	int ret;
> >  
> >  	if (on) {
> > -		ret = pm_runtime_get_sync(dev);
> > -		if (ret < 0)
> > -			pm_runtime_put_noidle(dev);
> > +		ret = pm_runtime_resume_and_get(dev);
> >  	} else {
> >  		pm_runtime_mark_last_busy(dev);
> >  		ret = pm_runtime_put_autosuspend(dev);  
> 
> 
> 
> Thanks,
> Mauro

