Return-Path: <SRS0=rKOe=RG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5B8C43381
	for <linux-iio@archiver.kernel.org>; Sun,  3 Mar 2019 14:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A462120857
	for <linux-iio@archiver.kernel.org>; Sun,  3 Mar 2019 14:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqrJZXrx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfCCO07 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 3 Mar 2019 09:26:59 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45475 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfCCO07 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Mar 2019 09:26:59 -0500
Received: by mail-ot1-f65.google.com with SMTP id i12so2087163otp.12
        for <linux-iio@vger.kernel.org>; Sun, 03 Mar 2019 06:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=056n2a/LOWc7FF8NjLxHft+JCTjXjrTsKdbfvBPwRlI=;
        b=RqrJZXrxISMgtbaMRMCVSMyWgVp1aloYJWirf/Du9q9SOxo7VtWQezeScFVsjd99SG
         ojAnDcSFH5qHhE5U8Kzw6/tRDffigUIEbKk/xNfrw5U7qviFJmJ8fa6q9tnTf2RSCilT
         +vaC7J3AZzwRxecWuJO3YF4bgN8yim6koPcV/uhQS5+KEidre/oEVk1hLlRrEMgwF2Kd
         WUt1iII/objP+KFhjXa3czNFDeVTK6yW11HfJZdDEofFoLhgjE16asnVdmurqQZYhqdw
         vzAbi0tAzxJ3WypIlH5byS8bJrh0/r5tDIRhTcnBNBuquiD2CEqPFWcfk//PMRNgHiC5
         ZzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=056n2a/LOWc7FF8NjLxHft+JCTjXjrTsKdbfvBPwRlI=;
        b=XkgYTTEuG6WgA5ft6CnaDuY8IVPJg8uYMUsxbdVit0KmEHnUvZsD57IwqS/uGwpR8S
         5cJUesx55nCVzy/H2VYBt7gyrb8VGBhLQglDNn6x7BpVaaKWgPh4fCDzzOSK7t7DCCTx
         b5EPgS8PGC49ATjslX5X+w54JKTebb4OskkofzrhXHjTpZObg49eIMOE3132AYY8bL5N
         +mvb4XC63j4/jUI2bNWmYF+FDIrAwisPNNJXkG9NWGhmyfNcjUrDlE/xjSPZx6z+npW1
         uuggnUnYk0IBBS3gVd+8gBuN88GiSHXYDwrAIJ+/8OlwrdVJAWhsP6kbqd5mtjOUlcIf
         DLJA==
X-Gm-Message-State: APjAAAWydI+ZOjZIGDwwUlu4JRMjiHJACbuSF1eRXJq1PA9d7mppJ/z1
        m1LZMIKFDvmD9yl8x71ZXcysGPJZNHmXvyvsk/g=
X-Google-Smtp-Source: APXvYqytn7VX4ANfTiRPIJ7PYFYQseR68hYueDAjWhKl6+4Xxrom8mgYCHQD7BKbOuKYbirInQOyGE/2wA70u7rtSEI=
X-Received: by 2002:a9d:7608:: with SMTP id k8mr8763697otl.157.1551623218564;
 Sun, 03 Mar 2019 06:26:58 -0800 (PST)
MIME-Version: 1.0
References: <20190220182344.19236-1-jic23@kernel.org> <CA+U=Dsr2Yiu60fOvcR18EePM22Z1N-d_W6RXHf2QvxvTj-hpGw@mail.gmail.com>
 <20190302175244.01e1b43f@archlinux>
