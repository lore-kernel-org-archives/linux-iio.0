Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAAFC433B4
	for <linux-iio@archiver.kernel.org>; Sun, 16 May 2021 15:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F63C61177
	for <linux-iio@archiver.kernel.org>; Sun, 16 May 2021 15:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhEPPl5 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 16 May 2021 11:41:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229501AbhEPPl5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 11:41:57 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D701F61139;
        Sun, 16 May 2021 15:40:40 +0000 (UTC)
Date:   Sun, 16 May 2021 16:41:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 17/28] iio: adc: ads1015: Use
 pm_runtime_resume_and_get() to replace open coding.
Message-ID: <20210516164154.3775440a@jic23-huawei>
In-Reply-To: <20210512162212.7f56f0c7@coco.lan>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-18-jic23@kernel.org>
        <20210512162212.7f56f0c7@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 May 2021 16:22:12 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Sun,  9 May 2021 12:33:43 +0100
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
> 
> This driver has an extra (unbalanced?) call to pm_runtime_put_noidle() at
> ads1015_remove().
Good point. Dropped that as well for v2.

> 
> > ---
> >  drivers/iio/adc/ti-ads1015.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> > index 9fef39bcf997..4b61ee3d2501 100644
> > --- a/drivers/iio/adc/ti-ads1015.c
> > +++ b/drivers/iio/adc/ti-ads1015.c
> > @@ -323,9 +323,7 @@ static int ads1015_set_power_state(struct ads1015_data *data, bool on)
> >  	struct device *dev = regmap_get_device(data->regmap);
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

