Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:48655 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbbABJDi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 2 Jan 2015 04:03:38 -0500
Received: by mail-pa0-f49.google.com with SMTP id eu11so23739379pac.36
        for <linux-iio@vger.kernel.org>; Fri, 02 Jan 2015 01:03:37 -0800 (PST)
From: Devendra Naga <devendra.aaru@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Cc: Devendra Naga <devendra.aaru@gmail.com>
Subject: [PATCH V2 1/2] iio: meter: ade7754: add error handling in _reset and _stop_device
Date: Fri,  2 Jan 2015 04:02:54 -0500
Message-Id: <1420189375-19854-1-git-send-email-devendra.aaru@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds the error handling for the value returned from
ade7754_spi_read_reg_8. With this patch, the following randconfig
warnings get fixed automatically.

drivers/staging/iio/meter/ade7754.c:222:6: warning: ‘val’ may be used
uninitialized in this function [-Wmaybe-uninitialized]
drivers/staging/iio/meter/ade7754.c:368:6: warning: ‘val’ may be used
uninitialized in this function [-Wmaybe-uninitialized]

Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
---

 Hello, 

 Please see if this is the error message you wanted.

 Build tested on next-20141231 with randconfig sent to iio ml,
 and with allmodconfig.

 drivers/staging/iio/meter/ade7754.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index 81f6731..746b188 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -216,9 +216,13 @@ error_ret:
 
 static int ade7754_reset(struct device *dev)
 {
+	int ret;
 	u8 val;
 
-	ade7754_spi_read_reg_8(dev, ADE7754_OPMODE, &val);
+	ret = ade7754_spi_read_reg_8(dev, ADE7754_OPMODE, &val);
+	if (ret < 0)
+		return ret;
+
 	val |= 1 << 6; /* Software Chip Reset */
 	return ade7754_spi_write_reg_8(dev, ADE7754_OPMODE, val);
 }
@@ -362,9 +366,16 @@ error_ret:
 /* Power down the device */
 static int ade7754_stop_device(struct device *dev)
 {
+	int ret;
 	u8 val;
 
-	ade7754_spi_read_reg_8(dev, ADE7754_OPMODE, &val);
+	ret = ade7754_spi_read_reg_8(dev, ADE7754_OPMODE, &val);
+	if (ret < 0) {
+		dev_err(dev, "unable to power down the device, error: %d",
+			ret);
+		return ret;
+	}
+
 	val |= 7 << 3;  /* ADE7754 powered down */
 	return ade7754_spi_write_reg_8(dev, ADE7754_OPMODE, val);
 }
-- 
1.9.3

