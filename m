Return-Path: <SRS0=/rIq=QF=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83505C169C4
	for <linux-iio@archiver.kernel.org>; Tue, 29 Jan 2019 08:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EA420844
	for <linux-iio@archiver.kernel.org>; Tue, 29 Jan 2019 08:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVCGf4Vb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfA2Ick (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:32:40 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45848 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfA2Ick (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Jan 2019 03:32:40 -0500
Received: by mail-oi1-f195.google.com with SMTP id y1so15428310oie.12
        for <linux-iio@vger.kernel.org>; Tue, 29 Jan 2019 00:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0kooBdsDJ8beSmzMmXF9YQfA1Oe+Rq/boaot15Jcaro=;
        b=XVCGf4VbBlEj6Hx4AjIERfMEocwP7e6Wc/vERZgWVWUXHJqwqwXvKXZKpD+uoChjdx
         zJfFrrXUV12Qf2wTyUl46HQeOZlnuNpjYV/As+sgtPPnpV8a9RX0jbx6YoYSozpIrIgY
         iJVyrEGRudNYYk7xDSOrGZryhuhWppZRBfU65N0Eyye0piIY/cYD8AcRFhDh0GTxKhRM
         IePRFmhqx1fivyJIek3XVbqERroFinXAwvSWcowQQ1QqedvM2na4uEv2cbjoEh0P2tPm
         V63h3IHVqOGjWhjs/p3IplbyTNISXzAG/DGlFLWKR5TE6HNENtrNzab8pVM5It4FKQue
         Ed1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0kooBdsDJ8beSmzMmXF9YQfA1Oe+Rq/boaot15Jcaro=;
        b=Fy3W6UO0KXQbmP6CTVnoAv5X27KIelqbmiHEF+K5OJObNbGEIXENLbenyW3cHezaDf
         dwb6SsRqeznMz3mUpqDoj8teTNxsmiwmmlpa9gswX5tIICBhoINsn/AXwiyuMInZazam
         /233/nohWSNPiId9GNUE2UK0RtaCPbb5SexhDQGSnLN+w5aYbOJFW5/Xim6ZZBBHb8Rb
         4CpksvvC73UIdcAo4yheopjbCnmQfJRe3f16pokUkhCp5rjLgUPjbXaESwy4ivmuma+O
         phShiEUGbxCNsMe1QCJOhbsBfBeRPpcHvcnQu446+P/OgYlnxXlBTuRInGPTeFnf1enG
         PoAQ==
X-Gm-Message-State: AHQUAuY0vxwGGIAEaTAMTOvMea3r8vxfFJw/etLin/3KtbACEWaDaSY0
        smVozu5qKF9fHwtYLi2lXSp1QPVoabn/wPLK9Uo=
X-Google-Smtp-Source: AHgI3IbyYn3yVlSfkC4uSBDtRTewPeTwRS7RPCf0Pcx4SWh+uuVsXAIQspCNfRbSyBMUlVJ1eALUU9GQTp80IjPykZA=
X-Received: by 2002:aca:58d7:: with SMTP id m206mr8948612oib.140.1548750759526;
 Tue, 29 Jan 2019 00:32:39 -0800 (PST)
MIME-Version: 1.0
References: <1548743212-83787-1-git-send-email-preid@electromag.com.au>
In-Reply-To: <1548743212-83787-1-git-send-email-preid@electromag.com.au>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 29 Jan 2019 10:32:28 +0200
Message-ID: <CA+U=Dso+_dn4mEew5y62nGg8AmEABOCnV9aFgHvQV9WsM0enrA@mail.gmail.com>
Subject: Re: [PATCH 1/1] iio: core: Improve precision of __iio_format_value
 for FRACTIONAL values
To:     Phil Reid <preid@electromag.com.au>
Cc:     Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        lars@metafoo.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 29, 2019 at 8:28 AM Phil Reid <preid@electromag.com.au> wrote:
>
> Currently FRACTIONAL values are outputed with 9 digits after the decimal
> place. This is not always sufficient to resolve the raw value with 1 bit.
> Output FRACTIONAL values to 15 decimal places of precision, regardless
> of the number of leading zeros.
>
> Currently for a 2.5V ref with 24 bits of precision the code outputs only
> to 9 decimal places.
>
> Cur: 0.00014901100000000000 * 16777216 = 2499.989733
> New: 0.00014901161193847600 * 16777216 = 2500.000000
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>
> Notes:
>     Alternatively I could add additonal FRACTIONAL types that select the new
>     behaviour to prevent any possible regressions.
>
>  drivers/iio/industrialio-core.c | 55 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 46 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index a062cfd..bd9da64 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -571,11 +571,53 @@ int of_iio_read_mount_matrix(const struct device *dev,
>  #endif
>  EXPORT_SYMBOL(of_iio_read_mount_matrix);
>
> +static ssize_t __iio_format_div_prec(char *buf, unsigned int len, s64 x, s32 y)
> +{
> +       unsigned int prec = 0;
> +       unsigned int idx = 0;
> +       s64 d;
> +
> +       if (!len)
> +               return 0;
> +
> +       if (!y)
> +               return snprintf(buf, len, "inf");
> +
> +       if (!x)
> +               return snprintf(buf, len, "0");
> +
> +       if (((x > 0) && (y < 0)) || ((x < 0) && (y > 0))) {
> +               buf[idx++] = '-';
> +               x = x > 0 ? x : -x;
> +               y = y > 0 ? y : -y;
> +       }
> +
> +       d = div64_s64(x, y);
> +       idx += snprintf(buf+idx, len-idx, "%d", (int)d);
> +       x = x - (y * d);
> +       if ((x != 0) && (idx < len-1)) {
> +               buf[idx++] = '.';
> +               x = x * 10;
> +               d = div64_s64(x, y);
> +
> +               while ((idx < len-1) && (prec < 15)) {
> +                       if (d || prec)
> +                               prec++;
> +                       buf[idx++] = '0' + (char)d;
> +                       x = x - (y * d);
> +                       if (!x)
> +                               break;
> +                       x = x * 10;
> +                       d = div64_s64(x, y);
> +               }
> +               buf[idx] = 0;
> +       }
> +       return idx;
> +}
> +
>  static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
>                                   int size, const int *vals)
>  {
> -       unsigned long long tmp;
> -       int tmp0, tmp1;
>         bool scale_db = false;
>
>         switch (type) {
> @@ -598,14 +640,9 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
>                 else
>                         return snprintf(buf, len, "%d.%09u", vals[0], vals[1]);
>         case IIO_VAL_FRACTIONAL:
> -               tmp = div_s64((s64)vals[0] * 1000000000LL, vals[1]);
> -               tmp1 = vals[1];
> -               tmp0 = (int)div_s64_rem(tmp, 1000000000, &tmp1);
> -               return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
> +               return __iio_format_div_prec(buf, len, vals[0], vals[1]);

Maybe I'm a bit naive, but I'm also a bit curious.
If you just bump the numbers here, would it work the same ?

i.e.   10^9 -> 10^15 and "snprintf(buf, len, "%d.%15u", tmp0, abs(tmp1));"

But in any case, what would be interesting now, is to extend the IIO
core logic to provide [somehow] a precision number, default being 9.
This could probably be specified on per-channel basis [somehow],
similar to other channel params.

So, for example in the default case, if you have "uint32_t precision =
9", you would have the same behavior, with something like

      tmp = div_s64((s64)vals[0] * pow_of_10(precision), vals[1]);
      tmp1 = vals[1];
      tmp0 = (int)div_s64_rem(tmp, pow_of_10(precision), &tmp1);
      return snprintf(buf, len, "%d.%" precision "u", tmp0, abs(tmp1));

Obviously, the above code is just pseudo-code, where pow_of_10()
multiplies 10 a "precision" number of times, and the snprintf() would
need a temporary buffer to create a format string, which then would be
used.

Thanks
Alex

>         case IIO_VAL_FRACTIONAL_LOG2:
> -               tmp = shift_right((s64)vals[0] * 1000000000LL, vals[1]);
> -               tmp0 = (int)div_s64_rem(tmp, 1000000000LL, &tmp1);
> -               return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
> +               return __iio_format_div_prec(buf, len, vals[0], 1 << vals[1]);
>         case IIO_VAL_INT_MULTIPLE:
>         {
>                 int i;
> --
> 1.8.3.1
>
