Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:64380 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625AbaGCGly (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 3 Jul 2014 02:41:54 -0400
Received: by mail-pd0-f178.google.com with SMTP id r10so13287110pdi.37
        for <linux-iio@vger.kernel.org>; Wed, 02 Jul 2014 23:41:54 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@samsung.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, spk.linux@gmail.com,
	Lars-Peter Clauen <lars@metafoo.de>,
	Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 5/5] iio: xilinx-xadc: Remove unused variable
Date: Thu,  3 Jul 2014 12:08:05 +0530
Message-Id: <1404369485-1903-5-git-send-email-sachin.kamat@samsung.com>
In-Reply-To: <1404369485-1903-1-git-send-email-sachin.kamat@samsung.com>
References: <1404369485-1903-1-git-send-email-sachin.kamat@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

'offset’ is not used in the function. Remove it.

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
Cc: Lars-Peter Clauen <lars@metafoo.de>
Cc: Michal Simek <michal.simek@xilinx.com>
---
 drivers/iio/adc/xilinx-xadc-events.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-events.c b/drivers/iio/adc/xilinx-xadc-events.c
index 3e7f0d7..edcf3aa 100644
--- a/drivers/iio/adc/xilinx-xadc-events.c
+++ b/drivers/iio/adc/xilinx-xadc-events.c
@@ -31,17 +31,11 @@ static const struct iio_chan_spec *xadc_event_to_channel(
 static void xadc_handle_event(struct iio_dev *indio_dev, unsigned int event)
 {
 	const struct iio_chan_spec *chan;
-	unsigned int offset;
 
 	/* Temperature threshold error, we don't handle this yet */
 	if (event == 0)
 		return;
 
-	if (event < 4)
-		offset = event;
-	else
-		offset = event + 4;
-
 	chan = xadc_event_to_channel(indio_dev, event);
 
 	if (chan->type == IIO_TEMP) {
-- 
1.7.9.5

