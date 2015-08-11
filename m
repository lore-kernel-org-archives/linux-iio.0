Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:33236 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934022AbbHKKV4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 Aug 2015 06:21:56 -0400
Date: Tue, 11 Aug 2015 13:20:53 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [PATCH 2/2] Staging: iio: trigger: Use braces on both branches of if
 statement
Message-ID: <d9079236646cd08ab1f55a71ec67830dd8813e72.1439286814.git.cristina.opriceana@gmail.com>
References: <cover.1439286814.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1439286814.git.cristina.opriceana@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix style issue related to missing braces, detected by checkpatch.pl.

Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
---
 drivers/staging/iio/trigger/iio-trig-periodic-rtc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
index a2a42c2..2db8857 100644
--- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
+++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
@@ -74,8 +74,9 @@ static ssize_t iio_trig_periodic_write_freq(struct device *dev,
 		if (ret == 0 && trig_info->state && trig_info->frequency == 0)
 			ret = rtc_irq_set_state(trig_info->rtc,
 						&trig_info->task, 1);
-	} else
+	} else {
 		ret = rtc_irq_set_state(trig_info->rtc, &trig_info->task, 0);
+	}
 	if (ret)
 		goto error_ret;
 
-- 
1.9.1

