Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:22873 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbaDZLjt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 26 Apr 2014 07:39:49 -0400
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	dianders@chromium.org, gregkh@linuxfoundation.org,
	naveenkrishna.ch@gmail.com, lars@metafoo.de, cpgs@samsung.com,
	grundler@chromium.org, jic23@kernel.org
Subject: [PATCH 5/5 v2] iio: exynos_adc: do a reinit_completion before the
 conversion
Date: Sat, 26 Apr 2014 17:07:56 +0530
Message-id: <1398512276-4105-6-git-send-email-ch.naveen@samsung.com>
In-reply-to: <1398512276-4105-1-git-send-email-ch.naveen@samsung.com>
References: <1398512276-4105-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add reinit_completion() before the wait_for_completion_timeout in
raw_read() call.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Reviewed-by: Doug Anderson <dianders@chromium.org>
---
 drivers/iio/adc/exynos_adc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 805c9f6..32290e6 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -151,6 +151,7 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
 		return -EINVAL;
 
 	mutex_lock(&indio_dev->mlock);
+	reinit_completion(&info->completion);
 
 	/* Select the channel to be used and Trigger conversion */
 	if (info->version == ADC_V2) {
-- 
1.7.9.5

