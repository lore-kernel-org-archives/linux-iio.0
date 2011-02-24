Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] IIO: ADC: AD7606: Update timestamp handling
Date: Thu, 24 Feb 2011 20:09:36 +0100
Message-ID: <1298574577-8373-3-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1298574577-8373-1-git-send-email-michael.hennerich@analog.com>
References: <1298574577-8373-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Add timestamp attributes.
Revise timestamp handling accordingly.
Preset timestamp generation.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad7606_ring.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index 9889680..b32cb0d 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -30,6 +30,9 @@ static IIO_SCAN_EL_C(in5, 5, 0, NULL);
 static IIO_SCAN_EL_C(in6, 6, 0, NULL);
 static IIO_SCAN_EL_C(in7, 7, 0, NULL);
 
+static IIO_SCAN_EL_TIMESTAMP(8);
+static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
+
 static ssize_t ad7606_show_type(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
@@ -60,6 +63,9 @@ static struct attribute *ad7606_scan_el_attrs[] = {
 	&iio_const_attr_in6_index.dev_attr.attr,
 	&iio_scan_el_in7.dev_attr.attr,
 	&iio_const_attr_in7_index.dev_attr.attr,
+	&iio_const_attr_timestamp_index.dev_attr.attr,
+	&iio_scan_el_timestamp.dev_attr.attr,
+	&iio_const_attr_timestamp_type.dev_attr.attr,
 	&iio_dev_attr_in_type.dev_attr.attr,
 	NULL,
 };
@@ -133,10 +139,14 @@ static int ad7606_ring_preenable(struct iio_dev *indio_dev)
 	size_t d_size;
 
 	d_size = st->chip_info->num_channels *
-		 st->chip_info->bits / 8 + sizeof(s64);
+		 st->chip_info->bits / 8;
+
+	if (ring->scan_timestamp) {
+		d_size += sizeof(s64);
 
-	if (d_size % sizeof(s64))
-		d_size += sizeof(s64) - (d_size % sizeof(s64));
+		if (d_size % sizeof(s64))
+			d_size += sizeof(s64) - (d_size % sizeof(s64));
+	}
 
 	if (ring->access.set_bytes_per_datum)
 		ring->access.set_bytes_per_datum(ring, d_size);
@@ -210,7 +220,10 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
 	}
 
 	time_ns = iio_get_time_ns();
-	memcpy(buf + st->d_size - sizeof(s64), &time_ns, sizeof(time_ns));
+
+	if (ring->scan_timestamp)
+		memcpy(buf + st->d_size - sizeof(s64),
+			&time_ns, sizeof(time_ns));
 
 	ring->access.store_to(&sw_ring->buf, buf, time_ns);
 done:
@@ -242,6 +255,7 @@ int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	indio_dev->ring->postenable = &iio_triggered_ring_postenable;
 	indio_dev->ring->predisable = &iio_triggered_ring_predisable;
 	indio_dev->ring->scan_el_attrs = &ad7606_scan_el_group;
+	indio_dev->ring->scan_timestamp = true ;
 
 	INIT_WORK(&st->poll_work, &ad7606_poll_bh_to_ring);
 
-- 
1.6.0.2
