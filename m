Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: greg@kroah.com
CC: linux-iio@vger.kernel.org, drivers@analog.com, jic23@cam.ac.uk,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] staging: iio: adc: ad7887: Fix typos
Date: Mon, 22 Nov 2010 13:47:20 +0100
Message-ID: <1290430040-30753-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad7887_core.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index c4088a5..6859089 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -173,8 +173,8 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 			    0 : AD7887_REF_DIS);
 
 	st->xfer[0].rx_buf = &st->data[0];
-	st->xfer[0].tx_buf = &st->tx_cmd_buf[0],
-	st->xfer[0].len = 2,
+	st->xfer[0].tx_buf = &st->tx_cmd_buf[0];
+	st->xfer[0].len = 2;
 
 	spi_message_init(&st->msg[AD7887_CH0]);
 	spi_message_add_tail(&st->xfer[0], &st->msg[AD7887_CH0]);
@@ -190,20 +190,20 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 				    AD7887_REF_DIS | AD7887_PM_MODE4;
 
 		st->xfer[1].rx_buf = &st->data[0];
-		st->xfer[1].tx_buf = &st->tx_cmd_buf[2],
-		st->xfer[1].len = 2,
+		st->xfer[1].tx_buf = &st->tx_cmd_buf[2];
+		st->xfer[1].len = 2;
 
 		st->xfer[2].rx_buf = &st->data[2];
-		st->xfer[2].tx_buf = &st->tx_cmd_buf[4],
-		st->xfer[2].len = 2,
+		st->xfer[2].tx_buf = &st->tx_cmd_buf[4];
+		st->xfer[2].len = 2;
 
 		spi_message_init(&st->msg[AD7887_CH0_CH1]);
 		spi_message_add_tail(&st->xfer[1], &st->msg[AD7887_CH0_CH1]);
 		spi_message_add_tail(&st->xfer[2], &st->msg[AD7887_CH0_CH1]);
 
 		st->xfer[3].rx_buf = &st->data[0];
-		st->xfer[3].tx_buf = &st->tx_cmd_buf[6],
-		st->xfer[3].len = 2,
+		st->xfer[3].tx_buf = &st->tx_cmd_buf[6];
+		st->xfer[3].len = 2;
 
 		spi_message_init(&st->msg[AD7887_CH1]);
 		spi_message_add_tail(&st->xfer[3], &st->msg[AD7887_CH1]);
-- 
1.6.0.2
