Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41966 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753439AbdA3O2r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2017 09:28:47 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
Subject: [PATCH 0/5] Add EXTI GPIO trigger support to STM32 ADC
Date: Mon, 30 Jan 2017 14:57:38 +0100
Message-ID: <1485784663-19505-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

STM32 ADC, can use GPIOs configured as EXTI line (external interrupt)
as trigger source for conversions.
This patchset is based on latest IIO testing branch, and adds support
for EXTi GPIO triggers in IIO.
It also adds a dt option to configure default trigger polarity in
STM32 ADC driver.

Fabrice Gasnier (5):
  Documentation: dt: iio: document stm32 adc trigger polarity
  iio: adc: stm32: add dt option to set default trigger polarity
  Documentation: dt: iio: document stm32 exti trigger
  iio: trigger: add support for STM32 EXTI triggers
  iio: adc: stm32: add exti11 gpio trigger source

 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |   3 +
 .../bindings/iio/trigger/st,stm32-exti-trigger.txt |  17 +++
 drivers/iio/adc/stm32-adc.c                        |  14 +++
 drivers/iio/trigger/Kconfig                        |  10 ++
 drivers/iio/trigger/Makefile                       |   1 +
 drivers/iio/trigger/stm32-exti-trigger.c           | 124 +++++++++++++++++++++
 include/linux/iio/trigger/stm32-exti-trigger.h     |  26 +++++
 7 files changed, 195 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/trigger/st,stm32-exti-trigger.txt
 create mode 100644 drivers/iio/trigger/stm32-exti-trigger.c
 create mode 100644 include/linux/iio/trigger/stm32-exti-trigger.h

-- 
1.9.1

