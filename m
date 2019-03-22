Return-Path: <SRS0=R23/=RZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5236C43381
	for <linux-iio@archiver.kernel.org>; Fri, 22 Mar 2019 20:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0496218D3
	for <linux-iio@archiver.kernel.org>; Fri, 22 Mar 2019 20:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lc1fZuYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfCVUo6 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:44:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38869 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbfCVUo6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Mar 2019 16:44:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id a188so3392730wmf.3
        for <linux-iio@vger.kernel.org>; Fri, 22 Mar 2019 13:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pl2j3w7uK2uBRlbuwdelFf5Y60Ogei0VihtknpX2drs=;
        b=lc1fZuYTYj33qhr0IkW/ilCIN1ax0ouIxZApJMWDsBuHShLNyy1M2XhJqkqe2GC0Ip
         M9Bw6ABMAGDI816HXwyDVmhrEibo9NTHQ/wY87GkhHgSVNAbDh5YepMQEw5BB1Ns4gRd
         JuKYzbIgrNcvZKtBn5JIkg0dGRMiKAlZqLAYzp5vEz2KdQ/XY/Wb0bSYVVY5dZFg5Qt1
         bAHzgiO4YlblsJo6niDDoIMyOTgxx8SGxybjaVaspymD71QlWZh7TF0d7T9ZQPwuU75i
         /SXWoHGIWcLcxtwNMZM3YhwlbCuq5+zH0MmS+WdLOTGH1I8SIj0mbEW5mTIO6fX9PdHf
         Bl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pl2j3w7uK2uBRlbuwdelFf5Y60Ogei0VihtknpX2drs=;
        b=tApOTl6jp5Z3foXhBOjiUyUwHueyCigFkdUNdoQDyKEgKNUKxjIkQOl/ZuFKGgYGoB
         AQUm46Evn7AxF9nAiWaAUgleRSkmubOey7jtMoK3HFCloogmIALSkKNdNqxpZwmZ2ScK
         +4UBnd2TAWRDqZnPiQ/ueZeKw83EOGuGIelk2g1aMxFwPWr6pk4KN14b0dUsCLOI6Oim
         lcFlLHO/XtXk1TuYEwL16b/QcK/tgIjbm3Px9E93X50NWgTZzJRUJlE2g/ToYZ+c0xju
         WnQdAX/eMaD2WfM98rw6G3Cn+Brk/rLMBcIV8BsGM859+s0WB/lFZam9fQcC9w5O51xm
         3yyA==
X-Gm-Message-State: APjAAAX0zOcBcG/mfwY1TAzgVT1hVcBXFgdJGWbimHfXHv+6sDyUtfge
        z8n1xGhjWl5z9X+K1FeDptBzqXrC
X-Google-Smtp-Source: APXvYqy11fBtGup9eAhY1YcVmbgSg5wxcBLfM09g59pQ8LGjgYUPCZH58HstvNgXeMhkW+4fJupkng==
X-Received: by 2002:a1c:c907:: with SMTP id f7mr4197218wmb.39.1553287494378;
        Fri, 22 Mar 2019 13:44:54 -0700 (PDT)
Received: from localhost.localdomain ([188.24.4.251])
        by smtp.gmail.com with ESMTPSA id a9sm10436565wmb.30.2019.03.22.13.44.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 13:44:53 -0700 (PDT)
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 5/5] iio: imu: adis16400: move adis16400.h into adis16400.c
Date:   Fri, 22 Mar 2019 22:44:42 +0200
Message-Id: <20190322204442.4035-5-ardeleanalex@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190322204442.4035-1-ardeleanalex@gmail.com>
References: <20190322204442.4035-1-ardeleanalex@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

Final part of the re-organization. Move the `adis16400.h` into
`adis16400.c` since it no longer needs to be shared among other files.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis16400.c | 176 +++++++++++++++++++++++++++++++-
 drivers/iio/imu/adis16400.h | 197 ------------------------------------
 2 files changed, 175 insertions(+), 198 deletions(-)
 delete mode 100644 drivers/iio/imu/adis16400.h

diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index 265c0a46597f..aef9c4d5edb8 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -32,8 +32,182 @@
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/trigger_consumer.h>
+#include <linux/iio/imu/adis.h>
+
+#define ADIS16400_STARTUP_DELAY	290 /* ms */
+#define ADIS16400_MTEST_DELAY 90 /* ms */
+
+#define ADIS16400_FLASH_CNT  0x00 /* Flash memory write count */
+#define ADIS16400_SUPPLY_OUT 0x02 /* Power supply measurement */
+#define ADIS16400_XGYRO_OUT 0x04 /* X-axis gyroscope output */
+#define ADIS16400_YGYRO_OUT 0x06 /* Y-axis gyroscope output */
+#define ADIS16400_ZGYRO_OUT 0x08 /* Z-axis gyroscope output */
+#define ADIS16400_XACCL_OUT 0x0A /* X-axis accelerometer output */
+#define ADIS16400_YACCL_OUT 0x0C /* Y-axis accelerometer output */
+#define ADIS16400_ZACCL_OUT 0x0E /* Z-axis accelerometer output */
+#define ADIS16400_XMAGN_OUT 0x10 /* X-axis magnetometer measurement */
+#define ADIS16400_YMAGN_OUT 0x12 /* Y-axis magnetometer measurement */
+#define ADIS16400_ZMAGN_OUT 0x14 /* Z-axis magnetometer measurement */
+#define ADIS16400_TEMP_OUT  0x16 /* Temperature output */
+#define ADIS16400_AUX_ADC   0x18 /* Auxiliary ADC measurement */
+
+#define ADIS16350_XTEMP_OUT 0x10 /* X-axis gyroscope temperature measurement */
+#define ADIS16350_YTEMP_OUT 0x12 /* Y-axis gyroscope temperature measurement */
+#define ADIS16350_ZTEMP_OUT 0x14 /* Z-axis gyroscope temperature measurement */
+
+#define ADIS16300_PITCH_OUT 0x12 /* X axis inclinometer output measurement */
+#define ADIS16300_ROLL_OUT  0x14 /* Y axis inclinometer output measurement */
+#define ADIS16300_AUX_ADC   0x16 /* Auxiliary ADC measurement */
+
+#define ADIS16448_BARO_OUT	0x16 /* Barometric pressure output */
+#define ADIS16448_TEMP_OUT  0x18 /* Temperature output */
+
+/* Calibration parameters */
+#define ADIS16400_XGYRO_OFF 0x1A /* X-axis gyroscope bias offset factor */
+#define ADIS16400_YGYRO_OFF 0x1C /* Y-axis gyroscope bias offset factor */
+#define ADIS16400_ZGYRO_OFF 0x1E /* Z-axis gyroscope bias offset factor */
+#define ADIS16400_XACCL_OFF 0x20 /* X-axis acceleration bias offset factor */
+#define ADIS16400_YACCL_OFF 0x22 /* Y-axis acceleration bias offset factor */
+#define ADIS16400_ZACCL_OFF 0x24 /* Z-axis acceleration bias offset factor */
+#define ADIS16400_XMAGN_HIF 0x26 /* X-axis magnetometer, hard-iron factor */
+#define ADIS16400_YMAGN_HIF 0x28 /* Y-axis magnetometer, hard-iron factor */
+#define ADIS16400_ZMAGN_HIF 0x2A /* Z-axis magnetometer, hard-iron factor */
+#define ADIS16400_XMAGN_SIF 0x2C /* X-axis magnetometer, soft-iron factor */
+#define ADIS16400_YMAGN_SIF 0x2E /* Y-axis magnetometer, soft-iron factor */
+#define ADIS16400_ZMAGN_SIF 0x30 /* Z-axis magnetometer, soft-iron factor */
+
+#define ADIS16400_GPIO_CTRL 0x32 /* Auxiliary digital input/output control */
+#define ADIS16400_MSC_CTRL  0x34 /* Miscellaneous control */
+#define ADIS16400_SMPL_PRD  0x36 /* Internal sample period (rate) control */
+#define ADIS16400_SENS_AVG  0x38 /* Dynamic range and digital filter control */
+#define ADIS16400_SLP_CNT   0x3A /* Sleep mode control */
+#define ADIS16400_DIAG_STAT 0x3C /* System status */
+
+/* Alarm functions */
+#define ADIS16400_GLOB_CMD  0x3E /* System command */
+#define ADIS16400_ALM_MAG1  0x40 /* Alarm 1 amplitude threshold */
+#define ADIS16400_ALM_MAG2  0x42 /* Alarm 2 amplitude threshold */
+#define ADIS16400_ALM_SMPL1 0x44 /* Alarm 1 sample size */
+#define ADIS16400_ALM_SMPL2 0x46 /* Alarm 2 sample size */
+#define ADIS16400_ALM_CTRL  0x48 /* Alarm control */
+#define ADIS16400_AUX_DAC   0x4A /* Auxiliary DAC data */
+
+#define ADIS16334_LOT_ID1   0x52 /* Lot identification code 1 */
+#define ADIS16334_LOT_ID2   0x54 /* Lot identification code 2 */
+#define ADIS16400_PRODUCT_ID 0x56 /* Product identifier */
+#define ADIS16334_SERIAL_NUMBER 0x58 /* Serial number, lot specific */
+
+#define ADIS16400_ERROR_ACTIVE			(1<<14)
+#define ADIS16400_NEW_DATA			(1<<14)
+
+/* MSC_CTRL */
+#define ADIS16400_MSC_CTRL_MEM_TEST		(1<<11)
+#define ADIS16400_MSC_CTRL_INT_SELF_TEST	(1<<10)
+#define ADIS16400_MSC_CTRL_NEG_SELF_TEST	(1<<9)
+#define ADIS16400_MSC_CTRL_POS_SELF_TEST	(1<<8)
+#define ADIS16400_MSC_CTRL_GYRO_BIAS		(1<<7)
+#define ADIS16400_MSC_CTRL_ACCL_ALIGN		(1<<6)
+#define ADIS16400_MSC_CTRL_DATA_RDY_EN		(1<<2)
+#define ADIS16400_MSC_CTRL_DATA_RDY_POL_HIGH	(1<<1)
+#define ADIS16400_MSC_CTRL_DATA_RDY_DIO2	(1<<0)
+
+/* SMPL_PRD */
+#define ADIS16400_SMPL_PRD_TIME_BASE	(1<<7)
+#define ADIS16400_SMPL_PRD_DIV_MASK	0x7F
+
+/* DIAG_STAT */
+#define ADIS16400_DIAG_STAT_ZACCL_FAIL	15
+#define ADIS16400_DIAG_STAT_YACCL_FAIL	14
+#define ADIS16400_DIAG_STAT_XACCL_FAIL	13
+#define ADIS16400_DIAG_STAT_XGYRO_FAIL	12
+#define ADIS16400_DIAG_STAT_YGYRO_FAIL	11
+#define ADIS16400_DIAG_STAT_ZGYRO_FAIL	10
+#define ADIS16400_DIAG_STAT_ALARM2	9
+#define ADIS16400_DIAG_STAT_ALARM1	8
+#define ADIS16400_DIAG_STAT_FLASH_CHK	6
+#define ADIS16400_DIAG_STAT_SELF_TEST	5
+#define ADIS16400_DIAG_STAT_OVERFLOW	4
+#define ADIS16400_DIAG_STAT_SPI_FAIL	3
+#define ADIS16400_DIAG_STAT_FLASH_UPT	2
+#define ADIS16400_DIAG_STAT_POWER_HIGH	1
+#define ADIS16400_DIAG_STAT_POWER_LOW	0
+
+/* GLOB_CMD */
+#define ADIS16400_GLOB_CMD_SW_RESET	(1<<7)
+#define ADIS16400_GLOB_CMD_P_AUTO_NULL	(1<<4)
+#define ADIS16400_GLOB_CMD_FLASH_UPD	(1<<3)
+#define ADIS16400_GLOB_CMD_DAC_LATCH	(1<<2)
+#define ADIS16400_GLOB_CMD_FAC_CALIB	(1<<1)
+#define ADIS16400_GLOB_CMD_AUTO_NULL	(1<<0)
+
+/* SLP_CNT */
+#define ADIS16400_SLP_CNT_POWER_OFF	(1<<8)
+
+#define ADIS16334_RATE_DIV_SHIFT 8
+#define ADIS16334_RATE_INT_CLK BIT(0)
+
+#define ADIS16400_SPI_SLOW	(u32)(300 * 1000)
+#define ADIS16400_SPI_BURST	(u32)(1000 * 1000)
+#define ADIS16400_SPI_FAST	(u32)(2000 * 1000)
+
+#define ADIS16400_HAS_PROD_ID		BIT(0)
+#define ADIS16400_NO_BURST		BIT(1)
+#define ADIS16400_HAS_SLOW_MODE		BIT(2)
+#define ADIS16400_HAS_SERIAL_NUMBER	BIT(3)
+#define ADIS16400_BURST_DIAG_STAT	BIT(4)
+
+struct adis16400_state;
+
+struct adis16400_chip_info {
+	const struct iio_chan_spec *channels;
+	const int num_channels;
+	const long flags;
+	unsigned int gyro_scale_micro;
+	unsigned int accel_scale_micro;
+	int temp_scale_nano;
+	int temp_offset;
+	int (*set_freq)(struct adis16400_state *st, unsigned int freq);
+	int (*get_freq)(struct adis16400_state *st);
+};
+
+/**
+ * struct adis16400_state - device instance specific data
+ * @variant:	chip variant info
+ * @filt_int:	integer part of requested filter frequency
+ * @adis:	adis device
+ **/
+struct adis16400_state {
+	struct adis16400_chip_info	*variant;
+	int				filt_int;
+
+	struct adis adis;
+	unsigned long avail_scan_mask[2];
+};
 
