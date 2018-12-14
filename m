Return-Path: <SRS0=HY5B=OX=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1857C43387
	for <linux-iio@archiver.kernel.org>; Fri, 14 Dec 2018 18:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6144206C0
	for <linux-iio@archiver.kernel.org>; Fri, 14 Dec 2018 18:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="o+h8mFAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbeLNSKo (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:10:44 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34743 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbeLNSKo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Dec 2018 13:10:44 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so3093858plz.1
        for <linux-iio@vger.kernel.org>; Fri, 14 Dec 2018 10:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zzt3jh8EHDsAbb/yB3ZT+jxl/mYi+Wvr1wldxOUI4ac=;
        b=o+h8mFAhld9M9nhZTUShMRQzgWKhh2Ofz2R9Ea9IjDDlv26nliuFFiRB02DolKFlNA
         SEWGknUi+e8OfPQFIFAvozz5CE8pmteaHFlYXAD0cD+4g56ChBh0cjM/8Wfu4nJ8UwTH
         /o/+XL48KXUmwcZS8e8jFvGDTQL6fvdDKeki8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zzt3jh8EHDsAbb/yB3ZT+jxl/mYi+Wvr1wldxOUI4ac=;
        b=pezIgeQuCbVM9pYiUmAO6iHHuYLkV9d23vxCTH4FplPglCgHNSpmE5i4UbPPmORb/c
         lO6rR9Uqyw68QMVnbb+0IJS1VQvYHdmM8UhdnEH+ekXGF5czjM9V/DIQqWjkWBsWV5Rp
         z4ubAe026lIRT05oduWhFYMAWbnIhiR93ZboxLVvFrYG0gMOezwwJfVd1gemZ0GDUsvj
         DWiqMUGUQegY9vz577Hm3V5+qECdc9wdUtydTq7SWp/Tq7hxQ/O218MGP3KQ2DNW0pfF
         80TfLo4Q9DWQEYsL3iaDj5xJx0g8frUYzaIKKPY8qz9XRc5vx9UUQwr1TicVsGl1TOU0
         tpug==
X-Gm-Message-State: AA+aEWaPpHLn7XspTBi56VnyP7eN7RPZAgads9EuTYrW2U36VKb/zg3T
        AespAt3rJhTzozni+8FBeSEy3MpGthoDZGoIZpCx8w==
X-Google-Smtp-Source: AFSGD/XXt9dT44hec9IQeOnskgWoVq+d56tZmb3+ZpZfXqGxHRdWTzSu2S25rdeDTDEr/qDjFb3D/JI2dUOBdk33yDs=
X-Received: by 2002:a17:902:59c8:: with SMTP id d8mr3817333plj.116.1544811044023;
 Fri, 14 Dec 2018 10:10:44 -0800 (PST)
MIME-Version: 1.0
References: <20181212183011.16567-1-tduszyns@gmail.com> <20181212183011.16567-2-tduszyns@gmail.com>
In-Reply-To: <20181212183011.16567-2-tduszyns@gmail.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Fri, 14 Dec 2018 10:10:32 -0800
Message-ID: <CAJCx=gng3h-W21FpuTmwqhet7s4mj+Wss5Mrq0MF+o+vg2zyvA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iio: add IIO_MASSCONCENTRATION channel type
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        jic23@jic23.retrosnub.co.uk,
        Andreas Brauchli <a.brauchli@elementarea.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 12, 2018 at 10:31 AM Tomasz Duszynski <tduszyns@gmail.com> wrote:
