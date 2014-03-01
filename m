Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58652 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285AbaCAWH2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 1 Mar 2014 17:07:28 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Neil Brown <neilb@suse.de>,
	Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] iio:gyro:itg3200 - drop unreachable return ret. Highlighted by smatch
Date: Sat,  1 Mar 2014 22:08:03 +0000
Message-Id: <1393711683-2287-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

CHECK   drivers/iio/gyro/itg3200_core.c
drivers/iio/gyro/itg3200_core.c:114 itg3200_read_raw() info: ignoring unreachable code.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Cc: Neil Brown <neilb@suse.de>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/gyro/itg3200_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_core.c
index 4d3f3b9..8295e31 100644
--- a/drivers/iio/gyro/itg3200_core.c
+++ b/drivers/iio/gyro/itg3200_core.c
@@ -110,8 +110,6 @@ static int itg3200_read_raw(struct iio_dev *indio_dev,
 	default:
 		return -EINVAL;
 	}
-
-	return ret;
 }
 
 static ssize_t itg3200_read_frequency(struct device *dev,
-- 
1.9.0

