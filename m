Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.stresser.de ([88.198.198.115]:57348 "EHLO mail.stresser.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752126AbeCHJdb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 8 Mar 2018 04:33:31 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.stresser.de (Postfix) with ESMTP id 75FF04380064
        for <linux-iio@vger.kernel.org>; Thu,  8 Mar 2018 10:33:30 +0100 (CET)
Received: from _ (frachter.heine.tech [46.4.84.91])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.stresser.de (Postfix) with ESMTPSA id 80ABF4380063
        for <linux-iio@vger.kernel.org>; Thu,  8 Mar 2018 10:33:29 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 08 Mar 2018 10:33:29 +0100
From: Michael Nosthoff <committed@heine.so>
To: linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: ad7793: implement IIO_CHAN_INFO_SAMP_FREQ
Message-ID: <54a52d0cd2417e64b607956b81aa16ec@heine.so>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This commit is a follow-up to changes made to ad_sigma_delta.h
in staging: iio: ad7192: implement IIO_CHAN_INFO_SAMP_FREQ
which broke ad7793 as it was not altered to match those changes.

This driver predates the availability of IIO_CHAN_INFO_SAMP_FREQ
attribute wherein usage has some advantages like it can be accessed by
in-kernel consumers as well as reduces the code size.

Therefore, use IIO_CHAN_INFO_SAMP_FREQ to implement the
sampling_frequency attribute instead of using IIO_DEV_ATTR_SAMP_FREQ()
macro.

Move code from the functions associated with IIO_DEV_ATTR_SAMP_FREQ()
into respective read and write hooks with the mask set to
IIO_CHAN_INFO_SAMP_FREQ.

Fixes: a13e831fcaa7 ("staging: iio: ad7192: implement 
IIO_CHAN_INFO_SAMP_FREQ")

Signed-off-by: Michael Nosthoff <committed@heine.so>
---
Changes in v2:

   - Added Fixes Tag
   - Removed unnecessary ret=0 statement

  drivers/iio/adc/ad7793.c | 73 
+++++++++++++++---------------------------------
  1 file changed, 22 insertions(+), 51 deletions(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index 47c3d7f..fa31a36 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -348,55 +348,6 @@ static const u16 ad7793_sample_freq_avail[16] = {0, 
470, 242, 123, 62, 50, 39,
  static const u16 ad7797_sample_freq_avail[16] = {0, 0, 0, 123, 62, 50, 
0,
  					33, 0, 17, 16, 12, 10, 8, 6, 4};

-static ssize_t ad7793_read_frequency(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7793_state *st = iio_priv(indio_dev);
-
-	return sprintf(buf, "%d\n",
-	       st->chip_info->sample_freq_avail[AD7793_MODE_RATE(st->mode)]);
-}
-
-static ssize_t ad7793_write_frequency(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7793_state *st = iio_priv(indio_dev);
-	long lval;
-	int i, ret;
-
-	ret = kstrtol(buf, 10, &lval);
-	if (ret)
-		return ret;
-
-	if (lval == 0)
-		return -EINVAL;
-
-	for (i = 0; i < 16; i++)
-		if (lval == st->chip_info->sample_freq_avail[i])
-			break;
-	if (i == 16)
-		return -EINVAL;
-
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
-	st->mode &= ~AD7793_MODE_RATE(-1);
-	st->mode |= AD7793_MODE_RATE(i);
-	ad_sd_write_reg(&st->sd, AD7793_REG_MODE, sizeof(st->mode), st->mode);
-	iio_device_release_direct_mode(indio_dev);
-
-	return len;
-}
-
-static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
-		ad7793_read_frequency,
-		ad7793_write_frequency);
-
  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
  	"470 242 123 62 50 39 33 19 17 16 12 10 8 6 4");

@@ -424,7 +375,6 @@ static 
IIO_DEVICE_ATTR_NAMED(in_m_in_scale_available,
  		ad7793_show_scale_available, NULL, 0);

  static struct attribute *ad7793_attributes[] = {
-	&iio_dev_attr_sampling_frequency.dev_attr.attr,
  	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
  	&iio_dev_attr_in_m_in_scale_available.dev_attr.attr,
  	NULL
@@ -435,7 +385,6 @@ static const struct attribute_group 
ad7793_attribute_group = {
  };

  static struct attribute *ad7797_attributes[] = {
-	&iio_dev_attr_sampling_frequency.dev_attr.attr,
  	&iio_const_attr_sampling_frequency_available_ad7797.dev_attr.attr,
  	NULL
  };
@@ -505,6 +454,9 @@ static int ad7793_read_raw(struct iio_dev 
*indio_dev,
  			*val -= offset;
  		}
  		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->chip_info->sample_freq_avail[AD7793_MODE_RATE(st->mode)];
+		return IIO_VAL_INT;
  	}
  	return -EINVAL;
  }
@@ -542,6 +494,25 @@ static int ad7793_write_raw(struct iio_dev 
*indio_dev,
  				break;
  			}
  		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (!val) {
+			ret = -EINVAL;
+			break;
+		}
+
+		for (i = 0; i < 16; i++)
+			if (val == st->chip_info->sample_freq_avail[i])
+				break;
+
+		if (i == 16) {
+			ret = -EINVAL;
+			break;
+		}
+
+		st->mode &= ~AD7793_MODE_RATE(-1);
+		st->mode |= AD7793_MODE_RATE(i);
+		ad_sd_write_reg(&st->sd, AD7793_REG_MODE, sizeof(st->mode), 
st->mode);
+		break;
  	default:
  		ret = -EINVAL;
  	}
-- 
2.7.4