>
> Measuring particulate matter in ug / m3 (micro-grams per cubic meter)
> is de facto standard. Existing air quality sensors usually follow
> this convention and are capable of returning measurements using
> this unit.
>
> IIO currently does not offer suitable channel type for this
> type of measurements hence this patch adds this.
>
> In addition, extra modifiers are introduced used for distinguishing
> between fine pm1, pm2p5 and coarse pm4, pm10 particle measurements, i.e
> IIO_MOD_PM1, IIO_MOD_PM25 and IIO_MOD_PM4, IIO_MOD_PM10.
>
> pmX consists of particles with aerodynamic diameter less or equal to
> X micrometers.
>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 17 ++++++++++++++++-
>  drivers/iio/industrialio-core.c         |  5 +++++
>  include/uapi/linux/iio/types.h          |  5 +++++
>  tools/iio/iio_event_monitor.c           | 10 ++++++++++
>  4 files changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 8127a08e366d..ad9579a9385f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1684,4 +1684,19 @@ KernelVersion:   4.18
>  Contact:       linux-iio@vger.kernel.org
>  Description:
>                 Raw (unscaled) phase difference reading from channel Y
> -               that can be processed to radians.
> \ No newline at end of file
> +               that can be processed to radians.
> +
> +What:          /sys/bus/iio/devices/iio:deviceX/in_massconcentration_pm1_input
> +What:          /sys/bus/iio/devices/iio:deviceX/in_massconcentrationY_pm1_input
> +What:          /sys/bus/iio/devices/iio:deviceX/in_massconcentration_pm2p5_input
> +What:          /sys/bus/iio/devices/iio:deviceX/in_massconcentrationY_pm2p5_input
> +What:          /sys/bus/iio/devices/iio:deviceX/in_massconcentration_pm4_input
> +What:          /sys/bus/iio/devices/iio:deviceX/in_massconcentrationY_pm4_input
> +What:          /sys/bus/iio/devices/iio:deviceX/in_massconcentration_pm10_input
> +What:          /sys/bus/iio/devices/iio:deviceX/in_massconcentrationY_pm10_input
> +KernelVersion: 4.21
> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +               Mass concentration reading of particulate matter in ug / m3.
> +               pmX consists of particles with aerodynamic diameter less or
> +               equal to X micrometers.
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 4f5cd9f60870..4700fd5d8c90 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -87,6 +87,7 @@ static const char * const iio_chan_type_name_spec[] = {
>         [IIO_GRAVITY]  = "gravity",
>         [IIO_POSITIONRELATIVE]  = "positionrelative",
>         [IIO_PHASE] = "phase",
> +       [IIO_MASSCONCENTRATION] = "massconcentration",
>  };
>
>  static const char * const iio_modifier_names[] = {
> @@ -127,6 +128,10 @@ static const char * const iio_modifier_names[] = {
>         [IIO_MOD_Q] = "q",
>         [IIO_MOD_CO2] = "co2",
>         [IIO_MOD_VOC] = "voc",
> +       [IIO_MOD_PM1] = "pm1",
> +       [IIO_MOD_PM2P5] = "pm2p5",
> +       [IIO_MOD_PM4] = "pm4",
> +       [IIO_MOD_PM10] = "pm10",
>  };
>
>  /* relies on pairs of these shared then separate */
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 92baabc103ac..c59adac24b1c 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -46,6 +46,7 @@ enum iio_chan_type {
>         IIO_GRAVITY,
>         IIO_POSITIONRELATIVE,
>         IIO_PHASE,
> +       IIO_MASSCONCENTRATION,
>  };
>
>  enum iio_modifier {
> @@ -87,6 +88,10 @@ enum iio_modifier {
>         IIO_MOD_VOC,
>         IIO_MOD_LIGHT_UV,
>         IIO_MOD_LIGHT_DUV,
> +       IIO_MOD_PM1,
> +       IIO_MOD_PM2P5,
> +       IIO_MOD_PM4,
> +       IIO_MOD_PM10,
>  };
>
>  enum iio_event_type {
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index ac2de6b7e89f..f6b8003fbe3c 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -60,6 +60,7 @@ static const char * const iio_chan_type_name_spec[] = {
>         [IIO_GRAVITY] = "gravity",
>         [IIO_POSITIONRELATIVE] = "positionrelative",
>         [IIO_PHASE] = "phase",
> +       [IIO_MASSCONCENTRATION] = "massconcentration",
>  };
>
>  static const char * const iio_ev_type_text[] = {
> @@ -115,6 +116,10 @@ static const char * const iio_modifier_names[] = {
>         [IIO_MOD_Q] = "q",
>         [IIO_MOD_CO2] = "co2",
>         [IIO_MOD_VOC] = "voc",
> +       [IIO_MOD_PM1] = "pm1",
> +       [IIO_MOD_PM2P5] = "pm2p5",
> +       [IIO_MOD_PM4] = "pm4",
> +       [IIO_MOD_PM10] = "pm10",
>  };
>
>  static bool event_is_known(struct iio_event_data *event)
> @@ -156,6 +161,7 @@ static bool event_is_known(struct iio_event_data *event)
>         case IIO_GRAVITY:
>         case IIO_POSITIONRELATIVE:
>         case IIO_PHASE:
> +       case IIO_MASSCONCENTRATION:
>                 break;
>         default:
>                 return false;
> @@ -200,6 +206,10 @@ static bool event_is_known(struct iio_event_data *event)
>         case IIO_MOD_Q:
>         case IIO_MOD_CO2:
>         case IIO_MOD_VOC:
> +       case IIO_MOD_PM1:
> +       case IIO_MOD_PM2P5:
> +       case IIO_MOD_PM4:
> +       case IIO_MOD_PM10:
>                 break;
>         default:
>                 return false;
> --
> 2.19.2
>
