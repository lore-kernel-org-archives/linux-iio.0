Return-Path: <gwendal@google.com>
From: Gwendal Grignou <gwendal@chromium.org>
To: srinivas.pandruvada@linux.intel.com,
	jic23@kernel.org,
	knaack.h@gmx.de
Cc: linux-iio@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 0/3] Support all AKM compass in a single driver
Date: Fri, 21 Nov 2014 10:45:46 -0800
Message-Id: <1416595549-18717-1-git-send-email-gwendal@chromium.org>
List-ID: <linux-iio@vger.kernel.org>

Currently, 2 drivers are used for supporting AKM compasses:
- ak8975 and ak8963 in ak875.c: these compasses support DRDY line and interrupt.
- ak09911 in ak0911.c: this compass has a new register map and does not support DRDY line.

A newer compass, ak09912 has the same register map as ak09911 but the same functionality as
ak8975. By adding support to ak09912 into ak8975, we can remove the driver specific to ak09911.


Gwendal Grignou (3):
  iio: ak8975: minor fixes
  iio: ak8975: add definition structure per compass type
  iio: ak8975: add ak09911 and ak09912 support

 drivers/iio/magnetometer/Kconfig   |  15 +-
 drivers/iio/magnetometer/Makefile  |   1 -
 drivers/iio/magnetometer/ak09911.c | 326 ------------------------
 drivers/iio/magnetometer/ak8975.c  | 501 +++++++++++++++++++++++++++----------
 4 files changed, 378 insertions(+), 465 deletions(-)
 delete mode 100644 drivers/iio/magnetometer/ak09911.c

Reviewed-by: Hartmut Knaack <knaack.h@gmx.de>
Tested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
-- 
2.1.0.rc2.206.gedb03e5
