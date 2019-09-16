Return-Path: <SRS0=iV6u=XL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BB8C4CECD
	for <linux-iio@archiver.kernel.org>; Mon, 16 Sep 2019 22:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1C5216C8
	for <linux-iio@archiver.kernel.org>; Mon, 16 Sep 2019 22:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568671298;
	bh=xqhVNJd5/Z861MxAPNLjsXkZbMQSWQl86jxQ7VGPWeo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=WbM7N+cBnwu/qrlT6LTwWDYIfruqkJs6jJNm0DneT/9ijiVzY3aVa3xY76DKKZtdO
	 bAs5cwtU/4j0RfGfkBEWNzqNPhDFSm7t0hOr07K97xDBIsAdV3RZSoFHDAiFpXwrIL
	 KwidFVjgc2lReWG8mH77sfSzgz+wupSHkF9EGgz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732464AbfIPWBh (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 16 Sep 2019 18:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730459AbfIPWBh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Sep 2019 18:01:37 -0400
Received: from lore-desk.lan (unknown [151.66.0.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29A04206C2;
        Mon, 16 Sep 2019 22:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568671297;
        bh=xqhVNJd5/Z861MxAPNLjsXkZbMQSWQl86jxQ7VGPWeo=;
        h=From:To:Cc:Subject:Date:From;
        b=xsoj4pa1KVCM7zRnDRh4S64oIi5VX2G4CqUqa4r+bEaL93LrYTKRaEZpOONu5UIHg
         cchYoTEH/2dRnKDSuhnRqsd8alXTuuwrCEORYt6+kern+ss1pKEkqMXLZJ0so3+hqp
         MP/VJDpZ9ZwLDrkkLcbVdjm/aiKRCLQiyL8VYDbA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org
Subject: [PATCH] iio: imu: st_lsm6dsx: fix waitime for st_lsm6dsx i2c controller
Date:   Tue, 17 Sep 2019 00:01:29 +0200
Message-Id: <46d302e91284908061e0a39e36b9a3122aa6fb1a.1568670658.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

i2c controller available in st_lsm6dsx series performs i2c slave
configuration using accel clock as trigger.
st_lsm6dsx_shub_wait_complete routine is used to wait the controller has
carried out the requested configuration. However if the accel sensor is not
enabled we should not use its configured odr to estimate a proper timeout

Fixes: c91c1c844ebd ("iio: imu: st_lsm6dsx: add i2c embedded controller support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index 66fbcd94642d..4c754a02717b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -92,9 +92,11 @@ static const struct st_lsm6dsx_ext_dev_settings st_lsm6dsx_ext_dev_table[] = {
 static void st_lsm6dsx_shub_wait_complete(struct st_lsm6dsx_hw *hw)
 {
 	struct st_lsm6dsx_sensor *sensor;
+	u16 odr;
 
 	sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
-	msleep((2000U / sensor->odr) + 1);
+	odr = (hw->enable_mask & BIT(ST_LSM6DSX_ID_ACC)) ? sensor->odr : 13;
+	msleep((2000U / odr) + 1);
 }
 
 /**
-- 
2.21.0

