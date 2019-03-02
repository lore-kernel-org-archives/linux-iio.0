Return-Path: <SRS0=Vd33=RF=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466B4C43381
	for <linux-iio@archiver.kernel.org>; Sat,  2 Mar 2019 17:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1340320863
	for <linux-iio@archiver.kernel.org>; Sat,  2 Mar 2019 17:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551549172;
	bh=ErHy3ovxwvATOAWjmmb9dQaeypMFTB6azca/L2zrnYU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RHIgSDw5d+5uXgddLbvcyvTHHyn9wiQKrPkU/vkIhKyEKvhpegKlbCYdyu2gi0K5m
	 aJ8ndCqTm/FL9ViHOxtlidRLfUvPF2VFyL6Q/3k2VlUppGXXGI87Fme5uYB4nsMxqz
	 dMJEy3aqwemRI7Agi0x7oRYnndSIGv7wNMOm/ABc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfCBRwv (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 2 Mar 2019 12:52:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:44892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbfCBRwv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 Mar 2019 12:52:51 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA38E20836;
        Sat,  2 Mar 2019 17:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551549169;
        bh=ErHy3ovxwvATOAWjmmb9dQaeypMFTB6azca/L2zrnYU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w6SPMPoCbFjsMIBVupnbfuKeNBXJhkdLtVo6hoDdafLQvt4SaT97RtRjuTuSAdu0m
         TjBehxf98pkuc2b/2a2JPzFoERPW6pRS9ZgU2dA1XJLAOALiolrx6V4On5D4WNUP/n
         SzOELLyf+63U9J1BPY68NB60u1kbBqw7iENZUYfg=
Date:   Sat, 2 Mar 2019 17:52:44 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        alexandru.ardelean@analog.com
Subject: Re: [PATCH] iio:dac:ad5064 mlock cleanup - move to a local lock.
Message-ID: <20190302175244.01e1b43f@archlinux>
In-Reply-To: <CA+U=Dsr2Yiu60fOvcR18EePM22Z1N-d_W6RXHf2QvxvTj-hpGw@mail.gmail.com>
References: <20190220182344.19236-1-jic23@kernel.org>
        <CA+U=Dsr2Yiu60fOvcR18EePM22Z1N-d_W6RXHf2QvxvTj-hpGw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 Feb 2019 13:58:13 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Wed, Feb 20, 2019 at 8:24 PM <jic23@kernel.org> wrote:
> >  
> 
> Hey,
> 
> One comment inline.
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > indio_dev->mlock is intended to protect state transitions in
> > the core. It's scope is tightly defined. For device specific
> > uses such as those made here, we should define a local lock
> > allowing the scope of the lock to be defined near to what it
> > is protecting.
> >
> > These mlock changes can be non obvious, but given we don't do
> > anything other than direct for DACs, these ones are easy to do.
> >
> > If anyone wants to help with this particular effort it would
> > be most welcome!
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/iio/dac/ad5064.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
> > index 2f98cb2a3b96..6c3ba143839b 100644
> > --- a/drivers/iio/dac/ad5064.c
> > +++ b/drivers/iio/dac/ad5064.c
> > @@ -112,6 +112,8 @@ struct ad5064_state {
> >         bool                            use_internal_vref;
> >
> >         ad5064_write_func               write;
> > +       /* Lock used to maintain consistency between cached and dev state */
> > +       struct mutex lock;
> >
> >         /*
> >          * DMA (thus cache coherency maintenance) requires the
> > @@ -248,11 +250,11 @@ static int ad5064_set_powerdown_mode(struct iio_dev *indio_dev,
> >         struct ad5064_state *st = iio_priv(indio_dev);
> >         int ret;
> >
> > -       mutex_lock(&indio_dev->mlock);
> > +       mutex_lock(&st->lock);
> >         st->pwr_down_mode[chan->channel] = mode + 1;
> >
> >         ret = ad5064_sync_powerdown_mode(st, chan);
> > -       mutex_unlock(&indio_dev->mlock);
> > +       mutex_unlock(&st->lock);
> >
> >         return ret;
> >  }
> > @@ -291,11 +293,11 @@ static ssize_t ad5064_write_dac_powerdown(struct iio_dev *indio_dev,
> >         if (ret)
> >                 return ret;
> >
> > -       mutex_lock(&indio_dev->mlock);
> > +       mutex_lock(&st->lock);
> >         st->pwr_down[chan->channel] = pwr_down;
> >
> >         ret = ad5064_sync_powerdown_mode(st, chan);
> > -       mutex_unlock(&indio_dev->mlock);
> > +       mutex_unlock(&st->lock);
> >         return ret ? ret : len;
> >  }
> >
> > @@ -349,12 +351,12 @@ static int ad5064_write_raw(struct iio_dev *indio_dev,
> >                 if (val >= (1 << chan->scan_type.realbits) || val < 0)
> >                         return -EINVAL;
> >
> > -               mutex_lock(&indio_dev->mlock);
> > +               mutex_lock(&st->lock);
> >                 ret = ad5064_write(st, AD5064_CMD_WRITE_INPUT_N_UPDATE_N,
> >                                 chan->address, val, chan->scan_type.shift);
> >                 if (ret == 0)
> >                         st->dac_cache[chan->channel] = val;
> > -               mutex_unlock(&indio_dev->mlock);
> > +               mutex_unlock(&st->lock);
> >                 break;
> >         default:
> >                 ret = -EINVAL;
> > @@ -856,6 +858,7 @@ static int ad5064_probe(struct device *dev, enum ad5064_type type,
> >                 return  -ENOMEM;
> >
> >         st = iio_priv(indio_dev);
> > +       mutex_init(&st->lock);  
> 
> An equivalent `mutex_destroy()` call would be a good idea in ad5064_remove()
> 
Ah, this one..

mutex_destroy is only useful in finding use after free if mutex debugging is
turned on.  In my view it is of dubious benefit if it's getting called only
in remove, on the basis we should be pretty sure the driver won't take
the lock if we hit that path.

The downside is that it complicates the remove path because there is no devm
version of mutex_init to automate the cleanup.

I'll look at whether it makes sense here (i.e. if there is too much
cost to adding it).

> >         dev_set_drvdata(dev, indio_dev);
> >
> >         st->chip_info = &ad5064_chip_info_tbl[type];
> > --
> > 2.20.1
> >  

