Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 59/70] staging:iio:accel: lis3l02dq add writing for calibscale and calibbias.
Date: Sun, 17 Apr 2011 20:06:32 +0100
Message-Id: <1303067203-4894-60-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
References: <1303067203-4894-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This was missed out in original chan_spec conversion.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/lis3l02dq_core.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 61045a5..ceae5b4 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -220,6 +220,33 @@ static int lis3l02dq_write_thresh(struct iio_dev *indio_dev,
 					   value);
 }
 
+static int lis3l02dq_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val,
+			       int val2,
+			       long mask)
+{
+	int ret = -EINVAL, reg;
+	u8 uval;
+	s8 sval;
+	switch (mask) {
+	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+		if (val > 255 || val < -256)
+			return -EINVAL;
+		sval = val;
+		reg = lis3l02dq_axis_map[LIS3L02DQ_BIAS][chan->address];
+		ret = lis3l02dq_spi_write_reg_8(indio_dev, reg, (u8 *)&sval);
+		break;
+	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
+		if (val & ~0xFF)
+			return -EINVAL;
+		uval = val;
+		reg = lis3l02dq_axis_map[LIS3L02DQ_GAIN][chan->address];
+		ret = lis3l02dq_spi_write_reg_8(indio_dev, reg, &uval);	
+	}
+	return ret;
+}
+
 static int lis3l02dq_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
 			      int *val,
@@ -697,6 +724,7 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 	st->help.indio_dev->channels = lis3l02dq_channels;
 	st->help.indio_dev->num_channels = ARRAY_SIZE(lis3l02dq_channels);
 	st->help.indio_dev->read_raw = &lis3l02dq_read_raw;
+	st->help.indio_dev->write_raw = &lis3l02dq_write_raw;
 	st->help.indio_dev->read_event_value = &lis3l02dq_read_thresh;
 	st->help.indio_dev->write_event_value = &lis3l02dq_write_thresh;
 	st->help.indio_dev->write_event_config = &lis3l02dq_write_event_config;
-- 
1.7.3.4
