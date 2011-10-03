Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:40239 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932197Ab1JCO7y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 3 Oct 2011 10:59:54 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 5/6] staging:iio:adc:naming: dev_info to indio_dev for consistency
Date: Mon,  3 Oct 2011 16:08:15 +0100
Message-Id: <1317654496-14484-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1317654496-14484-1-git-send-email-jic23@cam.ac.uk>
References: <1317654496-14484-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We had a random missmatch of these two.  Lets pick the most common
and get rid of the other.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7150.c      |    4 +-
 drivers/staging/iio/adc/ad7192.c      |    4 +-
 drivers/staging/iio/adc/ad7280a.c     |   60 ++++++++++++++++----------------
 drivers/staging/iio/adc/ad7291.c      |   12 +++---
 drivers/staging/iio/adc/ad7298_core.c |   12 +++---
 drivers/staging/iio/adc/ad7298_ring.c |    4 +-
 drivers/staging/iio/adc/ad7476_core.c |   12 +++---
 drivers/staging/iio/adc/ad7816.c      |   34 +++++++++---------
 drivers/staging/iio/adc/ad7887_core.c |   10 +++---
 drivers/staging/iio/adc/ad799x_core.c |   38 ++++++++++----------
 10 files changed, 95 insertions(+), 95 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7150.c b/drivers/staging/iio/adc/ad7150.c
