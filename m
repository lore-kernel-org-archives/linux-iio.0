Return-Path: <SRS0=Obq9=BB=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24521C433F8
	for <linux-iio@archiver.kernel.org>; Wed, 22 Jul 2020 15:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAEA62084D
	for <linux-iio@archiver.kernel.org>; Wed, 22 Jul 2020 15:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595433217;
	bh=aNShfbyrW0F2L3sXIPPxtNaDWjF+rIoFOTDsdMIaoIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DHNQSD5tP2Qqel9tQd/FbcDfqjiOV4BRoc7tj6BjNlxp+/0nglEARlZb3LHRAiG/8
	 gN67zJ71SMFJS6CH7WFF7liq8XFHp5eWvyITnOJ1JOz+h4ci9Txc82KcbgId27hsvd
	 OziVFG46ew5k5Sdq4rdiRhzpZDMdvle45FfzhGlk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbgGVPxg (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 22 Jul 2020 11:53:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgGVPxg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Jul 2020 11:53:36 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFB2720717;
        Wed, 22 Jul 2020 15:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595433215;
        bh=aNShfbyrW0F2L3sXIPPxtNaDWjF+rIoFOTDsdMIaoIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fxhoWybMtqxOk/FvrLOaqLl8o5uXi2xMxrBahurXloNoTeEnxGTinWygLGG6ougtG
         RfxV6IMfxsvEPYE4e0wmBs9eNJ66n0MyDx968a4vnX+76i5fcUHek6HMKjYCK9iTvO
         mtxCTbVXtxtJrO+hGbPGN3RLHNySW8UA6igvXgs4=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v3 18/27] iio:imu:inv_mpu6050: Use regmap_noinc_read for fifo reads.
Date:   Wed, 22 Jul 2020 16:50:54 +0100
Message-Id: <20200722155103.979802-19-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722155103.979802-1-jic23@kernel.org>
References: <20200722155103.979802-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

We should not be assuming that we are reading a sequence of
registers as here we are doing a read of a lot of data from
a single register address.

Suggested-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index d8e6b88ddffc..45c37525c2f1 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -179,8 +179,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	nb = fifo_count / bytes_per_datum;
 	inv_mpu6050_update_period(st, pf->timestamp, nb);
 	for (i = 0; i < nb; ++i) {
-		result = regmap_bulk_read(st->map, st->reg->fifo_r_w,
-					  st->data, bytes_per_datum);
+		result = regmap_noinc_read(st->map, st->reg->fifo_r_w,
+					   st->data, bytes_per_datum);
 		if (result)
 			goto flush_fifo;
 		/* skip first samples if needed */
-- 
2.27.0

