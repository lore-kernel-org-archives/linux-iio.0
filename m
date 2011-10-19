Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/4] staging:iio:dac:ad5791: Convert attributes to new naming spec
Date: Wed, 19 Oct 2011 14:23:49 +0200
Message-ID: <1319027030-9696-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1319027030-9696-1-git-send-email-lars@metafoo.de>
References: <1319027030-9696-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add the missing "voltage" chan_type to the powerdown attributes.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/dac/ad5791.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
index c465fcf..9ba45f1 100644
--- a/drivers/staging/iio/dac/ad5791.c
+++ b/drivers/staging/iio/dac/ad5791.c
@@ -158,24 +158,24 @@ static ssize_t ad5791_write_dac_powerdown(struct device *dev,
 	return ret ? ret : len;
 }
 
-static IIO_DEVICE_ATTR(out_powerdown_mode, S_IRUGO |
+static IIO_DEVICE_ATTR(out_voltage_powerdown_mode, S_IRUGO |
 			S_IWUSR, ad5791_read_powerdown_mode,
 			ad5791_write_powerdown_mode, 0);
 
-static IIO_CONST_ATTR(out_powerdown_mode_available,
+static IIO_CONST_ATTR(out_voltage_powerdown_mode_available,
 			"6kohm_to_gnd three_state");
 
 #define IIO_DEV_ATTR_DAC_POWERDOWN(_num, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(out##_num##_powerdown,				\
+	IIO_DEVICE_ATTR(out_voltage##_num##_powerdown,			\
 			S_IRUGO | S_IWUSR, _show, _store, _addr)
 
 static IIO_DEV_ATTR_DAC_POWERDOWN(0, ad5791_read_dac_powerdown,
 				   ad5791_write_dac_powerdown, 0);
 
 static struct attribute *ad5791_attributes[] = {
-	&iio_dev_attr_out0_powerdown.dev_attr.attr,
-	&iio_dev_attr_out_powerdown_mode.dev_attr.attr,
-	&iio_const_attr_out_powerdown_mode_available.dev_attr.attr,
+	&iio_dev_attr_out_voltage0_powerdown.dev_attr.attr,
+	&iio_dev_attr_out_voltage_powerdown_mode.dev_attr.attr,
+	&iio_const_attr_out_voltage_powerdown_mode_available.dev_attr.attr,
 	NULL,
 };
 
-- 
1.7.6.3
