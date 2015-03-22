Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:9091 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751888AbbCVSdz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 22 Mar 2015 14:33:55 -0400
From: Octavian Purdila <octavian.purdila@intel.com>
To: jic23@kernel.org
Cc: lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
	linux-iio@vger.kernel.org,
	Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH v6 0/3] iio: add support for hardware fifo
Date: Sun, 22 Mar 2015 20:33:37 +0200
Message-Id: <1427049220-2876-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Changes since v5:

 * remove hwfifo_get_watermark operation from iio_info operations; the
   driver can expose it dirrectly as a read-only buffer attribute and
   there is not much gain from do it in the core

 * in the case of non-blocking read flush with the full to read amount

 * fix a few spelling errors

 * add hwfifo_watermark_min, hwfifo_watermark_max,
   hwfifo_watermark_available, hwfifo_enabled attributes to give
   userspace more information of how to select a watermark that can
   used to enable the hardware fifo

 * rename hwfifo_flush to hwfifo_flush_to_buffer

 * bmc150: avoid changing the iio_info to keep it constant

 * bmc150: rename irq and threaded irq handlers


Josselin Costanzi (1):
  iio: add watermark logic to iio read and poll

Octavian Purdila (2):
  iio: add support for hardware fifo
  iio: bmc150_accel: add support for hardware fifo

 Documentation/ABI/testing/sysfs-bus-iio  |  84 +++++++
 drivers/iio/accel/bmc150-accel.c         | 407 +++++++++++++++++++++++++++++--
 drivers/iio/industrialio-buffer.c        | 164 +++++++++++--
 drivers/iio/kfifo_buf.c                  |  11 +-
 drivers/staging/iio/accel/sca3000_ring.c |   4 +-
 include/linux/iio/buffer.h               |   8 +-
 include/linux/iio/iio.h                  |  13 +
 7 files changed, 641 insertions(+), 50 deletions(-)

-- 
1.9.1

