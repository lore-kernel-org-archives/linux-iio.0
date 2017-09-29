Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:54357 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbdI2NYL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Sep 2017 09:24:11 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: dummy: events: Add missing break
Date: Fri, 29 Sep 2017 15:24:05 +0200
Message-Id: <20170929132405.28104-1-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add missing break in iio_simple_dummy_write_event_config() for the voltage
threshold event enable attribute. Without this writing to the
in_voltage0_thresh_rising_en always returns -EINVAL even though the change
was correctly applied.

Fixes: 3e34e650db197 ("iio: dummy: Demonstrate the usage of new channel types")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dummy/iio_simple_dummy_events.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dummy/iio_simple_dummy_events.c b/drivers/iio/dummy/iio_simple_dummy_events.c
index ed63ffd849f8..7ec2a0bb0807 100644
--- a/drivers/iio/dummy/iio_simple_dummy_events.c
+++ b/drivers/iio/dummy/iio_simple_dummy_events.c
@@ -72,6 +72,7 @@ int iio_simple_dummy_write_event_config(struct iio_dev *indio_dev,
 				st->event_en = state;
 			else
 				return -EINVAL;
+			break;
 		default:
 			return -EINVAL;
 		}
-- 
2.11.0

