Return-Path: <SRS0=pB1S=QD=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7E8C282CA
	for <linux-iio@archiver.kernel.org>; Sun, 27 Jan 2019 20:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B6D2133F
	for <linux-iio@archiver.kernel.org>; Sun, 27 Jan 2019 20:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="seTxKBbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfA0Ujb (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 27 Jan 2019 15:39:31 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40186 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbfA0Uja (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Jan 2019 15:39:30 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so6812261plq.7
        for <linux-iio@vger.kernel.org>; Sun, 27 Jan 2019 12:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+emAylfCxXB91cbBPVb9+jou3+Q2IsPc1dpIh7YBHNw=;
        b=seTxKBbv6NcYw7C/fWxfSIDXnW8QJGcsoke1fNa+shgYPiMPueYCWIQHhbMV5FzyuX
         AlJmrasn+/caaslB3Pv4A9I/o1MThhwVZjiV6pqiCegfLxgvA0lhucdBmL3KdZM4dkmY
         nX1MoVWlrAECC6ay6lKbFiBct3rATFtk6q0wEcGqRBM30dNLZWiTYry1erQZCfXX7Tln
         yxh+sbNPRR3t5kp6uigS+CTc72uXSy1piZ3uFM+WH3m0m/vEjvHl6BQuKAvKpPhoErU2
         gbEanCrIT2s7kDv8uMQqwOrcsLLJWKTVq84LI29EhOnM89koG9+FMTFcHC/xoIA5K5Um
         0V+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+emAylfCxXB91cbBPVb9+jou3+Q2IsPc1dpIh7YBHNw=;
        b=rnOwJOb1gHd8FXqw2/GFt4GJxcjjaUEuJ+8pncN2XEz2KRad2kUxcmZtQij/n+M0Gr
         bDpE/6KFvmDylcewbLZ4971xrlB4PFzPl9VnQVlZyy24LoTFAZ05YbiXi0BEAs5kEdEU
         4JrRk1aPaZU4ALXVx3Q0a1jEzBrRgeA7hL6rrTx/RJajAdCnwvhuGwN9wKtT9U9BXScD
         LKqbDWryteRuopoxpdotimnRH+/l/1nkWJTIO6fYWJf3ZjH506sRqMBjck27FmGgtxDB
         ehzMo9TnbFDOM9y+ri3pjPvt1Ead4eL49jewiZP7h5v52jeKCAoswVM/7IspwEgBfJnA
         +PMg==
X-Gm-Message-State: AJcUukeS/qCYwuqADcOnZbsTLY5WJ5NQS7V/k34lokzEenWpoOgL7MNM
        /ia/5JuLJzb+cf3M0gFzoj9TMQtKOxc5Iw==
X-Google-Smtp-Source: ALg8bN54JP+563eTAArczYrNxmRCjWwAK5xtno4dxiaRghLB9gQOcbR75WTDAxZiN4GRAyphXbCJwQ==
X-Received: by 2002:a17:902:12f:: with SMTP id 44mr19540379plb.74.1548621569745;
        Sun, 27 Jan 2019 12:39:29 -0800 (PST)
Received: from cascade.Home (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id a4sm33049912pgv.70.2019.01.27.12.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 12:39:29 -0800 (PST)
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
Subject: [PATCH v3 1/6] iio:bmi160: add SPDX identifiers
Date:   Sun, 27 Jan 2019 12:39:06 -0800
Message-Id: <20190127203911.8696-2-martin@martingkelly.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190127203911.8696-1-martin@martingkelly.com>
References: <20190127203911.8696-1-martin@martingkelly.com>
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

