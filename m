Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33040 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386Ab3AARTR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Jan 2013 12:19:17 -0500
Message-ID: <50E31A8E.4050008@kernel.org>
Date: Tue, 01 Jan 2013 17:19:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for v3.8-rc1
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:

  Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.8a

for you to fetch changes up to 678fb42e2b2c815c3475884017aac4da22124d0d:

  iio: (max1363) Fix probe error path (2012-12-27 11:11:27 +0000)

----------------------------------------------------------------
First round of fixes for IIO post 3.8-rc1.

A set of worthy if rather dull little fixes.

* A whole set of incorrect error handling on regulator voltage requests.
* An error in the probe path for max1363.
* A couple of Kconfig issues with missing/ignored dependencies.
* A nasty shift vs compare typo in adf4350
* Bug fixes for a silly error that prevents at91_adc driver building.

----------------------------------------------------------------
Alexander Holler (1):
      iio: hid-sensors: respect CONFIG_IIO_TRIGGER

Axel Lin (7):
      iio: adc: ad7266: Don't set error code to st->vref_uv
      iio: dac: ad5380: Don't set error code to st->vref
      iio: dac: ad5791: Don't set error code to [pos|neg]_voltage_uv
      iio: dac: ad5504: Don't set error code to voltage_uv
      iio: dac: ad5624r_spi: Don't set error code to voltage_uv
      iio: dac: ad5686: Don't set error code to voltage_uv
      iio: dac: ad5446: Don't set error code to voltage_uv

Guenter Roeck (1):
      iio: (max1363) Fix probe error path

Jean-Christophe PLAGNIOL-VILLARD (1):
      iio: at91: fix dev var name in at91_adc_trigger_handler

Lars-Peter Clausen (1):
      staging:iio:adis16260: Select adislib

Michael Hennerich (1):
      iio:adf4350: Fix typo

 drivers/iio/accel/Kconfig               |  1 +
 drivers/iio/adc/ad7266.c                |  6 +++++-
 drivers/iio/adc/at91_adc.c              |  2 +-
 drivers/iio/adc/max1363.c               | 13 ++++++-------
 drivers/iio/common/hid-sensors/Kconfig  | 13 ++++++++++++-
 drivers/iio/common/hid-sensors/Makefile |  3 ++-
 drivers/iio/dac/ad5380.c                |  6 +++++-
 drivers/iio/dac/ad5446.c                |  6 +++++-
 drivers/iio/dac/ad5504.c                |  6 +++++-
 drivers/iio/dac/ad5624r_spi.c           |  6 +++++-
 drivers/iio/dac/ad5686.c                |  6 +++++-
 drivers/iio/dac/ad5791.c                | 13 +++++++++++--
 drivers/iio/frequency/adf4350.c         |  2 +-
 drivers/iio/gyro/Kconfig                |  1 +
 drivers/iio/light/Kconfig               |  1 +
 drivers/iio/magnetometer/Kconfig        |  1 +
 drivers/staging/iio/gyro/Kconfig        |  4 ++--
 17 files changed, 69 insertions(+), 21 deletions(-)
