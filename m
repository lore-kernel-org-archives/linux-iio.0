Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59072 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674Ab2IQVcA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 17 Sep 2012 17:32:00 -0400
Message-ID: <505796CD.4090407@jic23.retrosnub.co.uk>
Date: Mon, 17 Sep 2012 22:31:57 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new device support and cleanups (set 4 for the 3.7 cycle)
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 7dd73b866ed656b4ef7b475de4588cb1a3f765d4:

  staging: ipack/bridges/tpci200: Use endianess-aware types where applicable. (2012-09-12 09:56:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-v3.7d

for you to fetch changes up to 87c5b10fd97937796dbf0769e8790a5f275b4a37:

  iio: ad7476: Add support for the ad7091r (2012-09-17 22:10:00 +0100)

----------------------------------------------------------------
IIO new drivers, features and rework for the 3.7 cycle, 4th set.

Here we have

1) a set cleaning up and moving the ad7476 driver out of staging.
Support for a number of additional parts is also added to that driver.

2) cleanups from various people for the in kernel interface code as that
is getting more an more real use and hence people are picking up on
minor issues that made it through review.  Also a related useful set
of utility functions to avoid duplicate code for converting IIO
representations to other forms.

3) a new fractional type for our read_raw / write_raw functions.
  This allows avoiding loss of accuracy via the in kernel interfaces in some
  cases as well as being rather convenient for a lot of range -> scale
  conversions.

4) New AD5755 DAC driver.

5) Some Blackfin timer trigger improvements including hardware pulse control
for device triggering.

6) Support for the ad7091r in the ad7476 driver.

----------------------------------------------------------------
Kim, Milo (2):
      iio: inkern: allocate zeroed memory
      iio: inkern: add error case in iio_channel_get()

Lars-Peter Clausen (19):
      staging:iio:ad7476: Fix off by one error for channel shift
      staging:iio:ad7476: Remove duplicated chip info entries
      staging:iio:ad7476: Avoid alloc/free for each sample in buffered mode
      staging:iio:ad7476: Rework reference voltage handling
      staging:iio:ad7476: Squash driver into a single file.
      staging:iio:ad7476: Use be16_to_cpup instead of open-coding it
      iio: Move ad7476 driver out of staging
      iio:ad7476: Add ad7910/ad7920 device table entries
      iio:ad7476: Add ad7940 support
      iio:ad7476: Add support for ad7273/ad7274/ad7276/ad7277/ad7278
      iio: Introduce a new fractional value type
      iio:dac: Add ad5755 driver
      iio: consumer.h: Fix kernel doc incosistency
      iio:inkern: Add function to read the processed value
      staging:iio:hwmon bridge: Use iio_read_channel_processed
      staging:iio:trigger:bfintmr: Avoid divide by zero
      staging:iio:trigger:bfintmr: Only enable timer when necessary
      staging:iio:trigger:bfintmr Add output support
      iio: ad7476: Add support for the ad7091r

anish kumar (1):
      iio: Documentation change for inkern interface.

 drivers/iio/adc/Kconfig                            |  15 +
 drivers/iio/adc/Makefile                           |   1 +
 .../iio/adc/ad7476_core.c => iio/adc/ad7476.c}     | 208 +++++--
 drivers/iio/dac/Kconfig                            |  11 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ad5755.c                           | 650 +++++++++++++++++++++
 drivers/iio/industrialio-core.c                    |   6 +
 drivers/iio/inkern.c                               | 131 ++++-
 drivers/staging/iio/Documentation/inkernel.txt     |   6 +-
 drivers/staging/iio/adc/Kconfig                    |  14 -
 drivers/staging/iio/adc/Makefile                   |   4 -
 drivers/staging/iio/adc/ad7476.h                   |  66 ---
 drivers/staging/iio/adc/ad7476_ring.c              |  64 --
 drivers/staging/iio/iio_hwmon.c                    |  33 +-
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c  | 109 +++-
 drivers/staging/iio/trigger/iio-trig-bfin-timer.h  |  24 +
 include/linux/iio/consumer.h                       |  42 +-
 include/linux/iio/iio.h                            |  17 +
 include/linux/iio/types.h                          |   1 +
 include/linux/platform_data/ad5755.h               | 103 ++++
 20 files changed, 1233 insertions(+), 273 deletions(-)
 rename drivers/{staging/iio/adc/ad7476_core.c => iio/adc/ad7476.c} (53%)
 create mode 100644 drivers/iio/dac/ad5755.c
 delete mode 100644 drivers/staging/iio/adc/ad7476.h
 delete mode 100644 drivers/staging/iio/adc/ad7476_ring.c
 create mode 100644 drivers/staging/iio/trigger/iio-trig-bfin-timer.h
 create mode 100644 include/linux/platform_data/ad5755.h
