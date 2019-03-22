Return-Path: <SRS0=R23/=RZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F30C43381
	for <linux-iio@archiver.kernel.org>; Fri, 22 Mar 2019 20:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5B3218D3
	for <linux-iio@archiver.kernel.org>; Fri, 22 Mar 2019 20:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZThTkJWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfCVUoz (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:44:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38063 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfCVUoy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Mar 2019 16:44:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id g12so3740346wrm.5
        for <linux-iio@vger.kernel.org>; Fri, 22 Mar 2019 13:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fuwr1AYS3lIem3uvasDIfGATPraH3urfuNIWTQGRiNg=;
        b=ZThTkJWlhkDXumevyrRHaduLMqXi9ilBPSEFgfOctRD1/upnU/HJOg+j6QLbdD+AKe
         0h03dYBk1TVCNiqMLoOucCsnwuQl2gIFY/xPI9Jlqcv87B63lehdQ0XQucJQ4SqRgTJl
         FFijCxPVYMQIZiDM/zA3cIGl3OJYQFx/gRJmHx+YEsj1y338oLoRAPPFaEAqYz0814Ji
         2zZm7ami+QBIfUYm2zCi0JBXNpSGhSRlxyVREOZm74X5R9g2aowCA1E/kgLf+J194Q1q
         3Y9ER5r+rKqxTbBfVMZW7jW8T81scS92MAcDLVmQz+PW9UJKEBci0+RtkMfm52nD8xZk
         4/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fuwr1AYS3lIem3uvasDIfGATPraH3urfuNIWTQGRiNg=;
        b=YOlbeFYX5ejVoah4wgRSjm6UF5jEiu19948ywwntxQlwAzO2n6hfCrJKKVM08Gg2zH
         KxfMHgENnzdsFF5HGztjJJNCevJQKxZvZgPJ07sw9Va8vdVshP/7p7cStVEnBKIIjczz
         bUngSgyiD17z7qwLjyXk6tlBaC+PxQwDOGi4JOKYzxjuQi+1iIGEcHyg6tWhI4oz89dr
         IZtMKEA8RJ6Jk/VkHBDBrZMeIkaTvjzgIvTItqN8Apnc0A5DJjOyq3iJvBAgLoIw5l+B
         YEaZ1PrTFyyLGl80xUX8w+BUOOk3t5PcQI//ybh+p72/1TfsED4wAv/U1REEF917GwR5
         L8xw==
X-Gm-Message-State: APjAAAVutfSjPoOSJEAppEJSlZklWW0fcRhAwU54RheZ1qR33Pc6vx/8
        8fm3rdlzY5A/2AEKcSlowZPqbmi9
X-Google-Smtp-Source: APXvYqwaC5e1iD5PDM87TB1lZZGz60FQjUjwngWi2w4Vllmz539lKqKMYx0VeeHD6kow2cuk+W8Btw==
X-Received: by 2002:adf:e443:: with SMTP id t3mr8184774wrm.257.1553287492312;
        Fri, 22 Mar 2019 13:44:52 -0700 (PDT)
Received: from localhost.localdomain ([188.24.4.251])
        by smtp.gmail.com with ESMTPSA id a9sm10436565wmb.30.2019.03.22.13.44.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 13:44:51 -0700 (PDT)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 3/5] iio: imu: adis16400: move burst logic to ADIS lib
Date:   Fri, 22 Mar 2019 22:44:40 +0200
Message-Id: <20190322204442.4035-3-ardeleanalex@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190322204442.4035-1-ardeleanalex@gmail.com>
References: <20190322204442.4035-1-ardeleanalex@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

This change has been done separately, so that it's easier to visualize the
changed logic in the adis_scan_update() function.

Most of the function in this `adis16400_update_scan_mode()` that deals with
burst-mode will be re-used in the ADIS16480, but with different parameters.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/Makefile           |  1 -
 drivers/iio/imu/adis16400.h        | 16 --------
 drivers/iio/imu/adis16400_buffer.c | 59 ------------------------------
 drivers/iio/imu/adis16400_core.c   |  2 +-
 drivers/iio/imu/adis_buffer.c      | 40 ++++++++++++++++++++
 5 files changed, 41 insertions(+), 77 deletions(-)
 delete mode 100644 drivers/iio/imu/adis16400_buffer.c

diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
index 5fd87701259f..c9f85126fbe1 100644
--- a/drivers/iio/imu/Makefile
+++ b/drivers/iio/imu/Makefile
@@ -5,7 +5,6 @@
 
 # When adding new entries keep the list in alphabetical order
 adis16400-y             := adis16400_core.o
-adis16400-$(CONFIG_IIO_BUFFER) += adis16400_buffer.o
 obj-$(CONFIG_ADIS16400) += adis16400.o
 obj-$(CONFIG_ADIS16460) += adis16460.o
 obj-$(CONFIG_ADIS16480) += adis16480.o
diff --git a/drivers/iio/imu/adis16400.h b/drivers/iio/imu/adis16400.h
index 93b6c0c41fdd..7e2e0dbaa2e1 100644
--- a/drivers/iio/imu/adis16400.h
+++ b/drivers/iio/imu/adis16400.h
@@ -194,20 +194,4 @@ enum {
 	ADIS16400_SCAN_TIMESTAMP,
 };
 
