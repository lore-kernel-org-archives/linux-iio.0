Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:3817 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752248AbdDCOyY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2017 10:54:24 -0400
Subject: Re: [PATCH v2 0/7] Add support for triggered buffer mode to STM32 ADC
To: Fabrice Gasnier <fabrice.gasnier@st.com>, <jic23@kernel.org>,
        <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1485440915-30119-1-git-send-email-fabrice.gasnier@st.com>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <63602dad-7640-1112-42aa-c4219d490041@st.com>
Date: Mon, 3 Apr 2017 16:53:37 +0200
MIME-Version: 1.0
In-Reply-To: <1485440915-30119-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi

On 01/26/2017 03:28 PM, Fabrice Gasnier wrote:
> The following patches add support for triggered buffer mode.
> These are based on top of "Add PWM and IIO timer drivers for STM32"
> series. Reference:
> https://lkml.org/lkml/2017/1/20/116
>
> STM32 ADC, can use either interrupts or DMA to collect data.
> Either timer trigger output (TRGO) or PWM can be used as trigger source.
> This patchset has been tested on STM32F429 eval board.
>
...
> Fabrice Gasnier (7):
>   iio: adc: stm32: add support for triggered buffer mode
>   iio: adc: stm32: Enable use of stm32 timer triggers
>   iio: adc: stm32: add trigger polarity extended attribute
>   Documentation: dt: iio: stm32-adc: optional dma support
>   iio: adc: stm32: add optional dma support
>   ARM: dts: stm32: Enable dma by default on stm32f4 adc
>   ARM: dts: stm32: Enable pwm1 and pwm3 on stm32f429i-eval

Patches 6 & 7 (DT) applied on stm32-dt-for-v4.12

Regards
Alex

>
>  Documentation/ABI/testing/sysfs-bus-iio-adc-stm32  |  18 +
>  .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |   7 +
>  arch/arm/boot/dts/stm32429i-eval.dts               |  28 +
>  arch/arm/boot/dts/stm32f429.dtsi                   |   6 +
>  drivers/iio/adc/Kconfig                            |   5 +
>  drivers/iio/adc/stm32-adc-core.c                   |   1 +
>  drivers/iio/adc/stm32-adc-core.h                   |   2 +
>  drivers/iio/adc/stm32-adc.c                        | 633 ++++++++++++++++++++-
>  8 files changed, 676 insertions(+), 24 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-stm32
>
