Return-Path: <SRS0=e+7m=X7=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320C2C10F14
	for <linux-iio@archiver.kernel.org>; Sun,  6 Oct 2019 13:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0791D2133F
	for <linux-iio@archiver.kernel.org>; Sun,  6 Oct 2019 13:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570368162;
	bh=hFXi24clnV9HB2ZmxckPQEhdsBtRWGbh//3lUs7nsxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VRL5E7kI5hKDaL14I2XPaixFUg/DpKKoHjg8xSw/5vswys1X3rT5vgvCGLFYlQDUs
	 98vvZsDSTKWg2B25osIYTRG5TDrJRPAdDjtFqpjrHQ1OBk9f9iKpdkgA+FrM5L7GQi
	 DSQ8ZVarB7aAot3uZm2ofX6Oc00rqsPodNAUA8S4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfJFNWl (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 6 Oct 2019 09:22:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfJFNWl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 09:22:41 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.37.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 613B52087E;
        Sun,  6 Oct 2019 13:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570368161;
        bh=hFXi24clnV9HB2ZmxckPQEhdsBtRWGbh//3lUs7nsxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G8knE7R+dRnB66qBUYAOOOCyQGtEGNS3wAeeSBBcXY3JEaSCl4pVdEAxkNlkSRp3E
         ZkGk2Np8lBkOGaNweLuW6Lmsogow5aRemm3JHlKB79v1ovTliE4qApAUuGnAqR7cwN
         Jz6DMSKsmh4924Jjy0fEdSN5CIdC77+RkLCRkYc4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, sean@geanix.com, martin@geanix.com,
        rjones@gateworks.com, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org
Subject: [PATCH 08/13] iio: imu: st_lsm6dsx: grab conf mutex in st_lsm6dsx_write_event_config
Date:   Sun,  6 Oct 2019 15:22:02 +0200
Message-Id: <b9761bf79a087f1699c5df049e9f2a10c9ad66ea.1570367532.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1570367532.git.lorenzo@kernel.org>
References: <cover.1570367532.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Always grub conf mutex in st_lsm6dsx_write_event_config since it can run
concurrently with FIFO configuration

Fixes: b5969abfa8b8 ("iio: imu: st_lsm6dsx: add motion events")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 023646762b4a..04231710ab9c 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1604,7 +1604,9 @@ static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
 	if (err < 0)
 		return err;
 
+	mutex_lock(&hw->conf_lock);
 	err = st_lsm6dsx_sensor_set_enable(sensor, state);
+	mutex_unlock(&hw->conf_lock);
 	if (err < 0)
 		return err;
 
-- 
2.21.0

