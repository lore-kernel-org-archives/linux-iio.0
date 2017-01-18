Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33888 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752967AbdARMdq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jan 2017 07:33:46 -0500
Received: by mail-qk0-f172.google.com with SMTP id a20so11481526qkc.1
        for <linux-iio@vger.kernel.org>; Wed, 18 Jan 2017 04:33:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170118101628.GG18989@ulmo.ba.sec>
References: <1483608344-9012-1-git-send-email-benjamin.gaignard@st.com>
 <1483608344-9012-5-git-send-email-benjamin.gaignard@st.com> <20170118101628.GG18989@ulmo.ba.sec>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Wed, 18 Jan 2017 12:16:44 +0100
Message-ID: <CA+M3ks4NKApD-FGY9=KGcngA2aaiLop8QFtbVmgz2yeOSo7E=g@mail.gmail.com>
Subject: Re: [PATCH v7 4/8] PWM: add PWM driver for STM32 plaftorm
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, robh+dt@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

2017-01-18 11:16 GMT+01:00 Thierry Reding <thierry.reding@gmail.com>:
> On Thu, Jan 05, 2017 at 10:25:40AM +0100, Benjamin Gaignard wrote:
> [...]
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index f92dd41..88035c0 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -397,6 +397,15 @@ config PWM_STI
>>         To compile this driver as a module, choose M here: the module
>>         will be called pwm-sti.
>>
>> +config PWM_STM32
>> +     tristate "STMicroelectronics STM32 PWM"
>> +     depends on (ARCH_STM32 && OF && MFD_STM32_TIMERS) || COMPILE_TEST
>
> One other thing: is the dependency on ARCH_STM32 and OF necessary here?
> ARCH_STM32 and OF are both pulled in by MFD_STM32_TIMERS. The dependency
> is probably fine for MFD_STM32_TIMERS, though even there && OF seems too
> much, since it's already pulled in via ARCH_STM32 -> ARM_SINGLE_ARMV7M
> -> USE_OF.

Said like that MFD_STM32_TIMERS is enough so I will keep this one

Thanks

>
> Thierry



--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
