Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:38490 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754032AbdF0Xrj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jun 2017 19:47:39 -0400
Received: by mail-it0-f48.google.com with SMTP id b205so24771219itg.1
        for <linux-iio@vger.kernel.org>; Tue, 27 Jun 2017 16:47:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1493928654-18768-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1493928654-18768-1-git-send-email-Julia.Lawall@lip6.fr>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Jun 2017 16:47:37 -0700
Message-ID: <CAGXu5jK+oz7SoBKmHDjUpmZ96=keiou+75WK2or37Z8RL9jLxA@mail.gmail.com>
Subject: Re: [PATCH 0/9] Drop unnecessary static
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Linux PM list <linux-pm@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux mtd <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, drbd-dev@lists.linbit.com,
        linux-omap@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input <linux-input@vger.kernel.org>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, May 4, 2017 at 1:10 PM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
> These patches fix cases where there is a static on a local variable, but
> the variable is either first initialized or never used, on every possible
> execution path through the function.  The static has no benefit, and
> dropping it reduces the code size.
>
> ---
>
>  drivers/block/drbd/drbd_nl.c            |    2 +-
>  drivers/clocksource/timer-fttmr010.c    |    2 +-
>  drivers/iio/accel/hid-sensor-accel-3d.c |    2 +-
>  drivers/mfd/max8925-i2c.c               |    2 +-
>  drivers/mfd/twl4030-irq.c               |    2 +-
>  drivers/mtd/chips/cfi_cmdset_0020.c     |    2 +-
>  drivers/mtd/maps/physmap_of_gemini.c    |    2 +-
>  drivers/power/supply/axp20x_usb_power.c |    2 +-
>  drivers/regulator/palmas-regulator.c    |    2 +-
>  9 files changed, 9 insertions(+), 9 deletions(-)

It looks like most of these were taken. I pinged the other three. Thanks!

-Kees

-- 
Kees Cook
Pixel Security
