Return-Path: <SRS0=e/h2=QJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2407EC282D7
	for <linux-iio@archiver.kernel.org>; Sat,  2 Feb 2019 21:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58262084A
	for <linux-iio@archiver.kernel.org>; Sat,  2 Feb 2019 21:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="MJHYbUaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfBBV4T (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 2 Feb 2019 16:56:19 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43607 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbfBBV4T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 2 Feb 2019 16:56:19 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so4993233pfk.10
        for <linux-iio@vger.kernel.org>; Sat, 02 Feb 2019 13:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+emAylfCxXB91cbBPVb9+jou3+Q2IsPc1dpIh7YBHNw=;
        b=MJHYbUaHLWg1+jAFRAZxMlYgv6YmlcXRIvTmErlwgfmHvUe7+HCWIsV4hIOE5PrP1w
         Cq2xb35nPfhga9wC7ho5hbFoplKzlYeRn8JyBOaM+aZjWIdhxLJcV5sxbgCqhm2/p9RH
         uKouj5XsPIGSiXlQ+MkTJ42mlKoivrPGFIIgMnrjvEWnEvss0iyc5v+O3t7qEPOuHQx4
         eCHz59vmI/wuUxV13J3cewVoJl+FT/q6428CTVONJxCXpg1vFJz96LHVC0ha5H5Q8qAr
         NPxeVadJiH6h0DoOcwMbY7d9IJjBvcUjk1Px5XvZCYj9L+bQNXaomiF7yJb8vZIQX9CN
         Kqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+emAylfCxXB91cbBPVb9+jou3+Q2IsPc1dpIh7YBHNw=;
        b=DeA79Qh0TV9eNLoSfZdg5TLRNRHh9YxT5BvO4BZ+8RQkKbgooeOIpbHQYdIMXzC9w4
         of8ivLqp/q4hpjhKJVE7vg/XUWrN63kE6sZhc4A1hDmZXTIQ5ptKcH5ZFMe14WPS5E41
         3xnH4QLtrtSOfTplZM/ymfo3oOCNodj1NVXcgrho8bgZlJH3GLzWHABqAZXqAsW2ukjb
         IFM/0eoZK4rafpk8cR1xArTpLsQkXtBw7OrEH2cs6hNAmian2JmaaMj1zKLD3wSjeszw
         2anDQn5i1reLUVgWFpG71EmyQC0n7EyfzfWp09Afeh2K2TACYz0xrlCYFOP3ki81NIpI
         xgdw==
X-Gm-Message-State: AJcUukdtkHCYL3QC6QILUAojpRRoSlijqzSK7QUtTbUBjZ+CmYnt8GvN
        RN1G/5QvQGN8XtoU6M7mKHG7lEkH0s4=
X-Google-Smtp-Source: ALg8bN6AwAKdRe1DZXy8KX9dmt3yNmsr0cF/PaE1v5tIl79iGJ7crg2s62oChR5ff/AITHXLh6QXgg==
X-Received: by 2002:a62:6204:: with SMTP id w4mr45404816pfb.5.1549144578164;
        Sat, 02 Feb 2019 13:56:18 -0800 (PST)
Received: from cascade.Home (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id z127sm20082025pfb.80.2019.02.02.13.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 13:56:17 -0800 (PST)
From:   Martin Kelly <martin@martingkelly.com>
X-Google-Original-From: Martin Kelly <martin@martingkelly.com
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        devicetree@vger.kernel.org, Martin Kelly <martin@martingkelly.com>
Subject: [PATCH v4 1/6] iio:bmi160: add SPDX identifiers
Date:   Sat,  2 Feb 2019 13:55:56 -0800
Message-Id: <20190202215601.20275-2-martin@martingkelly.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190202215601.20275-1-martin@martingkelly.com>
References: <20190202215601.20275-1-martin@martingkelly.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Martin Kelly <martin@martingkelly.com>

Add SPDX identifiers (GPL 2) for the BMI160 driver. bmi160.h had an
identifier, but the other files did not.

Signed-off-by: Martin Kelly <martin@martingkelly.com>
---
 drivers/iio/imu/bmi160/bmi160_core.c | 5 +----
 drivers/iio/imu/bmi160/bmi160_i2c.c  | 5 +----
 drivers/iio/imu/bmi160/bmi160_spi.c  | 4 +---
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index b10330b0f93f..ce61026d84c3 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * BMI160 - Bosch IMU (accel, gyro plus external magnetometer)
  *
  * Copyright (c) 2016, Intel Corporation.
  *
- * This file is subject to the terms and conditions of version 2 of
- * the GNU General Public License.  See the file COPYING in the main
- * directory of this archive for more details.
- *
  * IIO core driver for BMI160, with support for I2C/SPI busses
  *
  * TODO: magnetometer, interrupts, hardware FIFO
diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
index 5b1f7e6af651..e36f5e82d400 100644
--- a/drivers/iio/imu/bmi160/bmi160_i2c.c
+++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * BMI160 - Bosch IMU, I2C bits
  *
  * Copyright (c) 2016, Intel Corporation.
  *
- * This file is subject to the terms and conditions of version 2 of
- * the GNU General Public License.  See the file COPYING in the main
- * directory of this archive for more details.
- *
  * 7-bit I2C slave address is:
  *      - 0x68 if SDO is pulled to GND
  *      - 0x69 if SDO is pulled to VDDIO
diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
index e521ad14eeac..c19e3df35559 100644
--- a/drivers/iio/imu/bmi160/bmi160_spi.c
+++ b/drivers/iio/imu/bmi160/bmi160_spi.c
@@ -1,11 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * BMI160 - Bosch IMU, SPI bits
  *
  * Copyright (c) 2016, Intel Corporation.
  *
- * This file is subject to the terms and conditions of version 2 of
- * the GNU General Public License.  See the file COPYING in the main
- * directory of this archive for more details.
  */
 #include <linux/acpi.h>
 #include <linux/module.h>
-- 
2.11.0

