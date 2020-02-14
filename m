Return-Path: <SRS0=TOo6=4C=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF65C47409
	for <linux-iio@archiver.kernel.org>; Fri, 14 Feb 2020 18:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53FA22314
	for <linux-iio@archiver.kernel.org>; Fri, 14 Feb 2020 18:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581704380;
	bh=2a+zUaID5zALeOpO/fqjSjJWxrxS49+DTJaNZxvO+2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qv4RA6tx425MWUOQ3WTdfV/a/uv8B/RH02BrJyYcqiMlvxU8/fpIDAKzfdQqkcnaI
	 VonRYqkkYXcZmPLr1A/m/gL0HquZ5IBmjMKVFyG7hHB2MDFXrvZ3DAM7nYSfroxojM
	 jWStKXWkkz6YO05jVJrSs8xpzK8IfWyHwKEs3nL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390389AbgBNSTg (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:19:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:54444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730451AbgBNPuY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 10:50:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B45E24684;
        Fri, 14 Feb 2020 15:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695424;
        bh=2a+zUaID5zALeOpO/fqjSjJWxrxS49+DTJaNZxvO+2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kf8MMhCdtosTqTAYCpyjD7+JWpMIYP/a+DdipeqfGCsMVDhSNgxmayEVsRvWMWhEC
         Iey2b8YcxkGZmvHHHUBsTfBW2PbQW/9IN667ceCw/51QixtNI4xoi0RbHaNolTzHs6
         U9JTkN52EaEsuQuHil5j492MtD8kaNDCY0PiMWbY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 068/542] iio: imu: st_lsm6dsx: check return value from st_lsm6dsx_sensor_set_enable
Date:   Fri, 14 Feb 2020 10:41:00 -0500
Message-Id: <20200214154854.6746-68-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit a2dd9bd9334efb8dc0bdc0109abff3a7b57effb1 ]

Add missing return value check in st_lsm6dsx_read_oneshot disabling the
sensor. The issue is reported by coverity with the following error:

Unchecked return value:
If the function returns an error value, the error value may be mistaken
for a normal value.

Addresses-Coverity-ID: 1446733 ("Unchecked return value")
Fixes: b5969abfa8b8 ("iio: imu: st_lsm6dsx: add motion events")
Fixes: 290a6ce11d93 ("iio: imu: add support to lsm6dsx driver")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index b921dd9e108fa..e45123d8d2812 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1506,8 +1506,11 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
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
2.20.1

