Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:38238 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1172621AbdDXO14 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Apr 2017 10:27:56 -0400
Received: by mail-it0-f44.google.com with SMTP id e132so57288615ite.1
        for <linux-iio@vger.kernel.org>; Mon, 24 Apr 2017 07:27:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170419140500.7793-1-shrirang.bagul@canonical.com>
References: <20170419140500.7793-1-shrirang.bagul@canonical.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 24 Apr 2017 16:26:48 +0200
Message-ID: <CACRpkdawMT-_0q4apzm=cVEzexs=1wVpnq6bTewamAsu1EohCQ@mail.gmail.com>
Subject: Re: [PATCH] iio: st_pressure: st_accel: Initialise sensor platform
 data properly
To: Shrirang Bagul <shrirang.bagul@canonical.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Gregor Boirie <gregor.boirie@parrot.com>, rob@kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marcin Niestroj <m.niestroj@grinn-global.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Apr 19, 2017 at 4:05 PM, Shrirang Bagul
<shrirang.bagul@canonical.com> wrote:

> This patch fixes the sensor platform data initialisation for st_pressure
> and st_accel device drivers. Without this patch, the driver fails to
> register the sensors when the user removes and re-loads the driver.
>
> 1. Unload the kernel modules for st_pressure
> $ sudo rmmod st_pressure_i2c
> $ sudo rmmod st_pressure
>
> 2. Re-load the driver
> $ sudo insmod st_pressure
> $ sudo insmod st_pressure_i2c
> --- OR ---
> $ sudo modprobe st_pressure_i2c
>
> dmesg errors:
>
> [ 160.935707] iio iio:device2: DRDY on pdata not valid.
> [ 160.941505] st-press-i2c: probe of i2c-SMO9210:00 failed with error -22
>
> The driver fails to register the pressure sensor device. Devices
> supported by st_accel driver also suffer from the same bug.
>
> Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>

Looks OK
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
