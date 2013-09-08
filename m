Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org
Subject: [PATCH 0/4] add INT_TIME and drivers using it
Date: Sun,  8 Sep 2013 17:20:55 +0200
Message-Id: <1378653659-15665-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

the INT_TIME introduction received an informal nod by Jon Brenner,
the tsl4531 driver has been updated to v3 due to comments by Lars-Peter
Clausen

Peter Meerwald (4):
  iio: Add INT_TIME (integration time) channel info attribute
  iio: adjd_s311: Use INT_TIME channel info
  iio: Add tsl4531 ambient light sensor driver
  iio: Add tcs3472 color light sensor driver

 Documentation/ABI/testing/sysfs-bus-iio |   12 +
 drivers/iio/industrialio-core.c         |    1 +
 drivers/iio/light/Kconfig               |   20 ++
 drivers/iio/light/Makefile              |    2 +
 drivers/iio/light/adjd_s311.c           |   72 ++----
 drivers/iio/light/tcs3472.c             |  373 +++++++++++++++++++++++++++++++
 drivers/iio/light/tsl4531.c             |  258 +++++++++++++++++++++
 include/linux/iio/iio.h                 |    1 +
 include/linux/iio/sysfs.h               |   15 ++
 9 files changed, 703 insertions(+), 51 deletions(-)
 create mode 100644 drivers/iio/light/tcs3472.c
 create mode 100644 drivers/iio/light/tsl4531.c

-- 
1.7.9.5
