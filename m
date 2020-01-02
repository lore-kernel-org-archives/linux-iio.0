Return-Path: <SRS0=H0lJ=2X=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5948C2D0DD
	for <linux-iio@archiver.kernel.org>; Thu,  2 Jan 2020 08:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF5721835
	for <linux-iio@archiver.kernel.org>; Thu,  2 Jan 2020 08:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577954207;
	bh=S/T899CaR4IPob3wO0sAJQSthMSbRNr+0F3WWN46/3Q=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=I2APul6sCoWAs7kjtp32JgVNFb244hRPkMe7GLLm0tG90eD+78QVXtQ3yiU2yuDv4
	 BbRVvoacKwQkpE9prCbxho9ZXOAq4GXpDZE5eDHs8LpUPe+nNYGxwNS8X0xgZhzNbh
	 d+9Tjl8HrkvejaPjRFNp+bpBjdy1Qd/o5b+7H0mQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgABIgr (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 2 Jan 2020 03:36:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:36342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbgABIgr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 2 Jan 2020 03:36:47 -0500
Received: from new-host-4.redhat.com (net-2-42-61-77.cust.vodafonedsl.it [2.42.61.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5974C20866;
        Thu,  2 Jan 2020 08:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577954206;
        bh=S/T899CaR4IPob3wO0sAJQSthMSbRNr+0F3WWN46/3Q=;
        h=From:To:Cc:Subject:Date:From;
        b=Pqv7I2eYPaQN/EF2ctKG+P3qbC1xaGDj2z3h4fz0Ku7ThuimM+GRUmOzHjfANDiOv
         XHzcZ+2R8m6oBzFDrYMXp9op17nr/txTMGqgnQulMFjNpzJhXgTJi1tZFbQXx7XWgT
         ShlfD5aTGg8flcw7IwGZWjEPw1wcLDsw1N9EGejE=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] iio: imu: st_lsm6dsx: check return value from st_lsm6dsx_sensor_set_enable
Date:   Thu,  2 Jan 2020 09:36:29 +0100
Message-Id: <3a7c5182cd676230eadb11510aee7317ce1b4e34.1577954098.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add missing return value check in st_lsm6dsx_read_oneshot disabling the
sensor. The issue is reported by coverity with the following error:

Unchecked return value:
If the function returns an error value, the error value may be mistaken
for a normal value.

Addresses-Coverity-ID: 1446733 ("Unchecked return value")
Fixes: b5969abfa8b8 ("iio: imu: st_lsm6dsx: add motion events")
Fixes: 290a6ce11d93 ("iio: imu: add support to lsm6dsx driver")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 0c64e35c7599..a16395598754 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1534,8 +1534,11 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
 	if (err < 0)
 		return err;
 
-	if (!hw->enable_event)
-		st_lsm6dsx_sensor_set_enable(sensor, false);
+	if (!hw->enable_event) {
+		err = st_lsm6dsx_sensor_set_enable(sensor, false);
+		if (err < 0)
+			return err;
+	}
 
 	*val = (s16)le16_to_cpu(data);
 
-- 
2.21.0

