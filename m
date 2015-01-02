Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:38116 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbbABJDl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 2 Jan 2015 04:03:41 -0500
Received: by mail-pd0-f176.google.com with SMTP id r10so23383162pdi.35
        for <linux-iio@vger.kernel.org>; Fri, 02 Jan 2015 01:03:41 -0800 (PST)
From: Devendra Naga <devendra.aaru@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Cc: Devendra Naga <devendra.aaru@gmail.com>
Subject: [PATCH V2 2/2] iio: meter: ade7759: add error handling in _reset and _stop_device
Date: Fri,  2 Jan 2015 04:02:55 -0500
Message-Id: <1420189375-19854-2-git-send-email-devendra.aaru@gmail.com>
In-Reply-To: <1420189375-19854-1-git-send-email-devendra.aaru@gmail.com>
References: <1420189375-19854-1-git-send-email-devendra.aaru@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds the error handling for the value returned from
ade7759_spi_read_reg_16. With this patch, the following randconfig
warnings get fixed automatically.

drivers/staging/iio/meter/ade7759.c:224:6: warning: ‘val’ may be
used uninitialized in this function [-Wmaybe-uninitialized]
drivers/staging/iio/meter/ade7759.c:309:6: warning: ‘val’ may be
used uninitialized in this function [-Wmaybe-uninitialized]

Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
---
 Hello, 

 Please see if this is the error message you wanted.

 Build tested on next-20141231 with randconfig sent to iio ml,
 and with allmodconfig.

 drivers/staging/iio/meter/ade7759.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index 7d21743..86b5145 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -218,9 +218,12 @@ static int ade7759_reset(struct device *dev)
 	int ret;
 	u16 val;
 
-	ade7759_spi_read_reg_16(dev,
+	ret = ade7759_spi_read_reg_16(dev,
 			ADE7759_MODE,
 			&val);
+	if (ret < 0)
+		return ret;
+
 	val |= 1 << 6; /* Software Chip Reset */
 	ret = ade7759_spi_write_reg_16(dev,
 			ADE7759_MODE,
@@ -301,11 +304,18 @@ error_ret:
 /* Power down the device */
 static int ade7759_stop_device(struct device *dev)
 {
+	int ret;
 	u16 val;
 
-	ade7759_spi_read_reg_16(dev,
+	ret = ade7759_spi_read_reg_16(dev,
 			ADE7759_MODE,
 			&val);
+	if (ret < 0) {
+		dev_err(dev, "unable to power down the device, error: %d\n",
+			ret);
+		return ret;
+	}
+
 	val |= 1 << 4;  /* AD converters can be turned off */
 
 	return ade7759_spi_write_reg_16(dev, ADE7759_MODE, val);
-- 
1.9.3

