Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56078 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405AbbGWURS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2015 16:17:18 -0400
To: Greg KH <gregkh@linuxfoundation.org>
Subject: [PULL] Third set of IIO fixes for the 4.2 cycle.
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55B14BCC.30803@kernel.org>
Date: Thu, 23 Jul 2015 21:17:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 7eb7ee30559c9c88ca23fa3b95bd06629669d0a8:

  staging: vt6656: check ieee80211_bss_conf bssid not NULL (2015-07-19 11:48:19 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.2c

for you to fetch changes up to 423ad0c405d87868bd1ab19e8b503e6a41c86caf:

  iio:light:stk3310: make endianness independent of host (2015-07-19 14:54:45 +0100)

----------------------------------------------------------------
3rd round of IIO fixes for the 4.2 cycle.

* bmc150_magn - add missing regmap dependency and ensure on a wrong chip
  case report hte chip id rather than a previous return value.
* mmc35240 - Fill a null pointer derefrence and wrong SET / RESET logic
  that results in North and South being swapped.
* mlx96014 - correct the offset value reported to userspace (wrong sign)
* vf610 - Prevent non aligned register reading.
* mcp320x - Another null pointer deference bug.
* mma8452 - change threshold type from THRESH to MAG to reflect the fact
  that the sign of the signal is not known when the event is signaled.
* stk3310 - move device registert to end of probe to avoid race conditions
  when coming up, check for invalid client->irq values and make it work
  for both endian types of host.

----------------------------------------------------------------
Crt Mori (1):
      iio: mlx96014: Replace offset sign

Daniel Baluta (2):
      iio: magnetometer: mmc35240: Fix crash in pm suspend
      iio: magnetometer: mmc35240: Fix SET/RESET mask

Fugang Duan (1):
      iio: adc: vf610: fix the adc register read fail issue

Hartmut Knaack (4):
      iio:magnetometer:bmc150_magn: add regmap dependency
      iio:magnetometer:bmc150_magn: output intended variable
      iio:light:stk3310: move device register to end of probe
      iio:light:stk3310: make endianness independent of host

Manfred Schlaegl (1):
      iio: mcp320x: Fix NULL pointer dereference

Martin Kepplinger (1):
      iio: mma8452: use iio event type IIO_EV_TYPE_MAG

Viorel Suman (1):
      iio: magnetometer: mmc35240: fix SET/RESET sequence

 drivers/iio/accel/mma8452.c            |  8 ++++----
 drivers/iio/adc/mcp320x.c              |  2 ++
 drivers/iio/adc/vf610_adc.c            |  2 +-
 drivers/iio/light/stk3310.c            | 26 +++++++++++++-------------
 drivers/iio/magnetometer/Kconfig       |  1 +
 drivers/iio/magnetometer/bmc150_magn.c |  4 ++--
 drivers/iio/magnetometer/mmc35240.c    | 12 +++++++-----
 drivers/iio/temperature/mlx90614.c     |  2 +-
 8 files changed, 31 insertions(+), 26 deletions(-)
