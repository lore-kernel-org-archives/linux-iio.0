Return-Path: <SRS0=R23/=RZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FA9C43381
	for <linux-iio@archiver.kernel.org>; Fri, 22 Mar 2019 20:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95895218D3
	for <linux-iio@archiver.kernel.org>; Fri, 22 Mar 2019 20:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JO6+V0+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfCVUox (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:44:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39757 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfCVUox (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Mar 2019 16:44:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so3744463wrn.6
        for <linux-iio@vger.kernel.org>; Fri, 22 Mar 2019 13:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Y/2Q+ooaHDGUSu1DsdVHCzdJg170F1KJxLYWwtCJ3Gw=;
        b=JO6+V0+CSP5zPc3BQzG0p8ho6t6/yCVXZ9m428oMo5wQh7eOK/Etr5ax+hjrv7H3L+
         lN2sK/Z1bEYR2PQJjBYJotIpDcTVJrT1Rqs/+GL8NRdv++pZ8CwV0T2K2weNNtCpaWm1
         KCJpa10pcKbtRaDaOA3+0dbBnrm4mHdPufBo/tKrlW1cb3xYoDpGvK+pXk2bQBtuD5HU
         wXOwC4T4euf/InZUF49SftyCsBqyj2WU2Z6cytwQ5amkqQpHWYTjPy11mKwXmmV2PACK
         oQRtvqTbNq+yAYYKH+q5d6UMaamGfs7WT0hNtk1ctDNYWZ7YF2Klligm9lznx54UGG+g
         plhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y/2Q+ooaHDGUSu1DsdVHCzdJg170F1KJxLYWwtCJ3Gw=;
        b=UN+1m3QIK8Qbdcp0/4oF8Oz9RwM5Av3imNf+JgHGDdSLxSyxN3+IcgOg402EzLskOf
         8wTuroN2xAdpYu9x3k7EBU/irx49BqpzwZUKr+7fwN4grUlZLLYWA53HoWt/8dpsiLgi
         JbNMMtHLiyKUxwTZXJrOQTW24MnGuJc/Ujw0MMrCnhSHz/WtaCAKOmGBxfo3O4uIZ/wr
         rmM4dXue9+nnulWX0mvymJNSHAHrjDYD1JazdoffZ0E+b/VWj/mSZfcslixQg6bPKGNS
         LTuAbf7mLXsfNmJjer+Hvptg8UntJKISCpEE9mf3Anx+JdgDfIyffvNt4DGzQ5IqYA4Z
         MYxA==
X-Gm-Message-State: APjAAAVPQGfY1vW+C6v6FZf6xHcb+HH9HsDvHhv63H3Y7xFKVwMR7g5O
        gFbLrfPbzR7SQ/CWIzWuIFT12mLr
X-Google-Smtp-Source: APXvYqxy/wsNm3gJuc/7e5L5zRmmgqgOKwFksjrc4rYR7utjk+v/Etn4jMidzxfWLsw7NsbSNeCOow==
X-Received: by 2002:adf:ebce:: with SMTP id v14mr7513626wrn.69.1553287490189;
        Fri, 22 Mar 2019 13:44:50 -0700 (PDT)
Received: from localhost.localdomain ([188.24.4.251])
        by smtp.gmail.com with ESMTPSA id a9sm10436565wmb.30.2019.03.22.13.44.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 13:44:49 -0700 (PDT)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/5] iio: imu: adis16400: move trigger handler into adis16400_core
Date:   Fri, 22 Mar 2019 22:44:38 +0200
Message-Id: <20190322204442.4035-1-ardeleanalex@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

The trigger handler for the ADIS16400 is very different from the generic
one in the ADIS library. Keeping it in a separate file won't make much
sense once the update_scan_mode function will be made more generic and
moved into the ADIS library.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis16400.h        |  2 --
 drivers/iio/imu/adis16400_buffer.c | 41 --------------------------
 drivers/iio/imu/adis16400_core.c   | 46 ++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/imu/adis16400.h b/drivers/iio/imu/adis16400.h
index 73b189c1c0fb..93b6c0c41fdd 100644
--- a/drivers/iio/imu/adis16400.h
+++ b/drivers/iio/imu/adis16400.h
@@ -203,12 +203,10 @@ ssize_t adis16400_read_data_from_ring(struct device *dev,
 
 int adis16400_update_scan_mode(struct iio_dev *indio_dev,
 	const unsigned long *scan_mask);
-irqreturn_t adis16400_trigger_handler(int irq, void *p);
 
 #else /* CONFIG_IIO_BUFFER */
 
 #define adis16400_update_scan_mode NULL
-#define adis16400_trigger_handler NULL
 
 #endif /* CONFIG_IIO_BUFFER */
 
diff --git a/drivers/iio/imu/adis16400_buffer.c b/drivers/iio/imu/adis16400_buffer.c
index e70a5339acb1..268349eb51c7 100644
--- a/drivers/iio/imu/adis16400_buffer.c
+++ b/drivers/iio/imu/adis16400_buffer.c
@@ -58,44 +58,3 @@ int adis16400_update_scan_mode(struct iio_dev *indio_dev,
 
 	return 0;
 }
-
-irqreturn_t adis16400_trigger_handler(int irq, void *p)
-{
-	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->indio_dev;
-	struct adis16400_state *st = iio_priv(indio_dev);
-	struct adis *adis = &st->adis;
-	u32 old_speed_hz = st->adis.spi->max_speed_hz;
-	void *buffer;
-	int ret;
-
-	if (!adis->buffer)
-		return -ENOMEM;
-
-	if (!(st->variant->flags & ADIS16400_NO_BURST) &&
-		st->adis.spi->max_speed_hz > ADIS16400_SPI_BURST) {
-		st->adis.spi->max_speed_hz = ADIS16400_SPI_BURST;
-		spi_setup(st->adis.spi);
-	}
-
-	ret = spi_sync(adis->spi, &adis->msg);
-	if (ret)
-		dev_err(&adis->spi->dev, "Failed to read data: %d\n", ret);
-
-	if (!(st->variant->flags & ADIS16400_NO_BURST)) {
-		st->adis.spi->max_speed_hz = old_speed_hz;
-		spi_setup(st->adis.spi);
-	}
-
-	if (st->variant->flags & ADIS16400_BURST_DIAG_STAT)
-		buffer = adis->buffer + sizeof(u16);
-	else
-		buffer = adis->buffer;
-
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
-		pf->timestamp);
-
-	iio_trigger_notify_done(indio_dev->trig);
-
-	return IRQ_HANDLED;
-}
diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
index 9b697d35dbef..34d52863377a 100644
--- a/drivers/iio/imu/adis16400_core.c
+++ b/drivers/iio/imu/adis16400_core.c
@@ -31,6 +31,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/trigger_consumer.h>
 
 #include "adis16400.h"
 
@@ -465,6 +466,51 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+#if IS_ENABLED(CONFIG_IIO_BUFFER)
+static irqreturn_t adis16400_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct adis16400_state *st = iio_priv(indio_dev);
+	struct adis *adis = &st->adis;
+	u32 old_speed_hz = st->adis.spi->max_speed_hz;
+	void *buffer;
+	int ret;
+
+	if (!adis->buffer)
+		return -ENOMEM;
+
+	if (!(st->variant->flags & ADIS16400_NO_BURST) &&
+		st->adis.spi->max_speed_hz > ADIS16400_SPI_BURST) {
+		st->adis.spi->max_speed_hz = ADIS16400_SPI_BURST;
+		spi_setup(st->adis.spi);
+	}
+
+	ret = spi_sync(adis->spi, &adis->msg);
+	if (ret)
+		dev_err(&adis->spi->dev, "Failed to read data: %d\n", ret);
+
+	if (!(st->variant->flags & ADIS16400_NO_BURST)) {
+		st->adis.spi->max_speed_hz = old_speed_hz;
+		spi_setup(st->adis.spi);
+	}
+
+	if (st->variant->flags & ADIS16400_BURST_DIAG_STAT)
+		buffer = adis->buffer + sizeof(u16);
+	else
+		buffer = adis->buffer;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
+		pf->timestamp);
+
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+#else
+#define adis16400_trigger_handler	NULL
+#endif /* IS_ENABLED(CONFIG_IIO_BUFFER) */
+
 #define ADIS16400_VOLTAGE_CHAN(addr, bits, name, si, chn) { \
 	.type = IIO_VOLTAGE, \
 	.indexed = 1, \
-- 
2.17.1

