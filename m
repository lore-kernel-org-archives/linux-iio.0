Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34647 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256AbcHPNDD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Aug 2016 09:03:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id q128so16318284wma.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Aug 2016 06:03:02 -0700 (PDT)
Date: Tue, 16 Aug 2016 15:02:58 +0200
From: Johanna Abrahamsson <johanna@mjao.org>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH] staging: iio: ade7854: checkpatch fixes
Message-ID: <20160816130254.GA9657@fedora-21-dvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

CHECK: Alignment should match open parenthesis

Signed-off-by: Johanna Abrahamsson <johanna@mjao.org>
---
 drivers/staging/iio/meter/ade7854.c | 40 ++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index 75e8685..24edbc3 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -23,8 +23,8 @@
 #include "ade7854.h"
 
 static ssize_t ade7854_read_8bit(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				 struct device_attribute *attr,
+				 char *buf)
 {
 	int ret;
 	u8 val = 0;
@@ -40,8 +40,8 @@ static ssize_t ade7854_read_8bit(struct device *dev,
 }
 
 static ssize_t ade7854_read_16bit(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				  struct device_attribute *attr,
+				  char *buf)
 {
 	int ret;
 	u16 val = 0;
@@ -57,8 +57,8 @@ static ssize_t ade7854_read_16bit(struct device *dev,
 }
 
 static ssize_t ade7854_read_24bit(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				  struct device_attribute *attr,
+				  char *buf)
 {
 	int ret;
 	u32 val;
@@ -74,8 +74,8 @@ static ssize_t ade7854_read_24bit(struct device *dev,
 }
 
 static ssize_t ade7854_read_32bit(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				  struct device_attribute *attr,
+				  char *buf)
 {
 	int ret;
 	u32 val = 0;
@@ -91,9 +91,9 @@ static ssize_t ade7854_read_32bit(struct device *dev,
 }
 
 static ssize_t ade7854_write_8bit(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+				  struct device_attribute *attr,
+				  const char *buf,
+				  size_t len)
 {
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -112,9 +112,9 @@ error_ret:
 }
 
 static ssize_t ade7854_write_16bit(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+				   struct device_attribute *attr,
+				   const char *buf,
+				   size_t len)
 {
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -133,9 +133,9 @@ error_ret:
 }
 
 static ssize_t ade7854_write_24bit(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+				   struct device_attribute *attr,
+				   const char *buf,
+				   size_t len)
 {
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -154,9 +154,9 @@ error_ret:
 }
 
 static ssize_t ade7854_write_32bit(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+				   struct device_attribute *attr,
+				   const char *buf,
+				   size_t len)
 {
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-- 
2.1.4

