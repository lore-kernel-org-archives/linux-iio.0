Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 78-11-180-123.static.ip.netia.com.pl ([78.11.180.123]:40550
        "EHLO rere.qmqm.pl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753907AbdHUWDe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Aug 2017 18:03:34 -0400
Date: Tue, 22 Aug 2017 00:03:32 +0200
Message-Id: <a8aa4077637a133a950b436d47b0eef7d22accef.1503352742.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1503352742.git.mirq-linux@rere.qmqm.pl>
References: <cover.1503352742.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 5/7] iio: accel: kxcjk1013: make
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
index 252004640403..11bf9afbd248 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -155,6 +155,9 @@ static const struct kx_odr_map samp_freq_table[] = {
 	{ 1600, 0, 0x07, 0x06 },
 };
 
+static const char *const samp_freq_avail =
+	"0.781000 1.563000 3.125000 6.250000 12.500000 25 50 100 200 400 800 1600";
+
 /* Refer to section 4 of the specification */
 static const struct {
 	int odr_bits;
@@ -879,13 +882,19 @@ static int kxcjk1013_buffer_postdisable(struct iio_dev *indio_dev)
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

