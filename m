Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 66/99] staging:iio:accel: lis3l02dq add writing for calibscale and calibbias.
Date: Wed,  4 May 2011 12:58:38 +0100
Message-Id: <1304510351-10922-67-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This was missed out in original chan_spec conversion.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/lis3l02dq_core.c |   29 ++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index a6b4631..8793ee4 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -218,6 +218,34 @@ static int lis3l02dq_write_thresh(struct iio_dev *indio_dev,
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
+		break;
+	}
+	return ret;
+}
+
 static int lis3l02dq_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
 			      int *val,
@@ -692,6 +720,7 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 	st->help.indio_dev->channels = lis3l02dq_channels;
 	st->help.indio_dev->num_channels = ARRAY_SIZE(lis3l02dq_channels);
 	st->help.indio_dev->read_raw = &lis3l02dq_read_raw;
+	st->help.indio_dev->write_raw = &lis3l02dq_write_raw;
 	st->help.indio_dev->read_event_value = &lis3l02dq_read_thresh;
 	st->help.indio_dev->write_event_value = &lis3l02dq_write_thresh;
 	st->help.indio_dev->write_event_config = &lis3l02dq_write_event_config;
-- 
1.7.3.4
