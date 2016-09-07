Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41927 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbcIGTCW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Sep 2016 15:02:22 -0400
To: Greg KH <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] Second set of IIO fixes for the 4.8 cycle.
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0a6aaf7b-3fa8-2b18-0d43-c5c726de39c4@kernel.org>
Date: Wed, 7 Sep 2016 20:02:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit eafe5cfe718926c1ed8b3dacd2191c189b3cdcd2:

  Merge tag 'iio-fixes-for-4.8a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into work-linus (2016-08-23 17:39:31 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.8b

for you to fetch changes up to 171c0091837c81ed5c949fec6966bb5afff2d1cf:

  iio:core: fix IIO_VAL_FRACTIONAL sign handling (2016-09-05 21:21:32 +0100)

----------------------------------------------------------------
Second set of IIO fixes for the 4.8 cycle.

We have a big rework of the kxsd9 driver queued up behind the fix below and
a fix for a recent fix that was marked for stable.
Hence this fix series is perhaps a little more urgent than average for IIO.
* core
  - a fix for a fix in the last set.  The recent fix for blocking ops when
   ! task running left a path (unlikely one) in which the function return
   value was not set - so initialise it to 0.
  - The IIO_TYPE_FRACTIONAL code previously didn't cope with negative
  fractions.  Turned out a fix for this was in Analog's tree but hadn't made
  it upstream.
* bmc150
  - reset chip at init time. At least one board out there ends up coming up
  in an unstable state due to noise during power up.  The reset does no
  harm on other boards.
* kxsd9
  - Fix a bug in the reported scaling due to failing to set the integer
  part to 0.
* hid-sensors-pressure
  - Output was in the wrong units to comply with the IIO ABI.
* tools
  - iio_generic_buffer: Fix the trigger-less mode by ensuring we don't fault
    out for having no trigger when we explicitly said we didn't want to have
    one.

----------------------------------------------------------------
Colin Ian King (1):
      iio: ensure ret is initialized to zero before entering do loop

Gregor Boirie (2):
      tools:iio:iio_generic_buffer: fix trigger-less mode
      iio:core: fix IIO_VAL_FRACTIONAL sign handling

Kweh, Hock Leong (1):
      iio: fix pressure data output unit in hid-sensor-attributes

Linus Walleij (1):
      iio: accel: kxsd9: Fix scaling bug

Olof Johansson (1):
      iio: accel: bmc150: reset chip at init time

 drivers/iio/accel/bmc150-accel-core.c                  | 11 +++++++++++
 drivers/iio/accel/kxsd9.c                              |  1 +
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c |  4 ++--
 drivers/iio/industrialio-buffer.c                      |  4 ++--
 drivers/iio/industrialio-core.c                        |  5 ++---
 tools/iio/iio_generic_buffer.c                         |  2 +-
 6 files changed, 19 insertions(+), 8 deletions(-)
