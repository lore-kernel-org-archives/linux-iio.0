Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53689 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166AbaBTSr6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Feb 2014 13:47:58 -0500
Message-ID: <53064E04.10503@kernel.org>
Date: Thu, 20 Feb 2014 18:48:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Linux IIO List <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 3.14 round 3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 55b40d37311807a6bb2acdae0df904f54a0da3ae:

   iio: max1363: Use devm_regulator_get_optional for optional regulator (2014-02-08 11:46:00 +0000)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.14c

for you to fetch changes up to a0657716416f834ef7710a9044614d50a36c3bdc:

   iio:gyro: bug on L3GD20H gyroscope support (2014-02-18 10:24:49 +0000)

----------------------------------------------------------------
Third round of fixes for IIO in the 3.14 cycle.

Fixes to 2 Capella light sensor drivers where the units of the integration
time reported to userspace were out be a factor of a thousand.
These patches are as large as they are purely due to a variable rename
tied up with the incorrect scale.  The actual change is only a couple of lines.

1 patch dropping L3GD20H from the st gyroscope driver.  It never actually
worked as the address set is different from any others supported by the
driver currently.   An additional patch enables correct support for this
part but is too large to sensibly apply as a fix to some support that never
actually allowed the driver to be successfully probed on this part.

----------------------------------------------------------------
Beomho Seo (2):
       iio: cm36651: Fix read/write integration time function.
       iio: cm32181: Change cm32181 ambient light sensor driver

Denis CIOCCA (1):
       iio:gyro: bug on L3GD20H gyroscope support

  drivers/iio/gyro/Kconfig        |  2 +-
  drivers/iio/gyro/st_gyro.h      |  1 -
  drivers/iio/gyro/st_gyro_core.c |  9 ++++-----
  drivers/iio/gyro/st_gyro_i2c.c  |  1 -
  drivers/iio/gyro/st_gyro_spi.c  |  1 -
  drivers/iio/light/cm32181.c     | 16 +++++++--------
  drivers/iio/light/cm36651.c     | 45 +++++++++++++++++++++--------------------
  7 files changed, 36 insertions(+), 39 deletions(-)
