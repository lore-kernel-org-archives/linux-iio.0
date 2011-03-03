Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/2] staging:iio:lis3l02dq fix spi cs_change behaviour
Date: Thu,  3 Mar 2011 17:41:40 +0000
Message-Id: <1299174101-1030-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1299174101-1030-1-git-send-email-jic23@cam.ac.uk>
References: <1299174101-1030-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>

The normal behaviour is:
 * After all transfers except the last: CS stays active
 * After the last transfer: CS goes inactive

Cherry picked form Manuel's patch so the second patch in series
can be applied on top.

Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/lis3l02dq_core.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index c4b4ab7..575012a 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -58,7 +58,6 @@ int lis3l02dq_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
 		.rx_buf = st->rx,
 		.bits_per_word = 8,
 		.len = 2,
-		.cs_change = 1,
 	};
 
 	mutex_lock(&st->buf_lock);
@@ -94,7 +93,6 @@ int lis3l02dq_spi_write_reg_8(struct device *dev,
 		.tx_buf = st->tx,
 		.bits_per_word = 8,
 		.len = 2,
-		.cs_change = 1,
 	};
 
 	mutex_lock(&st->buf_lock);
@@ -135,7 +133,7 @@ static int lis3l02dq_spi_write_reg_s16(struct device *dev,
 			.tx_buf = st->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
-			.cs_change = 1,
+			.cs_change = 0,
 		},
 	};
 
@@ -182,8 +180,7 @@ static int lis3l02dq_spi_read_reg_s16(struct device *dev,
 			.rx_buf = st->rx + 2,
 			.bits_per_word = 8,
 			.len = 2,
-			.cs_change = 1,
-
+			.cs_change = 0,
 		},
 	};
 
-- 
1.7.3.4
