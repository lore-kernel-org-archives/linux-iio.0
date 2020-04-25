Return-Path: <SRS0=dRc7=6J=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EDFC54FCB
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 13:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 795F42072B
	for <linux-iio@archiver.kernel.org>; Sat, 25 Apr 2020 13:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587821850;
	bh=qPLlgZ5pomNE6wdLEQLUXUUBbKrIqguhWIxlFkxA1RE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gJGSrPYdZ1l5W+3QfWIllHrwYr9YUzQHj6V6hVCrttNrwzFYwEZLrYoLt3c2lNttC
	 xVdAp9watX4aU2keygGgkXyj3gnYcOlA+oeexIZw6P5QYonfAOjMRrljecE8wSIcaJ
	 HQ0oF0M9FrJAw7cANZp164uaJykmjVCMH7Rw0m2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgDYNh3 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 25 Apr 2020 09:37:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgDYNh3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 09:37:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7361F20724;
        Sat, 25 Apr 2020 13:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587821849;
        bh=qPLlgZ5pomNE6wdLEQLUXUUBbKrIqguhWIxlFkxA1RE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LsLhKaPVSd22ODN458qU/wOb4iyJ4vaDvRo/Np9gR/FrXGl4i8yynRI/+kqIbl8IN
         xdrkiAQassROS5SR0UyfVPjCzDF+/PaOClQwfBrlov98yfQtMxiinlAnkQhBzCtyL2
         yb1Lh3As3VLzBr277R31lRs3gnUzRSNL10SdsVow=
Date:   Sat, 25 Apr 2020 14:37:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: chemical: atlas-sensor: correct DO-SM channels
Message-ID: <20200425143725.70f488aa@archlinux>
In-Reply-To: <CAJCx=gnjj6pp9=aEKohdmxrsm+aRgSO9wus3p8oLd01JQGoOUw@mail.gmail.com>
References: <20200419232847.32206-1-matt.ranostay@konsulko.com>
        <20200422182742.00004e9b@huawei.com>
        <CAJCx=gmHeyAsjf8ZkWpSE9=uDHtX7=5jES9sx0=P3kZh=TDHng@mail.gmail.com>
        <CAJCx=gnjj6pp9=aEKohdmxrsm+aRgSO9wus3p8oLd01JQGoOUw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Apr 2020 20:43:15 -0700
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Wed, Apr 22, 2020 at 8:42 PM Matt Ranostay
> <matt.ranostay@konsulko.com> wrote:
> >
> > On Wed, Apr 22, 2020 at 10:27 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:  
> > >
> > > On Mon, 20 Apr 2020 02:28:47 +0300
> > > Matt Ranostay <matt.ranostay@konsulko.com> wrote:
> > >  
> > > > IIO_CONCENTRATION channel for the DO-SM shouldn't be indexed as
> > > > there isn't more than one, and also ATLAS_CONCENTRATION_CHANNEL
> > > > macro scan_index define steps on the IIO_TIMESTAMP channel.
> > > >  
> >
> > Fixes: 1a881ed8a43b  (iio: chemical: atlas-sensor: add RTD-SM module support)  
> 
> Oops wrong change for Fixes tag. Sorry about that..
> 
> Fixes: a751b8e48018 (iio: chemical: atlas-sensor: add DO-SM module support)

So the index thing isn't really a fix as such. It's perfectly valid for
a single channel to be indexed even if not required.  Still it's your
driver so if you prefer it this way fair enough.

The other bit obviously is a fix so I'll just take this whole thing as a
fix.  Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

> 
> >  
> > > > Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>  
> > >
> > > Fixes tag?
> > >
> > > J  
> > > > ---
> > > >  drivers/iio/chemical/atlas-sensor.c | 14 +++++++++++++-
> > > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/iio/chemical/atlas-sensor.c
> > > > b/drivers/iio/chemical/atlas-sensor.c index
> > > > 82d470561ad3..7b199ce16ecf 100644 ---
> > > > a/drivers/iio/chemical/atlas-sensor.c +++
> > > > b/drivers/iio/chemical/atlas-sensor.c @@ -194,7 +194,19 @@ static
> > > > const struct iio_chan_spec atlas_orp_channels[] = { };
> > > >
> > > >  static const struct iio_chan_spec atlas_do_channels[] = {
> > > > -     ATLAS_CONCENTRATION_CHANNEL(0, ATLAS_REG_DO_DATA),
> > > > +     {
> > > > +             .type = IIO_CONCENTRATION,
> > > > +             .address = ATLAS_REG_DO_DATA,
> > > > +             .info_mask_separate =
> > > > +                     BIT(IIO_CHAN_INFO_RAW) |
> > > > BIT(IIO_CHAN_INFO_SCALE),
> > > > +             .scan_index = 0,
> > > > +             .scan_type = {
> > > > +                     .sign = 'u',
> > > > +                     .realbits = 32,
> > > > +                     .storagebits = 32,
> > > > +                     .endianness = IIO_BE,
> > > > +             },
> > > > +     },
> > > >       IIO_CHAN_SOFT_TIMESTAMP(1),
> > > >       {
> > > >               .type = IIO_TEMP,  
> > >  

