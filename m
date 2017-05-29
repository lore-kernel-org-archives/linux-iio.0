Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 35/38] staging:iio:light:tsl2x7x drop assignment of driver_module
Date: Mon, 29 May 2017 16:51:51 +0100
Message-Id: <20170529155154.22580-36-jic23@kernel.org>
In-Reply-To: <20170529155154.22580-1-jic23@kernel.org>
References: <20170529155154.22580-1-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

The equivalent is now done via macro magic in the register call.

Note this is the only case not found by the coccinelle script
suggesting that perhaps that script needs to be a little more
clever!

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 146719928fb3..3b4bf710da2a 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -1681,7 +1681,6 @@ static const struct iio_info tsl2X7X_device_info[] = {
 	[ALS] = {
 		.attrs = &tsl2X7X_device_attr_group_tbl[ALS],
 		.event_attrs = &tsl2X7X_event_attr_group_tbl[ALS],
-		.driver_module = THIS_MODULE,
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
 		.read_event_value = &tsl2x7x_read_thresh,
@@ -1692,7 +1691,6 @@ static const struct iio_info tsl2X7X_device_info[] = {
 	[PRX] = {
 		.attrs = &tsl2X7X_device_attr_group_tbl[PRX],
 		.event_attrs = &tsl2X7X_event_attr_group_tbl[PRX],
-		.driver_module = THIS_MODULE,
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
 		.read_event_value = &tsl2x7x_read_thresh,
@@ -1703,7 +1701,6 @@ static const struct iio_info tsl2X7X_device_info[] = {
 	[ALSPRX] = {
 		.attrs = &tsl2X7X_device_attr_group_tbl[ALSPRX],
 		.event_attrs = &tsl2X7X_event_attr_group_tbl[ALSPRX],
-		.driver_module = THIS_MODULE,
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
 		.read_event_value = &tsl2x7x_read_thresh,
@@ -1714,7 +1711,6 @@ static const struct iio_info tsl2X7X_device_info[] = {
 	[PRX2] = {
 		.attrs = &tsl2X7X_device_attr_group_tbl[PRX2],
 		.event_attrs = &tsl2X7X_event_attr_group_tbl[PRX],
-		.driver_module = THIS_MODULE,
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
 		.read_event_value = &tsl2x7x_read_thresh,
@@ -1725,7 +1721,6 @@ static const struct iio_info tsl2X7X_device_info[] = {
 	[ALSPRX2] = {
 		.attrs = &tsl2X7X_device_attr_group_tbl[ALSPRX2],
 		.event_attrs = &tsl2X7X_event_attr_group_tbl[ALSPRX],
-		.driver_module = THIS_MODULE,
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
 		.read_event_value = &tsl2x7x_read_thresh,
-- 
2.13.0
