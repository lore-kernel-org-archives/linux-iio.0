Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58050 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbbB1Lgi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Feb 2015 06:36:38 -0500
Message-ID: <54F1A845.2020109@kernel.org>
Date: Sat, 28 Feb 2015 11:36:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 4.0 set 2
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 533e80b1ea709577ec5cf73b8b566569bc711259:

  staging: lustre: lustre: libcfs: define symbols as static (2015-02-07 17:41:12 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.0b

for you to fetch changes up to 3608688973e8c85fbcd9b7e72b90e224b8d01526:

  iio: ak8975: fix AK09911 dependencies (2015-02-28 11:26:54 +0000)

----------------------------------------------------------------
Second round of IIO fixes for the 4.0 cycle (or round one part two really!)
These are fixes for patches in the recent merge window and are in a separate
branch to avoid rebasing the main fixes-togreg branch.

* jsa1212 - select missing REGMAP_I2C
* ssp_common - build warning fix for PM functions when PM not in use.
* ak8975 - the addition of a utility library for this driver (as part of
           adding new device support) led to a dependency not being inforced
	   for the original driver (I2C and GPIOLIB).

----------------------------------------------------------------
Arnd Bergmann (1):
      iio: ak8975: fix AK09911 dependencies

Geert Uytterhoeven (1):
      iio: common: ssp_sensors: Protect PM-only functions to kill warning

Roberta Dobrescu (1):
      iio: light: jsa1212: Select REGMAP_I2C

 drivers/iio/common/ssp_sensors/ssp_dev.c | 2 ++
 drivers/iio/light/Kconfig                | 1 +
 drivers/iio/magnetometer/Kconfig         | 2 ++
 3 files changed, 5 insertions(+)
The following changes since commit 533e80b1ea709577ec5cf73b8b566569bc711259:

  staging: lustre: lustre: libcfs: define symbols as static (2015-02-07 17:41:12 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.0b

for you to fetch changes up to 3608688973e8c85fbcd9b7e72b90e224b8d01526:

  iio: ak8975: fix AK09911 dependencies (2015-02-28 11:26:54 +0000)

----------------------------------------------------------------
Second round of IIO fixes for the 4.0 cycle (or round one part two really!)
These are fixes for patches in the recent merge window and are in a separate
branch to avoid rebasing the main fixes-togreg branch.

* jsa1212 - select missing REGMAP_I2C
* ssp_common - build warning fix for PM functions when PM not in use.
* ak8975 - the addition of a utility library for this driver (as part of
           adding new device support) led to a dependency not being inforced
	   for the original driver (I2C and GPIOLIB).

----------------------------------------------------------------
Arnd Bergmann (1):
      iio: ak8975: fix AK09911 dependencies

Geert Uytterhoeven (1):
      iio: common: ssp_sensors: Protect PM-only functions to kill warning

Roberta Dobrescu (1):
      iio: light: jsa1212: Select REGMAP_I2C

 drivers/iio/common/ssp_sensors/ssp_dev.c | 2 ++
 drivers/iio/light/Kconfig                | 1 +
 drivers/iio/magnetometer/Kconfig         | 2 ++
 3 files changed, 5 insertions(+)
