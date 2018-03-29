Return-Path: <SRS0=2H+Q=GT=gmail.com=shreeya.patel23498@kernel.org>
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	daniel.baluta@gmail.com
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [PATCH v6 0/6] adis16209 driver cleanup
Date: Thu, 29 Mar 2018 14:40:02 +0530
Message-Id: <cover.1522306893.git.shreeya.patel23498@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patchset has been introduced for the cleanup of
adis16209 driver.
This patchset cleans up miscellaneous code fragments
and improves the code readability.
After the cleanup, driver is moved from staging to
mailine IIO subsystem directory.

Changes in v6
  -This patchset has some new patches introduced for more
cleanup and from the previous version, patch *[1/6] has
been included in this patch series.

Shreeya Patel (6):
  Staging: iio: adis16209: Indent the field definitions
  Staging: iio: adis16209: Prefer reverse christmas tree ordering
  Staging: iio: adis16209: Add blank lines
  Staging: iio: adis16209: Remove unused headers
  Staging: iio: adis16209: Use GENMASK
  Staging: iio: adis16209: Move adis16209 driver out of staging

 drivers/iio/accel/Kconfig             |  12 ++
 drivers/iio/accel/Makefile            |   1 +
 drivers/iio/accel/adis16209.c         | 330 +++++++++++++++++++++++++++++++++
 drivers/staging/iio/accel/Kconfig     |  12 --
 drivers/staging/iio/accel/Makefile    |   1 -
 drivers/staging/iio/accel/adis16209.c | 334 ----------------------------------
 6 files changed, 343 insertions(+), 347 deletions(-)
 create mode 100644 drivers/iio/accel/adis16209.c
 delete mode 100644 drivers/staging/iio/accel/adis16209.c

-- 
2.7.4
