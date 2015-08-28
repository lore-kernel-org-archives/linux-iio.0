Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:59993 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752662AbbH1WAV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 28 Aug 2015 18:00:21 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH 1/6] iio:dac:m62332: share scale and offset
Date: Fri, 28 Aug 2015 23:59:53 +0200
Message-Id: <1d2903d19cf988620b155b16ea58dd13d392f598.1440459082.git.knaack.h@gmx.de>
In-Reply-To: <cover.1440459082.git.knaack.h@gmx.de>
References: <cover.1440459082.git.knaack.h@gmx.de>
In-Reply-To: <cover.1440459082.git.knaack.h@gmx.de>
References: <cover.1440459082.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This device simply uses its Vcc as reference voltage, so the same scale
applies for all channels. Also offset doesn't appear to be different for
any channel. Represent this by switching these two attributes to
info_mask_shared_by_type.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
Hope you don't mind too much, that I inserted an extra tab in the whole
block rather than messing up style and cleaning it up later.

 drivers/iio/dac/m62332.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
index c23d7fa889ee..cffc0630ed32 100644
--- a/drivers/iio/dac/m62332.c
+++ b/drivers/iio/dac/m62332.c
@@ -173,15 +173,15 @@ static const struct iio_info m62332_info = {
 	.driver_module = THIS_MODULE,
 };
 
-#define M62332_CHANNEL(chan) {				\
-	.type = IIO_VOLTAGE,				\
-	.indexed = 1,					\
-	.output = 1,					\
-	.channel = (chan),				\
-	.datasheet_name = "CH" #chan,			\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
-		BIT(IIO_CHAN_INFO_SCALE) |		\
-		BIT(IIO_CHAN_INFO_OFFSET),		\
+#define M62332_CHANNEL(chan) {					\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.output = 1,						\
+	.channel = (chan),					\
+	.datasheet_name = "CH" #chan,				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
+				    BIT(IIO_CHAN_INFO_OFFSET),	\
 }
 
 static const struct iio_chan_spec m62332_channels[M62332_CHANNELS] = {
-- 
2.4.6

