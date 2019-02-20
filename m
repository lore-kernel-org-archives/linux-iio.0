Return-Path: <SRS0=QBqV=Q3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D252C43381
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 18:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7331A20838
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 18:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nhqu5q/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfBTSUz (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:20:55 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46567 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfBTSUy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Feb 2019 13:20:54 -0500
Received: by mail-vs1-f66.google.com with SMTP id n10so14526940vso.13
        for <linux-iio@vger.kernel.org>; Wed, 20 Feb 2019 10:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VUU1T+vuYO12a2cKI5zt86WTM2zYaN6mxHhWTPZosm0=;
        b=Nhqu5q/KXoMlA03l4AfDe0kVGindGn0EpAZPZt5hGT3Ata1iMGpt2VlYz8d1xxXQ6d
         KJtmdOwfhECihW/nHnUAfJPAQVDQMw2+P9dj5hbyRoCVpwsiiDiTXoHQKPrmYKQTgL29
         gKxdz941pGWMN4xMdanXlLJPdI9Jx/faG9veE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VUU1T+vuYO12a2cKI5zt86WTM2zYaN6mxHhWTPZosm0=;
        b=DpKmJuTCqhHGbK4w/sPrfFJCFWTBToG/T8YxGkU7jnNYKMjd08rdBkKOVeL3FvpKy1
         Jxsw1LKKozRjEGfc0pwWj606IPcoKiiln6DPhU5PzArWW0kXOdW/kCHEsPd7EofWRjPX
         vkRhZOCriCk1iz4dCqlDOejGxJx1SN5NKUsckS3GB6t81CDzqL9c5opZbMCbnS/3P7PO
         /N3yOuGdtmnje2f0OhKZiMl2FfkaEZr1+jKVqorF9dfDzdeKvlxtCE/TRZBtChxeET2Z
         6dCJdwFhvWbUkYcwIuB4MbajnNwC3hbsPZGpWZPMm2v7x8nM/n98ZlYAxd4dz5dSiLI0
         ePpQ==
X-Gm-Message-State: AHQUAuZJInphQHXbKnG4R32np/qptbmchJ3/BV4tFbCK7WmRSB8ALYZ8
        R53JZuIaDj2Ds1qWo9W96B9lfvEm294=
X-Google-Smtp-Source: AHgI3IbYnD5XbD42ubfEaRt5vMlbAZ/jRjgVbUqH/YytVwzdc+3aF6sR0KXFXhYswCfj5BF5yCgTVg==
X-Received: by 2002:a67:c415:: with SMTP id c21mr936628vsk.100.1550686853220;
        Wed, 20 Feb 2019 10:20:53 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id d73sm3150709vsc.1.2019.02.20.10.20.52
        for <linux-iio@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 10:20:52 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id t13so14558210vsk.3
        for <linux-iio@vger.kernel.org>; Wed, 20 Feb 2019 10:20:52 -0800 (PST)
X-Received: by 2002:a67:6f44:: with SMTP id k65mr17619777vsc.222.1550686851781;
 Wed, 20 Feb 2019 10:20:51 -0800 (PST)
MIME-Version: 1.0
References: <20181008172332.GA29816@embeddedor.com>
In-Reply-To: <20181008172332.GA29816@embeddedor.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Feb 2019 10:20:39 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLsQ_Uc4kp=md2SrOERopjZmnQK_fAsru4MQUqEHRvEeA@mail.gmail.com>
Message-ID: <CAGXu5jLsQ_Uc4kp=md2SrOERopjZmnQK_fAsru4MQUqEHRvEeA@mail.gmail.com>
Subject: Re: [PATCH] iio: cros_ec_accel_legacy: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 8, 2018 at 10:24 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Addresses-Coverity-ID: 1397962 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/iio/accel/cros_ec_accel_legacy.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> index 063e89e..d609654 100644
> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> @@ -385,8 +385,10 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
>                 switch (i) {
>                 case X:
>                         ec_accel_channels[X].scan_index = Y;
> +                       /* fall through */
>                 case Y:
>                         ec_accel_channels[Y].scan_index = X;
> +                       /* fall through */
>                 case Z:
>                         ec_accel_channels[Z].scan_index = Z;
>                 }

Shouldn't these actually be "break;"s ? It seems like the loop is
stepping through X, Y, and Z. The _result_ is accidentally the same:

X: set X, Y, and Z
Y: set Y and Z
Z: set Z

result: X, Y, and Z are set correctly. But the code is technically wrong.


-- 
Kees Cook
