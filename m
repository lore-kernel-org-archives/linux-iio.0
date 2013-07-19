Return-Path: <Hector.Palacios@digi.com>
From: Hector Palacios <hector.palacios@digi.com>
To: <linux-iio@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree-discuss@lists.ozlabs.org>,
	<marex@denx.de>, <alexandre.belloni@free-electrons.com>, <jic23@kernel.org>,
	<lars@metafoo.de>, <fabio.estevam@freescale.com>, <hector.palacios@digi.com>
Subject: [PATCH v2 0/5] iio: mxs-lradc: add support to optional divider_by_two
Date: Fri, 19 Jul 2013 11:13:23 +0200
Message-ID: <1374225208-28940-1-git-send-email-hector.palacios@digi.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Greetings,

This is v2 of the patchset that adds support to the optional 
divider_by_two of LRADC channels. 

Changes in v2:
- Fix the sample mask passed by the touchscreen driver to the input
  subsytem, to be 12 bits.
- Move the reference voltages to the Device Tree.
- Rebased to avoid conflict with Marek Vasut's prior patch.
- Use IIO_DEVICE_ATTR() macro for adding scale_available property to
  all channels.
- Make 'is_divided' unsigned int.

Notes:
- Other fixes were discussed in v1 but they were not part of this
  patchset changes, and should be handled in a separate patch.
- The 64bit math to calculate the integer and decimal parts of the
  scaling attribute is a bit unreadable but used in other similar
  drivers like ad7791, ad7793, and ad7192. If it is to be changed
  it should be done in parallel with these, in a different patch.

The first patch changes the realbits to 12. The 
second adds the channels reference voltages to the DT.
The following add the scale read operation, scale_available read 
operation, and scale write operation.

This was tested on a custom i.MX28 platform.
Could someone please test on an i.MX23?

Hector Palacios (5):
  iio: mxs-lradc: change the realbits to 12
  ARM: dts: add reference voltage property for MXS LRADC
  iio: mxs-lradc: add scale attribute to channels
  iio: mxs-lradc: add scale_available file to channels
  iio: mxs-lradc: add write_raw function to modify scale

 .../bindings/staging/iio/adc/mxs-lradc.txt         |   9 +-
 arch/arm/boot/dts/imx23.dtsi                       |   4 +
 arch/arm/boot/dts/imx28.dtsi                       |   4 +
 drivers/staging/iio/adc/mxs-lradc.c                | 249 ++++++++++++++++++---
 4 files changed, 231 insertions(+), 35 deletions(-)
