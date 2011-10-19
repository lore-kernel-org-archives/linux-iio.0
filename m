Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:59607
	"EHLO VA3EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751761Ab1JSMXr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 19 Oct 2011 08:23:47 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/4] staging:iio:dac:ad5791: Fix scale unit
Date: Wed, 19 Oct 2011 14:23:50 +0200
Message-ID: <1319027030-9696-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1319027030-9696-1-git-send-email-lars@metafoo.de>
References: <1319027030-9696-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Scale is currently reported in volts instead of millivolts. This patch fixes it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/dac/ad5791.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
index 9ba45f1..6fbca8d 100644
--- a/drivers/staging/iio/dac/ad5791.c
+++ b/drivers/staging/iio/dac/ad5791.c
@@ -239,7 +239,7 @@ static int ad5791_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
 		*val = 0;
-		*val2 = (st->vref_mv * 1000) >> chan->scan_type.realbits;
+		*val2 = (((u64)st->vref_mv) * 1000000ULL) >> chan->scan_type.realbits;
 		return IIO_VAL_INT_PLUS_MICRO;
 	case (1 << IIO_CHAN_INFO_OFFSET_SHARED):
 		val64 = (((u64)st->vref_neg_mv) << chan->scan_type.realbits);
-- 
1.7.6.3


