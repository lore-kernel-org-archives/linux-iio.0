Return-Path: <SRS0=wvzB=7T=rere.qmqm.pl=mirq-linux@kernel.org>
Date: Thu, 17 Aug 2017 15:56:12 +0200
Message-Id: <dcdabb72b58170fcfde9b7536522256e0d3a8540.1502977929.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1502977929.git.mirq-linux@rere.qmqm.pl>
References: <cover.1502977929.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 4/4] iio: magnetometer: ak8974: debug AMI306 calibration data
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
List-ID: <linux-iio@vger.kernel.org>

Use AMI306 calibration data for randomness and debugging.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/iio/magnetometer/ak8974.c | 41 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index d8c45206ba00..b3221b34606b 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -445,6 +445,20 @@ static int ak8974_selftest(struct ak8974 *ak8974)
 	return 0;
 }
 
+static void ak8974_read_calib_data(struct ak8974 *ak8974, unsigned int reg,
+				   __le16 *tab, size_t tab_size)
+{
+	int ret = regmap_bulk_read(ak8974->map, reg, tab, tab_size);
+	if (ret) {
+		memset(tab, 0xFF, tab_size);
+		dev_warn(&ak8974->i2c->dev,
+			 "can't read calibration data (regs %u..%u): %d\n",
+			 reg, reg + tab_size - 1, ret);
+	} else {
+		add_device_randomness(tab, tab_size);
+	}
+}
+
 static int ak8974_detect(struct ak8974 *ak8974)
 {
 	unsigned int whoami;
@@ -490,6 +504,33 @@ static int ak8974_detect(struct ak8974 *ak8974)
 	ak8974->name = name;
 	ak8974->variant = whoami;
 
+	if (whoami == AK8974_WHOAMI_VALUE_AMI306) {
+		__le16 fab_data1[9], fab_data2[3];
+		int i;
+
+		ak8974_read_calib_data(ak8974, AMI306_FINEOUTPUT_X,
+				       fab_data1, sizeof(fab_data1));
+		ak8974_read_calib_data(ak8974, AMI306_OFFZERO_X,
+				       fab_data2, sizeof(fab_data2));
+
+		for (i = 0; i < 3; ++i) {
+			static const char axis[3] = "XYZ";
+			static const char pgaxis[6] = "ZYZXYX";
+			unsigned offz = le16_to_cpu(fab_data2[i]) & 0x7F;
+			unsigned fine = le16_to_cpu(fab_data1[i]);
+			unsigned sens = le16_to_cpu(fab_data1[i + 3]);
+			unsigned pgain1 = le16_to_cpu(fab_data1[i + 6]);
+			unsigned pgain2 = pgain1 >> 8;
+
+			pgain1 &= 0xFF;
+
+			dev_info(&ak8974->i2c->dev,
+				 "factory calibration for axis %c: offz=%u sens=%u fine=%u pga%c=%u pga%c=%u\n",
+				 axis[i], offz, sens, fine, pgaxis[i * 2],
+				 pgain1, pgaxis[i * 2 + 1], pgain2);
+		}
+	}
+
 	return 0;
 }
 
-- 
2.11.0
