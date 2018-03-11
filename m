Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932136AbeCKNl4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Mar 2018 09:41:56 -0400
Date: Sun, 11 Mar 2018 13:41:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PULL] Second set of IIO fixes for the 4.16 cycle
Message-ID: <20180311134152.04767f22@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit c6754712e05317923e3f67ac01d45c7d5ec6f79f:

  Merge tag 'iio-fixes-for-4.16a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2018-02-20 10:03:22 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.16b

for you to fetch changes up to 8b438686a001db64c21782d04ef68111e53c45d9:

  iio: st_pressure: st_accel: pass correct platform data to init (2018-03-10 16:28:05 +0000)

----------------------------------------------------------------
Second set of IIO fixes for the 4.16 cycle.

A slightly fiddly revert then fix pair in here as the bug lead to
an unused local variable that was then removed without us noticing
the bug.  The revert should only be needed on 4.16 - the fix
goes back futher.

* ccs811
  - Fix the transition from 'boot' to 'application' mode.  Fixes the case
    where the power is not cut between boot cycles.
* meson-saradc
  - Fix missing mutex_unlock in an error path.
* sd-modulator
  - Fix bindings doc to have the right value of io-channel-cells to reflect
    that this device type only ever outputs one channel.
* st-accel
  - Revert drop of redundant pointer patch.
  - Use the now available pointer to avoid overwriting the platform data
    pointer and causing trouble on reprobing the driver.
* st-pressure
  - Use local copy of the platform data pointer to avoid overwriting the
    one associated with the device, which would cause issues on reprobing
    the driver.
* stm32-dfsdm
  - Use the right regmap_cfg for the type of device.
  - Correct the ID passed to stop channel to be the channel one.
  - Correct which clock is used to allow for the 'audio' clock.
  - Fix allocation of channels when more than one is enabled.

----------------------------------------------------------------
Dan Carpenter (1):
      iio: adc: meson-saradc: unlock on error in meson_sar_adc_lock()

Fabrice Gasnier (5):
      iio: adc: stm32-dfsdm: fix compatible data use
      iio: adc: stm32-dfsdm: fix call to stop channel
      iio: adc: stm32-dfsdm: fix clock source selection
      iio: adc: stm32-dfsdm: fix multiple channel initialization
      dt-bindings: iio: adc: sd-modulator: fix io-channel-cells

Jonathan Cameron (1):
      Revert "iio: accel: st_accel: remove redundant pointer pdata"

Michael Nosthoff (1):
      iio: st_pressure: st_accel: pass correct platform data to init

Richard Lai (1):
      iio: chemical: ccs811: Corrected firmware boot/application mode transition

 .../bindings/iio/adc/sigma-delta-modulator.txt     |  4 +--
 drivers/iio/accel/st_accel_core.c                  |  7 +++-
 drivers/iio/adc/meson_saradc.c                     |  4 ++-
 drivers/iio/adc/stm32-dfsdm-adc.c                  | 39 ++++++++++++----------
 drivers/iio/adc/stm32-dfsdm-core.c                 | 12 +++++--
 drivers/iio/chemical/ccs811.c                      |  3 ++
 drivers/iio/pressure/st_pressure_core.c            |  2 +-
 7 files changed, 46 insertions(+), 25 deletions(-)
