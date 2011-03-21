Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: greg@kroah.com, jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, stable@kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 1/6] IIO: IMU: ADIS16400: Fix up SPI messages cs_change behavior
Date: Mon, 21 Mar 2011 16:44:35 +0100
Message-ID: <1300722280-10720-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

cs_change must not be set in the last transfer of a spi message

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
CC: stable <stable@kernel.org>
---
 drivers/staging/iio/imu/adis16400_core.c |    2 --
 drivers/staging/iio/imu/adis16400_ring.c |    2 --
 2 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index cfb108a..1007e3d 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -93,7 +93,6 @@ static int adis16400_spi_write_reg_16(struct device *dev,
 			.tx_buf = st->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
-			.cs_change = 1,
 		},
 	};

@@ -137,7 +136,6 @@ static int adis16400_spi_read_reg_16(struct device *dev,
 			.rx_buf = st->rx,
 			.bits_per_word = 8,
 			.len = 2,
-			.cs_change = 1,
 		},
 	};

diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index 33293fb..ac381ca 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -122,12 +122,10 @@ static int adis16400_spi_read_burst(struct device *dev, u8 *rx)
 			.tx_buf = st->tx,
 			.bits_per_word = 8,
 			.len = 2,
-			.cs_change = 0,
 		}, {
 			.rx_buf = rx,
 			.bits_per_word = 8,
 			.len = 24,
-			.cs_change = 1,
 		},
 	};

--
1.6.0.2
