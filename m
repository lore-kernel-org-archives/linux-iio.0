Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:49492 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756509Ab0ITOH4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Sep 2010 10:07:56 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: manuel.stahl@iis.fraunhofer.de, linux-iio@vger.kernel.org
Cc: drivers@analog.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 21/22] staging:iio: remove deprecated form of scan_el attribute naming.
Date: Mon, 20 Sep 2010 15:13:06 +0100
Message-Id: <1284991987-12407-22-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk>
References: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This has been replaced by a separate _index attribute

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/ring_generic.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index 1daeb01..abd52ea 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -236,7 +236,7 @@ ssize_t iio_scan_el_ts_show(struct device *dev, struct device_attribute *attr,
  **/
 #define __IIO_SCAN_EL_C(_name, _number, _label, _controlfunc)	\
 	struct iio_scan_el iio_scan_el_##_name = {			\
-		.dev_attr = __ATTR(_number##_##_name##_en,		\
+		.dev_attr = __ATTR(_name##_en,				\
 				   S_IRUGO | S_IWUSR,			\
 				   iio_scan_el_show,			\
 				   iio_scan_el_store),			\
@@ -251,7 +251,7 @@ ssize_t iio_scan_el_ts_show(struct device *dev, struct device_attribute *attr,
 
 #define __IIO_SCAN_NAMED_EL_C(_name, _string, _number, _label, _cf)	\
 	struct iio_scan_el iio_scan_el_##_name = {			\
-		.dev_attr = __ATTR(_number##_##_string##_en,		\
+		.dev_attr = __ATTR(_string##_en,			\
 				   S_IRUGO | S_IWUSR,			\
 				   iio_scan_el_show,			\
 				   iio_scan_el_store),			\
@@ -276,7 +276,7 @@ ssize_t iio_scan_el_ts_show(struct device *dev, struct device_attribute *attr,
  **/
 #define IIO_SCAN_EL_TIMESTAMP(number)				\
 	struct iio_scan_el iio_scan_el_timestamp = {		\
-		.dev_attr = __ATTR(number##_timestamp_en,	\
+		.dev_attr = __ATTR(_timestamp_en,		\
 				   S_IRUGO | S_IWUSR,		\
 				   iio_scan_el_ts_show,		\
 				   iio_scan_el_ts_store),	\
-- 
1.7.2.2

