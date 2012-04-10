Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 12/14] staging:iio:impedance-analyzer:ad5933 unwind use of IIO_CHAN macro.
Date: Tue, 10 Apr 2012 21:21:48 +0100
Message-Id: <1334089310-22576-13-git-send-email-jic23@kernel.org>
In-Reply-To: <1334089310-22576-1-git-send-email-jic23@kernel.org>
References: <1334089310-22576-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This macro is being removed to simplify ongoing maintenance
so we need to unwind and remaining users.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c |   47 ++++++++++++++++++-----
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index cd82b56..06b9fe2 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -109,15 +109,44 @@ static struct ad5933_platform_data ad5933_default_pdata  = {
 };
 
 static struct iio_chan_spec ad5933_channels[] = {
-	IIO_CHAN(IIO_TEMP, 0, 1, 1, NULL, 0, 0, 0,
-		 0, AD5933_REG_TEMP_DATA, IIO_ST('s', 14, 16, 0), 0),
-	/* Ring Channels */
-	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, "real_raw", 0, 0,
-		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		 AD5933_REG_REAL_DATA, 0, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, "imag_raw", 0, 0,
-		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
-		 AD5933_REG_IMAG_DATA, 1, IIO_ST('s', 16, 16, 0), 0),
+	{
+		.type = IIO_TEMP,
+		.indexed = 1,
+		.processed_val = 1,
+		.channel = 0,
+		.address = AD5933_REG_TEMP_DATA,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 14,
+			.storagebits = 16,
+		},
+	}, { /* Ring Channels */
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = 0,
+		.extend_name = "real_raw",
+		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.address = AD5933_REG_REAL_DATA,
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+		},
+	}, {
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = 0,
+		.extend_name = "imag_raw",
+		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.address = AD5933_REG_IMAG_DATA,
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+		},
+	},
 };
 
 static int ad5933_i2c_write(struct i2c_client *client,
-- 
1.7.9.4
