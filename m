Return-Path: <21cnbao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
To: jic23@cam.ac.uk, gregkh@suse.de
CC: linux-iio@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Subject: [PATCH 3/3] adis16209/220/240/350: tuning spi delay to make hardware more stable
Date: Fri, 4 Jun 2010 17:19:54 +0800
Message-ID: <1275643194-25328-4-git-send-email-21cnbao@gmail.com>
In-Reply-To: <1275643194-25328-3-git-send-email-21cnbao@gmail.com>
References: <1275643194-25328-1-git-send-email-21cnbao@gmail.com>
 <1275643194-25328-2-git-send-email-21cnbao@gmail.com>
 <1275643194-25328-3-git-send-email-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 drivers/staging/iio/accel/adis16209_core.c |    6 ++++--
 drivers/staging/iio/accel/adis16220_core.c |   12 ++++++------
 drivers/staging/iio/accel/adis16240_core.c |    8 ++++----
 drivers/staging/iio/imu/adis16350_core.c   |    8 ++++----
 4 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index ac375c5..94491a1 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -76,11 +76,13 @@ static int adis16209_spi_write_reg_16(struct device *dev,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
+			.delay_usecs = 30,
 		}, {
 			.tx_buf = st->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
+			.delay_usecs = 30,
 		},
 	};
 
@@ -120,13 +122,13 @@ static int adis16209_spi_read_reg_16(struct device *dev,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
-			.delay_usecs = 20,
+			.delay_usecs = 30,
 		}, {
 			.rx_buf = st->rx,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
-			.delay_usecs = 20,
+			.delay_usecs = 30,
 		},
 	};
 
diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index 6de439f..fffa49c 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -72,13 +72,13 @@ static int adis16220_spi_write_reg_16(struct device *dev,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
-			.delay_usecs = 25,
+			.delay_usecs = 35,
 		}, {
 			.tx_buf = st->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
-			.delay_usecs = 25,
+			.delay_usecs = 35,
 		},
 	};
 
@@ -118,13 +118,13 @@ static int adis16220_spi_read_reg_16(struct device *dev,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
-			.delay_usecs = 25,
+			.delay_usecs = 35,
 		}, {
 			.rx_buf = st->rx,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
-			.delay_usecs = 25,
+			.delay_usecs = 35,
 		},
 	};
 
@@ -291,9 +291,9 @@ static int adis16220_check_status(struct device *dev)
 	if (status & ADIS16220_DIAG_STAT_FLASH_UPT)
 		dev_err(dev, "Flash update failed\n");
 	if (status & ADIS16220_DIAG_STAT_POWER_HIGH)
-		dev_err(dev, "Power supply above 5.25V\n");
+		dev_err(dev, "Power supply above 3.625V\n");
 	if (status & ADIS16220_DIAG_STAT_POWER_LOW)
-		dev_err(dev, "Power supply below 4.75V\n");
+		dev_err(dev, "Power supply below 3.15V\n");
 
 error_ret:
 	return ret;
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 54fd6d7..731bca6 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -74,13 +74,13 @@ static int adis16240_spi_write_reg_16(struct device *dev,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
-			.delay_usecs = 25,
+			.delay_usecs = 35,
 		}, {
 			.tx_buf = st->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
-			.delay_usecs = 25,
+			.delay_usecs = 35,
 		},
 	};
 
@@ -120,13 +120,13 @@ static int adis16240_spi_read_reg_16(struct device *dev,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
-			.delay_usecs = 25,
+			.delay_usecs = 35,
 		}, {
 			.rx_buf = st->rx,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
-			.delay_usecs = 25,
+			.delay_usecs = 35,
 		},
 	};
 
diff --git a/drivers/staging/iio/imu/adis16350_core.c b/drivers/staging/iio/imu/adis16350_core.c
index 0edde73..0bb19a9 100644
--- a/drivers/staging/iio/imu/adis16350_core.c
+++ b/drivers/staging/iio/imu/adis16350_core.c
@@ -75,13 +75,13 @@ static int adis16350_spi_write_reg_16(struct device *dev,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
-			.delay_usecs = 25,
+			.delay_usecs = 35,
 		}, {
 			.tx_buf = st->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
-			.delay_usecs = 25,
+			.delay_usecs = 35,
 		},
 	};
 
@@ -121,13 +121,13 @@ static int adis16350_spi_read_reg_16(struct device *dev,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
-			.delay_usecs = 25,
+			.delay_usecs = 35,
 		}, {
 			.rx_buf = st->rx,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
-			.delay_usecs = 25,
+			.delay_usecs = 35,
 		},
 	};
 
-- 
1.5.6.3
