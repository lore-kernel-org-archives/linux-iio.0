Return-Path: <SRS0=bqw6=63=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>
CC: <linux@armlinux.org.uk>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] Allow to tune sampling time on STM32 ADC
Date: Mon, 24 Jul 2017 18:10:37 +0200
Message-ID: <1500912640-23927-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

STM32 ADC allows each channel to be sampled with a different sampling
time. This series fixes common clock rate and adds optional device
tree property, so minimum sampling time can be tuned. This is done via
device tree as it's tightly coupled with hardware (analog source).
---
Changes in v2:
- Better describe fix patch
- Use 'st,min-sample-time-nsecs' instead of 'min-sample-time'.
- Add a comment on of_property_read_u32_index() use.

Fabrice Gasnier (3):
  iio: adc: stm32: fix common clock rate
  dt-bindings: iio: adc: stm32: add optional st,min-sample-time-nsecs
  iio: adc: stm32: add optional st,min-sample-time-nsecs

 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |   5 +
 drivers/iio/adc/stm32-adc-core.c                   |  10 +-
 drivers/iio/adc/stm32-adc.c                        | 140 ++++++++++++++++++++-
 3 files changed, 146 insertions(+), 9 deletions(-)

-- 
1.9.1
