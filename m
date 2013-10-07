Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-020.synserver.de ([212.40.185.20]:1164 "EHLO
	smtp-out-017.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755293Ab3JGOJr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2013 10:09:47 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 09/20] staging:iio:lis2l02dq: Share threshold value between axis
Date: Mon,  7 Oct 2013 16:11:23 +0200
Message-Id: <1381155094-20166-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1381155094-20166-1-git-send-email-lars@metafoo.de>
References: <1381155094-20166-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The threshold event can be enabled/disabled separately, but the threshold value
is shared between all three axis.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/accel/lis3l02dq_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 78187f1..b2d1dfa 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -518,13 +518,13 @@ static const struct iio_event_spec lis3l02dq_event[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_RISING,
-		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
-			BIT(IIO_EV_INFO_ENABLE),
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE);
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE);
 	}, {
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_FALLING,
-		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
-			BIT(IIO_EV_INFO_ENABLE),
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE);
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE);
 	}
 };
 
-- 
1.8.0

