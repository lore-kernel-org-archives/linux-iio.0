Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44737 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbaKESjP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Nov 2014 13:39:15 -0500
Message-ID: <545A6ED0.1000807@kernel.org>
Date: Wed, 05 Nov 2014 18:39:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 3.18 set 2
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 4748119f1889b4ce96c84831ad0581598081b46f:

  iio: adc: mxs-lradc: Disable the clock on probe failure (2014-11-05 18:33:44
+0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
tags/iio-fixes-for-3.18b

for you to fetch changes up to b598aacc29331e7e638cd509108600e916c6331b:

  staging:iio:ade7758: Remove "raw" from channel name (2014-11-05 18:33:48 +0000)

----------------------------------------------------------------
Second round of IIO fixes for the 3.18 cycle.

* tsl4531 - fix a compile error when CONFIG_PM_OPS not set.
* kxcjk-1013 - event spec direction was invalid - leading to 'interesting'
  attrribute names.
* as3935 - sizeof(st) used instead of sizeof(*st) leading to allocation of
  space for a pointer rather than the structure desired.
* ade7758 - Another null pointer deref fix due to different channels
  being provided to the the buffer register than used for the sysfs
  side of things.
* ade7758 - Check there is a channel enabled in preenable for the buffer
  before doing anything.
* ade7758 - Drop a stray raw from the channel name that leads to _raw_raw
  postfix.

----------------------------------------------------------------
Dan Murphy (1):
      iio: tsl4531: Fix compiler error when CONFIG_PM_OPS is not defined

Daniel Baluta (1):
      io: accel: kxcjk-1013: Fix iio_event_spec direction

George McCollister (1):
      iio: as3935: allocate correct iio_device size

Lars-Peter Clausen (3):
      staging:iio:ade7758: Fix NULL pointer deref when enabling buffer
      staging:iio:ade7758: Fix check if channels are enabled in prenable
      staging:iio:ade7758: Remove "raw" from channel name

 drivers/iio/accel/kxcjk-1013.c           |  2 +-
 drivers/iio/light/tsl4531.c              |  7 ++--
 drivers/iio/proximity/as3935.c           |  2 +-
 drivers/staging/iio/meter/ade7758.h      |  1 -
 drivers/staging/iio/meter/ade7758_core.c | 57 ++++++--------------------------
 drivers/staging/iio/meter/ade7758_ring.c |  5 ++-
 6 files changed, 20 insertions(+), 54 deletions(-)
