Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77088C433B4
	for <linux-iio@archiver.kernel.org>; Fri,  7 May 2021 10:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5338461426
	for <linux-iio@archiver.kernel.org>; Fri,  7 May 2021 10:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbhEGKci (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 7 May 2021 06:32:38 -0400
Received: from first.geanix.com ([116.203.34.67]:38858 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229829AbhEGKch (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 7 May 2021 06:32:37 -0400
Received: from zen.. (109.57.11.253.mobile.3.dk [109.57.11.253])
        by first.geanix.com (Postfix) with ESMTPSA id 914064680DE;
        Fri,  7 May 2021 10:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1620383495; bh=S2q2tzdDm6E95jCOCbV5DhbJxg2LzcGDOE4mBgDMDoI=;
        h=From:To:Cc:Subject:Date;
        b=IGzL/SZUosa+4Ke+FNLhGkkC25iT+dmOVs75OEYXLpV3VxESqcho0zV0/Vb6OvV0z
         IszYOEJqEQhhe7wnqGCYZaevq7l3DvhvuBIh8p5ExhWHkQbBV9GCZ9PPRByM7tEdvy
         yo1EQN355CvdIFJXTx9fBmc7Li0/W+g4Z06sUSAFSw9gTZqovUN1OBjthSRzxSKndj
         Y3xJNrI5QL7KK2tCbb4uwjR+UoXgbN3qKiKG8T3EpIYQ4HJVJGkH3W0JMxw3zLZVyF
         jZrfDa7FfC+ULXRmhrfyr53xyvZqMK1QerEE0pjZLEzTtOH0EjOgczkoJT1Hnr3Zua
         Az+pnAhdl5ksg==
From:   Sean Nyekjaer <sean@geanix.com>
To:     lorenzo.bianconi83@gmail.com, jic23@kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org
Subject: [PATCH] iio: imu: st_lsm6dsx: correct ODR in header
Date:   Fri,  7 May 2021 12:31:26 +0200
Message-Id: <20210507103126.2193875-1-sean@geanix.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix wrongly stated 13 Hz ODR for accelerometers, the correct ODR is 12.5 Hz

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 2ab1ac5a2412..a3ab16615729 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -15,19 +15,19 @@
  *
  * Supported sensors:
  * - LSM6DS3:
- *   - Accelerometer/Gyroscope supported ODR [Hz]: 13, 26, 52, 104, 208, 416
+ *   - Accelerometer/Gyroscope supported ODR [Hz]: 12.5, 26, 52, 104, 208, 416
  *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
  *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
  *   - FIFO size: 8KB
  *
  * - LSM6DS3H/LSM6DSL/LSM6DSM/ISM330DLC/LSM6DS3TR-C:
- *   - Accelerometer/Gyroscope supported ODR [Hz]: 13, 26, 52, 104, 208, 416
+ *   - Accelerometer/Gyroscope supported ODR [Hz]: 12.5, 26, 52, 104, 208, 416
  *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
  *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
  *   - FIFO size: 4KB
  *
  * - LSM6DSO/LSM6DSOX/ASM330LHH/LSM6DSR/ISM330DHCX:
- *   - Accelerometer/Gyroscope supported ODR [Hz]: 13, 26, 52, 104, 208, 416,
+ *   - Accelerometer/Gyroscope supported ODR [Hz]: 12.5, 26, 52, 104, 208, 416,
  *     833
  *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
  *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
-- 
2.31.0

