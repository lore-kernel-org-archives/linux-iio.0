Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39544 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846Ab3LQUuw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 17 Dec 2013 15:50:52 -0500
Message-ID: <52B0B92A.8090108@kernel.org>
Date: Tue, 17 Dec 2013 20:50:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 3.13 - set 3
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 55ef003e4ae684d5660f984eb2352df12572d9df:

  Merge tag 'iio-fixes-for-3.13b' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus
(2013-12-03 13:24:58 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.13c

for you to fetch changes up to e39d99059ad7f75d7ae2d3c59055d3c476cdb0d9:

  iio:adc:ad7887 Fix channel reported endianness from cpu to big endian (2013-12-17 20:37:14 +0000)

----------------------------------------------------------------
Third set of fixes for IIO in the 3.13 cycle.

* Fix for a bug in the new cm36651 driver where it told the IIO driver it
  was providing a decimal part, but then didn't.  Now it correctly tells the
  IIO core that it is only providing an integer value.  This prevents random
  incorrect values being output on a sysfs read.

* 3 fixes where drivers were miss specifying the endianness of their channels
  as output through the buffer interface.  These were discovered whilst
  removing the terrible IIO_ST macro once and for all.  The result is that
  userspace may be informed that the buffer elements are being output as
  little endian (on little endian platforms) when infact they are big endian.
  Thus userspace will handle them incorrectly.  This incorrect buffer
  element specification is provided as sysfs attributes under
  iio:deviceN/scan_elements.

----------------------------------------------------------------
Beomho Seo (1):
      iio: cm36651: Changed return value of read function

Jonathan Cameron (3):
      staging:iio:mag:hmc5843 fix incorrect endianness of channel as a result of missuse of the IIO_ST macro.
      iio:imu:adis16400 fix pressure channel scan type
      iio:adc:ad7887 Fix channel reported endianness from cpu to big endian

 drivers/iio/adc/ad7887.c                   | 16 ++++++++++++++--
 drivers/iio/imu/adis16400_core.c           |  7 ++++++-
 drivers/iio/light/cm36651.c                |  2 +-
 drivers/staging/iio/magnetometer/hmc5843.c |  7 ++++++-
 4 files changed, 27 insertions(+), 5 deletions(-)
