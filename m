Return-Path: <SRS0=XRxs=YG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6A0C4360C
	for <linux-iio@archiver.kernel.org>; Sun, 13 Oct 2019 19:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD1120663
	for <linux-iio@archiver.kernel.org>; Sun, 13 Oct 2019 19:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="ewaIElaN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbfJMTMw (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 13 Oct 2019 15:12:52 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35836 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbfJMTMw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Oct 2019 15:12:52 -0400
Received: by mail-io1-f67.google.com with SMTP id q10so33110351iop.2
        for <linux-iio@vger.kernel.org>; Sun, 13 Oct 2019 12:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x4avXQhSVtpftvb52RPMowWelQdJvkNIuK7sUV2Mo30=;
        b=ewaIElaNBJUcaNQF+t+KOfuu5mXF4Wl0k13AG9ZgfOMGAtAr/WPh2BqEGZIuX32pZT
         4Kcab52/pbSPU6gpUGW3flfsjMMmOBFdlsZdI4leXUvgibhkKFQVvf/Uy9Eo9+//mZUg
         46zfDnZwx2ywSzvxQ4ZI13UoWprEnsGyYFw04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x4avXQhSVtpftvb52RPMowWelQdJvkNIuK7sUV2Mo30=;
        b=PdnvyNMmV4vZcyKrYHe1l1YNT5x/VJUzRv11BygD/9NDQKX7ybENgHfkIe6vqNpKXg
         1lBywyWIepUlcdD7ebCvGbOHVTqsG8TBxYLMddTTI1qe1lKTL0Bfxcbz5rRXUFGVMhwh
         6TpHWc3UrBdbZ889dioofqwi7I6eKPNuC41wWWmdNtPbbiHrQom65RLLvMLahSMS6RFP
         I9dIOR8fy9LUnwgTLtamKiAzmCI0u0oBtreAXk7hxYk40Ud9x2/75AfpviYgNerY0O2D
         ejmvGlkMaqqcky2t+1yFaZUvgWhMJvmfLZH9iPWiVuL3MeB9/CztgoLVlWVp+lPdMeUt
         WgmA==
X-Gm-Message-State: APjAAAWRb/kgldQW67ctV/BiKXTNvGblXdLRBsF8gBZ/F8PKoKE6t+un
        Xadx3YM1kXpobb8SgkGV5ipL+4zJ4+7hy8lk/f2vug==
X-Google-Smtp-Source: APXvYqwZt7ZcHZLfyBBUZu9nb6LQCYPuKnEQgdDc1oloIN4ms0b3pRCy/9ltL8G6Fq5sEO4iArEFeW/MVExbG3yHESA=
X-Received: by 2002:a5d:8483:: with SMTP id t3mr10209803iom.87.1570993971791;
 Sun, 13 Oct 2019 12:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191013181013.2399842-1-jic23@kernel.org>
In-Reply-To: <20191013181013.2399842-1-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sun, 13 Oct 2019 22:12:40 +0300
Message-ID: <CAJCx=g=EABNtJ8FBda0ty4cM+HstuQda_ChTf0vEajdW7opLoQ@mail.gmail.com>
Subject: Re: [PATCH] iio: temp: maxim thermocouple: Drop unneeded semi colon.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 13, 2019 at 9:12 PM <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Identified by coccinelle
>
> CHECK   drivers/iio/temperature/maxim_thermocouple.c
> drivers/iio/temperature/maxim_thermocouple.c:197:3-4: Unneeded semicolon
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
>  drivers/iio/temperature/maxim_thermocouple.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
> index 2ab68282d0b6..d1360605209c 100644
> --- a/drivers/iio/temperature/maxim_thermocouple.c
> +++ b/drivers/iio/temperature/maxim_thermocouple.c
> @@ -194,7 +194,7 @@ static int maxim_thermocouple_read_raw(struct iio_dev *indio_dev,
>                 default:
>                         *val = 250; /* 1000 * 0.25 */
>                         ret = IIO_VAL_INT;
> -               };
> +               }
>                 break;
>         }
>
> --
> 2.23.0
>
