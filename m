Return-Path: <martink@posteo.de>
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kepplinger <martink@posteo.de>
Subject: [PATCH 2/3] iio: mma8452: update device description in header comments
Date: Fri,  3 Jun 2016 14:51:51 +0200
Message-Id: <1464958312-2720-2-git-send-email-martink@posteo.de>
In-Reply-To: <1464958312-2720-1-git-send-email-martink@posteo.de>
References: <1464958312-2720-1-git-send-email-martink@posteo.de>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 drivers/iio/accel/mma8452.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 9e679af..4be2a18 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1,12 +1,14 @@
 /*
  * mma8452.c - Support for following Freescale 3-axis accelerometers:
  *
- * MMA8451Q (14 bit)
- * MMA8452Q (12 bit)
- * MMA8453Q (10 bit)
- * MMA8652FC (12 bit)
- * MMA8653FC (10 bit)
- * FXLS8471Q (14 bit)
+ * device name	digital output	7-bit I2C slave address (pin selectable)
+ * ---------------------------------------------------------------------
+ * MMA8451Q	14 bit		0x1c / 0x1d
+ * MMA8452Q	12 bit		0x1c / 0x1d
+ * MMA8453Q	10 bit		0x1c / 0x1d
+ * MMA8652FC	12 bit		0x1d
+ * MMA8653FC	10 bit		0x1d
+ * FXLS8471Q	14 bit		0x1e / 0x1d / 0x1c / 0x1f
  *
  * Copyright 2015 Martin Kepplinger <martink@posteo.de>
  * Copyright 2014 Peter Meerwald <pmeerw@pmeerw.net>
@@ -15,8 +17,6 @@
  * the GNU General Public License.  See the file COPYING in the main
  * directory of this archive for more details.
  *
- * 7-bit I2C slave address 0x1c/0x1d (pin selectable)
- *
  * TODO: orientation events
  */
 
-- 
2.1.4
