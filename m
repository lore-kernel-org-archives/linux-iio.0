Return-Path: <SRS0=ocBO=SZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D819C10F03
	for <linux-iio@archiver.kernel.org>; Tue, 23 Apr 2019 19:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB9C21773
	for <linux-iio@archiver.kernel.org>; Tue, 23 Apr 2019 19:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQxo4w+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbfDWTzq (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:55:46 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33469 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWTzq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Apr 2019 15:55:46 -0400
Received: by mail-vs1-f67.google.com with SMTP id s11so9048047vsn.0
        for <linux-iio@vger.kernel.org>; Tue, 23 Apr 2019 12:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lNjYSr3hAEJuV64jfY0akeXFW5lP/jJpjgNXO8Ik2EI=;
        b=hQxo4w+5jVPwIbKCxbL8somncCnUOS5Vf//dzuVUAdNRMLMH4V4qT+IH1kpNlFjN5F
         vEL5ymjPXn8HQ2riFzYzrimL0Ae8g11al+uLhLDGQyLpuFywq175XObGL4U+44J7n7KH
         oiCe19rrImuX+vJVFn+tXXTCxUNyjNpiRA+Z0F9onNf9N0pfi6QhgFI6rAn2hM/7fqdk
         4q6tEMLeO2VZWp7FYOmwqLC7KyU7gRqxsAG/22Ilhx9L5dufrUZf98vV4kys3LNu07qk
         s8B/BPTWpLn5HrxynbxpslL8Z986GAUB/lcxxyyIA1QcsIK4SuNvKEQvZ0SVffolDi+n
         hj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lNjYSr3hAEJuV64jfY0akeXFW5lP/jJpjgNXO8Ik2EI=;
        b=qk9+d/q3qJ3JDCW69b5LG+wvhYQKa9O6FqbvhbVlGiYcgjwQ5+ekYSp4IxbmLTSwAQ
         n3NAyFScze0xkSAJgtmiYBVxY5JuKiK9f7PEH8Mo76BlSl/ff47RXDn0MYi/j9kiyz/j
         UCN6ecUDsRtO/RWjcr57c4ea6SdreGoiu8n9bK9EFvgEqAfTUOomXn/+8WbUQpEGD3oI
         SA3n1B6StFMPDN0L31S3Fds3OS8MRdDGLE7cNeS8iHsiE1O/LxAGXu9ImAsbkmoaGk60
         USAvcVYGidr2suJ9GvMoOvJQzwti8E4fd7wiSBto5/yywU7prfggr4wc5eaNz3s559l1
         m5Fg==
X-Gm-Message-State: APjAAAUC43Hf0fv3cuj22/8Ip2r9892aiSFgsJinrB/9dFS1PEjAN+ac
        9vNN3ph45pHSYFtZEakHw7SH4564zI9OjCA3hFI=
X-Google-Smtp-Source: APXvYqzBAQk9OVVj+Q2lQnRw2PZjRyquW6DnlrnVPty6AjqZ63ADNvFDOFjuYYgiMnyzHIOZ/L9+KC3cP/OC22ddgsw=
X-Received: by 2002:a05:6102:25a:: with SMTP id a26mr14656394vsq.187.1556049345002;
 Tue, 23 Apr 2019 12:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <1555959916-8207-1-git-send-email-dagmcr@gmail.com> <CA+U=DspEySc2e6+O6bR41My0Sme0oCRH=c9Q16eHTVsJ0cRpvQ@mail.gmail.com>
In-Reply-To: <CA+U=DspEySc2e6+O6bR41My0Sme0oCRH=c9Q16eHTVsJ0cRpvQ@mail.gmail.com>
From:   Daniel G <dagmcr@gmail.com>
Date:   Tue, 23 Apr 2019 21:55:33 +0200
Message-ID: <CAPsT6h=CQV07V2S8j07ZzLKNuAbM0q9xOCqSqb4BrdXaKcjX6A@mail.gmail.com>
Subject: Re: [PATCH] spi: AD accelerometer: declare missing of table
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
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

On Tue, Apr 23, 2019 at 9:58 AM Alexandru Ardelean
<ardeleanalex@gmail.com> wrote:
>
> On Mon, Apr 22, 2019 at 10:20 PM Daniel Gomez <dagmcr@gmail.com> wrote:
> >
> > Add missing <of_device_id> table for SPI driver relying on SPI
> > device match since compatible is in a DT binding or in a DTS.
> >
>
> Hey,
>
> The driver is under iio, so commit title should be something like:
>
> iio: accelerometer: adxl372: declare missing of table
> or
> iio: adxl372: declare missing of table
Okay! It makes sense so, I'll make the changes and send it back as v2.
I have sent other patches fixing the same issue under iio but with other
maintainers so, I will follow the same approach.
>
> > Before this patch:
> > modinfo drivers/iio/accel/adxl372_spi.ko | grep alias
> >
> > After this patch:
> > modinfo drivers/iio/accel/adxl372_spi.ko | grep alias
> > alias:          spi:adxl372
> > alias:          of:N*T*Cadi,adxl372C*
> > alias:          of:N*T*Cadi,adxl372
> >
> > Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
> > Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
> > ---
> >  drivers/iio/accel/adxl372_spi.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/iio/accel/adxl372_spi.c b/drivers/iio/accel/adxl372_spi.c
> > index e14e655..af0624b 100644
> > --- a/drivers/iio/accel/adxl372_spi.c
> > +++ b/drivers/iio/accel/adxl372_spi.c
> > @@ -7,6 +7,8 @@
> >
> >  #include <linux/module.h>
> >  #include <linux/regmap.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> >  #include <linux/spi/spi.h>
> >
> >  #include "adxl372.h"
> > @@ -37,9 +39,16 @@ static const struct spi_device_id adxl372_spi_id[] = {
> >  };
> >  MODULE_DEVICE_TABLE(spi, adxl372_spi_id);
> >
> > +static const struct of_device_id adxl372_spi_of_match[] = {
>
> The `spi` part of the name is un-needed.
> So,
> adxl372_spi_of_match  ->  adxl372_of_match
> or
> adxl372_spi_of_match  ->  adxl372_of_table
>
>
> > +        { .compatible = "adi,adxl372" },
> > +        { },
> > +};
> > +MODULE_DEVICE_TABLE(of, adxl372_spi_of_match);
> > +
> >  static struct spi_driver adxl372_spi_driver = {
> >         .driver = {
> >                 .name = "adxl372_spi",
> > +               .of_match_table = of_match_ptr(adxl372_spi_of_match),
>
> I think the the `of_match_ptr()` is un-needed. It messes with some ACPI stuff.
>
> So, something like:
>     .of_match_table = adxl372_of_table,
> should be fine.
Okay, I'll remove it as well but I thought this macro was needed to check if DT
support is enabled but only if the driver can be compiled as a module.
So, what's the reason for being unneeded in this case?
Thanks in advance!
>
> Rest looks good
>
> Thanks
> Alex
>
> >         },
> >         .probe = adxl372_spi_probe,
> >         .id_table = adxl372_spi_id,
> > --
> > 2.7.4
> >
