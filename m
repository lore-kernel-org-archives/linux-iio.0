Return-Path: <SRS0=DOsN=BQ=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>
CC: <linux@armlinux.org.uk>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
Subject: [PATCH 0/3] iio: adc: stm32: Add support for differential channels 
Date: Tue, 17 Oct 2017 15:15:42 +0200
Message-ID: <1508246145-19417-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add support for differential channels that can be found on STM32H7 ADC:
- Introduce new DT property 'st,adc-diff-channels'.
- Slightly rework single-ended channels definition in stm32-adc driver.
- Add support for differential channels to stm32-adc driver.

Fabrice Gasnier (3):
  dt-bindings: iio: adc: stm32: add support for diff channels
  iio: adc: stm32: remove const channel names definition
  iio: adc: stm32: add support for differential channels

 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |   6 +
 drivers/iio/adc/stm32-adc.c                        | 181 +++++++++++++--------
 2 files changed, 119 insertions(+), 68 deletions(-)

-- 
1.9.1
