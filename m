Return-Path: <SRS0=1vwA=SU=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F25C10F0E
	for <linux-iio@archiver.kernel.org>; Thu, 18 Apr 2019 23:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E3D21479
	for <linux-iio@archiver.kernel.org>; Thu, 18 Apr 2019 23:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="qoAE+0Wa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfDRXYC (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 18 Apr 2019 19:24:02 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33161 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfDRXYC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Apr 2019 19:24:02 -0400
Received: by mail-io1-f66.google.com with SMTP id b6so3271114iog.0
        for <linux-iio@vger.kernel.org>; Thu, 18 Apr 2019 16:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nYnjpbYIMxNLgPvwoxMtw7pWJw8b1tMjbX+F/ysjFc4=;
        b=qoAE+0Wa17POtFqv+4fJDrbB5jBS8MNmXgD5r82vEX7dy4nC+V6dpsX28bMbT4a2Yp
         9ra60l1BE5PvfQZjJHoo6U/JYkNDdmbIwkNzkwBiLMrxgAZXY70JgtioR3sXfQVYpCiN
         mlBDWjE/fAbhwgm2IaWEhK0DgJvn8laRqhqfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nYnjpbYIMxNLgPvwoxMtw7pWJw8b1tMjbX+F/ysjFc4=;
        b=XeC6Oq2gQNqFHSx+HkfqbrK7HzNCAtxw+T4fMhQRsAhaRFOLf5TRKo6eUUxboDtu7h
         f2xrY6BDQLvqbK5+JVqPymBqkGvtPl5OOJapD60557Fz/zZywxCL/3GW6rOglV+zvfZQ
         rLwXSfedAAkgDbAv9RLqYp1i3DIAx6A1jhyI1JExQd3O9rwpb9/9VlZ/8uK/BSPWqiAu
         32ZoMn5E4PJbsv3ZAXNIFkxRj7gKYFftq3468fIkE6EzqTgds5zpiasb5FV3nWDHUrbQ
         5COuNkC+kMTGvxxaykV7cvZjJT+NS63O64hyoOL0LLhj/Y/dtUiG7QhS6oL7hU60Rf15
         cabw==
X-Gm-Message-State: APjAAAW4cTkuOMwtYVGJQ4J0w0VbiLK525dnFrcwCKHT9E4/wglGJu1Y
        PDg/RPSIx+jBUcY/0G8svss+fCYsM6D4176+VTcoaA==
X-Google-Smtp-Source: APXvYqzJSMPZoVqHWxB/rrLHTWGRZBbREhfa+XWc2dlrDl5GhW9qka6R/0BuNpknkxKA90uUINfodzlmDxZaV+0GN/U=
X-Received: by 2002:a6b:b454:: with SMTP id d81mr681469iof.109.1555629841879;
 Thu, 18 Apr 2019 16:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <1555524925-15450-1-git-send-email-mohankumar718@gmail.com>
In-Reply-To: <1555524925-15450-1-git-send-email-mohankumar718@gmail.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Thu, 18 Apr 2019 16:23:51 -0700
Message-ID: <CAJCx=gmi6=uXbydpE2gY2x-XijtAd=bfufoJ+gbO1KU1n++g3Q@mail.gmail.com>
Subject: Re: [PATCH] drivers: iio: proximity: This patch fix the following
 checkpatch warning.
To:     Mohan Kumar <mohankumar718@gmail.com>
Cc:     Andreas Klinger <ak@it-klinger.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

See comments inline

On Wed, Apr 17, 2019 at 11:15 AM Mohan Kumar <mohankumar718@gmail.com> wrote:
>
> As per Documentation/timers/timers-howto.txt Msleep < 20ms can sleep for
> up to 20ms. so use usleep_range.
>
> Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
> ---
>  drivers/iio/proximity/mb1232.c | 2 +-
>  drivers/iio/proximity/srf08.c  | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/proximity/mb1232.c b/drivers/iio/proximity/mb1232.c
> index 166b3e6..74f7eae 100644
> --- a/drivers/iio/proximity/mb1232.c
> +++ b/drivers/iio/proximity/mb1232.c
> @@ -81,7 +81,7 @@ static s16 mb1232_read_distance(struct mb1232_data *data)
>                 }
>         } else {
>                 /* use simple sleep if announce irq is not connected */
> -               msleep(15);
> +               usleep_range(15000, 20000);

This is actually less than ideal.. because usleep_range uses the
hrtimers which forces an interrupt.

Unless you actually need to read between 15ms and 20ms it is best just
to leave the msleep() as it is, and let it take a bit longer
if required.

- Matt

>         }
>
>         ret = i2c_master_recv(client, (char *)&buf, sizeof(buf));
> diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
> index f2bf783..605a582 100644
> --- a/drivers/iio/proximity/srf08.c
> +++ b/drivers/iio/proximity/srf08.c
> @@ -150,7 +150,7 @@ static int srf08_read_ranging(struct srf08_data *data)
>          * polling for not more than 20 ms should be enough
>          */
>         waittime = 1 + data->range_mm / 172;
> -       msleep(waittime);
> +       usleep_range(waittime * 1000, (waittime * 1000) + 2000);
>         for (i = 0; i < 4; i++) {
>                 ret = i2c_smbus_read_byte_data(data->client,
>                                                 SRF08_READ_SW_REVISION);
> @@ -158,7 +158,7 @@ static int srf08_read_ranging(struct srf08_data *data)
>                 /* check if a valid version number is read */
>                 if (ret < 255 && ret > 0)
>                         break;
> -               msleep(5);
> +               usleep_range(5000, 15000);
>         }
>
>         if (ret >= 255 || ret <= 0) {
> --
> 2.7.4
>
