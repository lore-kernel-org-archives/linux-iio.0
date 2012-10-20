Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35882 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab2JTJh4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 20 Oct 2012 05:37:56 -0400
Message-ID: <508270F1.6080202@kernel.org>
Date: Sat, 20 Oct 2012 10:37:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for v3.7-rc1 set 1
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.7a

for you to fetch changes up to 98f9c3c137cea016c57c9fd60b3caf88eb34e4cd:

  iio: Remove duplicates for light/ in Kconfig and Makefile (2012-10-19 19:44:06 +0100)

----------------------------------------------------------------
First round of fixes for IIO in 3.7 cycle, applies to 3.7-rc1.

Mostly a round of fixes for Analog Devices MEMs devices where some
offset values were either completely incorrect, or in the wrong units.

Also removal of an accidental duplicate entry in a Kconfig file.

----------------------------------------------------------------
Andreas Larsson (1):
      iio: Remove duplicates for light/ in Kconfig and Makefile

Lars-Peter Clausen (11):
      iio: Add some helper macros for unit conversion
      staging:iio: Fix adis16201 channel offsets and scales
      staging:iio: Fix adis16203 channel offsets and scales
      staging:iio: Fix adis16204 channel offsets and scales
      staging:iio: Fix adis16209 channel offsets and scales
      staging:iio: Fix adis16220 channel offsets and scales
      staging:iio: Fix adis16240 channel offsets and scales
      staging:iio: Fix adis16260 channel offsets and scales
      staging:iio: Fix adis16400 channel offsets and scales
      staging:iio:adis16400: Report correct temperature scale and offset
      staging:iio:adis16400: Fixup adis16336 temp channel attributes

 drivers/iio/Kconfig                        |  1 -
 drivers/iio/Makefile                       |  1 -
 drivers/staging/iio/accel/adis16201_core.c | 24 +++++-----
 drivers/staging/iio/accel/adis16203_core.c | 20 +++++----
 drivers/staging/iio/accel/adis16204_core.c | 22 +++++-----
 drivers/staging/iio/accel/adis16209_core.c | 18 ++++----
 drivers/staging/iio/accel/adis16220_core.c | 19 ++++----
 drivers/staging/iio/accel/adis16240_core.c | 23 +++++-----
 drivers/staging/iio/gyro/adis16260_core.c  | 29 ++++++++-----
 drivers/staging/iio/imu/adis16400.h        |  2 +
 drivers/staging/iio/imu/adis16400_core.c   | 70 +++++++++++++++++++-----------
 include/linux/iio/iio.h                    | 16 +++++++
 12 files changed, 148 insertions(+), 97 deletions(-)
