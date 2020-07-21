Return-Path: <SRS0=ZQOz=BA=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB95C433E5
	for <linux-iio@archiver.kernel.org>; Tue, 21 Jul 2020 18:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D994C20717
	for <linux-iio@archiver.kernel.org>; Tue, 21 Jul 2020 18:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPTyck6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbgGUSgh (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 21 Jul 2020 14:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgGUSgh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2020 14:36:37 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CB2C061794;
        Tue, 21 Jul 2020 11:36:37 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a24so11129605pfc.10;
        Tue, 21 Jul 2020 11:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TFr1vDN4Hh+EBFaDQmE/0qvipCEGD4Tgyrl+Pql89Ug=;
        b=MPTyck6s3+BLAH3P9iLxb4mUOWz7Yd55vHXrb13fb6toaKq16WYXT7zGtpLocw/wTR
         AxmCKSaJPVTp7pilVti1TG0oDcJeCF0qiJMNclir0549HL9f6/wQkPA96zAYuYtDse8+
         fA14Rm0dH+kXr11ADjdIU4tr9PVoMHtKNGC85nKBJbY1ito7KoyQOVhF53rBtTZFvI0R
         EcQ4sh1JhCff36ptHzkVkpdE4kn/ZJ8XGBoWT9TKWcGx3I6lOT9BCP07sdKpZ12aG8nn
         CAXFi6DStKtJlke2yP9V4JQzrxPS9wCgCSNKb5NURVhrSFddGK90Mc9xogBZct/JzeEl
         kwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TFr1vDN4Hh+EBFaDQmE/0qvipCEGD4Tgyrl+Pql89Ug=;
        b=YI1vmCIgFm4GEAB7eFLyLdF9EFowmcUH44bqZ3khtWTH8PCTnD+vyVTpIsYEndYHof
         MgHopYrqRJIYq/+wRaN9AL9Jtt157DiupPka62kEQHfC/7tTlKSdrcYRL7oE0p1vyCr6
         Ol2Dl9zdxFAkbWCAkFUygutOwQmR12MQ/yplMIhKilx0gAKuxo98Wp0+7YRIE9JWtUYe
         owvAqBdPZ7119gTMYc4v1zhxFucnujzWv5l0dMz6I+rrscX3X4TMqGpF+Q5WAvvM4GnI
         vi2VVcLHmHriEocxICl65u4zA9KiV3OveqkVz3lM+6+FXA17o3OIl0NU3I8Am1AsvguO
         NO3Q==
X-Gm-Message-State: AOAM531l2ezN8++8lNEhv9dusGPDSJ9DnS98Wai5kzmVFL+lPpgXpGN/
        cTeqlJOEFJxPgwWg26bSo+BeacN2QNyjYBbCF5s=
X-Google-Smtp-Source: ABdhPJwqNx+Y8HNsjbn0fcHC8GbSSXvr8OC3ce1xceaIr2Dqfyf2nwoT/tiQ/2QaI/Z2DzpyaBHua2sXxuTFseyApSY=
X-Received: by 2002:a63:a05f:: with SMTP id u31mr22997684pgn.4.1595356596716;
 Tue, 21 Jul 2020 11:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200720134839.71124-1-alexandru.ardelean@analog.com>
In-Reply-To: <20200720134839.71124-1-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jul 2020 21:36:19 +0300
Message-ID: <CAHp75VfSRUYUaYaHgsr91H9DfV4WeObhzTB3r9UwdNx2tyW6Gg@mail.gmail.com>
Subject: Re: [PATCH] iio: adxl372: change indentation for of_table
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 20, 2020 at 4:49 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> The change is mostly stylistic. The table should be indented with tabs
> instead of spaces.
>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/accel/adxl372_spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/accel/adxl372_spi.c b/drivers/iio/accel/adxl372_spi.c
> index 3ef7e3a4804e..7741890674c1 100644
> --- a/drivers/iio/accel/adxl372_spi.c
> +++ b/drivers/iio/accel/adxl372_spi.c
> @@ -40,8 +40,8 @@ static const struct spi_device_id adxl372_spi_id[] = {
>  MODULE_DEVICE_TABLE(spi, adxl372_spi_id);
>
>  static const struct of_device_id adxl372_of_match[] = {
> -        { .compatible = "adi,adxl372" },
> -        { },
> +       { .compatible = "adi,adxl372" },
> +       { },

Please, drop useless and even bad in very rare cases comma at the
terminator line.

>  };
>  MODULE_DEVICE_TABLE(of, adxl372_of_match);
>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
