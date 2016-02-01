Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37867 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbcBAULF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Feb 2016 15:11:05 -0500
To: Greg KH <gregkh@linuxfoundation.org>
Subject: [PULL] First set of IIO fixes for the 4.5 cycle
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56AFBBD7.1040002@kernel.org>
Date: Mon, 1 Feb 2016 20:11:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit d590faf9e8f8509a0a0aa79c38e87fcc6b913248:

  iio: adis_buffer: Fix out-of-bounds memory access (2015-12-05 17:32:04 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.5a

for you to fetch changes up to 7e1da86339f29e445e40d41132c30741df8c19ad:

  iio: ade7753: avoid uninitialized data (2016-01-30 16:24:24 +0000)

----------------------------------------------------------------
First set of IIO fixes for the 4.5 cycle.

This set comprises those not dependent on patches in the 4.5 merge cycle.
A second set will follow shortly with ones that are.

* core in kernel interfaces
  - fix a possible NULL dereference that is a theoretical possibility
    via odd usage of iio_channel_release. Pretty much a hardening of
    the interface, but observed in the wild with the twl4030_charger
    driver.
* acpi-als
  - report the data as processed as it is in lux.  This fixes a wrong
    use of the IIO ABI.  However, old _raw version retained to avoid
    breaking any userspace in the wild that is relying on that (none
    known but it doesn't hurt us much to retain it)
* ade7753
  - fix some error handling to avoid use of unitialized data.
* ltr501
  - use a signed return type for ltr501_match_samp_freq so as to allow
    returning of an error code.
* mcp4725
  - set name field of struct iio_dev to ensure the sysfs name attribute
    doesn't give NULL.
* mpl115
  - temperature offset sign is wrong.
* stk8ba50
  - IIO_TRIGGER dependency added
* ti_am335x_adc
  - Label buffer as a software buffer. It's actually a hybrid of a
    true hardware buffer feeding a kfifo, but the meaning of these fields
    has changed a little recently and in this case it should be labeled
    a software buffer ensure it is allowed to use the kfifo.
* vf610_adc
  - HAS_IOMEM dependency

----------------------------------------------------------------
Akinobu Mita (1):
      iio: pressure: mpl115: fix temperature offset sign

Arnd Bergmann (1):
      iio: ade7753: avoid uninitialized data

Dan Carpenter (1):
      iio: inkern: fix a NULL dereference on error

Gabriele Mazzotta (1):
      iio: light: acpi-als: Report data as processed

Jonathan Cameron (1):
      iio:adc:ti_am335x_adc Fix buffered mode by identifying as software buffer.

Markus Elfring (1):
      iio-light: Use a signed return type for ltr501_match_samp_freq()

Vegard Nossum (2):
      iio: add IIO_TRIGGER dependency to STK8BA50
      iio: add HAS_IOMEM dependency to VF610_ADC

Yong Li (1):
      iio: dac: mcp4725: set iio name property in sysfs

 drivers/iio/accel/Kconfig           |  1 +
 drivers/iio/adc/Kconfig             |  1 +
 drivers/iio/adc/ti_am335x_adc.c     |  2 +-
 drivers/iio/dac/mcp4725.c           |  1 +
 drivers/iio/inkern.c                |  2 ++
 drivers/iio/light/acpi-als.c        |  6 ++++--
 drivers/iio/light/ltr501.c          |  2 +-
 drivers/iio/pressure/mpl115.c       |  2 +-
 drivers/staging/iio/meter/ade7753.c | 12 ++++++++++--
 9 files changed, 22 insertions(+), 7 deletions(-)
