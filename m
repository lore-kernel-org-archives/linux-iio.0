Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60213 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752448AbcJWVhr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2016 17:37:47 -0400
To: Greg KH <gregkh@linuxfoundation.org>
Subject: [PULL] First round of IIO fixes for the 4.9 cycle.
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8d03f506-a64a-a1de-f082-e1b003aea225@kernel.org>
Date: Sun, 23 Oct 2016 22:37:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 0ae952e3bd1c761d4952c8ff1a259292e4f03e89:

  staging: wlan-ng: fix block comments style errors (2016-09-25 19:54:45 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.9a

for you to fetch changes up to 64bc2d02d754f4143d65cc21c644176db12ab5c8:

  iio: accel: sca3000_core: avoid potentially uninitialized variable (2016-10-23 22:18:45 +0100)

----------------------------------------------------------------
First set of IIO fixes for the 4.9 cycle.

* atlas chemical
  - Fix alignment of big endian values in a larger storage (by using the right
  size storage)
* maxim thermocouple
  - Fix alignment of big endian values in larger (by using the correct
  sized storage).
* sca3000
  - Handle unexpected mode values.
* ti-adc081
  - Select IIO_TRIGGERED_BUFFER to avoid build errors

----------------------------------------------------------------
Arnd Bergmann (1):
      iio: accel: sca3000_core: avoid potentially uninitialized variable

Mika Westerberg (1):
      iio: adc: ti-adc081c: Select IIO_TRIGGERED_BUFFER to prevent build errors

Sandhya Bankar (1):
      iio:chemical:atlas-ph-sensor: Fix use of 32 bit int to hold 16 bit big endian value

sayli karnik (1):
      iio: maxim_thermocouple: Align 16 bit big endian value of raw reads

 drivers/iio/adc/Kconfig                      |  2 ++
 drivers/iio/chemical/atlas-ph-sensor.c       |  7 ++++---
 drivers/iio/temperature/maxim_thermocouple.c | 16 +++++++++-------
 drivers/staging/iio/accel/sca3000_core.c     |  2 ++
 4 files changed, 17 insertions(+), 10 deletions(-)
