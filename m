Return-Path: <SRS0=Gb5z=HH=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>, <alexandre.torgue@st.com>
CC: <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>, <lars@metafoo.de>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <benjamin.gaignard@linaro.org>
Subject: [PATCH 0/3] Add support for STM32MP1 ADC
Date: Wed, 18 Apr 2018 17:37:51 +0200
Message-ID: <1524065874-434-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add support for STM32MP1 Analog to Digital Converter variant.
It's quite similar to STM32H7 ADC and re-use most of existing driver.

Fabrice Gasnier (3):
  dt-bindings: iio: stm32-adc: add support for STM32MP1.
  iio: adc: stm32-adc: add support for STM32MP1
  ARM: dts: stm32: Add ADC support to stm32mp157c

 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |  6 +-
 arch/arm/boot/dts/stm32mp157c.dtsi                 | 32 +++++++++++
 drivers/iio/adc/stm32-adc-core.c                   | 66 ++++++++++++++++------
 drivers/iio/adc/stm32-adc.c                        | 47 +++++++++++++--
 4 files changed, 128 insertions(+), 23 deletions(-)

-- 
1.9.1
