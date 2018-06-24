Return-Path: <SRS0=5Vk5=JK=gmail.com=karim.eshapa@kernel.org>
From: Karim Eshapa <karim.eshapa@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Karim Eshapa <karim.eshapa@gmail.com>
Subject: [PATCH] staging:iio:impedance-analyzer:ad5933: Macro replacment Cleanups.
Date: Sun, 24 Jun 2018 22:15:11 +0200
Message-Id: <20180624201511.10597-1-karim.eshapa@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Doing some macro replacment to start an array of structures
so it can be reused by manipulating it with different values.

Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
---
 .../staging/iio/impedance-analyzer/ad5933.c   | 57 +++++++------------
 1 file changed, 19 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 3bcf49466361..14df89510396 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -116,45 +116,26 @@ static struct ad5933_platform_data ad5933_default_pdata  = {
 	.vref_mv = 3300,
 };
 
+#define AD5933_CHANNEL(_type, _extend_name, _info_mask_separate, _address, \
+		_scan_index, _realbits) { \
+	.type = (_type), \
+	.extend_name = (_extend_name), \
+	.info_mask_separate = (_info_mask_separate), \
+	.address = (_address), \
+	.scan_index = (_scan_index), \
+	.scan_type = { \
+		.sign = 's', \
+		.realbits = (_realbits), \
+		.storagebits = 16, \
+	}, \
+}
+
 static const struct iio_chan_spec ad5933_channels[] = {
-	{
-		.type = IIO_TEMP,
-		.indexed = 1,
-		.channel = 0,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-			BIT(IIO_CHAN_INFO_SCALE),
-		.address = AD5933_REG_TEMP_DATA,
-		.scan_index = -1,
-		.scan_type = {
-			.sign = 's',
-			.realbits = 14,
-			.storagebits = 16,
-		},
-	}, { /* Ring Channels */
-		.type = IIO_VOLTAGE,
-		.indexed = 1,
-		.channel = 0,
-		.extend_name = "real",
-		.address = AD5933_REG_REAL_DATA,
-		.scan_index = 0,
-		.scan_type = {
-			.sign = 's',
-			.realbits = 16,
-			.storagebits = 16,
-		},
-	}, {
-		.type = IIO_VOLTAGE,
-		.indexed = 1,
-		.channel = 0,
-		.extend_name = "imag",
-		.address = AD5933_REG_IMAG_DATA,
-		.scan_index = 1,
-		.scan_type = {
-			.sign = 's',
-			.realbits = 16,
-			.storagebits = 16,
-		},
-	},
+	AD5933_CHANNEL(IIO_TEMP, NULL, BIT(IIO_CHAN_INFO_RAW) |
+		BIT(IIO_CHAN_INFO_SCALE), AD5933_REG_TEMP_DATA, -1, 14),
+	/* Ring Channels */
+	AD5933_CHANNEL(IIO_VOLTAGE, "real", 0, AD5933_REG_REAL_DATA, 0, 16),
+	AD5933_CHANNEL(IIO_VOLTAGE, "imag", 0, AD5933_REG_IMAG_DATA, 1, 16),
 };
 
 static int ad5933_i2c_write(struct i2c_client *client, u8 reg, u8 len, u8 *data)
-- 
2.17.1
