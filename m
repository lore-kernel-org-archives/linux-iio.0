Return-Path: <SRS0=ELbO=Q4=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9470C43381
	for <linux-iio@archiver.kernel.org>; Thu, 21 Feb 2019 07:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8992D2148D
	for <linux-iio@archiver.kernel.org>; Thu, 21 Feb 2019 07:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FJ42sFKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfBUHAr (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 21 Feb 2019 02:00:47 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37218 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfBUHAr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Feb 2019 02:00:47 -0500
Received: by mail-vs1-f67.google.com with SMTP id y19so2299150vsc.4
        for <linux-iio@vger.kernel.org>; Wed, 20 Feb 2019 23:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q9OR+366B5hz9/K05pp1Ilce+YyZ9pQ17esvkOO9aIU=;
        b=FJ42sFKbiswaF4LEj3/pf7kDORFC4l2c0nvgm+NSQrmWNLtcqtoeWfkEZ36pXsCPmc
         oiLyzioc83Wf/YblpbzuGBk9c3xfIVlI1LCwMQbT/GJyPMR24ne8gbX76h7+ZGGcXF/N
         vPcPm1NWcX9pGtbz2kbDEtLhaWD4q5wX0ZqEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q9OR+366B5hz9/K05pp1Ilce+YyZ9pQ17esvkOO9aIU=;
        b=QrRDnrGzJVxte4nZvDT9EU1RaF0FYoQrLoC7tQnAy8Lhudzl/SM8N41v+zsB+SgwVb
         LqvxWZSXjF2PA3AvNiXklpSeAn5wmSerr+Hf22vOnaEWB5IaIh+2Sy04Avm08u/r8Jyd
         6BgJugWOyxHncxaFaRnMvoTMT2E4ydOrHxiWS5m74qI8UsEjRXwSJmn0kUxkhfUntZhB
         PQeP0sGUDG84538meWjGsirRv86sviGuLGmvclS+CstFNEx1QerKjd+6ghHHZgkf0SZw
         IH85VQRsDFdIqdHQJFBcOIKFt277doBPgXJFSDMKt4k0EduVQ7qanyGMVUFHexTGLQZ6
         mr6Q==
X-Gm-Message-State: AHQUAuZFYru1DUEIoLykfa5V7Czg0hs8gFXznDAvpGQsA4sic3oWAQY8
        oNop96CfHnZDbSAUJKZAEXWQRHrliBI=
X-Google-Smtp-Source: AHgI3IZ9rXTUHbXP9kcWpKGRevX2Korb2GsNQn3aTX2+oRCwS9FgOcy6mQCRaX557t1aAYXnqpXTvg==
X-Received: by 2002:a67:cd93:: with SMTP id r19mr16189152vsl.185.1550732445419;
        Wed, 20 Feb 2019 23:00:45 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id q193sm12457034vsd.0.2019.02.20.23.00.41
        for <linux-iio@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 23:00:42 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id n10so15545464vso.13
        for <linux-iio@vger.kernel.org>; Wed, 20 Feb 2019 23:00:41 -0800 (PST)
X-Received: by 2002:a67:fa45:: with SMTP id j5mr4115107vsq.48.1550732441514;
 Wed, 20 Feb 2019 23:00:41 -0800 (PST)
MIME-Version: 1.0
References: <20190221020633.GA4195@embeddedor>
In-Reply-To: <20190221020633.GA4195@embeddedor>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Feb 2019 23:00:29 -0800
X-Gmail-Original-Message-ID: <CAGXu5jK1fKaSSfHP1dGFyKVjRM7APvqdOhHNjZnN=+An950J1A@mail.gmail.com>
Message-ID: <CAGXu5jK1fKaSSfHP1dGFyKVjRM7APvqdOhHNjZnN=+An950J1A@mail.gmail.com>
Subject: Re: [PATCH] iio: cros_ec_accel_legacy: Refactor code in cros_ec_accel_legacy_probe
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Feb 20, 2019 at 6:06 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Refactor some code in order to fix both the technical implementation
> and the following warnings:
>
> drivers/iio/accel/cros_ec_accel_legacy.c: In function =E2=80=98cros_ec_ac=
cel_legacy_probe=E2=80=99:
> drivers/iio/accel/cros_ec_accel_legacy.c:387:36: warning: this statement =
may fall through [-Wimplicit-fallthrough=3D]
>     ec_accel_channels[X].scan_index =3D Y;
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> drivers/iio/accel/cros_ec_accel_legacy.c:388:3: note: here
>    case Y:
>    ^~~~
> drivers/iio/accel/cros_ec_accel_legacy.c:389:36: warning: this statement =
may fall through [-Wimplicit-fallthrough=3D]
>     ec_accel_channels[Y].scan_index =3D X;
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> drivers/iio/accel/cros_ec_accel_legacy.c:390:3: note: here
>    case Z:
>    ^~~~
>
> Notice that neither the for loop nor the switch statement is needed.
> Also, "state->sign[Y] =3D 1" should be unconditional.
>
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/iio/accel/cros_ec_accel_legacy.c | 27 +++++++++++-------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel=
/cros_ec_accel_legacy.c
> index 063e89eff791..021f9f5cd3bb 100644
> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> @@ -353,7 +353,7 @@ static int cros_ec_accel_legacy_probe(struct platform=
_device *pdev)
>         struct cros_ec_sensor_platform *sensor_platform =3D dev_get_platd=
ata(dev);
>         struct iio_dev *indio_dev;
>         struct cros_ec_accel_legacy_state *state;
> -       int ret, i;
> +       int ret;
>
>         if (!ec || !ec->ec_dev) {
>                 dev_warn(&pdev->dev, "No EC device found.\n");
> @@ -381,20 +381,17 @@ static int cros_ec_accel_legacy_probe(struct platfo=
rm_device *pdev)
>          * Present the channel using HTML5 standard:
>          * need to invert X and Y and invert some lid axis.
>          */
> -       for (i =3D X ; i < MAX_AXIS; i++) {
> -               switch (i) {
> -               case X:
> -                       ec_accel_channels[X].scan_index =3D Y;
> -               case Y:
> -                       ec_accel_channels[Y].scan_index =3D X;
> -               case Z:
> -                       ec_accel_channels[Z].scan_index =3D Z;
> -               }
> -               if (state->sensor_num =3D=3D MOTIONSENSE_LOC_LID && i !=
=3D Y)
> -                       state->sign[i] =3D -1;
> -               else
> -                       state->sign[i] =3D 1;
> -       }
> +       ec_accel_channels[X].scan_index =3D Y;
> +       ec_accel_channels[Y].scan_index =3D X;
> +       ec_accel_channels[Z].scan_index =3D Z;
> +
> +       state->sign[Y] =3D 1;
> +
> +       if (state->sensor_num =3D=3D MOTIONSENSE_LOC_LID)
> +               state->sign[X] =3D state->sign[Z] =3D -1;
> +       else
> +               state->sign[X] =3D state->sign[Z] =3D 1;
> +
>         indio_dev->num_channels =3D ARRAY_SIZE(ec_accel_channels);
>         indio_dev->dev.parent =3D &pdev->dev;
>         indio_dev->info =3D &cros_ec_accel_legacy_info;
> --
> 2.20.1
>


--=20
Kees Cook
