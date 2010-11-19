Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 2/3] staging: iio: dac: Use spi_write() and handle return value
Date: Fri, 19 Nov 2010 13:34:49 +0100
Message-ID: <1290170090-31015-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1290170090-31015-1-git-send-email-michael.hennerich@analog.com>
References: <1290170090-31015-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/dac/ad5624r_spi.c |   23 +++++++----------------
 1 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
index c0d7de9..17588b4 100644
--- a/drivers/staging/iio/dac/ad5624r_spi.c
+++ b/drivers/staging/iio/dac/ad5624r_spi.c
@@ -35,10 +35,9 @@ struct ad5624r_state {
 	int internal_ref;
 };
 
-static int ad5624r_spi_write(struct spi_device *spi, u8 cmd, u8 addr, u16 val, u8 len)
+static int ad5624r_spi_write(struct spi_device *spi,
+			     u8 cmd, u8 addr, u16 val, u8 len)
 {
-	struct spi_transfer t;
-	struct spi_message m;
 	u32 data;
 	u8 msg[3];
 
@@ -54,15 +53,7 @@ static int ad5624r_spi_write(struct spi_device *spi, u8 cmd, u8 addr, u16 val, u
 	msg[1] = data >> 8;
 	msg[2] = data;
 
-	spi_message_init(&m);
-	memset(&t, 0, (sizeof t));
-	t.tx_buf = &msg[0];
-	t.len = 3;
-
-	spi_message_add_tail(&t, &m);
-	spi_sync(spi, &m);
-
-	return len;
+	return spi_write(spi, msg, 3);
 }
 
 static ssize_t ad5624r_write_dac(struct device *dev,
@@ -80,7 +71,7 @@ static ssize_t ad5624r_write_dac(struct device *dev,
 	if (ret)
 		return ret;
 
-	ad5624r_spi_write(st->us, AD5624R_CMD_WRITE_INPUT_N_UPDATE_N,
+	ret = ad5624r_spi_write(st->us, AD5624R_CMD_WRITE_INPUT_N_UPDATE_N,
 			this_attr->address, readin, st->data_len);
 	return ret ? ret : len;
 }
@@ -109,7 +100,7 @@ static ssize_t ad5624r_write_ldac_mode(struct device *dev,
 	if (ret)
 		return ret;
 
-	ad5624r_spi_write(st->us, AD5624R_CMD_LDAC_SETUP, 0, readin & 0xF, 16);
+	ret = ad5624r_spi_write(st->us, AD5624R_CMD_LDAC_SETUP, 0, readin & 0xF, 16);
 	st->ldac_mode = readin & 0xF;
 
 	return ret ? ret : len;
@@ -141,7 +132,7 @@ static ssize_t ad5624r_write_dac_power_mode(struct device *dev,
 	if (ret)
 		return ret;
 
-	ad5624r_spi_write(st->us, AD5624R_CMD_POWERDOWN_DAC, 0,
+	ret = ad5624r_spi_write(st->us, AD5624R_CMD_POWERDOWN_DAC, 0,
 			((readin & 0x3) << 4) | (1 << this_attr->address), 16);
 
 	st->dac_power_mode[this_attr->address] = readin & 0x3;
@@ -173,7 +164,7 @@ static ssize_t ad5624r_write_internal_ref_mode(struct device *dev,
 	if (ret)
 		return ret;
 
-	ad5624r_spi_write(st->us, AD5624R_CMD_INTERNAL_REFER_SETUP, 0, !!readin, 16);
+	ret = ad5624r_spi_write(st->us, AD5624R_CMD_INTERNAL_REFER_SETUP, 0, !!readin, 16);
 
 	st->internal_ref = !!readin;
 
-- 
1.6.0.2
