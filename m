Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:56593 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751982AbaF2O4A (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 29 Jun 2014 10:56:00 -0400
Message-ID: <53B0297E.7040209@kernel.org>
Date: Sun, 29 Jun 2014 15:58:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Linux IIO List <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new drivers, features and cleanups for 3.17 - set 2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 88f6da779a37a3579e580296776ba86d6c6bd980:

   iio: accel: kxcjk1013 Fix missing unlock errors (2014-06-16 20:57:36 +0100)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.17b

for you to fetch changes up to 9dd4694dafbd8b44ac4ca740beede18ca67d725f:

   iio: staging: sca3000: hide stufftoread logic (2014-06-29 14:43:38 +0100)

----------------------------------------------------------------
Second round of new drivers and cleanups for IIO in the 3.17 cycle.

New drivers
* mcp4902, mcp4912 and mcp4922 SPI DAC driver.
* max1027, max1029 and max1031 SPI ADC driver.

Cleanups
* cm32181 - use devm APIs to simplify error paths.
* ak8975 - use devm APIs to simplify error paths.
* ad9850 - drop some unused defines and an unnecessary goto.
* hmc5843 - add missing devices to the device id table and the documentation.
* ad9832 - small formatting cleanups.
* sca3000 - hide direct use of the stufftoread element by adding a
     data_available function.  This is a precursor for the addition of buffer
     watermarks to the subsystem but stands as a good cleanup on its own.

----------------------------------------------------------------
Beomho Seo (2):
       iio: light: cm32181: Use devm_* APIs
       iio: magnetometer: ak8975: Use devm_* APIs

Federico Di Pierro (1):
       staging: iio: Coding style issues fix.

Guillaume Morin (1):
       staging: iio: ad9850.c: code cleanup

Josselin Costanzi (1):
       iio: staging: sca3000: hide stufftoread logic

Marek Belisko (2):
       staging: iio: hmc5843: Add all available models to device tree id table.
       Documentation: iio: Extend documentation for hmc5843 bindings.

Michael Welling (1):
       iio: dac: mcp4902/mcp4912/mcp4922 dac driver

Philippe Reynes (1):
       iio: add support of the max1027

  .../devicetree/bindings/iio/adc/max1027-adc.txt    |  22 +
  .../bindings/iio/magnetometer/hmc5843.txt          |   3 +
  drivers/iio/adc/Kconfig                            |   9 +
  drivers/iio/adc/Makefile                           |   1 +
  drivers/iio/adc/max1027.c                          | 521 +++++++++++++++++++++
  drivers/iio/dac/Kconfig                            |  10 +
  drivers/iio/dac/Makefile                           |   1 +
  drivers/iio/dac/mcp4922.c                          | 216 +++++++++
  drivers/iio/industrialio-buffer.c                  |   5 +-
  drivers/iio/light/cm32181.c                        |  11 +-
  drivers/iio/magnetometer/ak8975.c                  |  58 +--
  drivers/staging/iio/accel/sca3000_ring.c           |   6 +
  drivers/staging/iio/frequency/ad9832.c             |  14 +-
  drivers/staging/iio/frequency/ad9850.c             |   6 -
  drivers/staging/iio/magnetometer/hmc5843.c         |   4 +-
  15 files changed, 814 insertions(+), 73 deletions(-)
  create mode 100644 Documentation/devicetree/bindings/iio/adc/max1027-adc.txt
  create mode 100644 drivers/iio/adc/max1027.c
  create mode 100644 drivers/iio/dac/mcp4922.c
