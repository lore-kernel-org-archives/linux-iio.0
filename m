Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52873 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075Ab2GHTaD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jul 2012 15:30:03 -0400
Message-ID: <4FF9DFB7.70903@kernel.org>
Date: Sun, 08 Jul 2012 20:29:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Greg,

To get a clean start on doing this without merges this is on top of
your staging/staging-next tree of a few days back.

I 'think' the signed tag should be correct.

All comments welcome.

The following changes since commit 0932966b1ca03217c6e0c18375867b1a99ee5af0:

  staging: ccg: print MAC addresses via %pM (2012-07-06 16:24:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
tags/fixes-togreg_8_7_2012

for you to fetch changes up to 7b7627410e2c211f24787f61e6419e16d259aa13:

  iio: Fix inkern remove incorrect put of device (2012-07-08 20:02:31 +0100)

----------------------------------------------------------------
Mixed bag of IIO fixes.

Quite a few cases of interrupt handlers returning
errors and a few more specific bits and bobs.

Most of these only effect fairly obscure error
paths. The IRQF_ONESHOT one may cause trouble
given the requests will now be rejected.

Jonathan

8_7_2012

----------------------------------------------------------------
Jonathan Cameron (1):
      iio: Fix inkern remove incorrect put of device

Lars-Peter Clausen (13):
      iio: iio_buffer_register: Use correct channel when calculating
masklength
      staging:iio: Request threaded-only IRQs with IRQF_ONESHOT
      staging:iio:ad7298: Do not return error code in interrupt handler
      staging:iio:adt7310: Do not return error code in interrupt handler
      staging:iio:dummy driver: Do not return error code in interrupt
handler
      staging:iio:ad799x: Do not return error code in interrupt handler
      staging:iio:ad7476: Do not return error code in interrupt handler
      staging:iio:ad7887: Do not return error code in interrupt handler
      staging:iio:max1363: Do not return error code in interrupt handler
      staging:iio:lis3l02dq: Do not return error code in interrupt handler
      staging:iio:accel:adis16xxx: Do not return error code in the
interrupt handler
      staging:iio:adis16260: Do not return error code in the interrupt
handler
      staging:iio:adis16400: Do not return error code in the interrupt
handler

Sascha Hauer (3):
      iio: Fix unitialized use of list
      staging iio adt7410: sysfs store function must return length
      staging iio adt7410: fix 13bit mode

 drivers/iio/industrialio-buffer.c             |  2 +-
 drivers/iio/industrialio-event.c              |  3 ++-
 drivers/iio/inkern.c                          |  1 -
 drivers/staging/iio/accel/adis16201_ring.c    |  5 ++--
 drivers/staging/iio/accel/adis16203_ring.c    |  5 ++--
 drivers/staging/iio/accel/adis16204_ring.c    |  5 ++--
 drivers/staging/iio/accel/adis16209_ring.c    |  5 ++--
 drivers/staging/iio/accel/adis16240_ring.c    |  5 ++--
 drivers/staging/iio/accel/lis3l02dq_ring.c    |  5 ++--
 drivers/staging/iio/accel/sca3000_core.c      |  2 +-
 drivers/staging/iio/adc/ad7298_ring.c         |  4 ++-
 drivers/staging/iio/adc/ad7476_ring.c         |  2 +-
 drivers/staging/iio/adc/ad7816.c              |  2 +-
 drivers/staging/iio/adc/ad7887_ring.c         |  2 +-
 drivers/staging/iio/adc/ad799x_core.c         |  5 ++--
 drivers/staging/iio/adc/ad799x_ring.c         |  2 --
 drivers/staging/iio/adc/adt7310.c             |  9 ++++---
 drivers/staging/iio/adc/adt7410.c             | 36
+++++++++++----------------
 drivers/staging/iio/adc/max1363_ring.c        |  4 +--
 drivers/staging/iio/cdc/ad7150.c              |  6 +++--
 drivers/staging/iio/gyro/adis16260_ring.c     |  5 ++--
 drivers/staging/iio/iio_simple_dummy_buffer.c |  3 ++-
 drivers/staging/iio/imu/adis16400_ring.c      | 13 ++++------
 23 files changed, 67 insertions(+), 64 deletions(-)
