Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:50227 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857AbaGGNyD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Jul 2014 09:54:03 -0400
Received: by mail-ob0-f178.google.com with SMTP id wn1so4619938obc.37
        for <linux-iio@vger.kernel.org>; Mon, 07 Jul 2014 06:54:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53BA918D.2050402@kernel.org>
References: <1404726525-2649-1-git-send-email-linus.walleij@linaro.org>
	<53BA918D.2050402@kernel.org>
Date: Mon, 7 Jul 2014 15:54:03 +0200
Message-ID: <CACRpkdYCh7qQM7C1WpphNyhi96NkYEP8chXOtQP3YdyuprmptA@mail.gmail.com>
Subject: Re: [RESEND PATCH 3/3] iio: st_sensors: add devicetree probing support
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Denis CIOCCA <denis.ciocca@st.com>,
	Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jul 7, 2014 at 2:24 PM, Jonathan Cameron <jic23@kernel.org> wrote:

> ERROR: "st_sensors_of_i2c_probe" [drivers/iio/pressure/st_pressure_i2c.ko]
> undefined!
> ERROR: "st_sensors_of_i2c_probe" [drivers/iio/magnetometer/st_magn_i2c.ko]
> undefined!
> ERROR: "st_sensors_of_i2c_probe" [drivers/iio/gyro/st_gyro_i2c.ko]
> undefined!
> ERROR: "st_sensors_of_i2c_probe" [drivers/iio/accel/st_accel_i2c.ko]
> undefined!
> scripts/Makefile.modpost:90: recipe for target '__modpost' failed
> make[1]: *** [__modpost] Error 1
> Makefile:1047: recipe for target 'modules' failed
> make: *** [modules] Error 2
>
> When CONFIG_OF not selected.

Um, when CONFIG_OF is *not* selected?

This looks more like it is selected, but the symbol is missing, since
I missed to export that symbol, right?

In the !CONFIG_OF case there is a static inline in
<linux/iio/common/st_sensors_i2c.h> to handle that.

The v2 patch I just sent should fix this issue...

Yours,
Linus Walleij
