Return-Path: <SRS0=x61j=S2=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EB1C10F11
	for <linux-iio@archiver.kernel.org>; Wed, 24 Apr 2019 06:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D879A218D3
	for <linux-iio@archiver.kernel.org>; Wed, 24 Apr 2019 06:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dye9EhS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfDXGjd (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:39:33 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40768 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfDXGjc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Apr 2019 02:39:32 -0400
Received: by mail-ot1-f65.google.com with SMTP id t8so15148890otp.7
        for <linux-iio@vger.kernel.org>; Tue, 23 Apr 2019 23:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jCQreI0a2VPQDRszljvMnnQwlFEX6l55b6Ti+c+BZts=;
        b=Dye9EhS+hrgh2pu+1y91Bnd7WVVRNoG+DsH949ic27V3aua5C2hzQPxEKlguaDPzo8
         KVGCGQ4/nIxjyLeRQ6yKj12lBcqQn+1d1HEJe1syAh+yepqg3po888AeUhhanwwgDyqF
         g8sBAgB4yaHysr7Z0VZPUl73elMF/LObr1Of7w/R+zYrXyoxrjLwSrMeGz8l5IlWg0Og
         c9akiYyMnMva0ug5ic87bjWiPpQNGyHL+VX6vv4FqPy5pRxZvb6ZBzfbSz2LkPRwNQ2J
         LkA9UjSxT3nTHfL95vWGyEm3ooVpFfFq8MJnnqnFkz0f7l8Wom1wtkFSOnQ/sEzDPFnZ
         vCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jCQreI0a2VPQDRszljvMnnQwlFEX6l55b6Ti+c+BZts=;
        b=nclI9wL55DVaEaw4Yf1IJVTU3S4b0SE4DMXVVeaQ5Si6nZZEXlGMdfWl3Nmu1CTS3G
         Tbju4AGULMsk33YiNxPj1h0IdzmXfQIpTjq8wUxBJYN3lve3DLHtVDYgf9uAmQly603o
         X6jbs6sHVdNUkEQQKtb8HXn8StkuLvSVOKG2RkaFJG35pUOzF2YaNCARkAOkkb44WIln
         nrFbyA1dW5EP1KRBSvzaWekpspf2DtkChfP//yQGq86RyGcN0mAcZZ3nWmc6g3YN76uz
         TiVjmXkQ9j3S42UHnCYy+O71dDLCX4HDGxTQSGHzEz3Ai4wYpFZZtsV5kQzixRX00m77
         WDDA==
X-Gm-Message-State: APjAAAVDApKgClB9OZgm/8c4pUzClVep13ia9LDRea5TwoN3TaHVbsAn
        eB2TwZuD33wtmVzcJVEj/SzKZangYVbsyfKyKW0=
X-Google-Smtp-Source: APXvYqyj3cpIbUO5+zTr61BFqC4Td9YfFWo9VkvMxz8JJSh2wEfoh18lfzDwcCT+RS+oOhk3okd09t9wdLV9LwoqBSs=
X-Received: by 2002:a9d:491a:: with SMTP id e26mr1266939otf.66.1556087972027;
 Tue, 23 Apr 2019 23:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <1555959916-8207-1-git-send-email-dagmcr@gmail.com>
 <CA+U=DspEySc2e6+O6bR41My0Sme0oCRH=c9Q16eHTVsJ0cRpvQ@mail.gmail.com> <CAPsT6h=CQV07V2S8j07ZzLKNuAbM0q9xOCqSqb4BrdXaKcjX6A@mail.gmail.com>
In-Reply-To: <CAPsT6h=CQV07V2S8j07ZzLKNuAbM0q9xOCqSqb4BrdXaKcjX6A@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 24 Apr 2019 09:39:20 +0300
Message-ID: <CA+U=DspXd1VMOQ+qf_UYzru2E5VOZHa8Cksgeh+UAH-v4nQ8Uw@mail.gmail.com>
Subject: Re: [PATCH] spi: AD accelerometer: declare missing of table
To:     Daniel G <dagmcr@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, stefan.popa@analog.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        knaack.h@gmx.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Javier Martinez Canillas <javier@dowhile0.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 23, 2019 at 10:55 PM Daniel G <dagmcr@gmail.com> wrote:
>
> On Tue, Apr 23, 2019 at 9:58 AM Alexandru Ardelean
> <ardeleanalex@gmail.com> wrote:
> >
> > On Mon, Apr 22, 2019 at 10:20 PM Daniel Gomez <dagmcr@gmail.com> wrote:
> > >
> > > Add missing <of_device_id> table for SPI driver relying on SPI
> > > device match since compatible is in a DT binding or in a DTS.
> > >
> >
> > Hey,
> >
> > The driver is under iio, so commit title should be something like:
> >
> > iio: accelerometer: adxl372: declare missing of table
> > or
> > iio: adxl372: declare missing of table
> Okay! It makes sense so, I'll make the changes and send it back as v2.
> I have sent other patches fixing the same issue under iio but with other
> maintainers so, I will follow the same approach.
> >
> > > Before this patch:
> > > modinfo drivers/iio/accel/adxl372_spi.ko | grep alias
> > >
> > > After this patch:
> > > modinfo drivers/iio/accel/adxl372_spi.ko | grep alias
> > > alias:          spi:adxl372
> > > alias:          of:N*T*Cadi,adxl372C*
> > > alias:          of:N*T*Cadi,adxl372
> > >
> > > Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
> > > Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
> > > ---
> > >  drivers/iio/accel/adxl372_spi.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/drivers/iio/accel/adxl372_spi.c b/drivers/iio/accel/adxl372_spi.c
> > > index e14e655..af0624b 100644
> > > --- a/drivers/iio/accel/adxl372_spi.c
> > > +++ b/drivers/iio/accel/adxl372_spi.c
> > > @@ -7,6 +7,8 @@
> > >
> > >  #include <linux/module.h>
> > >  #include <linux/regmap.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_device.h>
> > >  #include <linux/spi/spi.h>
> > >
> > >  #include "adxl372.h"
> > > @@ -37,9 +39,16 @@ static const struct spi_device_id adxl372_spi_id[] = {
> > >  };
> > >  MODULE_DEVICE_TABLE(spi, adxl372_spi_id);
> > >
> > > +static const struct of_device_id adxl372_spi_of_match[] = {
> >
> > The `spi` part of the name is un-needed.
> > So,
> > adxl372_spi_of_match  ->  adxl372_of_match
> > or
> > adxl372_spi_of_match  ->  adxl372_of_table
> >
> >
> > > +        { .compatible = "adi,adxl372" },
> > > +        { },
> > > +};
> > > +MODULE_DEVICE_TABLE(of, adxl372_spi_of_match);
> > > +
> > >  static struct spi_driver adxl372_spi_driver = {
> > >         .driver = {
> > >                 .name = "adxl372_spi",
> > > +               .of_match_table = of_match_ptr(adxl372_spi_of_match),
> >
> > I think the the `of_match_ptr()` is un-needed. It messes with some ACPI stuff.
> >
> > So, something like:
> >     .of_match_table = adxl372_of_table,
> > should be fine.
> Okay, I'll remove it as well but I thought this macro was needed to check if DT
> support is enabled but only if the driver can be compiled as a module.
> So, what's the reason for being unneeded in this case?

There are 2 main mechanisms for configuring a device/board/computer [in Linux].
One is ACPI (mostly driven by Intel & Microsoft) and the other one is
DT (mostly driven by ARM).
Ideally, a driver should work with both.

I'm a bit vague on how ACPI uses this table/information.
I did look through the ACPI code (drivers/acpi) but a lot of the fine
details are unclear to me.
There seems to be some code in there that can parse of_match_table.

In any case, I do remember however that this is some older comment
from other reviews.
i.e. (if possible) do not use of_match_ptr(), because ACPI won't work

btw, a fun read about ACPI on ARM is:
http://www.secretlab.ca/archives/151

Thanks
Alex

> Thanks in advance!
> >
> > Rest looks good
> >
> > Thanks
> > Alex
> >
> > >         },
> > >         .probe = adxl372_spi_probe,
> > >         .id_table = adxl372_spi_id,
> > > --
> > > 2.7.4
> > >
