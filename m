Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:35215 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754643AbdHVHgt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Aug 2017 03:36:49 -0400
Received: by mail-wr0-f179.google.com with SMTP id k46so42733067wre.2
        for <linux-iio@vger.kernel.org>; Tue, 22 Aug 2017 00:36:49 -0700 (PDT)
Date: Tue, 22 Aug 2017 08:36:45 +0100
From: Lee Jones <lee.jones@linaro.org>
To: s.abhisit@gmail.com
Cc: Jonathan.Cameron@huawei.com, pmeerw@pmeerw.net, jacopo@jmondi.org,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, fabrice.gasnier@st.com,
        robh@kernel.org, akinobu.mita@gmail.com,
        marek.vasut+renesas@gmail.com, jacopo+renesas@jmondi.org,
        mike.looijmans@topic.nl, peda@axentia.se, jeff.dagenais@gmail.com,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] mfd: Add support for TI LMP92001
Message-ID: <20170822073645.rd6wn3gyhbe5fbbo@dell>
References: <1503383171-15515-1-git-send-email-s.abhisit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1503383171-15515-1-git-send-email-s.abhisit@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 22 Aug 2017, s.abhisit@gmail.com wrote:

> From: Abhisit Sangjan <s.abhisit@gmail.com>
> 
> TI LMP92001 Analog System Monitor and Controller
> 
> 8-bit GPIOs.
> 12 DACs with 12-bit resolution.
> The GPIOs and DACs are shared port function with Cy function pin to
> take control the pin suddenly from external hardware.
> DAC's referance voltage selectable for Internal/External.
> 
> 16 + 1 ADCs with 12-bit resolution.
> Built-in internal Temperature Sensor on channel 17.
> Windows Comparator Function is supported on channel 1-3 and 9-11 for
> monitoring with interrupt signal (pending to implement for interrupt).
> ADC's referance voltage selectable for Internal/External.
> 
> Signed-off-by: Abhisit Sangjan <s.abhisit@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-lmp920001  |  92 ++++
>  .../devicetree/bindings/gpio/gpio-lmp92001.txt     |  22 +
>  .../bindings/iio/adc/ti-lmp92001-adc.txt           |  21 +
>  .../bindings/iio/dac/ti-lmp92001-dac.txt           |  35 ++
>  drivers/gpio/Kconfig                               |   7 +
>  drivers/gpio/Makefile                              |   1 +
>  drivers/gpio/gpio-lmp92001.c                       | 209 +++++++++
>  drivers/iio/adc/Kconfig                            |  10 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/lmp92001-adc.c                     | 500 +++++++++++++++++++++
>  drivers/iio/dac/Kconfig                            |   9 +
>  drivers/iio/dac/Makefile                           |   1 +
>  drivers/iio/dac/lmp92001-dac.c                     | 390 ++++++++++++++++
>  drivers/mfd/Kconfig                                |  12 +
>  drivers/mfd/Makefile                               |   4 +
>  drivers/mfd/lmp92001-core.c                        | 308 +++++++++++++
>  drivers/mfd/lmp92001-debug.c                       |  67 +++
>  drivers/mfd/lmp92001-i2c.c                         | 215 +++++++++
>  include/linux/mfd/lmp92001/core.h                  | 119 +++++
>  include/linux/mfd/lmp92001/debug.h                 |  28 ++

You need to split this up into a patch-set containing smaller
bite-sized patches.  Each should contain the smallest (reasonable)
change set, split up by subsystem and again by functionality.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
