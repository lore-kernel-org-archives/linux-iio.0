Return-Path: <SRS0=acV6=7M=microchip.com=Eugen.Hristev@kernel.org>
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <nicolas.ferre@microchip.com>, <ludovic.desroches@microchip.com>,
	<linux-iio@vger.kernel.org>, <jic23@kernel.org>,
	<alexandre.belloni@free-electrons.com>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lars@metafoo.de>
CC: <eugen.hristev@microchip.com>
Subject: [PATCH 0/3] iio: adc: at91-sama5d2_adc: add DMA support
Date: Thu, 10 Aug 2017 15:34:56 +0300
Message-ID: <1502368499-6739-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This patch implements the DMA support for the ADC in sam5d2 SOC.
After discussing on the mailing list, this approach is based on triggered
kfifo buffer, with DMA support added on top of it.
Thus, the trigger is enabled by the buffer. The ADC itself will not have
an IRQ enabled if using DMA. With DMA, the channels are enabled, and DMA
controller is configured to read from the data ready registers.
When DMA starts, the trigger will start the conversion (external trigger
configured), then the registers will have the conversion data ready, trigger
the DMA controller to read from the registers, the DMA will copy the data into
the software buffer, and trigger the DMA IRQ. In the bottom half, the
trigger polled and the data from the DMA buffer is pushed to buffer.

The DMA will use a cyclic buffer to write to one half, and the software can
read from the other half. The DMA operation doesn't stop until the buffer is
disabled.
The DMA coherent area is allocated when DMA is initially started, and
deallocated only if the watermark is changed to 1 (no more DMA usage). The
coherent area is large enough to cope with maximum fifo size for all possible
channels enabled.
The fifo size is set to 128 conversions by default in the driver.

The implementation uses the user watermark  to decide whether DMA will be
used or not. For watermark 1, DMA will not be used. If watermark is greater,
DMA will be used.
Sysfs attributes are created to indicate whether the DMA is used,
with hwfifo_enabled, and the current DMA watermark is readable
in hwfifo_watermark. Minimum and maximum values are in hwfifo_watermark_min
and hwfifo_watermark_max.

Devicetree binding added for dma as well.
Modified devicetree for sama5d2 SoC to add connected DMA channel.

Eugen Hristev (3):
  Documentation: dt: iio: at91-sama5d2_adc: add optional dma property
  ARM: dts: at91: sama5d2: added dma property for ADC device
  iio: adc: at91-sama5d2_adc: add support for DMA

 .../bindings/iio/adc/at91-sama5d2_adc.txt          |   7 +
 arch/arm/boot/dts/sama5d2.dtsi                     |   2 +
 drivers/iio/adc/at91-sama5d2_adc.c                 | 366 ++++++++++++++++++++-
 3 files changed, 359 insertions(+), 16 deletions(-)

-- 
2.7.4
