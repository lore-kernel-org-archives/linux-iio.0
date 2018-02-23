Return-Path: <SRS0=y4pC=FR=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>
CC: <linux@armlinux.org.uk>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@linaro.org>,
        <arnaud.pouliquen@st.com>
Subject: [PATCH] dt-bindings: iio: adc: stm32-dfsdm: fix types, add missing pinctrl
Date: Fri, 23 Feb 2018 12:11:00 +0100
Message-ID: <1519384260-23875-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

- Add missing pinctrl description. Support is made optional as dfsdm
  may use internal sources (e.g. via registers)
- Fix typo in IIO STM32 DFSDM filter "MANCH_F" description.
Basically, this should be "falling edge = logic 0", not "1" that applies
to "MANCH_R".
BTW, make the description complete by describing both rising/falling
edges as described in reference manuals.

Fixes: 6c82f947fc97 ("IIO: add DT bindings for stm32 DFSDM filter")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt
index 911492da..ed7520d 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt
@@ -32,6 +32,10 @@ Optional properties:
 		  to "clock" property. Frequency must be a multiple of the rcc
 		  clock frequency. If not, SPI CLKOUT frequency will not be
 		  accurate.
+- pinctrl-names:	Set to "default".
+- pinctrl-0:		List of phandles pointing to pin configuration
+			nodes to set pins in mode of operation for dfsdm
+			on external pin.
 
 Contents of a STM32 DFSDM child nodes:
 --------------------------------------
@@ -68,8 +72,8 @@ Optional properties:
 - st,adc-channel-types:	Single-ended channel input type.
 			- "SPI_R": SPI with data on rising edge (default)
 			- "SPI_F": SPI with data on falling edge
-			- "MANCH_R": manchester codec, rising edge = logic 0
-			- "MANCH_F": manchester codec, falling edge = logic 1
+			- "MANCH_R": manchester codec, rising edge = logic 0, falling edge = logic 1
+			- "MANCH_F": manchester codec, rising edge = logic 1, falling edge = logic 0
 - st,adc-channel-clk-src: Conversion clock source.
 			  - "CLKIN": external SPI clock (CLKIN x)
 			  - "CLKOUT": internal SPI clock (CLKOUT) (default)
-- 
1.9.1
