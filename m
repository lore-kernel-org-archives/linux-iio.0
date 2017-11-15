Return-Path: <SRS0=H85M=CN=microchip.com=Eugen.Hristev@kernel.org>
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <nicolas.ferre@microchip.com>, <alexandre.belloni@free-electrons.com>,
	<linux-iio@vger.kernel.org>, <lars@metafoo.de>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <ludovic.desroches@microchip.com>,
	<jic23@kernel.org>
CC: <eugen.hristev@microchip.com>
Subject: [PATCH v3 0/4] iio: adc: at91-sama5d2_adc: add DMA support
Date: Wed, 15 Nov 2017 14:56:44 +0200
Message-ID: <1510750608-8697-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This patch implements the DMA support for the ADC in sama5d2 SoC.
After discussing on the mailing list, this approach is based on triggered
kfifo buffer, with DMA support added on top of it.
Thus, the trigger is enabled by the buffer. The ADC itself will not have
an IRQ enabled if using DMA. With DMA, the channels are enabled, and DMA
controller is configured to read from the data ready registers.
When DMA starts, the trigger will start the conversion (external trigger
configured), then the registers will have the conversion data ready, the ADC
will trigger the DMA controller to read from the registers, the DMA will
copy the data into the software buffer, and trigger the DMA IRQ.
In the bottom half, the trigger polled and the data from the DMA buffer is
pushed to buffer.

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
Binding adds both dmas and dma-names to keep compatibility with the drivers and
current helpers that rely on the properties being present

Modified devicetree for sama5d2 SoC to add connected DMA channel.

To demonstrate the capabilities of the DMA support at best sampling rate, the
frequency for the ADC needs to be modified to maximum, from sysfs attribute.

A different commit addresses the issue of not clearing the DRDY irq in direct
mode. This is required to avoid erroneous overrun warnings.

  Changes in v3:
 - Removed commit to change sample rate to maximum as this is configurable
from sysfs
 - Remove misleaded dev_info message when DMA was not enabled at probe
 - Rebased patch on top of the
[PATCH] iio: adc: at91-sama5d2_adc: fix probe error on missing trigger property
Which is already upstreamed in 4.14
 - Fixed the bug introduced in v2, with buffer size
 - added extra check when enabling DMA, to have hw trigger present.
This is because now, we can have the driver with software trigger only (if no
hw trigger in device tree, start as software only)

  Changes in v2:
 - No longer add last timestamp to all samples. Now, compute an interval
between samples w.r.t. start and end time of the transfer and number
of samples. Then distribute them each in the time interval.
 - Add warning for conversion overrun. This helps user identify cases
when the watermark needs adjustment : the software is too slow in reading
data from the ADC.
 - Protection around watermark is not needed, changing of the watermark
cannot be done while the buffer is enabled. When buffer is disabled, all
DMA resources are freed anyway.
 - Added validation on trigger to be used by own device
 - Best sample rate I could obtain using the low frequency clock was about
4k samples/second, with a watermark of 100. To get up to 50k samples/second
the ADC frequency must be increased to max.
 - Addressed other comments from mailing list review. Feedback is appreciated
 - Added [PATCH v2 4/5] iio: adc: at91-sama5d2_adc: ack DRDY irq in direct
 - Added [PATCH v2 5/5] iio: adc: at91-sama5d2_adc: use max sample rate


Eugen Hristev (4):
  dt-bindings: iio: at91-sama5d2_adc: add optional dma property
  ARM: dts: at91: sama5d2: added dma property for ADC device
  iio: adc: at91-sama5d2_adc: add support for DMA
  iio: adc: at91-sama5d2_adc: ack DRDY irq in direct mode

 .../bindings/iio/adc/at91-sama5d2_adc.txt          |   7 +
 arch/arm/boot/dts/sama5d2.dtsi                     |   2 +
 drivers/iio/adc/Kconfig                            |   1 +
 drivers/iio/adc/at91-sama5d2_adc.c                 | 456 ++++++++++++++++++++-
 4 files changed, 446 insertions(+), 20 deletions(-)

-- 
2.7.4
