Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46489 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab2GOSTl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Jul 2012 14:19:41 -0400
Message-ID: <500309B8.60009@kernel.org>
Date: Sun, 15 Jul 2012 19:19:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [GIT PULL] iio fixes for staging/staging-next.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 2b6e6b8042a9f783170b0a15e0550a075381726e:

  staging: comedi: rtd520: remove RtdDio0Read macro (2012-07-13 08:12:31 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git fixes-togreg

for you to fetch changes up to dcbc3c414e62faa4e1a1e17421f89eceea6bee30:

  iio staging: fix cast warning and cleanup alignment code (2012-07-15 17:33:18 +0100)

----------------------------------------------------------------
3 types of fix here.

1) Incorrect pointer casting via phys_addr_t which causes
   trouble on some architectures.
2) request_irq and free_irq dev_id parameters not matching.
3) Inconsistencies in client_data for some i2c devices
(writing one pointer and expecting another later).

----------------------------------------------------------------
Lars-Peter Clausen (4):
      staging:iio:adis16260: Fix drvdata inconsistency
      staging:iio:tsl2x7x: Fix client data inconsistency
      staging:iio:lpc32xx_adc: Ensure request_irq and free_irq dev_id parameter match
      staging:iio:tsl2x7x: Ensure request_irq and free_irq dev_id parameter match

Peter Meerwald (3):
      iio: fix pointer cast warning
      iio staging: fix cast warning
      iio staging: fix cast warning and cleanup alignment code

 drivers/iio/light/adjd_s311.c                 | 2 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c    | 3 +--
 drivers/staging/iio/adc/lpc32xx_adc.c         | 4 ++--
 drivers/staging/iio/gyro/adis16260_core.c     | 2 +-
 drivers/staging/iio/iio_simple_dummy_buffer.c | 2 +-
 drivers/staging/iio/light/tsl2x7x_core.c      | 5 ++---
 6 files changed, 8 insertions(+), 10 deletions(-)
