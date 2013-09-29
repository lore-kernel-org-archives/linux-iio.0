Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58536 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755121Ab3I2T4N (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 Sep 2013 15:56:13 -0400
Message-ID: <52489407.4050302@kernel.org>
Date: Sun, 29 Sep 2013 21:56:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 3.12 set 2
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit bda2f8fca20b564ac8edb2b9c080d942c2144359:

  iio:buffer_cb: Add missing iio_buffer_init() (2013-09-21 12:52:50 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.12b

for you to fetch changes up to f09b44ed1d8553c8a91b8de8cfa05f2ea585ab0d:

  iio:magnetometer: Bugfix magnetometer default output registers (2013-09-28 12:03:24 +0100)

----------------------------------------------------------------
Second set of IIO fixes for the 3.12 cycle.

One large fix here to add reference counting to IIO's buffers
in order to prevent them being prematurely freed. The actual code addition
is small but needs to be repeated in a number of different places.

A few small additional fixes:
1) Make sure that debugfs entries are removed early enough to prevent
a race.
2) Drop a stray regulator_put from ad8366 left over from the devm_ patches.
3) The ST magnetometer driver had incorrect register addresses for the
   actual data channels.

----------------------------------------------------------------
Denis CIOCCA (1):
      iio:magnetometer: Bugfix magnetometer default output registers

Lars-Peter Clausen (2):
      iio: Add reference counting for buffers
      iio: Remove debugfs entries in iio_device_unregister()

Sachin Kamat (1):
      iio: amplifiers: ad8366: Remove regulator_put

 drivers/iio/amplifiers/ad8366.c                 |  4 +--
 drivers/iio/buffer_cb.c                         | 21 +++++++----
 drivers/iio/industrialio-buffer.c               | 41 +++++++++++++++++++---
 drivers/iio/industrialio-core.c                 |  6 +++-
 drivers/iio/industrialio-triggered-buffer.c     |  7 ++--
 drivers/iio/kfifo_buf.c                         |  8 ++++-
 drivers/iio/magnetometer/st_magn_core.c         | 18 +++++-----
 drivers/staging/iio/accel/lis3l02dq_ring.c      |  2 +-
 drivers/staging/iio/accel/sca3000_ring.c        | 13 ++++---
 drivers/staging/iio/iio_simple_dummy_buffer.c   |  2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c |  8 +++--
 drivers/staging/iio/meter/ade7758_ring.c        |  7 ++--
 include/linux/iio/buffer.h                      | 46 +++++++++++++++++++++++++
 13 files changed, 146 insertions(+), 37 deletions(-)
