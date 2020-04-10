Return-Path: <SRS0=Too6=52=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784C7C2D0EC
	for <linux-iio@archiver.kernel.org>; Fri, 10 Apr 2020 03:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4761420B1F
	for <linux-iio@archiver.kernel.org>; Fri, 10 Apr 2020 03:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586490417;
	bh=qnKjeRFljIsmqkFccDcOzXGYVkd2gtcV3xBaAQ+3WqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W1wwmv6BLkdZA0xGKKZog2iZYz7kO3yKmQgdvoFzhnwO5fPqrS872Q9qyNgemEENy
	 7ogBJ3s8ZPpR2Kyg0LWHmgnUFNizql9XWQAeCIcQ/5Pmxx+9jKi853ytNHNm1nqupy
	 9two9cZ/dWr26Z+GMsGY9ty9Cesb8HghrBODUPhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgDJDqz (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:46:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbgDJDqy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 9 Apr 2020 23:46:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4382A21473;
        Fri, 10 Apr 2020 03:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490414;
        bh=qnKjeRFljIsmqkFccDcOzXGYVkd2gtcV3xBaAQ+3WqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nzJWqgz59/0IzM6zAaL8Zy82k2FSOyprfxfZqocnjLyMh3Bd2pMUhHFtWRxpUZjak
         vdvS46IdEi45OuGvZPZ8UutL1YPjEV/RK8dNjPJo0VFYbJsFmS3FiG0PzS5SAgtKWV
         E2Kv3tmpZvuhavfzJ53bTtuFl6iSPgFtb6MvtB5M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 16/68] iio: imu: st_lsm6dsx: check return value from st_lsm6dsx_sensor_set_enable
Date:   Thu,  9 Apr 2020 23:45:41 -0400
Message-Id: <20200410034634.7731-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410034634.7731-1-sashal@kernel.org>
References: <20200410034634.7731-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit f20dbe11e2e904547597ae7371c1f635e3be9cad ]

Add missing return value check in st_lsm6dsx_shub_read_oneshot disabling
the slave device connected to the st_lsm6dsx i2c controller.
The issue is reported by coverity with the following error:

Unchecked return value:
If the function returns an error value, the error value may be mistaken
for a normal value.

Addresses-Coverity-ID: 1456767 ("Unchecked return value")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index eea555617d4aa..95ddd19d1aa7c 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -464,9 +464,10 @@ st_lsm6dsx_shub_read_oneshot(struct st_lsm6dsx_sensor *sensor,
 
 	len = min_t(int, sizeof(data), ch->scan_type.realbits >> 3);
 	err = st_lsm6dsx_shub_read(sensor, ch->address, data, len);
+	if (err < 0)
+		return err;
 
-	st_lsm6dsx_shub_set_enable(sensor, false);
-
+	err = st_lsm6dsx_shub_set_enable(sensor, false);
 	if (err < 0)
 		return err;
 
-- 
2.20.1

