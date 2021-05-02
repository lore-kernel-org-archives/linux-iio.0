Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D4DC433ED
	for <linux-iio@archiver.kernel.org>; Sun,  2 May 2021 15:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B075061359
	for <linux-iio@archiver.kernel.org>; Sun,  2 May 2021 15:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhEBPh1 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 2 May 2021 11:37:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230110AbhEBPh1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 May 2021 11:37:27 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C94661175;
        Sun,  2 May 2021 15:36:34 +0000 (UTC)
Date:   Sun, 2 May 2021 16:37:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC PATCH 1/4] iio: core: Introduce
 iio_push_to_buffers_with_ts_na() for non aligned case.
Message-ID: <20210502163724.0a943f6e@jic23-huawei>
In-Reply-To: <CAHp75VdNiEGLC44AycNTJ7_oaibtshJHaFFcq+UKBJ3XtAcp+w@mail.gmail.com>
References: <20210501172515.513486-1-jic23@kernel.org>
        <20210501172515.513486-2-jic23@kernel.org>
        <CAHp75VdRTh6Pzj8yy6sDQqfhfAJj1nGZ79UmzBckNR4b1h5sog@mail.gmail.com>
        <CAHp75VdNiEGLC44AycNTJ7_oaibtshJHaFFcq+UKBJ3XtAcp+w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 1 May 2021 22:27:22 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, May 1, 2021 at 10:25 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sat, May 1, 2021 at 8:28 PM Jonathan Cameron <jic23@kernel.org> wrote:  
> 
> ...
> 
> > > +               iio_dev_opaque->bounce_buffer =
> > > +                       devm_krealloc(&indio_dev->dev,
> > > +                                     iio_dev_opaque->bounce_buffer,  
> >
> > Oh la la, foo = realloc(foo, ...) is 101 type of mistakes.
> > Please, don't do this.
> >  
> > > +                                     indio_dev->scan_bytes, GFP_KERNEL);
> > > +               if (!iio_dev_opaque)  
> 
> And this check...
Yup. Thoroughly broken.  Hohum, but basic idea conveyed however bad the rfc was :(


> 
> > > +                       return -ENOMEM;
> > > +       }  
> 

