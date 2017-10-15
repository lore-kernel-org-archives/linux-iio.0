Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750722AbdJOKvW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Oct 2017 06:51:22 -0400
Date: Sun, 15 Oct 2017 11:51:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PULL] Second set of IIO fixes for the 4.14 cycle.
Message-ID: <20171015115118.0090f5c9@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit b2e312061c5e9f533c44487862dc405094bf250a:

  Merge tag 'iio-fixes-for-4.14a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2017-09-25 10:58:22 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.14b

for you to fetch changes up to ca4c302398963c0cae29bc168e44cf91e40ff0d3:

  iio: adc: at91-sama5d2_adc: fix probe error on missing trigger property (2017-10-14 19:52:07 +0100)

----------------------------------------------------------------
Second set of IIO fixes for the 4.14 cycle.

* ade7759
  - Fix a signed extension bug.
* as3935
  - The default noise and watch dog settings were such that the device
    was unusuable in most applications.  Add device tree parameters to
    allow it to be configured to something that will actually work.
* at91-sama5d2 adc
  - Fix handling of legacy device trees that don't provide the new
    trigger edge property.
* dln2-adc
  - Fix a missing Kconfig dependency on IIO_TRIGGERED_BUFFER.
* dummy driver
  - Add a missing break so that writing in_voltage0_thresh_rising_en
    doesn't always result in an error.
* zpa2326
  - Drop a test for an always true condition so that gcc won't spit out
    and unused variable warning.

----------------------------------------------------------------
Colin Ian King (1):
      staging: iio: ade7759: fix signed extension bug on shift of a u8

Eugen Hristev (1):
      iio: adc: at91-sama5d2_adc: fix probe error on missing trigger property

Geert Uytterhoeven (1):
      iio: pressure: zpa2326: Remove always-true check which confuses gcc

Lars-Peter Clausen (1):
      iio: dummy: events: Add missing break

Matt Ranostay (1):
      iio: proximity: as3935: noise detection + threshold changes

Randy Dunlap (1):
      iio: adc: dln2-adc: fix build error

 .../ABI/testing/sysfs-bus-iio-proximity-as3935     |  8 ++++
 .../devicetree/bindings/iio/proximity/as3935.txt   |  5 +++
 drivers/iio/adc/Kconfig                            |  2 +
 drivers/iio/adc/at91-sama5d2_adc.c                 | 45 ++++++++++++++--------
 drivers/iio/dummy/iio_simple_dummy_events.c        |  1 +
 drivers/iio/pressure/zpa2326.c                     | 10 ++---
 drivers/iio/proximity/as3935.c                     | 43 +++++++++++++++++++--
 drivers/staging/iio/meter/ade7759.c                |  2 +-
 8 files changed, 89 insertions(+), 27 deletions(-)
