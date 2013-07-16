Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41076 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932Ab3GPIOZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jul 2013 04:14:25 -0400
Message-ID: <51E500E0.7000805@kernel.org>
Date: Tue, 16 Jul 2013 09:14:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 3.11 - set 1
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 0ad1ea69545b1965be4c93ee03fdc685c6beb23d:

  Revert "Revert "Revert "staging/lustre: drop CONFIG_BROKEN dependency""" (2013-06-24 16:47:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.11a

for you to fetch changes up to 67dbf54a3b03881c7b683801fa49ca1f2c4c3bcf:

  iio: lps331ap: Fix wrong in_pressure_scale output value (2013-07-16 08:51:57 +0100)

----------------------------------------------------------------
The first round of IIO fixes for the 3.11 cycle.

This set is larger than I would like, partly due to my lack of review
time in the weeks before the merge window and partly because a
couple of large drivers and the subsystem as a whole seem to be
getting a lot more exposure and testing recently.

1) A long term bug in trigger handling gave a double free of the device.

2) Wrong return value handling means offsets are ignored in
   iio_convert_raw_to_processed_unlocked.

3) The iio_channel_has_info utility function was incorrectly updated
   during the recent info_mask split, this is now fixed.

4) mxs-lradc has a couple of little fixes.

5) A couple of missing .driver_module entries meant that drivers
   could be removed from underneath their users.

6) Error path fixes for ad7303 and lis3l02dq.

7) The scale value for presure in the lps331ap driver was out by
   a factor of 100.

----------------------------------------------------------------
Alexandre Belloni (2):
      iio: Fix iio_channel_has_info
      iio: inkern: fix iio_convert_raw_to_processed_unlocked

Jacek Anaszewski (1):
      iio: lps331ap: Fix wrong in_pressure_scale output value

Jonathan Cameron (1):
      iio:trigger: device_unregister->device_del to avoid double free

Marek Vasut (2):
      iio: mxs-lradc: Fix misuse of iio->trig
      iio: mxs-lradc: Remove useless check in read_raw

Peter Meerwald (1):
      iio staging: fix lis3l02dq, read error handling

Wei Yongjun (3):
      iio: dac: ad7303: fix error return code in ad7303_probe()
      iio: ti_am335x_adc: add missing .driver_module to struct iio_info
      staging:iio:ad7291: add missing .driver_module to struct iio_info

 drivers/iio/adc/ti_am335x_adc.c            |  1 +
 drivers/iio/dac/ad7303.c                   |  4 +++-
 drivers/iio/industrialio-trigger.c         |  2 +-
 drivers/iio/inkern.c                       |  2 +-
 drivers/iio/pressure/st_pressure_core.c    |  6 ++++--
 drivers/staging/iio/accel/lis3l02dq_core.c |  2 ++
 drivers/staging/iio/adc/ad7291.c           |  1 +
 drivers/staging/iio/adc/mxs-lradc.c        | 18 +++++++-----------
 include/linux/iio/iio.h                    |  4 ++--
 9 files changed, 22 insertions(+), 18 deletions(-)
