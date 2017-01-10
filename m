Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:36851 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756579AbdAJI4J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Jan 2017 03:56:09 -0500
Received: by mail-qt0-f169.google.com with SMTP id k15so389153996qtg.3
        for <linux-iio@vger.kernel.org>; Tue, 10 Jan 2017 00:56:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170109180051.uwd4su3maj5gkf5l@rob-hp-laptop>
References: <1483608344-9012-1-git-send-email-benjamin.gaignard@st.com>
 <1483608344-9012-3-git-send-email-benjamin.gaignard@st.com> <20170109180051.uwd4su3maj5gkf5l@rob-hp-laptop>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Tue, 10 Jan 2017 09:56:08 +0100
Message-ID: <CA+M3ks5r71FAuy5tKeHSRtSVvDvZ21pXecYFnZEF2VrxdT81xw@mail.gmail.com>
Subject: Re: [PATCH v7 2/8] MFD: add STM32 Timers driver
To: Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2017-01-09 19:00 GMT+01:00 Rob Herring <robh@kernel.org>:
> On Thu, Jan 05, 2017 at 10:25:38AM +0100, Benjamin Gaignard wrote:
>> This hardware block could at used at same time for PWM generation
>> and IIO timers.
>> PWM and IIO timer configuration are mixed in the same registers
>> so we need a multi fonction driver to be able to share those registers.
>>
>> version 7:
>> - rebase on v4.10-rc2
>>
>> version 6:
>> - rename files to stm32-timers
>> - rename functions to stm32_timers_xxx
>>
>> version 5:
>> - fix Lee comments about detect function
>> - add missing dependency on REGMAP_MMIO
>>
>> version 4:
>> - add a function to detect Auto Reload Register (ARR) size
>> - rename the structure shared with other drivers
>>
>> version 2:
>> - rename driver "stm32-gptimer" to be align with SoC documentation
>> - only keep one compatible
>> - use of_platform_populate() instead of devm_mfd_add_devices()
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>> ---
>>  .../devicetree/bindings/mfd/stm32-timers.txt       |  2 +-
>>  drivers/mfd/Kconfig                                | 11 +++
>>  drivers/mfd/Makefile                               |  2 +
>>  drivers/mfd/stm32-timers.c                         | 80 +++++++++++++++=
+++++++
>>  include/linux/mfd/stm32-timers.h                   | 71 +++++++++++++++=
++++
>>  5 files changed, 165 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/mfd/stm32-timers.c
>>  create mode 100644 include/linux/mfd/stm32-timers.h
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/stm32-timers.txt b/Do=
cumentation/devicetree/bindings/mfd/stm32-timers.txt
>> index a73301d..897e7c2 100644
>> --- a/Documentation/devicetree/bindings/mfd/stm32-timers.txt
>> +++ b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
>> @@ -12,7 +12,7 @@ Required parameters:
>>
>>  - reg:                       Physical base address and length of the co=
ntroller's
>>                       registers.
>> -- clock-names:               Set to "int".
>> +- clock-names:               Set to "int".
>
> This hunk should be dropped or moved to previous patch.

I will move it in the previous patch

>
>>  - clocks:            Phandle to the clock used by the timer module.
>>                       For Clk properties, please refer to ../clock/clock=
-bindings.txt
>>



--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
