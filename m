Return-Path: <SRS0=Um4Y=GO=onstation.org=masneyb@kernel.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: [PATCH 0/4] staging: iio: tsl2x7x: move out of staging
Date: Sat, 24 Mar 2018 16:05:51 -0400
Message-Id: <20180324200555.1403-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

Here is a patch series to move the tsl2x7x driver out of staging and
into mainline. Driver was tested using various TSL2X7X devices on a
Raspberry Pi 2.

Datasheet for the TSl2772:
https://ams.com/eng/content/download/291503/1066377/file/TSL2772_DS000181_2-00.pdf

Brian Masney (4):
  staging: iio: tsl2x7x: use auto increment I2C protocol
  staging: iio: tsl2x7x: move IIO_CHAN_INFO_CALIB{SCALE,BIAS} to
    IIO_LIGHT channel
  staging: iio: tsl2x7x: use either direction for
    IIO_EV_INFO_{ENABLE,PERIOD}
  staging: iio: tsl2x7x: move out of staging

 drivers/iio/light/Kconfig                          |   8 ++
 drivers/iio/light/Makefile                         |   1 +
 drivers/{staging => }/iio/light/tsl2x7x.c          | 135 +++++++++++++--------
 drivers/staging/iio/Kconfig                        |   1 -
 drivers/staging/iio/Makefile                       |   1 -
 drivers/staging/iio/light/Kconfig                  |  14 ---
 drivers/staging/iio/light/Makefile                 |   5 -
 .../linux/platform_data}/tsl2x7x.h                 |   0
 8 files changed, 93 insertions(+), 72 deletions(-)
 rename drivers/{staging => }/iio/light/tsl2x7x.c (95%)
 delete mode 100644 drivers/staging/iio/light/Kconfig
 delete mode 100644 drivers/staging/iio/light/Makefile
 rename {drivers/staging/iio/light => include/linux/platform_data}/tsl2x7x.h (100%)

-- 
2.14.3
