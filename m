Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55728 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755371AbdGWQ0o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Jul 2017 12:26:44 -0400
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 22/45] iio:potentiostat:lmp91000 drop assign iio_info.driver_module and iio_trigger_ops.owner
Date: Sun, 23 Jul 2017 17:26:04 +0100
Message-Id: <20170723162627.22534-23-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Jonathan Cameron <jic23@kernel.org>

The equivalent of both of these are now done via macro magic when
the relevant register calls are made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/potentiostat/lmp91000.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index afa8de3418d0..007710991f15 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -207,7 +207,6 @@ static int lmp91000_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info lmp91000_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = lmp91000_read_raw,
 };
 
@@ -283,7 +282,6 @@ static int lmp91000_buffer_cb(const void *val, void *private)
 }
 
 static const struct iio_trigger_ops lmp91000_trigger_ops = {
-	.owner = THIS_MODULE,
 };
 
 
-- 
2.13.3

