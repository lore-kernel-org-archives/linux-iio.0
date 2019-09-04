Return-Path: <SRS0=9d48=W7=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1B4C3A5A7
	for <linux-iio@archiver.kernel.org>; Wed,  4 Sep 2019 09:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED73F23401
	for <linux-iio@archiver.kernel.org>; Wed,  4 Sep 2019 09:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="WUaIQVwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbfIDJRt (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 4 Sep 2019 05:17:49 -0400
Received: from first.geanix.com ([116.203.34.67]:60386 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728843AbfIDJRt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 4 Sep 2019 05:17:49 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 1A68462F94;
        Wed,  4 Sep 2019 09:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1567588662; bh=8243RAFDDk2YM0iU+gFhnBcgOGM4IOdaWDUj1viLnEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WUaIQVwq+xzZTwvgm5WLCSMxSdPmMcXShmO2oJ+DgjFjmFQN5D/eI2vXdQU8wvRgU
         pVFZwK2ZaYpsNle8gMff8Bg0RzUHfs8U0dVanGBS1wjr+L+KguqEArV8rH3l/7L5RO
         s6cZEWgHQEJyOyclqYEhVudUHPgY8HIqUeENXH4r6nlZNmsNlklauAk4UQOPwwfZvF
         xUDsVaZhu56EptCxvHBqXU5qgUz0h8LBDcsqWadJbTJdr02QACQaajM8DvbGI3QDam
         MUUf+YIkMlomycFlYrFAPFeWJ5/SWJUq1I0TYw3lABoFHuC/Ab3+3SlR4Nv73h/S84
         +NHrgr/5HOY2g==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v3 6/6] iio: imu: st_lsm6dsx: prohibit the use of events and buffered reads simultaneously
Date:   Wed,  4 Sep 2019 11:17:32 +0200
Message-Id: <20190904091732.112281-6-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904091732.112281-1-sean@geanix.com>
References: <20190904091732.112281-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When events and buffered reads is enabled simultaneously, and the first
event accours the interrupt pin stays high.

This can be reverted when we find a solution to allow events and
buffered reads simultaneously.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 3 +++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index ef579650fd52..94e8884a1db1 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -601,6 +601,9 @@ int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable)
 	struct st_lsm6dsx_hw *hw = sensor->hw;
 	int err;
 
+	if (hw->enable_event)
+		return -EBUSY;
+
 	mutex_lock(&hw->conf_lock);
 
 	if (hw->fifo_mode != ST_LSM6DSX_FIFO_BYPASS) {
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 2114c3c78888..7d0850df0a5e 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1277,6 +1277,9 @@ static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
 	if (type != IIO_EV_TYPE_THRESH)
 		return -EINVAL;
 
+	if (hw->fifo_mode != ST_LSM6DSX_FIFO_BYPASS)
+		return -EBUSY;
+
 	if (state && hw->enable_event)
 		return 0;
 
-- 
2.23.0

