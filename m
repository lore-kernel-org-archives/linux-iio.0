Return-Path: <SRS0=EDDA=5D=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
Subject: [PATCH v2 0/5] iio: add support for STM32H7 ADC
Date: Mon, 29 May 2017 11:28:15 +0200
Message-ID: <1496050100-25854-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add support for STM32H7 Analog to Digital Converter variant.
It has up to 20 external channels, resolution ranges from 8 to 16bits.
Differences are regarding clocking, registers and bitfields have also
been re-arranged, but behavior is similar. It also has additional self
calibration and power on/off procedures.

---
Changes in v2:
- update bindings with Rob's remarks, document stm32h7 resolutions
- Slightly re-arrange channels definition, remove a trivial comment

Fabrice Gasnier (5):
  dt-bindings: iio: stm32-adc: add support for STM32H7
  iio: adc: stm32: make core adc clock optional by default
  iio: adc: stm32: introduce compatible data cfg
  iio: adc: stm32: make per instance bus clock optional
  iio: adc: stm32: add support for STM32H7

 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |  28 +-
 drivers/iio/adc/stm32-adc-core.c                   | 269 +++++++-
 drivers/iio/adc/stm32-adc-core.h                   |   2 +
 drivers/iio/adc/stm32-adc.c                        | 762 +++++++++++++++++++--
 4 files changed, 972 insertions(+), 89 deletions(-)

-- 
1.9.1
