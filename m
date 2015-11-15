Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48242 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbbKORub (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Nov 2015 12:50:31 -0500
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] First set of iio fixes for the 4.4 cycle.
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5648C5E4.1060806@kernel.org>
Date: Sun, 15 Nov 2015 17:50:28 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit b94e22805a2224061bb263a82b72e09544a5fbb3:

  iio: mxs-lradc: Fix temperature offset (2015-10-11 15:02:02 +0100)

are available in the git repository at:

  ssh://gitolite@ra.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.4a

for you to fetch changes up to a57f8dac46fbac5ab0e31aef1a98b3f6eb30c079:

  iio: adc: xilinx: Fix VREFN scale (2015-11-15 12:36:20 +0000)

----------------------------------------------------------------
First set of IIO fixes for the 4.4 cycle.

This set does not include those for issues introduced during the merge
window.  Fixes of those will follow in a future series.

* ad5064
  - Make sure the local i2c_write returns 0 on success rather than the
    number of bytes transfered.  Otherwise we report an error on all writes.
  - Fix a shift for ad5629 and ad5669 which gives incorrect DAC output on
    these parts.
* ad7793
  - The product ID on the datasheet is wrong.  Fix it in the driver.
* IIO_DUMMY_EVGEN
  - select IRQ_WORK as a dependency.
* lpc32xx
  - make sure clock is prepared before enabling.
* si7020
  - data byte order was reversed. Fix it.
* vf610
  - Internal temperature calculation was wrong if a different
    reference voltage was used.  Now use a linear interpolation
    function to make it work over the full range.
  - Fix a division by zero in the case of a device tree property
    not being present (same issue two fixes).
* xilinx XADC
  - VREFN scale was wrong - fix it.

----------------------------------------------------------------
Arnd Bergmann (1):
      staging: iio: select IRQ_WORK for IIO_DUMMY_EVGEN

Bhuvanchandra DV (1):
      vf610_adc: Fix internal temperature calculation

Chris Lesiak (1):
      iio: si7020: Swap data byte order

Lars-Peter Clausen (2):
      iio: ad5064: Fix ad5629/ad5669 shift
      iio:ad7793: Fix ad7785 product ID

Michael Hennerich (1):
      iio:ad5064: Make sure ad5064_i2c_write() returns 0 on success

Sanchayan Maity (1):
      iio: adc: vf610_adc: Fix division by zero error

Thomas Betker (1):
      iio: adc: xilinx: Fix VREFN scale

Vladimir Zapolskiy (1):
      iio: lpc32xx_adc: fix warnings caused by enabling unprepared clock

 drivers/iio/adc/ad7793.c              |  2 +-
 drivers/iio/adc/vf610_adc.c           | 22 ++++++---
 drivers/iio/adc/xilinx-xadc-core.c    |  1 +
 drivers/iio/dac/ad5064.c              | 91 ++++++++++++++++++++++++-----------
 drivers/iio/humidity/si7020.c         |  8 +--
 drivers/staging/iio/Kconfig           |  3 +-
 drivers/staging/iio/adc/lpc32xx_adc.c |  4 +-
 7 files changed, 90 insertions(+), 41 deletions(-)
