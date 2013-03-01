Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-170.synserver.de ([212.40.185.170]:1063 "EHLO
	smtp-out-170.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708Ab3CANFw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Mar 2013 08:05:52 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] iio:ad5064: Fix off by one in DAC value range check
Date: Fri,  1 Mar 2013 14:07:18 +0100
Message-Id: <1362143239-891-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1362143239-891-1-git-send-email-lars@metafoo.de>
References: <1362143239-891-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The DAC value range check allows values one larger than the maximum value, which
effectively results in setting the DAC value to 0. This patch fixes the issue.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad5064.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index e19b73f..a491976 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -257,7 +257,7 @@ static int ad5064_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (val > (1 << chan->scan_type.realbits) || val < 0)
+		if (val >= (1 << chan->scan_type.realbits) || val < 0)
 			return -EINVAL;
 
 		mutex_lock(&indio_dev->mlock);
-- 
1.8.0

