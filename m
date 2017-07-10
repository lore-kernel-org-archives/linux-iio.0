Return-Path: <SRS0=ii5x=6N=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>
CC: <linux@armlinux.org.uk>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] Add support for STM32F4 DAC
Date: Mon, 10 Jul 2017 15:23:56 +0200
Message-ID: <1499693040-12994-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add support for STM32F4 Digital to Analog Converter variant into
existing STM32 DAC driver.
Introduce compatible associated with configuration data.
BTW, fix error message in driver probe (minor).

Fabrice Gasnier (4):
  dt-bindings: iio: stm32-dac: add support for STM32F4
  iio: dac: stm32: fix error message
  iio: dac: stm32: add support for stm32f4
  ARM: dts: stm32: Add DAC support on stm32f429

 .../devicetree/bindings/iio/dac/st,stm32-dac.txt   |  4 ++-
 arch/arm/boot/dts/stm32f429.dtsi                   | 25 ++++++++++++++
 drivers/iio/dac/stm32-dac-core.c                   | 38 ++++++++++++++++++----
 drivers/iio/dac/stm32-dac.c                        |  2 +-
 4 files changed, 60 insertions(+), 9 deletions(-)

-- 
1.9.1
