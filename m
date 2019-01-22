Return-Path: <SRS0=dXrR=P6=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27401C37124
	for <linux-iio@archiver.kernel.org>; Tue, 22 Jan 2019 02:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E557620870
	for <linux-iio@archiver.kernel.org>; Tue, 22 Jan 2019 02:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="ELvrrYdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfAVCEp (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 21 Jan 2019 21:04:45 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39443 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfAVCEp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Jan 2019 21:04:45 -0500
Received: by mail-pg1-f196.google.com with SMTP id w6so10277373pgl.6
        for <linux-iio@vger.kernel.org>; Mon, 21 Jan 2019 18:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=+emAylfCxXB91cbBPVb9+jou3+Q2IsPc1dpIh7YBHNw=;
        b=ELvrrYdkS1KN7JJ6CocQLVQXkN2CLFBkT/gNkHZytLdLJ+gEiHL8lK7qhybZisWJQd
         HCIC9Hu9/MwmuSMyyvHtwah2MJwtw922OgfCoGbbaD/UTE9MDyXyp9oyrv4tXWkwTwpn
         MpLzIVG1nTBW2Xn3F6jzvppZIRCtk8E8PQjRnyyZXe8lh08G4LrsLt8WVQeqqhlRfRdI
         aTwrUwxHG0e3mLgJBDRbyen911Vbz423n2kgNE1/cSmfLYFsHjZV+OaEpIhvNfqmv6aN
         bYffIAKdQOE1GhqGlxN6GqMvg2Nezeka9uyAOVfFcQruiF3yaLf5luPCnaMFBZkpISyr
         tebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+emAylfCxXB91cbBPVb9+jou3+Q2IsPc1dpIh7YBHNw=;
        b=q27sYXlRQDnlodetqRz5VYuHZ/xWth5UgdqKgjckGh8IwV3U+cInE0i9JMy3BGXrbs
         gX/o691vgaPYu3ColZCumlaAYrwpR0YYhOl8Ecc5nMrvl7xahCBseqnqHXJOzgs2pZM9
         8ntSX4Q9efqQDvP5A/E5Doe6k/vsnbySnVZ436OAk36UpaY6PcHJtOtC2+BWOydPJKFW
         lHwp/WDbfALiP1tMhMpu01DQOsHnmQZ2lu5AnDiMw6aEA5/TzLFqYMTJrbhOKWbet7RW
         dgP/z8c05oyGvIu5T9pM8WkJBWcYBqp4ZvdA4P61M1cIFvMOZdolQwZTQ8Bn6TSSdrpY
         pP0Q==
X-Gm-Message-State: AJcUukf23UnvO3UGgVFlpjKnVPSw07yKGCTHzk5sjHDaONn9LtB0qvcd
        L4x8xl5HQELPTXXmsOdZfC1GHPsXTEo=
X-Google-Smtp-Source: ALg8bN5QAjDzGiWNn4IuiO87o8INoxCa3IQFatxHmrxNSiWDJclVeSthSqpdEUOQvDysKsnFXIBOOQ==
X-Received: by 2002:a63:eb52:: with SMTP id b18mr29514958pgk.213.1548122683923;
        Mon, 21 Jan 2019 18:04:43 -0800 (PST)
Received: from cascade.Home (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id n21sm19759404pfg.84.2019.01.21.18.04.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 18:04:43 -0800 (PST)
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
Subject: [PATCH v2 1/6] iio:bmi160: add SPDX identifiers
Date:   Mon, 21 Jan 2019 18:04:26 -0800
Message-Id: <20190122020431.5338-1-martin@martingkelly.com>
X-Mailer: git-send-email 2.11.0
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

