Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36885 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbdE2PwM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 May 2017 11:52:12 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 06/38] iio:amplifiers:ad8366 drop assign iio_info.driver_module and iio_trigger_ops.owner
Date: Mon, 29 May 2017 16:51:22 +0100
Message-Id: <20170529155154.22580-7-jic23@kernel.org>
In-Reply-To: <20170529155154.22580-1-jic23@kernel.org>
References: <20170529155154.22580-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The equivalent of both of these are now done via macro magic when
the relevant register calls are made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/amplifiers/ad8366.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 102c7174da5b..43667866321e 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -117,7 +117,6 @@ static int ad8366_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad8366_info = {
 	.read_raw = &ad8366_read_raw,
 	.write_raw = &ad8366_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 #define AD8366_CHAN(_channel) {				\
-- 
2.13.0

