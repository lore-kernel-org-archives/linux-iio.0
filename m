Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45039 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967503AbeBPMuq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Feb 2018 07:50:46 -0500
Date: Fri, 16 Feb 2018 10:50:41 -0200
From: rodrigosiqueira <rodrigosiqueiramelo@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio/meter: add name to function definition arguments
Message-ID: <20180216125041.qfvg7xtpulc54tk6@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch fixes the checkpatch.pl warning:

drivers/staging/iio/meter/ade7854.h:157: WARNING: function definition
argument 'struct device *' should also have an identifier name...

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/staging/iio/meter/ade7854.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
index c27247a7891a..2362a4a51ce3 100644
--- a/drivers/staging/iio/meter/ade7854.h
+++ b/drivers/staging/iio/meter/ade7854.h
@@ -152,20 +152,20 @@
  * @rx:			receive buffer
  **/
 struct ade7854_state {
-	struct spi_device	*spi;
-	struct i2c_client	*i2c;
-	int			(*read_reg_8)(struct device *, u16, u8 *);
-	int			(*read_reg_16)(struct device *, u16, u16 *);
-	int			(*read_reg_24)(struct device *, u16, u32 *);
-	int			(*read_reg_32)(struct device *, u16, u32 *);
-	int			(*write_reg_8)(struct device *, u16, u8);
-	int			(*write_reg_16)(struct device *, u16, u16);
-	int			(*write_reg_24)(struct device *, u16, u32);
-	int			(*write_reg_32)(struct device *, u16, u32);
-	int			irq;
-	struct mutex		buf_lock;
-	u8			tx[ADE7854_MAX_TX] ____cacheline_aligned;
-	u8			rx[ADE7854_MAX_RX];
+	struct spi_device *spi;
+	struct i2c_client *i2c;
+	int (*read_reg_8)(struct device *dev, u16 reg_address, u8 *val);
+	int (*read_reg_16)(struct device *dev, u16 reg_address, u16 *val);
+	int (*read_reg_24)(struct device *dev, u16 reg_address, u32 *val);
+	int (*read_reg_32)(struct device *dev, u16 reg_address, u32 *val);
+	int (*write_reg_8)(struct device *dev, u16 reg_address, u8 value);
+	int (*write_reg_16)(struct device *dev, u16 reg_address, u16 value);
+	int (*write_reg_24)(struct device *dev, u16 reg_address, u32 value);
+	int (*write_reg_32)(struct device *dev, u16 reg_address, u32 value);
+	int irq;
+	struct mutex buf_lock;
+	u8 tx[ADE7854_MAX_TX] ____cacheline_aligned;
+	u8 rx[ADE7854_MAX_RX];
 
 };
 
-- 
2.16.1

