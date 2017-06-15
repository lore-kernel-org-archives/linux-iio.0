Return-Path: <SRS0=7O/Q=5U=microchip.com=Eugen.Hristev@kernel.org>
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <nicolas.ferre@microchip.com>, <alexandre.belloni@free-electrons.com>,
	<linux-iio@vger.kernel.org>, <lars@metafoo.de>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <ludovic.desroches@microchip.com>,
	<jic23@kernel.org>, <robh@kernel.org>
CC: <eugen.hristev@microchip.com>
Subject: [PATCH v5 0/4] iio: adc: sama5d2_adc hw triggers and buffers
Date: Thu, 15 Jun 2017 16:24:53 +0300
Message-ID: <1497533097-12052-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This patch implements the hardware triggers support and buffer management
for sama5d2.
The DT modifications ( [PATCH v5 1/4] ARM: dts: at91: sama5d2_xplained:
enable ADTRG pin) are for demonstration purposes of the feature,
setting the pinctrl for the ADC hw trigger pin,should go through
at91 maintainers.
As discussed on the mailing list, since we have a single external trigger
namely the ADTRG, but three different possible edges that can trigger it,
will have a single trigger in the IIO subsystem and three possible edges
which can be selected from the device tree.
Thus I created new bindings in the device tree for having the possible
edge types for the ADTRG pin.
The documentation for the bindings is in the patch
[PATCH v5 2/4] Documentation: dt: iio: at91-sama5d2_adc: add adtrg
 trigger binding
The modifications in the DT are in the patch
[PATCH v5 3/4] ARM: dts: at91: sama5d2: add ADC hw trigger
The new property must be set with the values from interrupt edge types, as this
pin is effectively an internal interrupt.

  Changes in v5:
 - Moved DRDY ack in tryreenable function
 - Used PTR_ERR to pass error code to probe

  Changes in v4:
 - Modified bindings to be similar with interrupts
 - Used iio claim direct to make sure buffer is not enabled when someone might
   try to use a software triggered conversion

  Changes in v3:
 - No longer have all three possible triggers registered in the subsystem and
   available in the sysfs. Only registering one trigger, and the possible edge
   is being read from the device tree. In the device tree, any possible edge
   can be set. There are three already made nodes for each possible edge which
   can be selected.
 - Fixed a bug where software triggered conversion could be started even if
   the hardware trigger was enabled.
 - Preallocate enough space for the buffer, considering all the channels
   and timestamp



  Changes in v2:
 - Moved buffer allocation and freeing into the preenable and postdisable
   callbacks.
   We have a total of scan bytes that can vary a lot depending on each channel
   enabled at a certain point.
 - made the at91 trigger list part of state structure
 - made the iio trigger list preallocated in state structure
 - moved irq enabling/disabling into the try_reenable callback
 - on trigger disable must write disable registries as well
 - Modified trigger name length to 64

Eugen Hristev (4):
  ARM: dts: at91: sama5d2_xplained: enable ADTRG pin
  Documentation: dt: iio: at91-sama5d2_adc: add hw trigger edge binding
  ARM: dts: at91: sama5d2: add ADC hw trigger edge type
  iio: adc: at91-sama5d2_adc: add hw trigger and buffer support

 .../bindings/iio/adc/at91-sama5d2_adc.txt          |   6 +
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |  16 +-
 arch/arm/boot/dts/sama5d2.dtsi                     |   1 +
 drivers/iio/adc/at91-sama5d2_adc.c                 | 237 ++++++++++++++++++++-
 4 files changed, 254 insertions(+), 6 deletions(-)

-- 
2.7.4
