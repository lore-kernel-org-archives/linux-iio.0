Return-Path: <SRS0=AYw5=AS=rere.qmqm.pl=mirq-linux@kernel.org>
Date: Sun, 17 Sep 2017 17:01:02 +0200
Message-Id: <e42aecf940e2f5acb5ed98dc13ea28af9eb74f2f.1505660069.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1505660069.git.mirq-linux@rere.qmqm.pl>
References: <cover.1505660069.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 2/8] iio: accel: kxcjk1013: fix INT_CTRL/INT_SRC1 bit names
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Fix INT_CTRL1 bit names to match register name and add names
for INT_SRC1 bits.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/iio/accel/kxcjk-1013.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 33e4b98f39fc..7828570d87d2 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -67,14 +67,19 @@
 #define KXCJK1013_REG_CTRL1_BIT_GSEL1	BIT(4)
 #define KXCJK1013_REG_CTRL1_BIT_GSEL0	BIT(3)
 #define KXCJK1013_REG_CTRL1_BIT_WUFE	BIT(1)
-#define KXCJK1013_REG_INT_REG1_BIT_IEA	BIT(4)
-#define KXCJK1013_REG_INT_REG1_BIT_IEN	BIT(5)
+
+#define KXCJK1013_REG_INT_CTRL1_BIT_IEL	BIT(3)
+#define KXCJK1013_REG_INT_CTRL1_BIT_IEA	BIT(4)
+#define KXCJK1013_REG_INT_CTRL1_BIT_IEN	BIT(5)
 
 #define KXCJK1013_DATA_MASK_12_BIT	0x0FFF
 #define KXCJK1013_MAX_STARTUP_TIME_US	100000
 
 #define KXCJK1013_SLEEP_DELAY_MS	2000
 
+#define KXCJK1013_REG_INT_SRC1_BIT_WUFS	BIT(1)
+#define KXCJK1013_REG_INT_SRC1_BIT_DRDY	BIT(4)
+
 #define KXCJK1013_REG_INT_SRC2_BIT_ZP	BIT(0)
 #define KXCJK1013_REG_INT_SRC2_BIT_ZN	BIT(1)
 #define KXCJK1013_REG_INT_SRC2_BIT_YP	BIT(2)
@@ -336,9 +341,9 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 	}
 
 	if (data->active_high_intr)
-		ret |= KXCJK1013_REG_INT_REG1_BIT_IEA;
+		ret |= KXCJK1013_REG_INT_CTRL1_BIT_IEA;
 	else
-		ret &= ~KXCJK1013_REG_INT_REG1_BIT_IEA;
+		ret &= ~KXCJK1013_REG_INT_CTRL1_BIT_IEA;
 
 	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_INT_CTRL1,
 					ret);
@@ -444,9 +449,9 @@ static int kxcjk1013_setup_any_motion_interrupt(struct kxcjk1013_data *data,
 	}
 
 	if (status)
-		ret |= KXCJK1013_REG_INT_REG1_BIT_IEN;
+		ret |= KXCJK1013_REG_INT_CTRL1_BIT_IEN;
 	else
-		ret &= ~KXCJK1013_REG_INT_REG1_BIT_IEN;
+		ret &= ~KXCJK1013_REG_INT_CTRL1_BIT_IEN;
 
 	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_INT_CTRL1,
 					ret);
@@ -504,9 +509,9 @@ static int kxcjk1013_setup_new_data_interrupt(struct kxcjk1013_data *data,
 	}
 
 	if (status)
-		ret |= KXCJK1013_REG_INT_REG1_BIT_IEN;
+		ret |= KXCJK1013_REG_INT_CTRL1_BIT_IEN;
 	else
-		ret &= ~KXCJK1013_REG_INT_REG1_BIT_IEN;
+		ret &= ~KXCJK1013_REG_INT_CTRL1_BIT_IEN;
 
 	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_INT_CTRL1,
 					ret);
@@ -1039,7 +1044,7 @@ static irqreturn_t kxcjk1013_event_handler(int irq, void *private)
 		goto ack_intr;
 	}
 
-	if (ret & 0x02) {
+	if (ret & KXCJK1013_REG_INT_SRC1_BIT_WUFS) {
 		ret = i2c_smbus_read_byte_data(data->client,
 					       KXCJK1013_REG_INT_SRC2);
 		if (ret < 0) {
-- 
2.11.0
