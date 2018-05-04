Return-Path: <SRS0=zzH2=HX=onstation.org=masneyb@kernel.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	drew.paterson@ams.com
Subject: [PATCH v2 00/11] staging: iio: tsl2x7x: move out of staging
Date: Thu,  3 May 2018 22:53:08 -0400
Message-Id: <20180504025319.28953-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

Here is a patch set that should hopefully be the last of the changes
required for a staging graduation. Changes since v1:

- Use correct syntax for SPDX license identifier
- Use kstrtou16 for range checking
- Correct integration time sysfs attribute. This fix required correcting
  all of the equations and coefficients. Fortunately TAOS / AMS has
  really good documentation available.
- Rename driver from tsl2x7x to tsl2772.

Datasheet for TSL2772
https://ams.com/eng/content/download/291503/1066377/file/TSL2772_DS000181_2-00.pdf

Other datasheets:

ALS only
- https://ams.com/eng/content/download/250043/975277/file/TSL2571_DS000114_2-00.pdf
- https://ams.com/eng/content/download/291224/1065822/file/TSL2572_DS000178_2-00.pdf

Proximity Only
- https://ams.com/eng/content/download/250323/976177/file/TSL2671_DS000111_2-00.pdf
- https://ams.com/eng/content/download/250304/976107/file/TMD2671_DS000176_2-00.pdf
- https://ams.com/eng/content/download/291443/1066277/file/TSL2672_Datasheet_EN_v1.pdf
- https://ams.com/eng/content/download/364923/1210537/file/TMD2672_Datasheet_EN_v1.pdf

ALS / Proximity
- https://ams.com/eng/content/download/250264/976045/file/TSL2771_DS000105_3-00.pdf
- https://ams.com/eng/content/download/250283/976077/file/TMD2771_DS000177_2-00.pdf
- https://ams.com/eng/content/download/365023/1210677/file/TMD2772-E.pdf

Brian Masney (11):
  staging: iio: tsl2x7x: use GPL-2.0+ SPDX license identifier
  staging: iio: tsl2x7x: add range checking to three sysfs attributes
  staging: iio: tsl2x7x: don't setup event handlers if interrupts are
    not configured
  staging: iio: tsl2x7x: move calibscale_available attribute to
    IIO_INTENSITY channel
  staging: iio: tsl2x7x: use IIO_CONST_ATTR for calibscale_available
  staging: iio: tsl2x7x: correct integration time and lux equation
  staging: iio: tsl2x7x: support 2.72 and 2.73 ALS increments
  staging: iio: tsl2x7x: add device ids for code readability
  staging: iio: tsl2x7x: correct IIO_EV_INFO_PERIOD values
  staging: iio: tsl2x7x: rename driver to tsl2772
  staging: iio: tsl2x7x/tsl2772: move out of staging

 drivers/iio/light/Kconfig                          |    8 +
 drivers/iio/light/Makefile                         |    1 +
 .../iio/light/tsl2x7x.c => iio/light/tsl2772.c}    | 1137 ++++++++++----------
 drivers/staging/iio/Kconfig                        |    1 -
 drivers/staging/iio/Makefile                       |    1 -
 drivers/staging/iio/light/Kconfig                  |   14 -
 drivers/staging/iio/light/Makefile                 |    5 -
 .../linux/platform_data/tsl2772.h                  |   65 +-
 8 files changed, 631 insertions(+), 601 deletions(-)
 rename drivers/{staging/iio/light/tsl2x7x.c => iio/light/tsl2772.c} (50%)
 delete mode 100644 drivers/staging/iio/light/Kconfig
 delete mode 100644 drivers/staging/iio/light/Makefile
 rename drivers/staging/iio/light/tsl2x7x.h => include/linux/platform_data/tsl2772.h (58%)

-- 
2.14.3
