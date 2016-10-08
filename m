Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35419 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756447AbcJHQjf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Oct 2016 12:39:35 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 12/18] staging:iio:accel:sca3000 Add write support to the low pass filter control
Date: Sat,  8 Oct 2016 17:39:12 +0100
Message-Id: <20161008163918.18758-13-jic23@kernel.org>
In-Reply-To: <20161008163918.18758-1-jic23@kernel.org>
References: <20161008163918.18758-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Also includes an available attribute.  The ordering of values appears
a bit random, but as the ABI doesn't specify this and we already have
both rising and falling lists I think this is fine.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/sca3000.c | 55 +++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/staging/iio/accel/sca3000.c b/drivers/staging/iio/accel/sca3000.c
index 859394f8d8af..8212e1c7e91d 100644
--- a/drivers/staging/iio/accel/sca3000.c
+++ b/drivers/staging/iio/accel/sca3000.c
@@ -432,6 +432,26 @@ error_ret:
 	return ret ? ret : len;
 }
 
+static ssize_t
+sca3000_show_available_3db_freqs(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct sca3000_state *st = iio_priv(indio_dev);
+	int len;
+
+	len = sprintf(buf, "%d", st->info->measurement_mode_3db_freq);
+	if (st->info->option_mode_1)
+		len += sprintf(buf + len, " %d",
+			       st->info->option_mode_1_3db_freq);
+	if (st->info->option_mode_2)
+		len += sprintf(buf + len, " %d",
+			       st->info->option_mode_2_3db_freq);
+	len += sprintf(buf + len, "\n");
+
+	return len;
+}
 /**
  * sca3000_show_available_measurement_modes() display available modes
  *
@@ -570,6 +590,9 @@ static IIO_DEVICE_ATTR(measurement_mode, S_IRUGO | S_IWUSR,
 		       sca3000_store_measurement_mode,
 		       0);
 
+static IIO_DEVICE_ATTR(in_accel_filter_low_pass_3db_frequency_available,
+		       S_IRUGO, sca3000_show_available_3db_freqs,
+		       NULL, 0);
 /* More standard attributes */
 
 static IIO_DEVICE_ATTR(revision, S_IRUGO, sca3000_show_rev, NULL, 0);
@@ -778,6 +801,31 @@ static int sca3000_read_3db_freq(struct sca3000_state *st, int *val)
 	}
 }
 
+static int sca3000_write_3db_freq(struct sca3000_state *st, int val)
+{
+	int ret;
+	int mode;
+
+	if (val == st->info->measurement_mode_3db_freq)
+		mode = SCA3000_REG_MODE_MEAS_MODE_NORMAL;
+	else if (st->info->option_mode_1 &&
+		 (val == st->info->option_mode_1_3db_freq))
+		mode = SCA3000_REG_MODE_MEAS_MODE_OP_1;
+	else if (st->info->option_mode_2 &&
+		 (val == st->info->option_mode_2_3db_freq))
+		mode = SCA3000_REG_MODE_MEAS_MODE_OP_2;
+	else
+		return -EINVAL;
+	ret = sca3000_read_data_short(st, SCA3000_REG_MODE_ADDR, 1);
+	if (ret)
+		return ret;
+
+	st->rx[0] &= ~SCA3000_REG_MODE_MODE_MASK;
+	st->rx[0] |= (mode & SCA3000_REG_MODE_MODE_MASK);
+
+	return sca3000_write_reg(st, SCA3000_REG_MODE_ADDR, st->rx[0]);
+}
+
 static int sca3000_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val,
@@ -860,6 +908,12 @@ static int sca3000_write_raw(struct iio_dev *indio_dev,
 		ret = write_raw_samp_freq(st, val);
 		mutex_unlock(&st->lock);
 		return ret;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		if (val2)
+			return -EINVAL;
+		mutex_lock(&st->lock);
+		ret = sca3000_write_3db_freq(st, val);
+		mutex_unlock(&st->lock);
 	default:
 		return -EINVAL;
 	}
@@ -1006,6 +1060,7 @@ static struct attribute *sca3000_attributes[] = {
 	&iio_dev_attr_revision.dev_attr.attr,
 	&iio_dev_attr_measurement_mode_available.dev_attr.attr,
 	&iio_dev_attr_measurement_mode.dev_attr.attr,
+	&iio_dev_attr_in_accel_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
 	NULL,
 };
-- 
2.10.0

