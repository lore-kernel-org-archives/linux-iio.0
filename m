Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55636 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755407AbdGWQ0q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Jul 2017 12:26:46 -0400
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 36/45] staging:iio:light:tsl2x7x drop assignment of driver_module
Date: Sun, 23 Jul 2017 17:26:18 +0100
Message-Id: <20170723162627.22534-37-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Jonathan Cameron <jic23@kernel.org>

The equivalent is now done via macro magic in the register call.

Note this is the only case not found by the coccinelle script
suggesting that perhaps that script needs to be a little more
clever!

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/light/tsl2x7x.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 786e93f16ce9..02e4a21c3e97 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -1654,7 +1654,6 @@ static const struct iio_info tsl2X7X_device_info[] = {
 	[ALS] = {
 		.attrs = &tsl2X7X_device_attr_group_tbl[ALS],
 		.event_attrs = &tsl2X7X_event_attr_group_tbl[ALS],
-		.driver_module = THIS_MODULE,
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
 		.read_event_value = &tsl2x7x_read_event_value,
@@ -1665,7 +1664,6 @@ static const struct iio_info tsl2X7X_device_info[] = {
 	[PRX] = {
 		.attrs = &tsl2X7X_device_attr_group_tbl[PRX],
 		.event_attrs = &tsl2X7X_event_attr_group_tbl[PRX],
-		.driver_module = THIS_MODULE,
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
 		.read_event_value = &tsl2x7x_read_event_value,
@@ -1676,7 +1674,6 @@ static const struct iio_info tsl2X7X_device_info[] = {
 	[ALSPRX] = {
 		.attrs = &tsl2X7X_device_attr_group_tbl[ALSPRX],
 		.event_attrs = &tsl2X7X_event_attr_group_tbl[ALSPRX],
-		.driver_module = THIS_MODULE,
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
 		.read_event_value = &tsl2x7x_read_event_value,
@@ -1687,7 +1684,6 @@ static const struct iio_info tsl2X7X_device_info[] = {
 	[PRX2] = {
 		.attrs = &tsl2X7X_device_attr_group_tbl[PRX2],
 		.event_attrs = &tsl2X7X_event_attr_group_tbl[PRX],
-		.driver_module = THIS_MODULE,
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
 		.read_event_value = &tsl2x7x_read_event_value,
@@ -1698,7 +1694,6 @@ static const struct iio_info tsl2X7X_device_info[] = {
 	[ALSPRX2] = {
 		.attrs = &tsl2X7X_device_attr_group_tbl[ALSPRX2],
 		.event_attrs = &tsl2X7X_event_attr_group_tbl[ALSPRX],
-		.driver_module = THIS_MODULE,
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
 		.read_event_value = &tsl2x7x_read_event_value,
-- 
2.13.3

