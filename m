Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:59825 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667AbbHBUoH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 2 Aug 2015 16:44:07 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Martin Fuzzey <mfuzzey@parkeon.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	martink@posteo.de
Subject: [PATCH 5/7] iio:accel:mma8452: rework register definitions
Date: Sun,  2 Aug 2015 22:43:50 +0200
Message-Id: <34fd2ccf719564a27a3a9d9285d236b0f2ec385b.1438483410.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438483410.git.knaack.h@gmx.de>
References: <cover.1438483410.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438483410.git.knaack.h@gmx.de>
References: <cover.1438483410.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Rework register definitions to be sorted by register and bit number, with
bit definitions cascaded under the appropriate register, use GENMASK for
consecutive bitmasks and realign properly.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/accel/mma8452.c | 93 ++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 48 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 516b6108d5f8..10e9623431e4 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -23,54 +23,51 @@
 #include <linux/iio/events.h>
 #include <linux/delay.h>
 
-#define MMA8452_STATUS 0x00
-#define MMA8452_OUT_X 0x01 /* MSB first, 12-bit  */
-#define MMA8452_OUT_Y 0x03
-#define MMA8452_OUT_Z 0x05
-#define MMA8452_INT_SRC 0x0c
-#define MMA8452_WHO_AM_I 0x0d
-#define MMA8452_DATA_CFG 0x0e
-#define MMA8452_HP_FILTER_CUTOFF 0x0f
-#define MMA8452_HP_FILTER_CUTOFF_SEL_MASK	(BIT(0) | BIT(1))
-#define MMA8452_TRANSIENT_CFG 0x1d
-#define MMA8452_TRANSIENT_CFG_ELE		BIT(4)
-#define MMA8452_TRANSIENT_CFG_CHAN(chan)	BIT(chan + 1)
-#define MMA8452_TRANSIENT_CFG_HPF_BYP		BIT(0)
-#define MMA8452_TRANSIENT_SRC 0x1e
-#define MMA8452_TRANSIENT_SRC_XTRANSE		BIT(1)
-#define MMA8452_TRANSIENT_SRC_YTRANSE		BIT(3)
-#define MMA8452_TRANSIENT_SRC_ZTRANSE		BIT(5)
-#define MMA8452_TRANSIENT_THS 0x1f
-#define MMA8452_TRANSIENT_THS_MASK	0x7f
-#define MMA8452_TRANSIENT_COUNT 0x20
-#define MMA8452_OFF_X 0x2f
-#define MMA8452_OFF_Y 0x30
-#define MMA8452_OFF_Z 0x31
-#define MMA8452_CTRL_REG1 0x2a
-#define MMA8452_CTRL_REG2 0x2b
-#define MMA8452_CTRL_REG2_RST		BIT(6)
-#define MMA8452_CTRL_REG4 0x2d
-#define MMA8452_CTRL_REG5 0x2e
-
-#define MMA8452_MAX_REG 0x31
-
-#define MMA8452_STATUS_DRDY (BIT(2) | BIT(1) | BIT(0))
-
-#define MMA8452_CTRL_DR_MASK (BIT(5) | BIT(4) | BIT(3))
-#define MMA8452_CTRL_DR_SHIFT 3
-#define MMA8452_CTRL_DR_DEFAULT 0x4 /* 50 Hz sample frequency */
-#define MMA8452_CTRL_ACTIVE BIT(0)
-
-#define MMA8452_DATA_CFG_FS_MASK (BIT(1) | BIT(0))
-#define MMA8452_DATA_CFG_FS_2G 0
-#define MMA8452_DATA_CFG_FS_4G 1
-#define MMA8452_DATA_CFG_FS_8G 2
-#define MMA8452_DATA_CFG_HPF_MASK BIT(4)
-
-#define MMA8452_INT_DRDY	BIT(0)
-#define MMA8452_INT_TRANS	BIT(5)
-
-#define MMA8452_DEVICE_ID 0x2a
+#define MMA8452_STATUS				0x00
+#define  MMA8452_STATUS_DRDY			(BIT(2) | BIT(1) | BIT(0))
+#define MMA8452_OUT_X				0x01 /* MSB first, 12-bit  */
+#define MMA8452_OUT_Y				0x03
+#define MMA8452_OUT_Z				0x05
+#define MMA8452_INT_SRC				0x0c
+#define MMA8452_WHO_AM_I			0x0d
+#define MMA8452_DATA_CFG			0x0e
+#define  MMA8452_DATA_CFG_FS_MASK		GENMASK(1, 0)
+#define  MMA8452_DATA_CFG_FS_2G			0
+#define  MMA8452_DATA_CFG_FS_4G			1
+#define  MMA8452_DATA_CFG_FS_8G			2
+#define  MMA8452_DATA_CFG_HPF_MASK		BIT(4)
+#define MMA8452_HP_FILTER_CUTOFF		0x0f
+#define  MMA8452_HP_FILTER_CUTOFF_SEL_MASK	GENMASK(1, 0)
+#define MMA8452_TRANSIENT_CFG			0x1d
+#define  MMA8452_TRANSIENT_CFG_HPF_BYP		BIT(0)
+#define  MMA8452_TRANSIENT_CFG_CHAN(chan)	BIT(chan + 1)
+#define  MMA8452_TRANSIENT_CFG_ELE		BIT(4)
+#define MMA8452_TRANSIENT_SRC			0x1e
+#define  MMA8452_TRANSIENT_SRC_XTRANSE		BIT(1)
+#define  MMA8452_TRANSIENT_SRC_YTRANSE		BIT(3)
+#define  MMA8452_TRANSIENT_SRC_ZTRANSE		BIT(5)
+#define MMA8452_TRANSIENT_THS			0x1f
+#define  MMA8452_TRANSIENT_THS_MASK		GENMASK(6, 0)
+#define MMA8452_TRANSIENT_COUNT			0x20
+#define MMA8452_CTRL_REG1			0x2a
+#define  MMA8452_CTRL_ACTIVE			BIT(0)
+#define  MMA8452_CTRL_DR_MASK			GENMASK(5, 3)
+#define  MMA8452_CTRL_DR_SHIFT			3
+#define  MMA8452_CTRL_DR_DEFAULT		0x4 /* 50 Hz sample frequency */
+#define MMA8452_CTRL_REG2			0x2b
+#define  MMA8452_CTRL_REG2_RST			BIT(6)
+#define MMA8452_CTRL_REG4			0x2d
+#define MMA8452_CTRL_REG5			0x2e
+#define MMA8452_OFF_X				0x2f
+#define MMA8452_OFF_Y				0x30
+#define MMA8452_OFF_Z				0x31
+
+#define MMA8452_MAX_REG				0x31
+
+#define  MMA8452_INT_DRDY			BIT(0)
+#define  MMA8452_INT_TRANS			BIT(5)
+
+#define  MMA8452_DEVICE_ID			0x2a
 
 struct mma8452_data {
 	struct i2c_client *client;
-- 
2.4.6

