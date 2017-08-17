Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 78-11-180-123.static.ip.netia.com.pl ([78.11.180.123]:42286
        "EHLO rere.qmqm.pl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752027AbdHQOVi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Aug 2017 10:21:38 -0400
Date: Thu, 17 Aug 2017 16:21:37 +0200
Message-Id: <8c323191a50145994ca16608abcab42d7688146a.1502979014.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1502979014.git.mirq-linux@rere.qmqm.pl>
References: <cover.1502979014.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 4/6] iio: accel: kxcjk1013: make
 sysfs/sampling_frequency_avail dynamic
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In preparation for KXTF9 support, make sampling_frequency_avail
attribute dynamic.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/iio/accel/kxcjk-1013.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 27147b687471..50d9eefa745f 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -159,6 +159,9 @@ static const struct kx_odr_map samp_freq_table[] = {
 	{ 1600, 0, 0x07, 0x06 },
 };
 
+static const char *const samp_freq_avail =
+	"0.781000 1.563000 3.125000 6.250000 12.500000 25 50 100 200 400 800 1600";
+
 /* Refer to section 4 of the specification */
 static const struct {
 	int odr_bits;
@@ -881,13 +884,19 @@ static int kxcjk1013_buffer_postdisable(struct iio_dev *indio_dev)
 	return kxcjk1013_set_power_state(data, false);
 }
 
-static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
-	"0.781000 1.563000 3.125000 6.250000 12.500000 25 50 100 200 400 800 1600");
+static ssize_t kxcjk1013_get_samp_freq_avail(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	return sprintf(buf, "%s\n", samp_freq_avail);
+}
+
+static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(kxcjk1013_get_samp_freq_avail);
 
 static IIO_CONST_ATTR(in_accel_scale_available, "0.009582 0.019163 0.038326");
 
 static struct attribute *kxcjk1013_attributes[] = {
-	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
 	NULL,
 };
-- 
2.11.0

