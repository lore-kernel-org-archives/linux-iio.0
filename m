Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52342 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbaKPVII (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 16 Nov 2014 16:08:08 -0500
Message-ID: <54691234.4030309@kernel.org>
Date: Sun, 16 Nov 2014 21:08:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 3.18 set 3
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit b598aacc29331e7e638cd509108600e916c6331b:

  staging:iio:ade7758: Remove "raw" from channel name (2014-11-05 18:33:48 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.18c

for you to fetch changes up to 9e8e228f2bf066c37eeee7c25b810cad3235427a:

  iio: accel: bmc150: set low default thresholds (2014-11-16 20:25:00 +0000)

----------------------------------------------------------------
Third set of IIO fixes for the 3.18 cycle.

Most of these are fairly standard little fixes, a bmc150 and bmg160 patch
is to make an ABI change to indicated a specific axis in an event rather
than the generic option in the original drivers.  As both of these drivers
are new in this cycle it would be ideal to push this minor change through
even though it isn't strictly a fix.  A couple of other 'fixes' change
defaults for some settings on these new drivers to more intuitive calues.
Looks like some useful feedback has been coming in for this driver
since it was applied.

* IIO_EVENT_CODE_EXTRACT_DIR bit mask was wrong and has been for a while
  0xCF clearly doesn't give a contiguous bitmask.
* kxcjk-1013 range setting was failing to mask out the previous value
  in the register and hence was 'enable only'.
* men_z188 device id table wasn't null terminated.
* bmg160 and bmc150 both failed to correctly handling an error in mode
  setting.
* bmg160 and bmc150 both had a bug in setting the event direction in the
  event spec (leads to an attribute name being incorrect)
* bmg160 defaulted to an open drain output for the interrupt - as a default
  this obviously only works with some interrupt chips - hence change the
  default to push-pull (note this is a new driver so we aren't going to
  cause any regressions with this change).
* bmc150 had an unintuitive default for the rate of change (motion detector)
  so change it to 0 (new driver so change of default won't cause any
  regressions).

----------------------------------------------------------------
Axel Lin (1):
      iio: adc: men_z188_adc: Add terminating entry for men_z188_ids

Cristina Ciocan (1):
      iio: Fix IIO_EVENT_CODE_EXTRACT_DIR bit mask

Daniel Baluta (1):
      iio: accel: kxcjk-1013: Fix kxcjk10013_set_range

Srinivas Pandruvada (8):
      iio: gyro: bmg160: Error handling when mode set fails
      iio: gyro: bmg160: Don't let interrupt mode to be open drain
      iio: gyro: bmg160: Send x, y and z motion separately
      iio: gyro: bmg160: Fix iio_event_spec direction
      iio: accel: bmc150: Error handling when mode set fails
      iio: accel: bmc150: Send x, y and z motion separately
      iio: accel: bmc150: Fix iio_event_spec direction
      iio: accel: bmc150: set low default thresholds

 drivers/iio/accel/bmc150-accel.c | 40 ++++++++++++++++++++++++------
 drivers/iio/accel/kxcjk-1013.c   |  2 ++
 drivers/iio/adc/men_z188_adc.c   |  1 +
 drivers/iio/gyro/bmg160.c        | 53 +++++++++++++++++++++++++++++++++++++---
 include/linux/iio/events.h       |  2 +-
 5 files changed, 86 insertions(+), 12 deletions(-)
