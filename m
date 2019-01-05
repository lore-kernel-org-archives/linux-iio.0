Return-Path: <SRS0=5rro=PN=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75143C43387
	for <linux-iio@archiver.kernel.org>; Sat,  5 Jan 2019 22:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3981E222B3
	for <linux-iio@archiver.kernel.org>; Sat,  5 Jan 2019 22:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="RgI7lW/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfAEWoa (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 5 Jan 2019 17:44:30 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45961 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfAEWoa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Jan 2019 17:44:30 -0500
Received: by mail-io1-f65.google.com with SMTP id c2so10029934iom.12
        for <linux-iio@vger.kernel.org>; Sat, 05 Jan 2019 14:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wa/l0XX6z72HhzXBRV1T8VxM3GYqWicvaI9dAabsCzc=;
        b=RgI7lW/c31ZBB0iKEU6+KFW84TZJDatQ8ejXDQsqwYoCuQYazbXToiJMQPXuydGNpg
         62R3G96LNm3gB25z9GwutOHiFD30DKcnmierHie12NqspJuoX9DRBmzxIuMNDTY50HaD
         I8q7xz10Mammk6tBvXJ2UdXlpArhDHuhglYrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wa/l0XX6z72HhzXBRV1T8VxM3GYqWicvaI9dAabsCzc=;
        b=p4jZrQgKcTDZATcWQCLFxb6yDJL/fBdtlTZuezmQPGoAxYtQqUTqZYedxNHa7AaaWm
         ZBrU0ljaosAeso8gGIYn5jUrEovmsmqDYaPwp3dgP8P38kjgH1J439krkFuk4WKDy3sI
         UGIyO1frZiuE0lfCpXhT+DV5aomLbVDPY1FtEyPuPritb5/q2FKKqcggD837hB8hc1cJ
         ra0jt1BtTO5MDEJN3oQIDiTWsLhvTIPuR6dBrhXNpTA+7agYAacbhCmN++F5IuizPhof
         SDFy8Kgl9dXllI2WOGEL6AchPtyR8VC7nwpkQvb38Vv8VyHoRcFQEP2fN85egbiSGUFo
         FOtw==
X-Gm-Message-State: AJcUukfuHzapyqtxV7bAE8XTx8URABCnZGnQzxvoTAbU8psB9RLhitAV
        nMk97XNmb7xIOohmT3S0P9DXgZXROd5jiUGZroarEsMD1FMC2Qz6
X-Google-Smtp-Source: ALg8bN7RSDGwKQDtcAJzD3f50E6syNgoPulQ2KYqXRvufLkrkFLcbBT0tLNnnxo8V103xLP1y8CigwDX9xzJpODu6BQ=
X-Received: by 2002:a6b:3a89:: with SMTP id h131mr13649492ioa.109.1546728269128;
 Sat, 05 Jan 2019 14:44:29 -0800 (PST)
MIME-Version: 1.0
References: <20181231030701.29789-1-matt.ranostay@konsulko.com> <20190105163420.48a047fc@archlinux>
In-Reply-To: <20190105163420.48a047fc@archlinux>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sat, 5 Jan 2019 14:44:18 -0800
Message-ID: <CAJCx=gkHyO8ggUhsdPGqgdSB=Efe-2VStm0JivsKq3yhZ9-S3g@mail.gmail.com>
Subject: Re: [PATCH] iio: chemical: atlas-ph-sensor: correct IIO_TEMP values
 to millicelsius
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jan 5, 2019 at 8:34 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun, 30 Dec 2018 19:07:01 -0800
> Matt Ranostay <matt.ranostay@konsulko.com> wrote:
>
> > IIO_TEMP scale value for temperature was incorrect and not in millicelsius
> > as required by the ABI documentation.
> >
> > Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> Ideally would have had a fixes tag.  Looks superficially like this
> goes back a long way but always nice to confirm how far :)
>

Fixes: 27dec00ecf2d (iio: chemical: add Atlas pH-SM sensor support)

And yes it goes back a far way..., and guess this happens when one
doesn't use the libiio for userspace development :).

> Anyhow, given we are in the merge window, I'll pick this up once rc1
> is out and mark it for stable etc.
>
> Give me a poke if I seem to have lost it in a week or so.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/chemical/atlas-ph-sensor.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
> > index a406ad31b096..3a20cb5d9bff 100644
> > --- a/drivers/iio/chemical/atlas-ph-sensor.c
> > +++ b/drivers/iio/chemical/atlas-ph-sensor.c
> > @@ -444,9 +444,8 @@ static int atlas_read_raw(struct iio_dev *indio_dev,
> >       case IIO_CHAN_INFO_SCALE:
> >               switch (chan->type) {
> >               case IIO_TEMP:
> > -                     *val = 1; /* 0.01 */
> > -                     *val2 = 100;
> > -                     break;
> > +                     *val = 10;
> > +                     return IIO_VAL_INT;
> >               case IIO_PH:
> >                       *val = 1; /* 0.001 */
> >                       *val2 = 1000;
> > @@ -477,7 +476,7 @@ static int atlas_write_raw(struct iio_dev *indio_dev,
> >                          int val, int val2, long mask)
> >  {
> >       struct atlas_data *data = iio_priv(indio_dev);
> > -     __be32 reg = cpu_to_be32(val);
> > +     __be32 reg = cpu_to_be32(val / 10);
> >
> >       if (val2 != 0 || val < 0 || val > 20000)
> >               return -EINVAL;
>
