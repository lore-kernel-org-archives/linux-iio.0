Return-Path: <SRS0=Wwjn=OY=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D071CC43387
	for <linux-iio@archiver.kernel.org>; Sat, 15 Dec 2018 08:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999D62086D
	for <linux-iio@archiver.kernel.org>; Sat, 15 Dec 2018 08:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vb538PZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbeLOIZK (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 15 Dec 2018 03:25:10 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46159 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729192AbeLOIZJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Dec 2018 03:25:09 -0500
Received: by mail-yw1-f67.google.com with SMTP id t13so3277746ywe.13;
        Sat, 15 Dec 2018 00:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qz/8JOStxRJlbEjAAjdKoOPLyBWqzSHI8B4/eilY2ng=;
        b=vb538PZVrWVh7ai9xV0b/0JOLYh4+jRaTMG9JNDP+dwmNucIIBO5QoID+vK+yvZn4V
         /HIa67+wPbXzVCVBuyhe7Pu+lYb/QFg6x75ttNuIGtxdWikIpzjg5U8uOOAtRkI99khq
         wcEXUC7YtVOwXmB9VFpkYME1BDHZGFCMEYvF32+OMzukCXa7ptDRWNrb3IBq2JnipVMW
         bkj3tIuuGvC5xTWJSCExRIe0CYY6FXqCX1dr3G0awgIgUqxWVl0qFUBL/F++L2txupyL
         uZfBcTt223clqbei47wEFz6SIlQ3tfSLBbNKUdDM2zD4BWEE+rX/KogD3nrsRTd8vkUm
         C39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qz/8JOStxRJlbEjAAjdKoOPLyBWqzSHI8B4/eilY2ng=;
        b=LlNiueujIjPYhEuf9Tv653PQxFsYjr9PUVdHWyeAZGShUW+Hts1rfmjQgNa69fjqaY
         ImJgAqQcEnF5wQ6Mf/C8g95mA7iEcsfCnZZ6BqV0Qg3PH1Lii9NY9xqpchecENeHOBsa
         g1MS3Ey8DmFtLqBXXHChKIWU1zNqsKkL1Lvf+wcUqlJQduJpltrzS8/9gKdMY4/0MrD3
         bre2FU1sZre3wziJbKZDiR0H840TCn87uItt4iyqRStyhw6WlQnrtlp9Zw2r7xTB5tp9
         Zrb8RSzsvzjI3IPTQNvXb+Ju1qKNY3o+1bxcy1iAHZ/AB2zpv2Y8C3mzjiGjAf51PzRl
         oZpA==
X-Gm-Message-State: AA+aEWbeXCXV9goYYIoJPIQ1HPBZUx/t+biOh0op311+/dLnVqhzvUiY
        Kcx+dsnEZENhP0fbPplu80lk6hgAH//hm3RBFYI=
X-Google-Smtp-Source: AFSGD/U8zOvcj0IIdUg4keuRxY5ik40s59nCvL0QhAlDWxhigP6HjMD5qujENQf5Q0lAVO/kGYksl2Wl/V+yCHlLl9w=
X-Received: by 2002:a0d:d9d2:: with SMTP id b201mr2100619ywe.318.1544862308060;
 Sat, 15 Dec 2018 00:25:08 -0800 (PST)
MIME-Version: 1.0
References: <1544855484-154231-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1544855484-154231-1-git-send-email-yuehaibing@huawei.com>
From:   Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date:   Sat, 15 Dec 2018 09:24:57 +0100
Message-ID: <CAA2SeN+6eNer_tMdC97LCuvVN+LqQGFAZidA_O6Ot86XASKfTA@mail.gmail.com>
Subject: Re: [PATCH -next] iio: imu: st_lsm6dsx: remove set but not used
 variable ''
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c: In function 'st_lsm6dsx_shub_read_reg':
> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:108:41: warning:
>  variable 'hub_settings' set but not used [-Wunused-but-set-variable]
>
> It never used since introduction in commit c91c1c844ebd ("iio: imu: st_lsm6dsx:
> add i2c embedded controller support")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> index 8e47dcc..66fbcd9 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -105,12 +105,10 @@ static void st_lsm6dsx_shub_wait_complete(struct st_lsm6dsx_hw *hw)
>  static int st_lsm6dsx_shub_read_reg(struct st_lsm6dsx_hw *hw, u8 addr,
>                                     u8 *data, int len)
>  {
> -       const struct st_lsm6dsx_shub_settings *hub_settings;
>         int err;
>
>         mutex_lock(&hw->page_lock);
>
> -       hub_settings = &hw->settings->shub_settings;
>         err = st_lsm6dsx_set_page(hw, true);
>         if (err < 0)
>                 goto out;
>
>
>
Acked-by: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
