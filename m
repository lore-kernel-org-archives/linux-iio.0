Return-Path: <SRS0=BsLG=PW=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82CFC43387
	for <linux-iio@archiver.kernel.org>; Mon, 14 Jan 2019 03:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A6D2086D
	for <linux-iio@archiver.kernel.org>; Mon, 14 Jan 2019 03:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="nEbsLnS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfAND4l (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 13 Jan 2019 22:56:41 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45707 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfAND4k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Jan 2019 22:56:40 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so9490162plm.12
        for <linux-iio@vger.kernel.org>; Sun, 13 Jan 2019 19:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+emAylfCxXB91cbBPVb9+jou3+Q2IsPc1dpIh7YBHNw=;
        b=nEbsLnS1DqY5CS1LxhtrxmD14ZyiXipQY3uKH/QZTX5o7NVAbb+MhS6gIAtVSYEWY1
         X/LBBwJyPE+WBlfbpTUuUuGZ1xWLpv/Lu8L6E5g6m6bBgNZK7Edzekwjjml8O0dnOKIr
         9oUR/Uux3XgaR1s+dsLCSVK7seowGNRQrp1ClOgv+tCQ76nJAdLXpDYE1E0BXuGLskNu
         A/Kd7YIAp1baZi6S4FsNTlPFvQZUcy8TTgtYU9KaU8E2DX9bwSXLbdp0MdFPE925scQm
         d/T0uWIdpkIhXPdX3DqEaDDb0J0TvvAm1TLKvp99JAnSAkq0x7xTZ2JKXosKvZpsfIhk
         LnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+emAylfCxXB91cbBPVb9+jou3+Q2IsPc1dpIh7YBHNw=;
        b=YuodDPd2MBvO1SyaJbi0IAezZbAU4RDaU5QzxO8GffW9Kc/koI0WKDNKwHv/ZlNJo+
         I+h4U7UAojOPXLGE4R5GL876sSnAa09mJVnn1dtgyC0X2uMydahwlkoDMi5P/Iv3rsDI
         fqxX/9PrWzHhTIHUUHhd8HREhWDLBypRE6a1+B0gHgpP1JWoSZs3cJw5WbVk3ASdNHRZ
         nRQY86NYJhlJ6JNgjx4utMzTVQj5+XpqayiHRYZyPH3ZLem2GMfn/m0NE1UeDYRdrwOq
         xsC4s3oz76LgAT+EpzuEvr70L4HbnJVcI8URRssPSQTirkWIkjwhDipA+zfeNFJSOdIv
         7FlA==
X-Gm-Message-State: AJcUukdSQaWYy2qHb3nHeO7VWCKCv1f+NoofhrAa3afiwiMiwg3eQTLl
        ykCLW4DjQLkvVm4KeQeVYVdsZ6t0+/k=
X-Google-Smtp-Source: ALg8bN6w211JPg25hulx9VoNrG175EXFCOsR80bK+RhCR6b3VWzkenHqhhf2Yhpv8YlgosHIr4YJTw==
X-Received: by 2002:a17:902:8d95:: with SMTP id v21mr23863417plo.162.1547438199790;
        Sun, 13 Jan 2019 19:56:39 -0800 (PST)
Received: from cascade.Home (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id l70sm93582741pgd.20.2019.01.13.19.56.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 19:56:39 -0800 (PST)
From:   Martin Kelly <martin@martingkelly.com>
X-Google-Original-From: Martin Kelly <martin@martingkelly.com
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Kelly <martin@martingkelly.com>
Subject: [PATCH 1/5] iio:bmi160: add SPDX identifiers
Date:   Sun, 13 Jan 2019 19:56:17 -0800
Message-Id: <20190114035621.5252-2-martin@martingkelly.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190114035621.5252-1-martin@martingkelly.com>
References: <20190114035621.5252-1-martin@martingkelly.com>
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

