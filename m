Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:36133 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbcDOO74 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Apr 2016 10:59:56 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/5] staging:iio:adis16240: Set self_test_no_autoclear flag
Date: Fri, 15 Apr 2016 16:59:42 +0200
Message-Id: <1460732382-6840-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1460732382-6840-1-git-send-email-lars@metafoo.de>
References: <1460732382-6840-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ADIS16201 does not automatically clear the self test flag bit the self
test has been, so clear it manually. Otherwise we'll see a offset caused by
the self-test bias on the output values during normal operation.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/accel/adis16240_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index a425e18..d5b99e6 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -222,6 +222,7 @@ static const struct adis_data adis16240_data = {
 	.diag_stat_reg = ADIS16240_DIAG_STAT,
 
 	.self_test_mask = ADIS16240_MSC_CTRL_SELF_TEST_EN,
+	.self_test_no_autoclear = true,
 	.startup_delay = ADIS16240_STARTUP_DELAY,
 
 	.status_error_msgs = adis16240_status_error_msgs,
-- 
2.1.4

