Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-co1nam03on0059.outbound.protection.outlook.com ([104.47.40.59]:18836
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752401AbeDKLwI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 11 Apr 2018 07:52:08 -0400
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>,
        <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH v3 1/7] iio:dac:ad5686: Style fixes no functional changes
Date: Wed, 11 Apr 2018 14:51:51 +0300
Message-ID: <1523447511-13059-1-git-send-email-stefan.popa@analog.com>
In-Reply-To: <1523375806-29296-1-git-send-email-stefan.popa@analog.com>
References: <1523375806-29296-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch fixes some indentation issues and does not modify the
functionality of the driver.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes v2:
	- Nothing changed, just follow the patch set version.
Changes v3:
        - Nothing changed, just follow the patch set version.

 drivers/iio/dac/ad5686.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 20254df..f7f975c 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -24,7 +24,7 @@
 #define AD5686_ADDR(x)				((x) << 16)
 #define AD5686_CMD(x)				((x) << 20)
 
-#define AD5686_ADDR_DAC(chan)		(0x1 << (chan))
+#define AD5686_ADDR_DAC(chan)			(0x1 << (chan))
 #define AD5686_ADDR_ALL_DAC			0xF
 
 #define AD5686_CMD_NOOP				0x0
@@ -137,7 +137,7 @@ static const char * const ad5686_powerdown_modes[] = {
 };
 
 static int ad5686_get_powerdown_mode(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan)
+				     const struct iio_chan_spec *chan)
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 
@@ -145,7 +145,8 @@ static int ad5686_get_powerdown_mode(struct iio_dev *indio_dev,
 }
 
 static int ad5686_set_powerdown_mode(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, unsigned int mode)
+				     const struct iio_chan_spec *chan,
+				     unsigned int mode)
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 
@@ -163,17 +164,19 @@ static const struct iio_enum ad5686_powerdown_mode_enum = {
 };
 
 static ssize_t ad5686_read_dac_powerdown(struct iio_dev *indio_dev,
-	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
+		uintptr_t private, const struct iio_chan_spec *chan, char *buf)
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 
 	return sprintf(buf, "%d\n", !!(st->pwr_down_mask &
-			(0x3 << (chan->channel * 2))));
+				       (0x3 << (chan->channel * 2))));
 }
 
 static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
-	 uintptr_t private, const struct iio_chan_spec *chan, const char *buf,
-	 size_t len)
+					  uintptr_t private,
+					  const struct iio_chan_spec *chan,
+					  const char *buf,
+					  size_t len)
 {
 	bool readin;
 	int ret;
@@ -221,10 +224,10 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
 }
 
 static int ad5686_write_raw(struct iio_dev *indio_dev,
-			       struct iio_chan_spec const *chan,
-			       int val,
-			       int val2,
-			       long mask)
+			    struct iio_chan_spec const *chan,
+			    int val,
+			    int val2,
+			    long mask)
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 	int ret;
-- 
2.7.4

