Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail01.prevas.se ([62.95.78.3]:17744 "EHLO mail01.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753560AbcAVNIB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 22 Jan 2016 08:08:01 -0500
From: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
To: <linux-iio@vger.kernel.org>
CC: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Subject: [RFC 1/2] iio: core: added support for a single output that supports both current and voltage
Date: Fri, 22 Jan 2016 13:54:55 +0100
Message-ID: <1453467296-26356-1-git-send-email-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
---
 drivers/iio/industrialio-core.c | 2 ++
 include/linux/iio/iio.h         | 1 +
 include/uapi/linux/iio/types.h  | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index fd01f34..5e1beea 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -77,6 +77,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_VELOCITY] = "velocity",
 	[IIO_CONCENTRATION] = "concentration",
 	[IIO_RESISTANCE] = "resistance",
+	[IIO_DUAL_VOLTCUR] = "voltcur",
 };
 
 static const char * const iio_modifier_names[] = {
@@ -146,6 +147,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_DEBOUNCE_TIME] = "debounce_time",
 	[IIO_CHAN_INFO_CALIBEMISSIVITY] = "calibemissivity",
 	[IIO_CHAN_INFO_OVERSAMPLING_RATIO] = "oversampling_ratio",
+	[IIO_CHAN_INFO_MODE] = "mode",
 };
 
 /**
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index b589411..ef4c7cd9 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -46,6 +46,7 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_DEBOUNCE_TIME,
 	IIO_CHAN_INFO_CALIBEMISSIVITY,
 	IIO_CHAN_INFO_OVERSAMPLING_RATIO,
+	IIO_CHAN_INFO_MODE,
 };
 
 enum iio_shared_by {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 7c63bd6..81e6a2a 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -37,6 +37,7 @@ enum iio_chan_type {
 	IIO_VELOCITY,
 	IIO_CONCENTRATION,
 	IIO_RESISTANCE,
+	IIO_DUAL_VOLTCUR,
 };
 
 enum iio_modifier {
-- 
2.7.0

