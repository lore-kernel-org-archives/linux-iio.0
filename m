Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38925 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbeDTTaI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Apr 2018 15:30:08 -0400
Date: Fri, 20 Apr 2018 21:30:03 +0200
From: David Veenstra <davidjulianveenstra@gmail.com>
To: lars@metafoo.de, jic23@kernel.org, pmeerw@pmeerw.net
Cc: robh+dt@kernel.org, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: [PATCH v2 05/13] staging: iio: ad2s1200: Add kernel docs to driver
 state
Message-ID: <2e083c69b1d249fe05badc94250c39db24d523e0.1524247563.git.davidjulianveenstra@gmail.com>
References: <cover.1524247563.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1524247563.git.davidjulianveenstra@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add missing kernel docs to the ad2s1200 driver state.

Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1200.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index 357fe3c382b3..f07aab7e7a35 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -33,6 +33,14 @@
 /* clock period in nano second */
 #define AD2S1200_TSCLK	(1000000000 / AD2S1200_HZ)
 
+/**
+ * struct ad2s1200_state - driver instance specific data
+ * @lock:	protect driver state
+ * @sdev:	spi device
+ * @sample:	GPIO pin SAMPLE
+ * @rdvel:	GPIO pin RDVEL
+ * @rx:		buffer for spi transfers
+ */
 struct ad2s1200_state {
 	struct mutex lock;
 	struct spi_device *sdev;
-- 
2.16.2

