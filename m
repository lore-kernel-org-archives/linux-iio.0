Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44364 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S946227AbcJSQac (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Oct 2016 12:30:32 -0400
In-Reply-To: <1476873130-24926-3-git-send-email-masneyb@onstation.org>
References: <1476873130-24926-1-git-send-email-masneyb@onstation.org> <1476873130-24926-3-git-send-email-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 3/7] iio: light: tsl2583: use DEVICE_ATTR_{RO, RW, WO} macros
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Wed, 19 Oct 2016 17:30:25 +0100
To: Brian Masney <masneyb@onstation.org>, jic23@kernel.org
CC: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Message-ID: <F0DEA1F9-B45C-4537-9B8A-D0A6BCBB7DF2@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 19 October 2016 11:32:06 BST, Brian Masney <masneyb@onstation.org> wrote:
>Use the DEVICE_ATTR_RO, IIO_DEVICE_ATTR_RW, and IIO_DEVICE_ATTR_WO
>macros to create the device attributes.
>
>Signed-off-by: Brian Masney <masneyb@onstation.org>

Hi Brian, 

One very quick comment.  Driver should be using an iio_chan_spec array and relevant
 info_mask elements plus read_raw etc.

That will get rid of about half of these so I would do that before cleaning up the remainder.

J
>---
>drivers/staging/iio/light/tsl2583.c | 117
>++++++++++++++++++------------------
> 1 file changed, 57 insertions(+), 60 deletions(-)
>
>diff --git a/drivers/staging/iio/light/tsl2583.c
>b/drivers/staging/iio/light/tsl2583.c
>index 8448a87..bbb8fc3 100644
>--- a/drivers/staging/iio/light/tsl2583.c
>+++ b/drivers/staging/iio/light/tsl2583.c
>@@ -501,8 +501,8 @@ static int taos_chip_off(struct iio_dev *indio_dev)
> 
> /* Sysfs Interface Functions */
> 
>-static ssize_t taos_power_state_show(struct device *dev,
>-				     struct device_attribute *attr, char *buf)
>+static ssize_t power_state_show(struct device *dev,
>+				struct device_attribute *attr, char *buf)
> {
> 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> 	struct tsl2583_chip *chip = iio_priv(indio_dev);
>@@ -510,9 +510,9 @@ static ssize_t taos_power_state_show(struct device
>*dev,
> 	return sprintf(buf, "%d\n", chip->taos_chip_status);
> }
> 
>-static ssize_t taos_power_state_store(struct device *dev,
>-				      struct device_attribute *attr,
>-				      const char *buf, size_t len)
>+static ssize_t power_state_store(struct device *dev,
>+				 struct device_attribute *attr,
>+				 const char *buf, size_t len)
> {
> 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> 	int value;
>@@ -528,8 +528,9 @@ static ssize_t taos_power_state_store(struct device
>*dev,
> 	return len;
> }
> 
>-static ssize_t taos_gain_show(struct device *dev,
>-			      struct device_attribute *attr, char *buf)
>+static ssize_t illuminance0_calibscale_show(struct device *dev,
>+					    struct device_attribute *attr,
>+					    char *buf)
> {
> 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> 	struct tsl2583_chip *chip = iio_priv(indio_dev);
>@@ -553,9 +554,9 @@ static ssize_t taos_gain_show(struct device *dev,
> 	return sprintf(buf, "%s\n", gain);
> }
> 
>-static ssize_t taos_gain_store(struct device *dev,
>-			       struct device_attribute *attr,
>-			       const char *buf, size_t len)
>+static ssize_t illuminance0_calibscale_store(struct device *dev,
>+					     struct device_attribute *attr,
>+					     const char *buf, size_t len)
> {
> 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> 	struct tsl2583_chip *chip = iio_priv(indio_dev);
>@@ -587,15 +588,16 @@ gain_store_done:
> 	return ret;
> }
> 
>-static ssize_t taos_gain_available_show(struct device *dev,
>-					struct device_attribute *attr,
>-					char *buf)
>+static ssize_t illuminance0_calibscale_available_show(struct device
>*dev,
>+						  struct device_attribute *attr,
>+						  char *buf)
> {
> 	return sprintf(buf, "%s\n", "1 8 16 111");
> }
> 
>-static ssize_t taos_als_time_show(struct device *dev,
>-				  struct device_attribute *attr, char *buf)
>+static ssize_t illuminance0_integration_time_show(struct device *dev,
>+						  struct device_attribute *attr,
>+						  char *buf)
> {
> 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> 	struct tsl2583_chip *chip = iio_priv(indio_dev);
>@@ -603,9 +605,9 @@ static ssize_t taos_als_time_show(struct device
>*dev,
> 	return sprintf(buf, "%d\n", chip->taos_settings.als_time);
> }
> 
>-static ssize_t taos_als_time_store(struct device *dev,
>-				   struct device_attribute *attr,
>-				   const char *buf, size_t len)
>+static ssize_t illuminance0_integration_time_store(struct device *dev,
>+						  struct device_attribute *attr,
>+						  const char *buf, size_t len)
> {
> 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> 	struct tsl2583_chip *chip = iio_priv(indio_dev);
>@@ -627,16 +629,17 @@ als_time_store_done:
> 	return ret;
> }
> 
>-static ssize_t taos_als_time_available_show(struct device *dev,
>-					    struct device_attribute *attr,
>-					    char *buf)
>+static ssize_t illuminance0_integration_time_available_show(struct
>device *dev,
>+						  struct device_attribute *attr,
>+						  char *buf)
> {
> 	return sprintf(buf, "%s\n",
> 		"50 100 150 200 250 300 350 400 450 500 550 600 650");
> }
> 
>-static ssize_t taos_als_trim_show(struct device *dev,
>-				  struct device_attribute *attr, char *buf)
>+static ssize_t illuminance0_calibbias_show(struct device *dev,
>+					   struct device_attribute *attr,
>+					   char *buf)
> {
> 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> 	struct tsl2583_chip *chip = iio_priv(indio_dev);
>@@ -644,9 +647,9 @@ static ssize_t taos_als_trim_show(struct device
>*dev,
> 	return sprintf(buf, "%d\n", chip->taos_settings.als_gain_trim);
> }
> 
>-static ssize_t taos_als_trim_store(struct device *dev,
>-				   struct device_attribute *attr,
>-				   const char *buf, size_t len)
>+static ssize_t illuminance0_calibbias_store(struct device *dev,
>+					    struct device_attribute *attr,
>+					    const char *buf, size_t len)
> {
> 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> 	struct tsl2583_chip *chip = iio_priv(indio_dev);
>@@ -661,9 +664,9 @@ static ssize_t taos_als_trim_store(struct device
>*dev,
> 	return len;
> }
> 
>-static ssize_t taos_als_cal_target_show(struct device *dev,
>-					struct device_attribute *attr,
>-					char *buf)
>+static ssize_t illuminance0_input_target_show(struct device *dev,
>+					      struct device_attribute *attr,
>+					      char *buf)
> {
> 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> 	struct tsl2583_chip *chip = iio_priv(indio_dev);
>@@ -671,9 +674,9 @@ static ssize_t taos_als_cal_target_show(struct
>device *dev,
> 	return sprintf(buf, "%d\n", chip->taos_settings.als_cal_target);
> }
> 
>-static ssize_t taos_als_cal_target_store(struct device *dev,
>-					 struct device_attribute *attr,
>-					 const char *buf, size_t len)
>+static ssize_t illuminance0_input_target_store(struct device *dev,
>+					       struct device_attribute *attr,
>+					       const char *buf, size_t len)
> {
> 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> 	struct tsl2583_chip *chip = iio_priv(indio_dev);
>@@ -688,8 +691,9 @@ static ssize_t taos_als_cal_target_store(struct
>device *dev,
> 	return len;
> }
> 
>-static ssize_t taos_lux_show(struct device *dev, struct
>device_attribute *attr,
>-			     char *buf)
>+static ssize_t illuminance0_input_show(struct device *dev,
>+				       struct device_attribute *attr,
>+				       char *buf)
> {
> 	int ret;
> 
>@@ -700,9 +704,9 @@ static ssize_t taos_lux_show(struct device *dev,
>struct device_attribute *attr,
> 	return sprintf(buf, "%d\n", ret);
> }
> 
>-static ssize_t taos_do_calibrate(struct device *dev,
>-				 struct device_attribute *attr,
>-				 const char *buf, size_t len)
>+static ssize_t illuminance0_calibrate_store(struct device *dev,
>+					    struct device_attribute *attr,
>+					    const char *buf, size_t len)
> {
> 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> 	int value;
>@@ -716,8 +720,9 @@ static ssize_t taos_do_calibrate(struct device
>*dev,
> 	return len;
> }
> 
>-static ssize_t taos_luxtable_show(struct device *dev,
>-				  struct device_attribute *attr, char *buf)
>+static ssize_t illuminance0_lux_table_show(struct device *dev,
>+					   struct device_attribute *attr,
>+					   char *buf)
> {
> 	int i;
> 	int offset = 0;
>@@ -741,9 +746,9 @@ static ssize_t taos_luxtable_show(struct device
>*dev,
> 	return offset;
> }
> 
>-static ssize_t taos_luxtable_store(struct device *dev,
>-				   struct device_attribute *attr,
>-				   const char *buf, size_t len)
>+static ssize_t illuminance0_lux_table_store(struct device *dev,
>+					    struct device_attribute *attr,
>+					    const char *buf, size_t len)
> {
> 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> 	struct tsl2583_chip *chip = iio_priv(indio_dev);
>@@ -781,29 +786,21 @@ luxable_store_done:
> 	return ret;
> }
> 
>-static DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR,
>-		taos_power_state_show, taos_power_state_store);
>+static DEVICE_ATTR_RW(power_state);
> 
>-static DEVICE_ATTR(illuminance0_calibscale, S_IRUGO | S_IWUSR,
>-		taos_gain_show, taos_gain_store);
>-static DEVICE_ATTR(illuminance0_calibscale_available, S_IRUGO,
>-		taos_gain_available_show, NULL);
>+static DEVICE_ATTR_RW(illuminance0_calibscale);
>+static DEVICE_ATTR_RO(illuminance0_calibscale_available);
> 
>-static DEVICE_ATTR(illuminance0_integration_time, S_IRUGO | S_IWUSR,
>-		taos_als_time_show, taos_als_time_store);
>-static DEVICE_ATTR(illuminance0_integration_time_available, S_IRUGO,
>-		taos_als_time_available_show, NULL);
>+static DEVICE_ATTR_RW(illuminance0_integration_time);
>+static DEVICE_ATTR_RO(illuminance0_integration_time_available);
> 
>-static DEVICE_ATTR(illuminance0_calibbias, S_IRUGO | S_IWUSR,
>-		taos_als_trim_show, taos_als_trim_store);
>+static DEVICE_ATTR_RW(illuminance0_calibbias);
> 
>-static DEVICE_ATTR(illuminance0_input_target, S_IRUGO | S_IWUSR,
>-		taos_als_cal_target_show, taos_als_cal_target_store);
>+static DEVICE_ATTR_RW(illuminance0_input_target);
> 
>-static DEVICE_ATTR(illuminance0_input, S_IRUGO, taos_lux_show, NULL);
>-static DEVICE_ATTR(illuminance0_calibrate, S_IWUSR, NULL,
>taos_do_calibrate);
>-static DEVICE_ATTR(illuminance0_lux_table, S_IRUGO | S_IWUSR,
>-		taos_luxtable_show, taos_luxtable_store);
>+static DEVICE_ATTR_RO(illuminance0_input);
>+static DEVICE_ATTR_WO(illuminance0_calibrate);
>+static DEVICE_ATTR_RW(illuminance0_lux_table);
> 
> static struct attribute *sysfs_attrs_ctrl[] = {
> 	&dev_attr_power_state.attr,

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
