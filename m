Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45516 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756169Ab3I3Tua (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Sep 2013 15:50:30 -0400
Message-ID: <5249E431.5050902@kernel.org>
Date: Mon, 30 Sep 2013 21:50:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 3.12 set 2 (take 2)
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit bda2f8fca20b564ac8edb2b9c080d942c2144359:

  iio:buffer_cb: Add missing iio_buffer_init() (2013-09-21 12:52:50 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.12b2

for you to fetch changes up to 512690daa6cc6dec0a4f776a0f0f3d729b029cf9:

  iio:magnetometer: Bugfix magnetometer default output registers (2013-09-30 21:46:11 +0100)

----------------------------------------------------------------
Second set of IIO fixes for the 3.12 cycle (take 2)

A few small fixes:
1) Make sure that debugfs entries are removed early enough to prevent
a race.
2) Drop a stray regulator_put from ad8366 left over from the devm_ patches.
3) The ST magnetometer driver had incorrect register addresses for the
   actual data channels.

----------------------------------------------------------------
Denis CIOCCA (1):
      iio:magnetometer: Bugfix magnetometer default output registers

Lars-Peter Clausen (1):
      iio: Remove debugfs entries in iio_device_unregister()

Sachin Kamat (1):
      iio: amplifiers: ad8366: Remove regulator_put

 drivers/iio/amplifiers/ad8366.c         |  4 +---
 drivers/iio/industrialio-core.c         |  2 +-
 drivers/iio/magnetometer/st_magn_core.c | 18 +++++++++---------
 3 files changed, 11 insertions(+), 13 deletions(-)
