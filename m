Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12811C433ED
	for <linux-iio@archiver.kernel.org>; Fri,  7 May 2021 10:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E23BD613F0
	for <linux-iio@archiver.kernel.org>; Fri,  7 May 2021 10:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbhEGKdc (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 7 May 2021 06:33:32 -0400
Received: from first.geanix.com ([116.203.34.67]:38914 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229829AbhEGKdb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 7 May 2021 06:33:31 -0400
Received: from zen.. (109.57.11.253.mobile.3.dk [109.57.11.253])
        by first.geanix.com (Postfix) with ESMTPSA id 3F53B4680DE;
        Fri,  7 May 2021 10:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1620383549; bh=EBEQBVVRYIv6ts4IVXXwZBwGfnpoLdBwayvg0Z203gI=;
        h=From:To:Cc:Subject:Date;
        b=DpHeZuB4CA6sgz+JUrTGhWKs7W8uYl9iKV9iH65PH7Hw50J9fgkKPMJntsrUv+wa6
         AOQQfPY/8q2B/u00LDsqXHcY9oZE7SlR/t/PbR6mOucq4c5i6oZ8f/X7nyyPvWUa+L
         NrkgQRxxMj7i0I4gxljTOMpKzyhliKzQpc59ekhTCP0FxJR8W6hHKj3J3453GdD7IF
         UfxacsZUwmvTxUy91YDYBRoTurERkYAyAUHwfZJ5/cqy2rEGQLirQPpZ63WrhuFmW3
         5VuNKUAK2VkV77dLGXevx0cCklluGsig6CFWXOb+bJ783Vx51ec5sfsGZhN4Y5fCBN
         mw6Bt0jX4NcOg==
From:   Sean Nyekjaer <sean@geanix.com>
To:     lorenzo.bianconi83@gmail.com, jic23@kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org
Subject: [PATCH] iio: imu: st_lsm6dsx: do not roundup set samplerate
Date:   Fri,  7 May 2021 12:32:20 +0200
Message-Id: <20210507103220.2194009-1-sean@geanix.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The correct way to set the sampling rate to 12.5 Hz before
commit f8710f0357bc ("iio: imu: st_lsm6dsx: express odr in mHZ")
was to write 13 Hz to sampling_frequency.
Before this patch writing 13 to samplerate results in sample rate set
to 26 Hz.
Now we return EINVAL if the sampling rate is not in table.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index a3ab16615729..a14a1df8537b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1427,7 +1427,7 @@ int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u32 odr, u8 *val)
 		 * ext devices can run at different odr respect to
 		 * accel sensor
 		 */
-		if (odr_table->odr_avl[i].milli_hz >= odr)
+		if (odr_table->odr_avl[i].milli_hz == odr)
 			break;
 	}
 
-- 
2.31.0

