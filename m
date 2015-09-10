Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35451 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672AbbIJQbC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 10 Sep 2015 12:31:02 -0400
From: Shraddha Barke <shraddha.6596@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Andreas Dilger <andreas.dilger@intel.com>
Cc: Ian Abbott <abbotti@mev.co.uk>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shraddha Barke <shraddha.6596@gmail.com>
Subject: [PATCH 2/6] Staging: iio: meter: Prefer using the BIT macro
Date: Thu, 10 Sep 2015 22:00:30 +0530
Message-Id: <1441902634-11129-2-git-send-email-shraddha.6596@gmail.com>
In-Reply-To: <1441902634-11129-1-git-send-email-shraddha.6596@gmail.com>
References: <1441902634-11129-1-git-send-email-shraddha.6596@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch replaces bit shifting on 1 with the BIT(x) macro

This was done with coccinelle:
@@ int g; @@

-(1 << g)
+BIT(g)

Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
---
 drivers/staging/iio/meter/ade7753.c      | 8 ++++----
 drivers/staging/iio/meter/ade7754.c      | 6 +++---
 drivers/staging/iio/meter/ade7758_core.c | 6 +++---
 drivers/staging/iio/meter/ade7759.c      | 8 ++++----
 drivers/staging/iio/meter/ade7854.c      | 6 +++---
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index ffc7f0d..3d2e50c 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -219,7 +219,7 @@ static int ade7753_reset(struct device *dev)
 	u16 val;
 
 	ade7753_spi_read_reg_16(dev, ADE7753_MODE, &val);
-	val |= 1 << 6; /* Software Chip Reset */
+	val |= BIT(6); /* Software Chip Reset */
 
 	return ade7753_spi_write_reg_16(dev, ADE7753_MODE, val);
 }
@@ -328,10 +328,10 @@ static int ade7753_set_irq(struct device *dev, bool enable)
 		goto error_ret;
 
 	if (enable)
-		irqen |= 1 << 3; /* Enables an interrupt when a data is
+		irqen |= BIT(3); /* Enables an interrupt when a data is
 				    present in the waveform register */
 	else
-		irqen &= ~(1 << 3);
+		irqen &= ~BIT(3);
 
 	ret = ade7753_spi_write_reg_8(dev, ADE7753_IRQEN, irqen);
 
@@ -345,7 +345,7 @@ static int ade7753_stop_device(struct device *dev)
 	u16 val;
 
 	ade7753_spi_read_reg_16(dev, ADE7753_MODE, &val);
-	val |= 1 << 4;  /* AD converters can be turned off */
+	val |= BIT(4);  /* AD converters can be turned off */
 
 	return ade7753_spi_write_reg_16(dev, ADE7753_MODE, val);
 }
diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index f12b2e5..8552c76 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -223,7 +223,7 @@ static int ade7754_reset(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	val |= 1 << 6; /* Software Chip Reset */
+	val |= BIT(6); /* Software Chip Reset */
 	return ade7754_spi_write_reg_8(dev, ADE7754_OPMODE, val);
 }
 
@@ -350,10 +350,10 @@ static int ade7754_set_irq(struct device *dev, bool enable)
 		goto error_ret;
 
 	if (enable)
-		irqen |= 1 << 14; /* Enables an interrupt when a data is
+		irqen |= BIT(14); /* Enables an interrupt when a data is
 				     present in the waveform register */
 	else
-		irqen &= ~(1 << 14);
+		irqen &= ~BIT(14);
 
 	ret = ade7754_spi_write_reg_16(dev, ADE7754_IRQEN, irqen);
 	if (ret)
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 77141ae..3883808 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -308,7 +308,7 @@ static int ade7758_reset(struct device *dev)
 		dev_err(dev, "Failed to read opmode reg\n");
 		return ret;
 	}
-	val |= 1 << 6; /* Software Chip Reset */
+	val |= BIT(6); /* Software Chip Reset */
 	ret = ade7758_spi_write_reg_8(dev, ADE7758_OPMODE, val);
 	if (ret < 0)
 		dev_err(dev, "Failed to write opmode reg\n");
@@ -426,10 +426,10 @@ int ade7758_set_irq(struct device *dev, bool enable)
 		goto error_ret;
 
 	if (enable)
-		irqen |= 1 << 16; /* Enables an interrupt when a data is
+		irqen |= BIT(16); /* Enables an interrupt when a data is
 				     present in the waveform register */
 	else
-		irqen &= ~(1 << 16);
+		irqen &= ~BIT(16);
 
 	ret = ade7758_spi_write_reg_24(dev, ADE7758_MASK, irqen);
 	if (ret)
diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index dbceda1..23e7392 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -224,7 +224,7 @@ static int ade7759_reset(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	val |= 1 << 6; /* Software Chip Reset */
+	val |= BIT(6); /* Software Chip Reset */
 	return ade7759_spi_write_reg_16(dev,
 			ADE7759_MODE,
 			val);
@@ -288,10 +288,10 @@ static int ade7759_set_irq(struct device *dev, bool enable)
 		goto error_ret;
 
 	if (enable)
-		irqen |= 1 << 3; /* Enables an interrupt when a data is
+		irqen |= BIT(3); /* Enables an interrupt when a data is
 				    present in the waveform register */
 	else
-		irqen &= ~(1 << 3);
+		irqen &= ~BIT(3);
 
 	ret = ade7759_spi_write_reg_8(dev, ADE7759_IRQEN, irqen);
 
@@ -314,7 +314,7 @@ static int ade7759_stop_device(struct device *dev)
 		return ret;
 	}
 
-	val |= 1 << 4;  /* AD converters can be turned off */
+	val |= BIT(4);  /* AD converters can be turned off */
 
 	return ade7759_spi_write_reg_16(dev, ADE7759_MODE, val);
 }
diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index d620bbd..a838835 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -181,7 +181,7 @@ static int ade7854_reset(struct device *dev)
 	u16 val;
 
 	st->read_reg_16(dev, ADE7854_CONFIG, &val);
-	val |= 1 << 7; /* Software Chip Reset */
+	val |= BIT(7); /* Software Chip Reset */
 
 	return st->write_reg_16(dev, ADE7854_CONFIG, val);
 }
@@ -420,10 +420,10 @@ static int ade7854_set_irq(struct device *dev, bool enable)
 		goto error_ret;
 
 	if (enable)
-		irqen |= 1 << 17; /* 1: interrupt enabled when all periodical
+		irqen |= BIT(17); /* 1: interrupt enabled when all periodical
 				     (at 8 kHz rate) DSP computations finish. */
 	else
-		irqen &= ~(1 << 17);
+		irqen &= ~BIT(17);
 
 	ret = st->write_reg_32(dev, ADE7854_MASK0, irqen);
 	if (ret)
-- 
2.1.4

