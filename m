Return-Path: <SRS0=6Xdg=H6=onstation.org=masneyb@kernel.org>
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
Subject: [PATCH v3 0/9] staging: iio: tsl2x7x: move out of staging
Date: Thu, 10 May 2018 20:12:14 -0400
Message-Id: <20180511001223.12378-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

Hopefully this is the last of the changes that are required for a
staging graduation. Changes since v2:

- Correct values returned in in_intensity0_integration_time_available so
  that it doesn't break expected ABI. The driver now uses the read_avail
  for all three *_available sysfs attributes.
- Remove unnecessary whitespace
- Direct returns
- Turn chip off if IIO registration fails
- Add range checking to tsl2x7x_write_raw

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

Brian Masney (9):
  staging: iio: tsl2x7x: remove unnecessary whitespace
  staging: iio: tsl2x7x: use direct returns
  staging: iio: tsl2x7x: turn chip off if IIO device registration fails
  staging: iio: tsl2x7x: use macro to populate tsl2X7X_device_info
  staging: iio: tsl2x7x: convert to use read_avail
  staging: iio: tsl2x7x: correct IIO_EV_INFO_PERIOD values
  staging: iio: tsl2x7x: add range checking to tsl2x7x_write_raw
  staging: iio: tsl2x7x: rename driver to tsl2772
  staging: iio: tsl2x7x/tsl2772: move out of staging

 drivers/iio/light/Kconfig                          |   8 +
 drivers/iio/light/Makefile                         |   1 +
 .../iio/light/tsl2x7x.c => iio/light/tsl2772.c}    | 886 +++++++++++----------
 drivers/staging/iio/Kconfig                        |   1 -
 drivers/staging/iio/Makefile                       |   1 -
 drivers/staging/iio/light/Kconfig                  |  14 -
 drivers/staging/iio/light/Makefile                 |   5 -
 .../linux/platform_data/tsl2772.h                  |  51 +-
 8 files changed, 494 insertions(+), 473 deletions(-)
 rename drivers/{staging/iio/light/tsl2x7x.c => iio/light/tsl2772.c} (59%)
 delete mode 100644 drivers/staging/iio/light/Kconfig
 delete mode 100644 drivers/staging/iio/light/Makefile
 rename drivers/staging/iio/light/tsl2x7x.h => include/linux/platform_data/tsl2772.h (70%)

-- 
2.14.3