-#include "adis16400.h"
+/* At the moment triggers are only used for ring buffer
+ * filling. This may change!
+ */
+
+enum {
+	ADIS16400_SCAN_SUPPLY,
+	ADIS16400_SCAN_GYRO_X,
+	ADIS16400_SCAN_GYRO_Y,
+	ADIS16400_SCAN_GYRO_Z,
+	ADIS16400_SCAN_ACC_X,
+	ADIS16400_SCAN_ACC_Y,
+	ADIS16400_SCAN_ACC_Z,
+	ADIS16400_SCAN_MAGN_X,
+	ADIS16400_SCAN_MAGN_Y,
+	ADIS16400_SCAN_MAGN_Z,
+	ADIS16400_SCAN_BARO,
+	ADIS16350_SCAN_TEMP_X,
+	ADIS16350_SCAN_TEMP_Y,
+	ADIS16350_SCAN_TEMP_Z,
+	ADIS16300_SCAN_INCLI_X,
+	ADIS16300_SCAN_INCLI_Y,
+	ADIS16400_SCAN_ADC,
+	ADIS16400_SCAN_TIMESTAMP,
+};
 
 #ifdef CONFIG_DEBUG_FS
 
diff --git a/drivers/iio/imu/adis16400.h b/drivers/iio/imu/adis16400.h
deleted file mode 100644
index 7e2e0dbaa2e1..000000000000
--- a/drivers/iio/imu/adis16400.h
+++ /dev/null
@@ -1,197 +0,0 @@
-/*
- * adis16400.h	support Analog Devices ADIS16400
- *		3d 18g accelerometers,
- *		3d gyroscopes,
- *		3d 2.5gauss magnetometers via SPI
- *
- * Copyright (c) 2009 Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
- * Copyright (c) 2007 Jonathan Cameron <jic23@kernel.org>
- *
- * Loosely based upon lis3l02dq.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef SPI_ADIS16400_H_
-#define SPI_ADIS16400_H_
-
-#include <linux/iio/imu/adis.h>
-
-#define ADIS16400_STARTUP_DELAY	290 /* ms */
-#define ADIS16400_MTEST_DELAY 90 /* ms */
-
-#define ADIS16400_FLASH_CNT  0x00 /* Flash memory write count */
-#define ADIS16400_SUPPLY_OUT 0x02 /* Power supply measurement */
-#define ADIS16400_XGYRO_OUT 0x04 /* X-axis gyroscope output */
-#define ADIS16400_YGYRO_OUT 0x06 /* Y-axis gyroscope output */
-#define ADIS16400_ZGYRO_OUT 0x08 /* Z-axis gyroscope output */
-#define ADIS16400_XACCL_OUT 0x0A /* X-axis accelerometer output */
-#define ADIS16400_YACCL_OUT 0x0C /* Y-axis accelerometer output */
-#define ADIS16400_ZACCL_OUT 0x0E /* Z-axis accelerometer output */
-#define ADIS16400_XMAGN_OUT 0x10 /* X-axis magnetometer measurement */
-#define ADIS16400_YMAGN_OUT 0x12 /* Y-axis magnetometer measurement */
-#define ADIS16400_ZMAGN_OUT 0x14 /* Z-axis magnetometer measurement */
-#define ADIS16400_TEMP_OUT  0x16 /* Temperature output */
-#define ADIS16400_AUX_ADC   0x18 /* Auxiliary ADC measurement */
-
-#define ADIS16350_XTEMP_OUT 0x10 /* X-axis gyroscope temperature measurement */
-#define ADIS16350_YTEMP_OUT 0x12 /* Y-axis gyroscope temperature measurement */
-#define ADIS16350_ZTEMP_OUT 0x14 /* Z-axis gyroscope temperature measurement */
-
-#define ADIS16300_PITCH_OUT 0x12 /* X axis inclinometer output measurement */
-#define ADIS16300_ROLL_OUT  0x14 /* Y axis inclinometer output measurement */
-#define ADIS16300_AUX_ADC   0x16 /* Auxiliary ADC measurement */
-
-#define ADIS16448_BARO_OUT	0x16 /* Barometric pressure output */
-#define ADIS16448_TEMP_OUT  0x18 /* Temperature output */
-
-/* Calibration parameters */
-#define ADIS16400_XGYRO_OFF 0x1A /* X-axis gyroscope bias offset factor */
-#define ADIS16400_YGYRO_OFF 0x1C /* Y-axis gyroscope bias offset factor */
-#define ADIS16400_ZGYRO_OFF 0x1E /* Z-axis gyroscope bias offset factor */
-#define ADIS16400_XACCL_OFF 0x20 /* X-axis acceleration bias offset factor */
-#define ADIS16400_YACCL_OFF 0x22 /* Y-axis acceleration bias offset factor */
-#define ADIS16400_ZACCL_OFF 0x24 /* Z-axis acceleration bias offset factor */
-#define ADIS16400_XMAGN_HIF 0x26 /* X-axis magnetometer, hard-iron factor */
-#define ADIS16400_YMAGN_HIF 0x28 /* Y-axis magnetometer, hard-iron factor */
-#define ADIS16400_ZMAGN_HIF 0x2A /* Z-axis magnetometer, hard-iron factor */
-#define ADIS16400_XMAGN_SIF 0x2C /* X-axis magnetometer, soft-iron factor */
-#define ADIS16400_YMAGN_SIF 0x2E /* Y-axis magnetometer, soft-iron factor */
-#define ADIS16400_ZMAGN_SIF 0x30 /* Z-axis magnetometer, soft-iron factor */
-
-#define ADIS16400_GPIO_CTRL 0x32 /* Auxiliary digital input/output control */
-#define ADIS16400_MSC_CTRL  0x34 /* Miscellaneous control */
-#define ADIS16400_SMPL_PRD  0x36 /* Internal sample period (rate) control */
-#define ADIS16400_SENS_AVG  0x38 /* Dynamic range and digital filter control */
-#define ADIS16400_SLP_CNT   0x3A /* Sleep mode control */
-#define ADIS16400_DIAG_STAT 0x3C /* System status */
-
-/* Alarm functions */
-#define ADIS16400_GLOB_CMD  0x3E /* System command */
-#define ADIS16400_ALM_MAG1  0x40 /* Alarm 1 amplitude threshold */
-#define ADIS16400_ALM_MAG2  0x42 /* Alarm 2 amplitude threshold */
-#define ADIS16400_ALM_SMPL1 0x44 /* Alarm 1 sample size */
-#define ADIS16400_ALM_SMPL2 0x46 /* Alarm 2 sample size */
-#define ADIS16400_ALM_CTRL  0x48 /* Alarm control */
-#define ADIS16400_AUX_DAC   0x4A /* Auxiliary DAC data */
-
-#define ADIS16334_LOT_ID1   0x52 /* Lot identification code 1 */
-#define ADIS16334_LOT_ID2   0x54 /* Lot identification code 2 */
-#define ADIS16400_PRODUCT_ID 0x56 /* Product identifier */
-#define ADIS16334_SERIAL_NUMBER 0x58 /* Serial number, lot specific */
-
-#define ADIS16400_ERROR_ACTIVE			(1<<14)
-#define ADIS16400_NEW_DATA			(1<<14)
-
-/* MSC_CTRL */
-#define ADIS16400_MSC_CTRL_MEM_TEST		(1<<11)
-#define ADIS16400_MSC_CTRL_INT_SELF_TEST	(1<<10)
-#define ADIS16400_MSC_CTRL_NEG_SELF_TEST	(1<<9)
-#define ADIS16400_MSC_CTRL_POS_SELF_TEST	(1<<8)
-#define ADIS16400_MSC_CTRL_GYRO_BIAS		(1<<7)
-#define ADIS16400_MSC_CTRL_ACCL_ALIGN		(1<<6)
-#define ADIS16400_MSC_CTRL_DATA_RDY_EN		(1<<2)
-#define ADIS16400_MSC_CTRL_DATA_RDY_POL_HIGH	(1<<1)
-#define ADIS16400_MSC_CTRL_DATA_RDY_DIO2	(1<<0)
-
-/* SMPL_PRD */
-#define ADIS16400_SMPL_PRD_TIME_BASE	(1<<7)
-#define ADIS16400_SMPL_PRD_DIV_MASK	0x7F
-
-/* DIAG_STAT */
-#define ADIS16400_DIAG_STAT_ZACCL_FAIL	15
-#define ADIS16400_DIAG_STAT_YACCL_FAIL	14
-#define ADIS16400_DIAG_STAT_XACCL_FAIL	13
-#define ADIS16400_DIAG_STAT_XGYRO_FAIL	12
-#define ADIS16400_DIAG_STAT_YGYRO_FAIL	11
-#define ADIS16400_DIAG_STAT_ZGYRO_FAIL	10
-#define ADIS16400_DIAG_STAT_ALARM2	9
-#define ADIS16400_DIAG_STAT_ALARM1	8
-#define ADIS16400_DIAG_STAT_FLASH_CHK	6
-#define ADIS16400_DIAG_STAT_SELF_TEST	5
-#define ADIS16400_DIAG_STAT_OVERFLOW	4
-#define ADIS16400_DIAG_STAT_SPI_FAIL	3
-#define ADIS16400_DIAG_STAT_FLASH_UPT	2
-#define ADIS16400_DIAG_STAT_POWER_HIGH	1
-#define ADIS16400_DIAG_STAT_POWER_LOW	0
-
-/* GLOB_CMD */
-#define ADIS16400_GLOB_CMD_SW_RESET	(1<<7)
-#define ADIS16400_GLOB_CMD_P_AUTO_NULL	(1<<4)
-#define ADIS16400_GLOB_CMD_FLASH_UPD	(1<<3)
-#define ADIS16400_GLOB_CMD_DAC_LATCH	(1<<2)
-#define ADIS16400_GLOB_CMD_FAC_CALIB	(1<<1)
-#define ADIS16400_GLOB_CMD_AUTO_NULL	(1<<0)
-
-/* SLP_CNT */
-#define ADIS16400_SLP_CNT_POWER_OFF	(1<<8)
-
-#define ADIS16334_RATE_DIV_SHIFT 8
-#define ADIS16334_RATE_INT_CLK BIT(0)
-
-#define ADIS16400_SPI_SLOW	(u32)(300 * 1000)
-#define ADIS16400_SPI_BURST	(u32)(1000 * 1000)
-#define ADIS16400_SPI_FAST	(u32)(2000 * 1000)
-
-#define ADIS16400_HAS_PROD_ID		BIT(0)
-#define ADIS16400_NO_BURST		BIT(1)
-#define ADIS16400_HAS_SLOW_MODE		BIT(2)
-#define ADIS16400_HAS_SERIAL_NUMBER	BIT(3)
-#define ADIS16400_BURST_DIAG_STAT	BIT(4)
-
-struct adis16400_state;
-
-struct adis16400_chip_info {
-	const struct iio_chan_spec *channels;
-	const int num_channels;
-	const long flags;
-	unsigned int gyro_scale_micro;
-	unsigned int accel_scale_micro;
-	int temp_scale_nano;
-	int temp_offset;
-	int (*set_freq)(struct adis16400_state *st, unsigned int freq);
-	int (*get_freq)(struct adis16400_state *st);
-};
-
-/**
- * struct adis16400_state - device instance specific data
- * @variant:	chip variant info
- * @filt_int:	integer part of requested filter frequency
- * @adis:	adis device
- **/
-struct adis16400_state {
-	struct adis16400_chip_info	*variant;
-	int				filt_int;
-
-	struct adis adis;
-	unsigned long avail_scan_mask[2];
-};
-
-/* At the moment triggers are only used for ring buffer
- * filling. This may change!
- */
-
-enum {
-	ADIS16400_SCAN_SUPPLY,
-	ADIS16400_SCAN_GYRO_X,
-	ADIS16400_SCAN_GYRO_Y,
-	ADIS16400_SCAN_GYRO_Z,
-	ADIS16400_SCAN_ACC_X,
-	ADIS16400_SCAN_ACC_Y,
-	ADIS16400_SCAN_ACC_Z,
-	ADIS16400_SCAN_MAGN_X,
-	ADIS16400_SCAN_MAGN_Y,
-	ADIS16400_SCAN_MAGN_Z,
-	ADIS16400_SCAN_BARO,
-	ADIS16350_SCAN_TEMP_X,
-	ADIS16350_SCAN_TEMP_Y,
-	ADIS16350_SCAN_TEMP_Z,
-	ADIS16300_SCAN_INCLI_X,
-	ADIS16300_SCAN_INCLI_Y,
-	ADIS16400_SCAN_ADC,
-	ADIS16400_SCAN_TIMESTAMP,
-};
-
-#endif /* SPI_ADIS16400_H_ */
-- 
2.17.1

