Return-Path: <SRS0=q/te=5V=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C423C2BA1A
	for <linux-iio@archiver.kernel.org>; Sun,  5 Apr 2020 18:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6859E206C3
	for <linux-iio@archiver.kernel.org>; Sun,  5 Apr 2020 18:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586109960;
	bh=d88SUaEzUyt7L1zsyfWDrWfWrZaeTiwYgxFv5uZDE28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ypjAvzf/qFLCQ1l1Pk7A948xHJuoURt46kWr8xqGCIAA5LFw0WojyH+hzFCvR7TWj
	 SzTbH/83mYBFNrAoqraFr/ITXy4JxbLzsV+OVOeGL5J2Oz792LQemK+kOteIltZWrM
	 mZYUjX0OXOCuH2bTDp+JT14PTkOaitWaH/LbrNtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgDESGA (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 5 Apr 2020 14:06:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727522AbgDESF7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 14:05:59 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84C1C20678;
        Sun,  5 Apr 2020 18:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586109959;
        bh=d88SUaEzUyt7L1zsyfWDrWfWrZaeTiwYgxFv5uZDE28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2pKAiENRiNy0PqJgtCyBzkDHkTO7kkRcONIb2G1Oe6xGd56sOtLmkbHb4F4H5/SFx
         KUEBlXo8ykcRxeKl/sUWhO7K71xx5qPVRJyP/pS366CZ+I5F5fZicS8sWNS8snMleO
         nkLTmuVfkIP6xelF4WJrBXI4zXhFO9Y0sf7EFUtE=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 4/6] iio:imu:mpu6050: Tidy up parameters to regmap_bulk functions.
Date:   Sun,  5 Apr 2020 19:03:19 +0100
Message-Id: <20200405180321.1737310-5-jic23@kernel.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405180321.1737310-1-jic23@kernel.org>
References: <20200405180321.1737310-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

A mixture of:
* Casts to u8 * for the val parameter which is void * and so needs no cast.
* Explicit sizes when we can use sizeof on the destination / source variable.

Not broken in anyway, I'm just trying to tidy up the is in the subsystem to
avoid it getting cut and paste into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index e4b0d368c2f9..d3819b516ec6 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -526,7 +526,7 @@ static int inv_mpu6050_sensor_set(struct inv_mpu6050_state  *st, int reg,
 	__be16 d = cpu_to_be16(val);
 
 	ind = (axis - IIO_MOD_X) * 2;
-	result = regmap_bulk_write(st->map, reg + ind, (u8 *)&d, 2);
+	result = regmap_bulk_write(st->map, reg + ind, &d, sizeof(d));
 	if (result)
 		return -EINVAL;
 
@@ -540,7 +540,7 @@ static int inv_mpu6050_sensor_show(struct inv_mpu6050_state  *st, int reg,
 	__be16 d;
 
 	ind = (axis - IIO_MOD_X) * 2;
-	result = regmap_bulk_read(st->map, reg + ind, (u8 *)&d, 2);
+	result = regmap_bulk_read(st->map, reg + ind, &d, sizeof(d));
 	if (result)
 		return -EINVAL;
 	*val = (short)be16_to_cpup(&d);
-- 
2.26.0