-#ifdef CONFIG_IIO_BUFFER
-
-ssize_t adis16400_read_data_from_ring(struct device *dev,
-				      struct device_attribute *attr,
-				      char *buf);
-
-
-int adis16400_update_scan_mode(struct iio_dev *indio_dev,
-	const unsigned long *scan_mask);
-
-#else /* CONFIG_IIO_BUFFER */
-
-#define adis16400_update_scan_mode NULL
-
-#endif /* CONFIG_IIO_BUFFER */
-
 #endif /* SPI_ADIS16400_H_ */
diff --git a/drivers/iio/imu/adis16400_buffer.c b/drivers/iio/imu/adis16400_buffer.c
deleted file mode 100644
index 199bd72348eb..000000000000
--- a/drivers/iio/imu/adis16400_buffer.c
+++ /dev/null
@@ -1,59 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/interrupt.h>
-#include <linux/mutex.h>
-#include <linux/kernel.h>
-#include <linux/spi/spi.h>
-#include <linux/slab.h>
-#include <linux/bitops.h>
-#include <linux/export.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/buffer.h>
-#include <linux/iio/triggered_buffer.h>
-#include <linux/iio/trigger_consumer.h>
-
-#include "adis16400.h"
-
-int adis16400_update_scan_mode(struct iio_dev *indio_dev,
-	const unsigned long *scan_mask)
-{
-	struct adis16400_state *st = iio_priv(indio_dev);
-	struct adis *adis = &st->adis;
-	unsigned int burst_length;
-	u8 *tx;
-
-	if (!adis->burst || !adis->burst->en)
-		return adis_update_scan_mode(indio_dev, scan_mask);
-
-	kfree(adis->xfer);
-	kfree(adis->buffer);
-
-	/* All but the timestamp channel */
-	burst_length = (indio_dev->num_channels - 1) * sizeof(u16);
-	burst_length += adis->burst->extra_len;
-
-	adis->xfer = kcalloc(2, sizeof(*adis->xfer), GFP_KERNEL);
-	if (!adis->xfer)
-		return -ENOMEM;
-
-	adis->buffer = kzalloc(burst_length + sizeof(u16), GFP_KERNEL);
-	if (!adis->buffer)
-		return -ENOMEM;
-
-	tx = adis->buffer + burst_length;
-	tx[0] = ADIS_READ_REG(adis->burst->reg_cmd);
-	tx[1] = 0;
-
-	adis->xfer[0].tx_buf = tx;
-	adis->xfer[0].bits_per_word = 8;
-	adis->xfer[0].len = 2;
-	adis->xfer[1].rx_buf = adis->buffer;
-	adis->xfer[1].bits_per_word = 8;
-	adis->xfer[1].len = burst_length;
-
-	spi_message_init(&adis->msg);
-	spi_message_add_tail(&adis->xfer[0], &adis->msg);
-	spi_message_add_tail(&adis->xfer[1], &adis->msg);
-
-	return 0;
-}
diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
index 0d799e983d74..265c0a46597f 100644
--- a/drivers/iio/imu/adis16400_core.c
+++ b/drivers/iio/imu/adis16400_core.c
@@ -887,7 +887,7 @@ static const struct iio_info adis16400_info = {
 	.driver_module = THIS_MODULE,
 	.read_raw = &adis16400_read_raw,
 	.write_raw = &adis16400_write_raw,
-	.update_scan_mode = adis16400_update_scan_mode,
+	.update_scan_mode = adis_update_scan_mode,
 	.debugfs_reg_access = adis_debugfs_reg_access,
 };
 
diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index 36607d52fee0..a2fa6e75b13e 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -20,6 +20,43 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/imu/adis.h>
 
+static int adis_update_scan_mode_burst(struct iio_dev *indio_dev,
+	const unsigned long *scan_mask)
+{
+	struct adis *adis = iio_device_get_drvdata(indio_dev);
+	unsigned int burst_length;
+	u8 *tx;
+
+	/* All but the timestamp channel */
+	burst_length = (indio_dev->num_channels - 1) * sizeof(u16);
+	burst_length += adis->burst->extra_len;
+
+	adis->xfer = kcalloc(2, sizeof(*adis->xfer), GFP_KERNEL);
+	if (!adis->xfer)
+		return -ENOMEM;
+
+	adis->buffer = kzalloc(burst_length + sizeof(u16), GFP_KERNEL);
+	if (!adis->buffer)
+		return -ENOMEM;
+
+	tx = adis->buffer + burst_length;
+	tx[0] = ADIS_READ_REG(adis->burst->reg_cmd);
+	tx[1] = 0;
+
+	adis->xfer[0].tx_buf = tx;
+	adis->xfer[0].bits_per_word = 8;
+	adis->xfer[0].len = 2;
+	adis->xfer[1].rx_buf = adis->buffer;
+	adis->xfer[1].bits_per_word = 8;
+	adis->xfer[1].len = burst_length;
+
+	spi_message_init(&adis->msg);
+	spi_message_add_tail(&adis->xfer[0], &adis->msg);
+	spi_message_add_tail(&adis->xfer[1], &adis->msg);
+
+	return 0;
+}
+
 int adis_update_scan_mode(struct iio_dev *indio_dev,
 	const unsigned long *scan_mask)
 {
@@ -32,6 +69,9 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
 	kfree(adis->xfer);
 	kfree(adis->buffer);
 
+	if (adis->burst && adis->burst->en)
+		return adis_update_scan_mode_burst(indio_dev, scan_mask);
+
 	scan_count = indio_dev->scan_bytes / 2;
 
 	adis->xfer = kcalloc(scan_count + 1, sizeof(*adis->xfer), GFP_KERNEL);
-- 
2.17.1

