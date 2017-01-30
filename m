Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:48941 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932073AbdA3OKs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2017 09:10:48 -0500
Subject: Re: [PATCH 0/5] Add EXTI GPIO trigger support to STM32 ADC
To: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1485784663-19505-1-git-send-email-fabrice.gasnier@st.com>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <benjamin.gaignard@linaro.org>, <benjamin.gaignard@st.com>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <0472f001-eee8-74a8-f078-2fb71904be58@st.com>
Date: Mon, 30 Jan 2017 15:09:54 +0100
MIME-Version: 1.0
In-Reply-To: <1485784663-19505-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

Please discard this series. I'll send a V2.
Sorry for the noise.

Best regards,
Fabrice

On 01/30/2017 02:57 PM, Fabrice Gasnier wrote:
> STM32 ADC, can use GPIOs configured as EXTI line (external interrupt)
> as trigger source for conversions.
> This patchset is based on latest IIO testing branch, and adds support
> for EXTi GPIO triggers in IIO.
> It also adds a dt option to configure default trigger polarity in
> STM32 ADC driver.
>
> Fabrice Gasnier (5):
>    Documentation: dt: iio: document stm32 adc trigger polarity
>    iio: adc: stm32: add dt option to set default trigger polarity
>    Documentation: dt: iio: document stm32 exti trigger
>    iio: trigger: add support for STM32 EXTI triggers
>    iio: adc: stm32: add exti11 gpio trigger source
>
>   .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |   3 +
>   .../bindings/iio/trigger/st,stm32-exti-trigger.txt |  17 +++
>   drivers/iio/adc/stm32-adc.c                        |  14 +++
>   drivers/iio/trigger/Kconfig                        |  10 ++
>   drivers/iio/trigger/Makefile                       |   1 +
>   drivers/iio/trigger/stm32-exti-trigger.c           | 124 +++++++++++++++++++++
>   include/linux/iio/trigger/stm32-exti-trigger.h     |  26 +++++
>   7 files changed, 195 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/iio/trigger/st,stm32-exti-trigger.txt
>   create mode 100644 drivers/iio/trigger/stm32-exti-trigger.c
>   create mode 100644 include/linux/iio/trigger/stm32-exti-trigger.h
>