In-Reply-To: <20190302175244.01e1b43f@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sun, 3 Mar 2019 16:26:45 +0200
Message-ID: <CA+U=DsojKKDnVzY7fzQVBkpKPQaT0XvydZ=c-T7HW5FEeaFpYg@mail.gmail.com>
Subject: Re: [PATCH] iio:dac:ad5064 mlock cleanup - move to a local lock.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        alexandru.ardelean@analog.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 2, 2019 at 7:52 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 22 Feb 2019 13:58:13 +0200
> Alexandru Ardelean <ardeleanalex@gmail.com> wrote:
>
> > On Wed, Feb 20, 2019 at 8:24 PM <jic23@kernel.org> wrote:
> > >
> >
> > Hey,
> >
> > One comment inline.
> >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > indio_dev->mlock is intended to protect state transitions in
> > > the core. It's scope is tightly defined. For device specific
> > > uses such as those made here, we should define a local lock
> > > allowing the scope of the lock to be defined near to what it
> > > is protecting.
> > >
> > > These mlock changes can be non obvious, but given we don't do
> > > anything other than direct for DACs, these ones are easy to do.
> > >
> > > If anyone wants to help with this particular effort it would
> > > be most welcome!
> > >
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  drivers/iio/dac/ad5064.c | 15 +++++++++------
> > >  1 file changed, 9 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
> > > index 2f98cb2a3b96..6c3ba143839b 100644
> > > --- a/drivers/iio/dac/ad5064.c
> > > +++ b/drivers/iio/dac/ad5064.c
> > > @@ -112,6 +112,8 @@ struct ad5064_state {
> > >         bool                            use_internal_vref;
> > >
> > >         ad5064_write_func               write;
> > > +       /* Lock used to maintain consistency between cached and dev state */
> > > +       struct mutex lock;
> > >
> > >         /*
> > >          * DMA (thus cache coherency maintenance) requires the
> > > @@ -248,11 +250,11 @@ static int ad5064_set_powerdown_mode(struct iio_dev *indio_dev,
> > >         struct ad5064_state *st = iio_priv(indio_dev);
> > >         int ret;
> > >
> > > -       mutex_lock(&indio_dev->mlock);
> > > +       mutex_lock(&st->lock);
> > >         st->pwr_down_mode[chan->channel] = mode + 1;
> > >
> > >         ret = ad5064_sync_powerdown_mode(st, chan);
> > > -       mutex_unlock(&indio_dev->mlock);
> > > +       mutex_unlock(&st->lock);
> > >
> > >         return ret;
> > >  }
> > > @@ -291,11 +293,11 @@ static ssize_t ad5064_write_dac_powerdown(struct iio_dev *indio_dev,
> > >         if (ret)
> > >                 return ret;
> > >
> > > -       mutex_lock(&indio_dev->mlock);
> > > +       mutex_lock(&st->lock);
> > >         st->pwr_down[chan->channel] = pwr_down;
> > >
> > >         ret = ad5064_sync_powerdown_mode(st, chan);
> > > -       mutex_unlock(&indio_dev->mlock);
> > > +       mutex_unlock(&st->lock);
> > >         return ret ? ret : len;
> > >  }
> > >
> > > @@ -349,12 +351,12 @@ static int ad5064_write_raw(struct iio_dev *indio_dev,
> > >                 if (val >= (1 << chan->scan_type.realbits) || val < 0)
> > >                         return -EINVAL;
> > >
> > > -               mutex_lock(&indio_dev->mlock);
> > > +               mutex_lock(&st->lock);
> > >                 ret = ad5064_write(st, AD5064_CMD_WRITE_INPUT_N_UPDATE_N,
> > >                                 chan->address, val, chan->scan_type.shift);
> > >                 if (ret == 0)
> > >                         st->dac_cache[chan->channel] = val;
> > > -               mutex_unlock(&indio_dev->mlock);
> > > +               mutex_unlock(&st->lock);
> > >                 break;
> > >         default:
> > >                 ret = -EINVAL;
> > > @@ -856,6 +858,7 @@ static int ad5064_probe(struct device *dev, enum ad5064_type type,
> > >                 return  -ENOMEM;
> > >
> > >         st = iio_priv(indio_dev);
> > > +       mutex_init(&st->lock);
> >
> > An equivalent `mutex_destroy()` call would be a good idea in ad5064_remove()
> >
> Ah, this one..
>
> mutex_destroy is only useful in finding use after free if mutex debugging is
> turned on.  In my view it is of dubious benefit if it's getting called only
> in remove, on the basis we should be pretty sure the driver won't take
> the lock if we hit that path.
>
> The downside is that it complicates the remove path because there is no devm
> version of mutex_init to automate the cleanup.
>
> I'll look at whether it makes sense here (i.e. if there is too much
> cost to adding it).

Hmm, ok.
From my side it's fine whether to leave it or add it.

>
> > >         dev_set_drvdata(dev, indio_dev);
> > >
> > >         st->chip_info = &ad5064_chip_info_tbl[type];
> > > --
> > > 2.20.1
> > >
>
