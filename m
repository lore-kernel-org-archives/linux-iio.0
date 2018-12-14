Return-Path: <SRS0=HY5B=OX=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FC0C43387
	for <linux-iio@archiver.kernel.org>; Fri, 14 Dec 2018 18:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91885206DD
	for <linux-iio@archiver.kernel.org>; Fri, 14 Dec 2018 18:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="Ce+liFcy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbeLNSGv (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:06:51 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41806 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729933AbeLNSGv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Dec 2018 13:06:51 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so1402232pgq.8
        for <linux-iio@vger.kernel.org>; Fri, 14 Dec 2018 10:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cy4O51U6sVKnzFN/6ke4qYh7v4hI4QhoyMWNCm0wQE8=;
        b=Ce+liFcy4uFeF0BWhPZ3BY+DUPR2jfXXz+X54VAidhl/1FjP8KzSPRrZrwaooTDFTw
         T9q8do3gOhXpAqCqms0pVviqvegPiUfggWGsaB29abh0f1OnAi+12r3nJ8khy7h9nOP1
         zBkDVF9Q1qACOHJrswLmPCFyrs58XLXOlJZkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cy4O51U6sVKnzFN/6ke4qYh7v4hI4QhoyMWNCm0wQE8=;
        b=LDccmKAICYBsoGE+HWv8WJ8rIueseFh+NWbXqBdYoBJP2JJ8ER2LD21YQPuHlBs9r7
         8eCD+idw9b2RQ1cvs2891Cx2svasfaE/IHqQ/Hanx0nRT37l0wD3upsYbcSwhgcRinCX
         np9VQ/vFh1piTPtrmRxqRreJzS+Af580MvmcuM4zWzkxF9iNPiE4XKYv5rYQSnSe0D28
         fzmHblpIb7deYpzhSyxM/zvYJ+0JqG9C3J4F1GTHgpRl5Lgl+ODoMk4CVbnQDP/a95GW
         x5gCbG1IqxrsGEmov0klKxKEyI6uRsCIombZ2sTPCZHPNqsj+SGwFAiuJXGL/RZEFzpS
         Imng==
X-Gm-Message-State: AA+aEWY0/7t+H8TqnxHI84PNbutgkNl170qwUanpvtmSGZi+w0AzkL9x
        SWgIjpkNDdXTDDRyIpl3k9mcUKSwuuDGckT84ohBEQ==
X-Google-Smtp-Source: AFSGD/VwXC07Np+ksEj4O63MNPhb9c34xg941XA1sn9LbtLqy8amjMUw6my12ndaji/CrsncVt8QnEmjJLHdnTARn+0=
X-Received: by 2002:a63:8043:: with SMTP id j64mr3622647pgd.405.1544810810547;
 Fri, 14 Dec 2018 10:06:50 -0800 (PST)
MIME-Version: 1.0
References: <20181213144323.24820-2-andreas.brauchli@sensirion.com>
In-Reply-To: <20181213144323.24820-2-andreas.brauchli@sensirion.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Fri, 14 Dec 2018 10:06:39 -0800
Message-ID: <CAJCx=g=ut+mWUfW=H3AorQiWXSpSd_GgyzV1F4CBatSKhh6qHA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iio: Add modifiers for ethanol and H2 gases
To:     Andreas Brauchli <a.brauchli@elementarea.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Andreas Brauchli <andreas.brauchli@sensirion.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 13, 2018 at 6:44 AM Andreas Brauchli
<a.brauchli@elementarea.net> wrote:
>
> Add ethanol and H2 gas modifiers:
> * IIO_MOD_ETHANOL

Was going to ask why this wasn't a chemical formula like the rest of
the modifiers, but C2H6O would be a bit wordy/unclear :).

> * IIO_MOD_H2
>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> Signed-off-by: Andreas Brauchli <andreas.brauchli@sensirion.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 4 ++++
>  include/uapi/linux/iio/types.h          | 2 ++
>  tools/iio/iio_event_monitor.c           | 4 ++++
>  3 files changed, 10 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 8127a08e366d..6d64521bf565 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1554,6 +1554,10 @@ What:            /sys/bus/iio/devices/iio:deviceX/in_concentration_raw
>  What:          /sys/bus/iio/devices/iio:deviceX/in_concentrationX_raw
>  What:          /sys/bus/iio/devices/iio:deviceX/in_concentration_co2_raw
>  What:          /sys/bus/iio/devices/iio:deviceX/in_concentrationX_co2_raw
> +What:          /sys/bus/iio/devices/iio:deviceX/in_concentration_ethanol_raw
> +What:          /sys/bus/iio/devices/iio:deviceX/in_concentrationX_ethanol_raw
> +What:          /sys/bus/iio/devices/iio:deviceX/in_concentration_h2_raw
> +What:          /sys/bus/iio/devices/iio:deviceX/in_concentrationX_h2_raw
>  What:          /sys/bus/iio/devices/iio:deviceX/in_concentration_voc_raw
>  What:          /sys/bus/iio/devices/iio:deviceX/in_concentrationX_voc_raw
>  KernelVersion: 4.3
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 92baabc103ac..04a6649fa442 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -87,6 +87,8 @@ enum iio_modifier {
>         IIO_MOD_VOC,
>         IIO_MOD_LIGHT_UV,
>         IIO_MOD_LIGHT_DUV,
> +       IIO_MOD_ETHANOL,
> +       IIO_MOD_H2,
>  };
>
>  enum iio_event_type {
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index ac2de6b7e89f..f29c885f4b28 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -114,6 +114,8 @@ static const char * const iio_modifier_names[] = {
>         [IIO_MOD_I] = "i",
>         [IIO_MOD_Q] = "q",
>         [IIO_MOD_CO2] = "co2",
> +       [IIO_MOD_ETHANOL] = "ethanol",
> +       [IIO_MOD_H2] = "h2",
>         [IIO_MOD_VOC] = "voc",
>  };
>
> @@ -199,6 +201,8 @@ static bool event_is_known(struct iio_event_data *event)
>         case IIO_MOD_I:
>         case IIO_MOD_Q:
>         case IIO_MOD_CO2:
> +       case IIO_MOD_ETHANOL:
> +       case IIO_MOD_H2:
>         case IIO_MOD_VOC:
>                 break;
>         default:
> --
> 2.17.1
>
