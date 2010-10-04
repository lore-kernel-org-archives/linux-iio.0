Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:51788 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581Ab0JDPwi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Oct 2010 11:52:38 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: manuel.stahl@iis.fraunhofer.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 01/16] staging:iio: timestamp_en naming typo fix.
Date: Mon,  4 Oct 2010 16:57:50 +0100
Message-Id: <1286207885-26689-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
References: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/ring_generic.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index abd52ea..6975722 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -276,7 +276,7 @@ ssize_t iio_scan_el_ts_show(struct device *dev, struct device_attribute *attr,
  **/
 #define IIO_SCAN_EL_TIMESTAMP(number)				\
 	struct iio_scan_el iio_scan_el_timestamp = {		\
-		.dev_attr = __ATTR(_timestamp_en,		\
+		.dev_attr = __ATTR(timestamp_en,		\
 				   S_IRUGO | S_IWUSR,		\
 				   iio_scan_el_ts_show,		\
 				   iio_scan_el_ts_store),	\
-- 
1.7.2.2

