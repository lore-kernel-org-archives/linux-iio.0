Return-Path: <SRS0=HY5B=OX=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA92C43387
	for <linux-iio@archiver.kernel.org>; Fri, 14 Dec 2018 14:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31DEB206BA
	for <linux-iio@archiver.kernel.org>; Fri, 14 Dec 2018 14:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m+P9d7fp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbeLNO3c (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:29:32 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46223 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729809AbeLNO3c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Dec 2018 09:29:32 -0500
Received: by mail-yb1-f194.google.com with SMTP id f9so2308592ybm.13
        for <linux-iio@vger.kernel.org>; Fri, 14 Dec 2018 06:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T682Xoha9EerAUtioi44lxZe7JlcD8bR5bEoR0S4Lk8=;
        b=m+P9d7fpwXaz0zdijM9JbDY95hNKxmTroJK1btlUBC3bq1K9Ky/3OsCvatcGDF4oAR
         8morcQgKfwKwNV6oJRJoQqxaWOw1rbwF9gPnqCE68x5YpYOpXtQHs4Kk/1vHbZFL20M4
         gpz6ZpSi2fXlHEj2/joow6EhNdA2JVxKOL0GAOG2f2wjosQ8wijTlHJZB63J/pTDB512
         nGJAsSR2Hf84NegAD+h3K2saOZ+oC1t7ecXTuyFwxEzJOFGbgAP2wJ4huIeyQ/YL9W/Z
         +jUS9d52P8oOhCtM8KCqmCuyGmaRlVXHE5CjiigKke0Eci0U24V20v95FgZ2LBrJ2B3J
         NNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T682Xoha9EerAUtioi44lxZe7JlcD8bR5bEoR0S4Lk8=;
        b=Tl/exfI69oRox0imlA7mlR/oyUK8KO7iUmJMkabPGJUfOVd1ZEM95MDWfBENGLfz/N
         L6QvGavjj7K4BQLDu5CbsJFhKaLyhlFmZOzCqZWRKAE+JDW79K6Oi5DPibCoQFbi5W/j
         cPUOmxHEWBCTBhPCDyUc9W4rixrvW2969yfwqvErrjw9SDVU5IuJkAVoW8boVkKvInkR
         +QhKZi0g3sewCvHAnhK2h/EvFziaF1yM7cwZFHuNoz/ic6cPp88GsYg9FphFEYmmBsz+
         WQB0YQ8aRaL5jycGYoj/v8A5o8RwJBXSFvOQ+4GaKZnZCmw1uR4ETOVczKUkin2tJQgQ
         vnfg==
X-Gm-Message-State: AA+aEWYQO8JxNFZud5UvQiOUW2aAMuPOoiBpjhY/rlSG+6FdgHhclqsq
        FSpU1LS0J1BuGGlvyM/KDG7HSyzTpf0/he6UkR1/+Q==
X-Google-Smtp-Source: AFSGD/XTEWm5fooeCxvBYhVhqRe3a62ENNyzPanAYxKmLuc94GbVY+keT2gUehjETPNwPIixFubcACa7NXsAispzjuU=
X-Received: by 2002:a5b:947:: with SMTP id x7mr3130145ybq.110.1544797771070;
 Fri, 14 Dec 2018 06:29:31 -0800 (PST)
MIME-Version: 1.0
References: <20181214114858.21231-1-enric.balletbo@collabora.com>
In-Reply-To: <20181214114858.21231-1-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 14 Dec 2018 06:29:19 -0800
Message-ID: <CABXOdTdDNaPgBK74dcTgRDy5mJKztZ9GTGRiXDv=ZXOwauO-2A@mail.gmail.com>
Subject: Re: [PATCH v3] MAINTAINERS: add maintainers for ChromeOS EC sub-drivers
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
        alexandre.belloni@bootlin.com, linux-i2c@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        linux-rtc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Miller <davem@davemloft.net>, mchehab+samsung@kernel.org,
        nicolas.ferre@microchip.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Dec 14, 2018 at 3:49 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> There are multiple ChromeOS EC sub-drivers spread in different
> subsystems, as all of them are related to the Chrome stuff add
> Benson and myself as a maintainers for all these sub-drivers.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Benson Leung <bleung@chromium.org>
> Acked-by: Wolfram Sang <wsa@the-dreams.de>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> for iio parts.
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Guenter Roeck <groeck@chromium.org>

> ---
>
> Changes in v3:
> - Add collected acks
> - Use a cros[-_]ec pattern instead of list all the files.
> - Add Guenter as a reviewer.
>
> Changes in v2:
> - Fix typo in Benson email address.
>
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e7260191301b..437e036435d5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3629,6 +3629,14 @@ S:       Maintained
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git
>  F:     drivers/platform/chrome/
>
> +CHROMEOS EC SUBDRIVERS
> +M:     Benson Leung <bleung@chromium.org>
> +M:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
> +R:     Guenter Roeck <groeck@chromium.org>
> +S:     Maintained
> +N:     cros[-_]ec
> +F:     drivers/power/supply/cros_usbpd-charger.c
> +
>  CIRRUS LOGIC AUDIO CODEC DRIVERS
>  M:     Brian Austin <brian.austin@cirrus.com>
>  M:     Paul Handrigan <Paul.Handrigan@cirrus.com>
> --
> 2.19.2
>
