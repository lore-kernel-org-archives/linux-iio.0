Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57508 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbbEXQMX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 May 2015 12:12:23 -0400
Message-ID: <5561F865.3070200@kernel.org>
Date: Sun, 24 May 2015 17:12:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for the 4.1 cycle, round 2
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit ec94efcdadab69f41d257a1054260f8295ab77ef:

  Merge tag 'iio-fixes-for-4.1a-take2' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2015-05-13 11:51:14 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.1b

for you to fetch changes up to e5d732186270e0881f47d95610316c0614b21c3e:

  iio: adc: twl6030-gpadc: Fix modalias (2015-05-23 12:30:52 +0100)

----------------------------------------------------------------
Second round of fixes for IIO in the 4.1 cycle.

* twl6030-gpadc - Drop a bonus space from the modalias.
* adis16400 - Report pressure channel scale (not much use without it)
            - Use different channel indices for the two voltage channels (ABI)
	    - Compute the san mask from the channel indices instead of using
	      ~0UL as we now care about extra bits being set.
	    - Fix burst mode due to rx buffer not being intialized and wrong
	      tx buffer type being set.  Also had the wrong transfer length.
	      All in all it didn't work, now it does ;)
	    - adis16448 has additional registers in burst mode so we skip
	      over them to make it work.

----------------------------------------------------------------
Axel Lin (1):
      iio: adc: twl6030-gpadc: Fix modalias

Lars-Peter Clausen (2):
      iio: adis16400: Report pressure channel scale
      iio: adis16400: Fix burst transfer for adis16448

Paul Cercueil (3):
      iio: adis16400: Use != channel indices for the two voltage channels
      iio: adis16400: Compute the scan mask from channel indices
      iio: adis16400: Fix burst mode

 drivers/iio/adc/twl6030-gpadc.c    |  2 +-
 drivers/iio/imu/adis16400.h        |  2 ++
 drivers/iio/imu/adis16400_buffer.c | 26 ++++++++++++++++--------
 drivers/iio/imu/adis16400_core.c   | 41 +++++++++++++++++++++++++++-----------
 4 files changed, 50 insertions(+), 21 deletions(-)
