Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0786FC433B4
	for <linux-iio@archiver.kernel.org>; Wed, 28 Apr 2021 15:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B77E1613F1
	for <linux-iio@archiver.kernel.org>; Wed, 28 Apr 2021 15:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbhD1PJd (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 28 Apr 2021 11:09:33 -0400
Received: from aposti.net ([89.234.176.197]:53996 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238948AbhD1PJS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 28 Apr 2021 11:09:18 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] tools/iio: iio_event_monitor: Fix ioctl error check
Date:   Wed, 28 Apr 2021 16:08:15 +0100
Message-Id: <20210428150815.136150-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ioctrl() call will return errno=EINVAL if the device does not
support the events interface, and not ENODEV.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 tools/iio/iio_event_monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index bb03859db89d..cdd9a84f18fa 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -323,7 +323,7 @@ int main(int argc, char **argv)
 	ret = ioctl(fd, IIO_GET_EVENT_FD_IOCTL, &event_fd);
 	if (ret == -1 || event_fd == -1) {
 		ret = -errno;
-		if (ret == -ENODEV)
+		if (ret == -EINVAL)
 			fprintf(stderr,
 				"This device does not support events\n");
 		else
-- 
2.30.2

