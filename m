Return-Path: <SRS0=ocBO=SZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9822FC10F14
	for <linux-iio@archiver.kernel.org>; Tue, 23 Apr 2019 07:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B3E206BA
	for <linux-iio@archiver.kernel.org>; Tue, 23 Apr 2019 07:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+En+PUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfDWH6w (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:58:52 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40755 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWH6w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Apr 2019 03:58:52 -0400
Received: by mail-oi1-f193.google.com with SMTP id k10so42593oik.7
        for <linux-iio@vger.kernel.org>; Tue, 23 Apr 2019 00:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ze/3uJK4bas5sew4U6u+lr9MlTyCRbDM4agWGxx9vZ4=;
        b=T+En+PUegmUasus2Yp5q/sfaRtszlun1Iw2fbhUaQpSkcX98x2cMj6Nvfo95YzuGHg
         EvsR89GKr25TxEQy3+Z7F7T2eds9C4IKnX/3S3Y5iaYcm7PTkLFVDSGcdw+ARB237Xp7
         iBsHejb0Zg1kyYXO9ew/igBGdovsqBjJ0LDsRaCTEcKZs8UgpM9yxJyOM6AC35RAKyiI
         EoR6Xb5ck/yYiF5EBjS63CayFb/WiAuNL/uLjKgQEpHq8QUXtjK/tW0jAVt74eM7HTC/
         XNfwh3Z3/Nyd1T4SUHn0jwXiuHMLRDRsSaW5oEPeL78NwDvQ9czCT2ntUFSrLYVnm2Io
         lTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ze/3uJK4bas5sew4U6u+lr9MlTyCRbDM4agWGxx9vZ4=;
        b=qT7PZj/XY742C400r7DOfVrdmGjE+Cbbwm+2w/Jd/ChDQA4DBesEIMUbJNZBfuL30T
         FdCsoPlla7aSOTiktgt0WbNrcBmwdvkhPshghudoc0tBz3nF+bt+EB7yhhh//2+kcLkA
         IqNX8+VargZN5Fl1h2QDrhYywxZ5HU1aQtcZt/0/iS3kefWmZsXg+0Ypso4xTxN1P0QS
         0t12xRag9Aq3mTM2U3umxKNV8oeoId+LGEbEO0D6eA9CIvgkIyj8SNw3RPqmCvbdfo1v
         njRDMEdR9D06WZuBSeRZyACBNxEzEfVOy6yscxW9+M87qGpgLTgFUwgY6IM9iK8pnmo3
         WZng==
X-Gm-Message-State: APjAAAW0TJ3Ea/dx7qYXXuYrsYqTl1pNN5bwiSyKCfdsASp8NvKRkVhg
        MT+W+5Iex8XCJwEejcZF+JXJUsWKCkbRU4QZShU=
X-Google-Smtp-Source: APXvYqzh05LCBKSZcy1Zphn4chiqFUMtc6LTz9U2WOooM0q1L/kuQIqJB/oN09lyxcEwkwFsXSlJXl+cPWkvkzpX6Sw=
X-Received: by 2002:aca:bdc4:: with SMTP id n187mr945205oif.140.1556006331748;
 Tue, 23 Apr 2019 00:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <1555959916-8207-1-git-send-email-dagmcr@gmail.com>
In-Reply-To: <1555959916-8207-1-git-send-email-dagmcr@gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 23 Apr 2019 10:58:39 +0300
Message-ID: <CA+U=DspEySc2e6+O6bR41My0Sme0oCRH=c9Q16eHTVsJ0cRpvQ@mail.gmail.com>
Subject: Re: [PATCH] spi: AD accelerometer: declare missing of table
To:     Daniel Gomez <dagmcr@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, stefan.popa@analog.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        knaack.h@gmx.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, javier@dowhile0.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 22, 2019 at 10:20 PM Daniel Gomez <dagmcr@gmail.com> wrote:
>
> Add missing <of_device_id> table for SPI driver relying on SPI
> device match since compatible is in a DT binding or in a DTS.
>

Hey,

The driver is under iio, so commit title should be something like:

iio: accelerometer: adxl372: declare missing of table
or
iio: adxl372: declare missing of table

> Before this patch:
> modinfo drivers/iio/accel/adxl372_spi.ko | grep alias
>
> After this patch:
> modinfo drivers/iio/accel/adxl372_spi.ko | grep alias
> alias:          spi:adxl372
> alias:          of:N*T*Cadi,adxl372C*
> alias:          of:N*T*Cadi,adxl372
>
> Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
> Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
> ---
>  drivers/iio/accel/adxl372_spi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/iio/accel/adxl372_spi.c b/drivers/iio/accel/adxl372_spi.c
> index e14e655..af0624b 100644
> --- a/drivers/iio/accel/adxl372_spi.c
> +++ b/drivers/iio/accel/adxl372_spi.c
> @@ -7,6 +7,8 @@
>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/spi/spi.h>
>
>  #include "adxl372.h"
> @@ -37,9 +39,16 @@ static const struct spi_device_id adxl372_spi_id[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, adxl372_spi_id);
>
> +static const struct of_device_id adxl372_spi_of_match[] = {

The `spi` part of the name is un-needed.
So,
adxl372_spi_of_match  ->  adxl372_of_match
or
adxl372_spi_of_match  ->  adxl372_of_table


> +        { .compatible = "adi,adxl372" },
> +        { },
> +};
> +MODULE_DEVICE_TABLE(of, adxl372_spi_of_match);
> +
>  static struct spi_driver adxl372_spi_driver = {
>         .driver = {
>                 .name = "adxl372_spi",
> +               .of_match_table = of_match_ptr(adxl372_spi_of_match),

I think the the `of_match_ptr()` is un-needed. It messes with some ACPI stuff.

So, something like:
    .of_match_table = adxl372_of_table,
should be fine.

Rest looks good

Thanks
Alex

>         },
>         .probe = adxl372_spi_probe,
>         .id_table = adxl372_spi_id,
> --
> 2.7.4
>
