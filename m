Return-Path: <SRS0=DXgW=ED=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB139C55179
	for <linux-iio@archiver.kernel.org>; Wed, 28 Oct 2020 23:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E69E20759
	for <linux-iio@archiver.kernel.org>; Wed, 28 Oct 2020 23:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="LVdDIlVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbgJ1XAR (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389913AbgJ1XAP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Oct 2020 19:00:15 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68587C0613CF
        for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2020 16:00:15 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id y20so1314684iod.5
        for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2020 16:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XegyVj+nKJZySlbg1aooffXXRVjlzMTjgACCsCZVjV8=;
        b=LVdDIlVnTSe5M3cOXfDKY/yoHCuAgiUhVYAKweEXnCXPK98JcwHeT6d1J7q4C5B/Zs
         kGek2AzWNEygiKEITXCTOoypC79xAnu5RB2xxnLYJ2CjrJGQ1J+7A/3cdQ+jNOcYNt5W
         dEtAZZ6qEGLyUT/hqdxLKve8EzhULmUA7HN5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XegyVj+nKJZySlbg1aooffXXRVjlzMTjgACCsCZVjV8=;
        b=ChJqYxAXX0CxKp3EscOiwD8ulNazQHTMxRecXkvaYuUW1SezmPy4VAX1ITRWxsN2ft
         oMELd5NzxqEfGU6olsZGt/BBy4Q7Naq/wQ0R3badDhVn/aYDoYW2RBbyXfUVrtoTv65G
         hBkWX+GFr+o4jYYhPgw4pcfI4iWo7sVCE2Mc8cV6hL1PWd+IONs2gw3912tgBg7+KEzW
         8SYwLx93N+eTQGiCJnTohiIrW44w/1RLuYPkXq3VhBCDl6LElGIRPufiPlPJ4K/zZWkV
         oLsWIQi5YiW6qmkSgQrqFRLDmcRX1/Gn+Qyrmu/9lOgQeXpXfzIbxlB7H236Zc95CaTw
         TEzg==
X-Gm-Message-State: AOAM530yfJ0jx1Cx2ePBhy7hjX+fhLZanbJTlcMWIZNE7RK6R8IE/0Cs
        +g0kizJJ7iC4n7cOF2iXIp5v9e29UjCg5CnbOT+IOs+ZpMfQxw==
X-Google-Smtp-Source: ABdhPJxZQ0BHtn1iP9Sa96xmeiH3d9xkjNIwwbKTU26Ow70h5eYTCHXvJ5Q2a5LLSTo886NZ9Q62P1+bQ7EjNgyE1Oo=
X-Received: by 2002:a05:6e02:c:: with SMTP id h12mr4681231ilr.177.1603859788644;
 Tue, 27 Oct 2020 21:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201027201436.1597726-1-trix@redhat.com>
In-Reply-To: <20201027201436.1597726-1-trix@redhat.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Tue, 27 Oct 2020 21:36:17 -0700
Message-ID: <CAJCx=g=zFHVevqtmHtP_MJS481aypAGB5PMMdsXdCNB_ZiPwoA@mail.gmail.com>
Subject: Re: [PATCH] iio: light: apds9960: remove unneeded semicolon
To:     trix@redhat.com
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 27, 2020 at 1:14 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> A semicolon is not needed after a switch statement.
>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/iio/light/apds9960.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index 9afb3fcc74e6..547e7f9d6920 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -561,7 +561,7 @@ static int apds9960_write_raw(struct iio_dev *indio_dev,
>                 }
>         default:
>                 return -EINVAL;
> -       };
> +       }
>
>         return 0;
>  }
> --
> 2.18.1
>
