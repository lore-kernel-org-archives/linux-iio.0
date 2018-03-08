Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cock.li ([185.100.85.212]:55976 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754837AbeCHMXB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 8 Mar 2018 07:23:01 -0500
From: Tom Lebreux <tomlebreux@cock.li>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Tom Lebreux <tomlebreux@cock.li>
Subject: [PATCH] staging:iio:ad7150: Align arguments to match open parenthesis
Date: Thu,  8 Mar 2018 07:22:44 -0500
Message-Id: <20180308122244.28537-1-tomlebreux@cock.li>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This fixes the following checkpatch.pl CHECK: Alignment should match
open parenthesis
---
 drivers/staging/iio/cdc/ad7150.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 2fe916c48848..947c088407a1 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -124,8 +124,9 @@ static int ad7150_read_raw(struct iio_dev *indio_dev,
 }

 static int ad7150_read_event_config(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, enum iio_event_type type,
-	enum iio_event_direction dir)
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir)
 {
 	int ret;
 	u8 threshtype;
--
2.16.2

