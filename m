Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 22/23] staging:iio:resolver: Use dev_to_iio_dev()
Date: Sat, 12 May 2012 15:39:53 +0200
Message-Id: <1336829994-7857-22-git-send-email-lars@metafoo.de>
In-Reply-To: <1336829994-7857-1-git-send-email-lars@metafoo.de>
References: <1336829994-7857-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Replace open-coded instances of getting a iio_dev struct from a device struct
with dev_to_iio_dev().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/resolver/ad2s1210.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index a236ddb..f313859 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -200,7 +200,7 @@ static ssize_t ad2s1210_store_softreset(struct device *dev,
 					const char *buf,
 					size_t len)
 {
-	struct ad2s1210_state *st = iio_priv(dev_get_drvdata(dev));
+	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
 	int ret;
 
 	mutex_lock(&st->lock);
@@ -214,7 +214,7 @@ static ssize_t ad2s1210_show_fclkin(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
 {
-	struct ad2s1210_state *st = iio_priv(dev_get_drvdata(dev));
+	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
 	return sprintf(buf, "%d\n", st->fclkin);
 }
 
@@ -223,7 +223,7 @@ static ssize_t ad2s1210_store_fclkin(struct device *dev,
 				     const char *buf,
 				     size_t len)
 {
-	struct ad2s1210_state *st = iio_priv(dev_get_drvdata(dev));
+	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
 	unsigned long fclkin;
 	int ret;
 
@@ -252,7 +252,7 @@ static ssize_t ad2s1210_show_fexcit(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
 {
-	struct ad2s1210_state *st = iio_priv(dev_get_drvdata(dev));
+	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
 	return sprintf(buf, "%d\n", st->fexcit);
 }
 
@@ -260,7 +260,7 @@ static ssize_t ad2s1210_store_fexcit(struct device *dev,
 				     struct device_attribute *attr,
 				     const char *buf, size_t len)
 {
-	struct ad2s1210_state *st = iio_priv(dev_get_drvdata(dev));
+	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
 	unsigned long fexcit;
 	int ret;
 
@@ -287,7 +287,7 @@ static ssize_t ad2s1210_show_control(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
 {
-	struct ad2s1210_state *st = iio_priv(dev_get_drvdata(dev));
+	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
 	int ret;
 	mutex_lock(&st->lock);
 	ret = ad2s1210_config_read(st, AD2S1210_REG_CONTROL);
@@ -299,7 +299,7 @@ static ssize_t ad2s1210_store_control(struct device *dev,
 			struct device_attribute *attr,
 			const char *buf, size_t len)
 {
-	struct ad2s1210_state *st = iio_priv(dev_get_drvdata(dev));
+	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
 	unsigned long udata;
 	unsigned char data;
 	int ret;
@@ -345,7 +345,7 @@ error_ret:
 static ssize_t ad2s1210_show_resolution(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
-	struct ad2s1210_state *st = iio_priv(dev_get_drvdata(dev));
+	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
 	return sprintf(buf, "%d\n", st->resolution);
 }
 
@@ -353,7 +353,7 @@ static ssize_t ad2s1210_store_resolution(struct device *dev,
 			struct device_attribute *attr,
 			const char *buf, size_t len)
 {
-	struct ad2s1210_state *st = iio_priv(dev_get_drvdata(dev));
+	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
 	unsigned char data;
 	unsigned long udata;
 	int ret;
@@ -403,7 +403,7 @@ error_ret:
 static ssize_t ad2s1210_show_fault(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
-	struct ad2s1210_state *st = iio_priv(dev_get_drvdata(dev));
+	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
 	int ret;
 
 	mutex_lock(&st->lock);
@@ -418,7 +418,7 @@ static ssize_t ad2s1210_clear_fault(struct device *dev,
 				    const char *buf,
 				    size_t len)
 {
-	struct ad2s1210_state *st = iio_priv(dev_get_drvdata(dev));
+	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
 	int ret;
 
 	mutex_lock(&st->lock);
@@ -441,7 +441,7 @@ static ssize_t ad2s1210_show_reg(struct device *dev,
 				 struct device_attribute *attr,
 				 char *buf)
 {
-	struct ad2s1210_state *st = iio_priv(dev_get_drvdata(dev));
+	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
 	struct iio_dev_attr *iattr = to_iio_dev_attr(attr);
 	int ret;
 
@@ -455,7 +455,7 @@ static ssize_t ad2s1210_show_reg(struct device *dev,
 static ssize_t ad2s1210_store_reg(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
-	struct ad2s1210_state *st = iio_priv(dev_get_drvdata(dev));
+	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
 	unsigned long data;
 	int ret;
 	struct iio_dev_attr *iattr = to_iio_dev_attr(attr);
-- 
1.7.10
