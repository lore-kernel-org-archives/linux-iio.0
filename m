Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90899C433B4
	for <linux-iio@archiver.kernel.org>; Sun, 16 May 2021 09:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B21161183
	for <linux-iio@archiver.kernel.org>; Sun, 16 May 2021 09:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhEPJJl (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 16 May 2021 05:09:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231258AbhEPJJl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 05:09:41 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 171196109F;
        Sun, 16 May 2021 09:08:24 +0000 (UTC)
Date:   Sun, 16 May 2021 10:09:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno Sa <nuno.sa@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: core: Fix an error pointer vs NULL bug in
 devm_iio_device_alloc()
Message-ID: <20210516100936.1d733df1@jic23-huawei>
In-Reply-To: <CA+U=Dspvr4J=vRYK7ntdB2-XSLss8YutMd0YOQi4zkDr-UkxWw@mail.gmail.com>
References: <YJ+a1yaMu2QNATgt@mwanda>
        <CA+U=Dspvr4J=vRYK7ntdB2-XSLss8YutMd0YOQi4zkDr-UkxWw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 16 May 2021 08:30:20 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Sat, May 15, 2021 at 3:01 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > The devm_iio_device_alloc() function is supposed to return NULL and not
> > error pointers.  Returning an error pointer will lead to a crash in the
> > callers.
> >  
> 
> oh
> that's a good catch;
> 
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

Applied to the togreg branch of iio.git and pushed out as testing for the autobuilders
to poke at it.

Thanks,

Jonathan


> 
> > Fixes: d240dc25e3b8 ("iio: core: simplify some devm functions")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/iio/industrialio-core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index bfa20a346f71..75e92bac78f3 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -1711,7 +1711,7 @@ struct iio_dev *devm_iio_device_alloc(struct device *parent, int sizeof_priv)
> >         ret = devm_add_action_or_reset(parent, devm_iio_device_release,
> >                                        iio_dev);
> >         if (ret)
> > -               return ERR_PTR(ret);
> > +               return NULL;
> >
> >         return iio_dev;
> >  }
> > --
> > 2.30.2
> >  

