Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52058 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752372AbeCRNfQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Mar 2018 09:35:16 -0400
Received: by mail-wm0-f67.google.com with SMTP id h21so10719572wmd.1
        for <linux-iio@vger.kernel.org>; Sun, 18 Mar 2018 06:35:16 -0700 (PDT)
Date: Sun, 18 Mar 2018 14:35:13 +0100
From: David Veenstra <davidjulianveenstra@gmail.com>
To: lars@metafoo.de, jic23@kernel.org
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 04/11] staging: iio: ad2s1200: Add kernel docs to driver state
Message-ID: <5811056e14d4170ce081e8bcda71a3cf7df000db.1521379685.git.davidjulianveenstra@gmail.com>
References: <cover.1521379685.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1521379685.git.davidjulianveenstra@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add missing kernel docs to the ad2s1200 driver state.

Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1200.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index 20df16b7852b..00efba598671 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -34,6 +34,14 @@
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

