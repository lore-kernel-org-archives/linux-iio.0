Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34482 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbcIOOvH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Sep 2016 10:51:07 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v3 1/2] iio: Implement counter channel type and info constants
Date: Thu, 15 Sep 2016 10:50:51 -0400
Message-Id: <322dbb6459919fbe93713669f9d25cf62f95a269.1473950198.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1473950198.git.vilhelm.gray@gmail.com>
References: <cover.1473950198.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Quadrature encoders, such as rotary encoders and linear encoders, are
devices which are capable of encoding the relative position and
direction of motion of a shaft. This patch introduces several IIO
constants for supporting quadrature encoder counter devices.

  IIO_COUNT: Current count (main data provided by the counter device)
  IIO_INDEX: Set high when index input is at active level
  IIO_CHAN_INFO_PRESET: Counter preset value

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/iio/industrialio-core.c | 3 +++
 include/linux/iio/iio.h         | 1 +
 include/uapi/linux/iio/types.h  | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 0528a0c..42d8c8b 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -81,6 +81,8 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_PH] = "ph",
 	[IIO_UVINDEX] = "uvindex",
 	[IIO_ELECTRICALCONDUCTIVITY] = "electricalconductivity",
+	[IIO_COUNT] = "count",
+	[IIO_INDEX] = "index",
 };
 
 static const char * const iio_modifier_names[] = {
@@ -151,6 +153,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_DEBOUNCE_TIME] = "debounce_time",
 	[IIO_CHAN_INFO_CALIBEMISSIVITY] = "calibemissivity",
 	[IIO_CHAN_INFO_OVERSAMPLING_RATIO] = "oversampling_ratio",
+	[IIO_CHAN_INFO_PRESET] = "preset",
 };
 
 /**
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index b4a0679..7dc86d1 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -46,6 +46,7 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_DEBOUNCE_TIME,
 	IIO_CHAN_INFO_CALIBEMISSIVITY,
 	IIO_CHAN_INFO_OVERSAMPLING_RATIO,
+	IIO_CHAN_INFO_PRESET,
 };
 
 enum iio_shared_by {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 22e5e58..e54d14a 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -40,6 +40,8 @@ enum iio_chan_type {
 	IIO_PH,
 	IIO_UVINDEX,
 	IIO_ELECTRICALCONDUCTIVITY,
+	IIO_COUNT,
+	IIO_INDEX,
 };
 
 enum iio_modifier {
-- 
2.7.3

