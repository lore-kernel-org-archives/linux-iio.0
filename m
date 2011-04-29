Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <greg@kroah.com>
CC: <linux-iio@vger.kernel.org>, <drivers@analog.com>, <jic23@cam.ac.uk>,
	<device-drivers-devel@blackfin.uclinux.org>, Michael Hennerich
	<michael.hennerich@analog.com>
Subject: [PATCH 3/6] IIO: GYRO: ADXRS450: Add missing parity bit generation
Date: Fri, 29 Apr 2011 14:17:01 +0200
Message-ID: <1304079424-18506-3-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1304079424-18506-1-git-send-email-michael.hennerich@analog.com>
References: <1304079424-18506-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Add missing parity bit generation. Failure to add the parity bit
caused half of the register accesses to fail.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/adxrs450_core.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index c02e3ef..5671276 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -59,6 +59,9 @@ static int adxrs450_spi_read_reg_16(struct device *dev,
 	st->tx[2] = 0;
 	st->tx[3] = 0;

+	if (!(hweight32(be32_to_cpu(*(u32 *)st->tx)) & 1))
+		st->tx[3]  |= ADXRS450_P;
+
 	spi_message_init(&msg);
 	spi_message_add_tail(&xfers[0], &msg);
 	spi_message_add_tail(&xfers[1], &msg);
@@ -103,6 +106,10 @@ static int adxrs450_spi_write_reg_16(struct device *dev,
 	st->tx[1] = reg_address << 1 | val >> 15;
 	st->tx[2] = val >> 7;
 	st->tx[3] = val << 1;
+
+	if (!(hweight32(be32_to_cpu(*(u32 *)st->tx)) & 1))
+		st->tx[3]  |= ADXRS450_P;
+
 	spi_message_init(&msg);
 	spi_message_add_tail(&xfers, &msg);
 	ret = spi_sync(st->us, &msg);
--
1.6.0.2
