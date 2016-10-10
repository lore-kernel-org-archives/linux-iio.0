Return-Path: <masneyb@onstation.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
Subject: [PATCH v2 0/8] staging: iio: isl29018: move out of staging
Date: Mon, 10 Oct 2016 03:19:54 -0400
Message-Id: <1476084002-29683-1-git-send-email-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

This is a series of cleanup patches to the ISL29018/ISL29023/ISL29035
driver to move it out of staging based on feedback from Jonathan
Cameron.

Brian Masney (8):
  staging: iio: isl29018: add newlines to improve readability
  staging: iio: isl29018: remove poorly named function
  staging: iio: isl29018: fix multiline comment syntax
  staging: iio: isl29018: combine two return statements into one
  staging: iio: isl29018: remove blank line for consistency
  staging: iio: isl29018: rename description in Kconfig for consistency
  staging: iio: isl29018: add ABI documentation for infrared suppression
  staging: iio: isl29018: move out of staging

 .../ABI/testing/sysfs-bus-iio-light-isl29018       |  19 +
 drivers/iio/light/Kconfig                          |  12 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/isl29018.c                       | 847 +++++++++++++++++++++
 drivers/staging/iio/light/Kconfig                  |  12 -
 drivers/staging/iio/light/Makefile                 |   1 -
 drivers/staging/iio/light/isl29018.c               | 847 ---------------------
 7 files changed, 879 insertions(+), 860 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-isl29018
 create mode 100644 drivers/iio/light/isl29018.c
 delete mode 100644 drivers/staging/iio/light/isl29018.c

-- 
2.5.5