index 8943420..1208c17 100644
--- a/drivers/staging/iio/adc/ad7150.c
+++ b/drivers/staging/iio/adc/ad7150.c
@@ -341,8 +341,8 @@ static ssize_t ad7150_show_timeout(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7150_chip_info *chip = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	u8 value;
 
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 67d731b..29258f4 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -842,8 +842,8 @@ static mode_t ad7192_attr_is_visible(struct kobject *kobj,
 				     struct attribute *attr, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7192_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7192_state *st = iio_priv(indio_dev);
 
 	mode_t mode = attr->mode;
 
diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 4c67cfe..164ba37 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -382,8 +382,8 @@ static ssize_t ad7280_show_balance_sw(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7280_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7280_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	return sprintf(buf, "%d\n",
@@ -396,8 +396,8 @@ static ssize_t ad7280_store_balance_sw(struct device *dev,
 					 const char *buf,
 					 size_t len)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7280_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7280_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	bool readin;
 	int ret;
@@ -410,7 +410,7 @@ static ssize_t ad7280_store_balance_sw(struct device *dev,
 	devaddr = this_attr->address >> 8;
 	ch = this_attr->address & 0xFF;
 
-	mutex_lock(&dev_info->mlock);
+	mutex_lock(&indio_dev->mlock);
 	if (readin)
 		st->cb_mask[devaddr] |= 1 << (ch + 2);
 	else
@@ -418,7 +418,7 @@ static ssize_t ad7280_store_balance_sw(struct device *dev,
 
 	ret = ad7280_write(st, devaddr, AD7280A_CELL_BALANCE,
 			   0, st->cb_mask[devaddr]);
-	mutex_unlock(&dev_info->mlock);
+	mutex_unlock(&indio_dev->mlock);
 
 	return ret ? ret : len;
 }
@@ -427,16 +427,16 @@ static ssize_t ad7280_show_balance_timer(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7280_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7280_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret;
 	unsigned msecs;
 
-	mutex_lock(&dev_info->mlock);
+	mutex_lock(&indio_dev->mlock);
 	ret = ad7280_read(st, this_attr->address >> 8,
 			this_attr->address & 0xFF);
-	mutex_unlock(&dev_info->mlock);
+	mutex_unlock(&indio_dev->mlock);
 
 	if (ret < 0)
 		return ret;
@@ -451,8 +451,8 @@ static ssize_t ad7280_store_balance_timer(struct device *dev,
 					 const char *buf,
 					 size_t len)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7280_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7280_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	long val;
 	int ret;
@@ -466,11 +466,11 @@ static ssize_t ad7280_store_balance_timer(struct device *dev,
 	if (val > 31)
 		return -EINVAL;
 
-	mutex_lock(&dev_info->mlock);
+	mutex_lock(&indio_dev->mlock);
 	ret = ad7280_write(st, this_attr->address >> 8,
 			   this_attr->address & 0xFF,
 			   0, (val & 0x1F) << 3);
-	mutex_unlock(&dev_info->mlock);
+	mutex_unlock(&indio_dev->mlock);
 
 	return ret ? ret : len;
 }
@@ -594,8 +594,8 @@ static ssize_t ad7280_read_channel_config(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7280_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7280_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	unsigned val;
 
@@ -624,8 +624,8 @@ static ssize_t ad7280_write_channel_config(struct device *dev,
 					 const char *buf,
 					 size_t len)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7280_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7280_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	long val;
@@ -650,7 +650,7 @@ static ssize_t ad7280_write_channel_config(struct device *dev,
 
 	val = clamp(val, 0L, 0xFFL);
 
-	mutex_lock(&dev_info->mlock);
+	mutex_lock(&indio_dev->mlock);
 	switch (this_attr->address) {
 	case AD7280A_CELL_OVERVOLTAGE:
 		st->cell_threshhigh = val;
@@ -669,15 +669,15 @@ static ssize_t ad7280_write_channel_config(struct device *dev,
 	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER,
 			   this_attr->address, 1, val);
 
-	mutex_unlock(&dev_info->mlock);
+	mutex_unlock(&indio_dev->mlock);
 
 	return ret ? ret : len;
 }
 
 static irqreturn_t ad7280_event_handler(int irq, void *private)
 {
-	struct iio_dev *dev_info = private;
-	struct ad7280_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = private;
+	struct ad7280_state *st = iio_priv(indio_dev);
 	unsigned *channels;
 	int i, ret;
 
@@ -693,7 +693,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 		if (((channels[i] >> 23) & 0xF) <= AD7280A_CELL_VOLTAGE_6) {
 			if (((channels[i] >> 11) & 0xFFF) >=
 				st->cell_threshhigh)
-				iio_push_event(dev_info,
+				iio_push_event(indio_dev,
 					IIO_EVENT_CODE(IIO_VOLTAGE,
 						       1,
 						       0,
@@ -703,7 +703,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 					iio_get_time_ns());
 			else if (((channels[i] >> 11) & 0xFFF) <=
 				st->cell_threshlow)
-				iio_push_event(dev_info,
+				iio_push_event(indio_dev,
 					IIO_EVENT_CODE(IIO_VOLTAGE,
 						       1,
 						       0,
@@ -713,7 +713,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 					iio_get_time_ns());
 		} else {
 			if (((channels[i] >> 11) & 0xFFF) >= st->aux_threshhigh)
-				iio_push_event(dev_info,
+				iio_push_event(indio_dev,
 					IIO_UNMOD_EVENT_CODE(IIO_TEMP,
 					0,
 					IIO_EV_TYPE_THRESH,
@@ -721,7 +721,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 					iio_get_time_ns());
 			else if (((channels[i] >> 11) & 0xFFF) <=
 				st->aux_threshlow)
-				iio_push_event(dev_info,
+				iio_push_event(indio_dev,
 					IIO_UNMOD_EVENT_CODE(IIO_TEMP,
 					0,
 					IIO_EV_TYPE_THRESH,
@@ -774,25 +774,25 @@ static struct attribute_group ad7280_event_attrs_group = {
 	.attrs = ad7280_event_attributes,
 };
 
-static int ad7280_read_raw(struct iio_dev *dev_info,
+static int ad7280_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val,
 			   int *val2,
 			   long m)
 {
-	struct ad7280_state *st = iio_priv(dev_info);
+	struct ad7280_state *st = iio_priv(indio_dev);
 	unsigned int scale_uv;
 	int ret;
 
 	switch (m) {
 	case 0:
-		mutex_lock(&dev_info->mlock);
+		mutex_lock(&indio_dev->mlock);
 		if (chan->address == AD7280A_ALL_CELLS)
 			ret = ad7280_read_all_channels(st, st->scan_cnt, NULL);
 		else
 			ret = ad7280_read_channel(st, chan->address >> 8,
 						  chan->address & 0xFF);
-		mutex_unlock(&dev_info->mlock);
+		mutex_unlock(&indio_dev->mlock);
 
 		if (ret < 0)
 			return ret;
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index ba3f19f..acdce8c 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -131,8 +131,8 @@ static ssize_t ad7291_store_reset(struct device *dev,
 		const char *buf,
 		size_t len)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7291_chip_info *chip = iio_priv(indio_dev);
 
 	return ad7291_i2c_write(chip, AD7291_COMMAND,
 				chip->command | AD7291_RESET);
@@ -213,8 +213,8 @@ static inline ssize_t ad7291_show_hyst(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7291_chip_info *chip = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	u16 data;
 	int ret;
@@ -231,8 +231,8 @@ static inline ssize_t ad7291_set_hyst(struct device *dev,
 				      const char *buf,
 				      size_t len)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7291_chip_info *chip = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7291_chip_info *chip = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	u16 data;
 	int ret;
diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index 9ef3102..b772727 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -109,24 +109,24 @@ static int ad7298_scan_temp(struct ad7298_state *st, int *val)
 	return 0;
 }
 
-static int ad7298_read_raw(struct iio_dev *dev_info,
+static int ad7298_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val,
 			   int *val2,
 			   long m)
 {
 	int ret;
-	struct ad7298_state *st = iio_priv(dev_info);
+	struct ad7298_state *st = iio_priv(indio_dev);
 	unsigned int scale_uv;
 
 	switch (m) {
 	case 0:
-		mutex_lock(&dev_info->mlock);
-		if (iio_buffer_enabled(dev_info)) {
+		mutex_lock(&indio_dev->mlock);
+		if (iio_buffer_enabled(indio_dev)) {
 			if (chan->address == AD7298_CH_TEMP)
 				ret = -ENODEV;
 			else
-				ret = ad7298_scan_from_ring(dev_info,
+				ret = ad7298_scan_from_ring(indio_dev,
 							    chan->address);
 		} else {
 			if (chan->address == AD7298_CH_TEMP)
@@ -134,7 +134,7 @@ static int ad7298_read_raw(struct iio_dev *dev_info,
 			else
 				ret = ad7298_scan_direct(st, chan->address);
 		}
-		mutex_unlock(&dev_info->mlock);
+		mutex_unlock(&indio_dev->mlock);
 
 		if (ret < 0)
 			return ret;
diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index d90b6f4..47630d5 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -18,9 +18,9 @@
 
 #include "ad7298.h"
 
-int ad7298_scan_from_ring(struct iio_dev *dev_info, long ch)
+int ad7298_scan_from_ring(struct iio_dev *indio_dev, long ch)
 {
-	struct iio_buffer *ring = dev_info->buffer;
+	struct iio_buffer *ring = indio_dev->buffer;
 	int ret;
 	u16 *ring_data;
 
diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index 9b050ce..1953dbf 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -32,24 +32,24 @@ static int ad7476_scan_direct(struct ad7476_state *st)
 	return (st->data[0] << 8) | st->data[1];
 }
 
-static int ad7476_read_raw(struct iio_dev *dev_info,
+static int ad7476_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val,
 			   int *val2,
 			   long m)
 {
 	int ret;
-	struct ad7476_state *st = iio_priv(dev_info);
+	struct ad7476_state *st = iio_priv(indio_dev);
 	unsigned int scale_uv;
 
 	switch (m) {
 	case 0:
-		mutex_lock(&dev_info->mlock);
-		if (iio_buffer_enabled(dev_info))
-			ret = ad7476_scan_from_ring(dev_info);
+		mutex_lock(&indio_dev->mlock);
+		if (iio_buffer_enabled(indio_dev))
+			ret = ad7476_scan_from_ring(indio_dev);
 		else
 			ret = ad7476_scan_direct(st);
-		mutex_unlock(&dev_info->mlock);
+		mutex_unlock(&indio_dev->mlock);
 
 		if (ret < 0)
 			return ret;
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index deec8f2..1440619 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -112,8 +112,8 @@ static ssize_t ad7816_show_mode(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7816_chip_info *chip = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
 	if (chip->mode)
 		return sprintf(buf, "power-save\n");
@@ -126,8 +126,8 @@ static ssize_t ad7816_store_mode(struct device *dev,
 		const char *buf,
 		size_t len)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7816_chip_info *chip = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
 	if (strcmp(buf, "full")) {
 		gpio_set_value(chip->rdwr_pin, 1);
@@ -158,8 +158,8 @@ static ssize_t ad7816_show_channel(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7816_chip_info *chip = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
 	return sprintf(buf, "%d\n", chip->channel_id);
 }
@@ -169,8 +169,8 @@ static ssize_t ad7816_store_channel(struct device *dev,
 		const char *buf,
 		size_t len)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7816_chip_info *chip = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 	unsigned long data;
 	int ret;
 
@@ -180,13 +180,13 @@ static ssize_t ad7816_store_channel(struct device *dev,
 
 	if (data > AD7816_CS_MAX && data != AD7816_CS_MASK) {
 		dev_err(&chip->spi_dev->dev, "Invalid channel id %lu for %s.\n",
-			data, dev_info->name);
+			data, indio_dev->name);
 		return -EINVAL;
-	} else if (strcmp(dev_info->name, "ad7818") == 0 && data > 1) {
+	} else if (strcmp(indio_dev->name, "ad7818") == 0 && data > 1) {
 		dev_err(&chip->spi_dev->dev,
 			"Invalid channel id %lu for ad7818.\n", data);
 		return -EINVAL;
-	} else if (strcmp(dev_info->name, "ad7816") == 0 && data > 0) {
+	} else if (strcmp(indio_dev->name, "ad7816") == 0 && data > 0) {
 		dev_err(&chip->spi_dev->dev,
 			"Invalid channel id %lu for ad7816.\n", data);
 		return -EINVAL;
@@ -207,8 +207,8 @@ static ssize_t ad7816_show_value(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7816_chip_info *chip = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 	u16 data;
 	s8 value;
 	int ret;
@@ -262,8 +262,8 @@ static ssize_t ad7816_show_oti(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7816_chip_info *chip = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 	int value;
 
 	if (chip->channel_id > AD7816_CS_MAX) {
@@ -283,8 +283,8 @@ static inline ssize_t ad7816_set_oti(struct device *dev,
 		const char *buf,
 		size_t len)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad7816_chip_info *chip = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 	long value;
 	u8 data;
 	int ret;
diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index 37e6cc9..9456c03 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -31,24 +31,24 @@ static int ad7887_scan_direct(struct ad7887_state *st, unsigned ch)
 	return (st->data[(ch * 2)] << 8) | st->data[(ch * 2) + 1];
 }
 
-static int ad7887_read_raw(struct iio_dev *dev_info,
+static int ad7887_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val,
 			   int *val2,
 			   long m)
 {
 	int ret;
-	struct ad7887_state *st = iio_priv(dev_info);
+	struct ad7887_state *st = iio_priv(indio_dev);
 	unsigned int scale_uv;
 
 	switch (m) {
 	case 0:
-		mutex_lock(&dev_info->mlock);
-		if (iio_buffer_enabled(dev_info))
+		mutex_lock(&indio_dev->mlock);
+		if (iio_buffer_enabled(indio_dev))
 			ret = ad7887_scan_from_ring(st, 1 << chan->address);
 		else
 			ret = ad7887_scan_direct(st, chan->address);
-		mutex_unlock(&dev_info->mlock);
+		mutex_unlock(&indio_dev->mlock);
 
 		if (ret < 0)
 			return ret;
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 7c42c12..2d60539 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -136,25 +136,25 @@ static int ad799x_scan_direct(struct ad799x_state *st, unsigned ch)
 	return rxbuf;
 }
 
-static int ad799x_read_raw(struct iio_dev *dev_info,
+static int ad799x_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val,
 			   int *val2,
 			   long m)
 {
 	int ret;
-	struct ad799x_state *st = iio_priv(dev_info);
+	struct ad799x_state *st = iio_priv(indio_dev);
 	unsigned int scale_uv;
 
 	switch (m) {
 	case 0:
-		mutex_lock(&dev_info->mlock);
-		if (iio_buffer_enabled(dev_info))
-			ret = ad799x_single_channel_from_ring(dev_info,
+		mutex_lock(&indio_dev->mlock);
+		if (iio_buffer_enabled(indio_dev))
+			ret = ad799x_single_channel_from_ring(indio_dev,
 							      chan->scan_index);
 		else
 			ret = ad799x_scan_direct(st, chan->scan_index);
-		mutex_unlock(&dev_info->mlock);
+		mutex_unlock(&indio_dev->mlock);
 
 		if (ret < 0)
 			return ret;
@@ -182,8 +182,8 @@ static ssize_t ad799x_read_frequency(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad799x_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad799x_state *st = iio_priv(indio_dev);
 
 	int ret;
 	u8 val;
@@ -201,8 +201,8 @@ static ssize_t ad799x_write_frequency(struct device *dev,
 					 const char *buf,
 					 size_t len)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad799x_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad799x_state *st = iio_priv(indio_dev);
 
 	long val;
 	int ret, i;
@@ -212,7 +212,7 @@ static ssize_t ad799x_write_frequency(struct device *dev,
 	if (ret)
 		return ret;
 
-	mutex_lock(&dev_info->mlock);
+	mutex_lock(&indio_dev->mlock);
 	ret = ad799x_i2c_read8(st, AD7998_CYCLE_TMR_REG, &t);
 	if (ret)
 		goto error_ret_mutex;
@@ -230,12 +230,12 @@ static ssize_t ad799x_write_frequency(struct device *dev,
 	ret = ad799x_i2c_write8(st, AD7998_CYCLE_TMR_REG, t);
 
 error_ret_mutex:
-	mutex_unlock(&dev_info->mlock);
+	mutex_unlock(&indio_dev->mlock);
 
 	return ret ? ret : len;
 }
 
-static int ad799x_read_event_config(struct iio_dev *dev_info,
+static int ad799x_read_event_config(struct iio_dev *indio_dev,
 				    u64 event_code)
 {
 	return 1;
@@ -294,8 +294,8 @@ static ssize_t ad799x_read_channel_config(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad799x_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad799x_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	int ret;
@@ -312,8 +312,8 @@ static ssize_t ad799x_write_channel_config(struct device *dev,
 					 const char *buf,
 					 size_t len)
 {
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad799x_state *st = iio_priv(dev_info);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad799x_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	long val;
@@ -323,9 +323,9 @@ static ssize_t ad799x_write_channel_config(struct device *dev,
 	if (ret)
 		return ret;
 
-	mutex_lock(&dev_info->mlock);
+	mutex_lock(&indio_dev->mlock);
 	ret = ad799x_i2c_write16(st, this_attr->address, val);
-	mutex_unlock(&dev_info->mlock);
+	mutex_unlock(&indio_dev->mlock);
 
 	return ret ? ret : len;
 }
-- 
1.7.3.4

