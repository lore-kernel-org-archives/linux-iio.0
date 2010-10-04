Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:51777 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773Ab0JDPwi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Oct 2010 11:52:38 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: manuel.stahl@iis.fraunhofer.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 02/16] staging:iio:events define macros for new event code system
Date: Mon,  4 Oct 2010 16:57:51 +0100
Message-Id: <1286207885-26689-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
References: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These are step one of moving to a systematic numbering for event
codes.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/sysfs.h |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index b531dc1..7707f8f 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -249,6 +249,38 @@ struct iio_const_attr {
 #define IIO_EVENT_ATTR_DATA_RDY(_show, _store, _mask, _handler) \
 	IIO_EVENT_ATTR(data_rdy, _show, _store, _mask, _handler)
 
+#define IIO_EV_CLASS_BUFFER		0
+#define IIO_EV_CLASS_IN			1
+#define IIO_EV_CLASS_ACCEL		2
+#define IIO_EV_CLASS_GYRO		3
+#define IIO_EV_CLASS_MAGN		4
+#define IIO_EV_CLASS_LIGHT		5
+#define IIO_EV_CLASS_PROXIMITY		6
+
+#define IIO_EV_MOD_X			0
+#define IIO_EV_MOD_Y			1
+#define IIO_EV_MOD_Z			2
+
+#define IIO_EV_TYPE_THRESH		0
+#define IIO_EV_TYPE_MAG			1
+#define IIO_EV_TYPE_ROC			2
+
+#define IIO_EV_DIR_EITHER		0
+#define IIO_EV_DIR_RISING		1
+#define IIO_EV_DIR_FALLING		2
+
+#define IIO_EVENT_CODE(channelclass, orient_bit, number,		\
+		       modifier, type, direction)			\
+	(channelclass | (orient_bit << 8) | ((number) << 9) |		\
+	 ((modifier) << 13) | ((type) << 16) | ((direction) << 24))
+
+#define IIO_MOD_EVENT_CODE(channelclass, number, modifier,		\
+			   type, direction)				\
+	IIO_EVENT_CODE(channelclass, 1, number, modifier, type, direction)
+
+#define IIO_UNMOD_EVENT_CODE(channelclass, number, type, direction)	\
+	IIO_EVENT_CODE(channelclass, 0, number, 0, type, direction)
+
 #define IIO_EVENT_CODE_DATA_RDY		100
 #define IIO_EVENT_CODE_RING_BASE	200
 #define IIO_EVENT_CODE_ACCEL_BASE	300
-- 
1.7.2.2

