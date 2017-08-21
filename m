Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 78-11-180-123.static.ip.netia.com.pl ([78.11.180.123]:40556
        "EHLO rere.qmqm.pl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754085AbdHUWDe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Aug 2017 18:03:34 -0400
Date: Tue, 22 Aug 2017 00:03:32 +0200
Message-Id: <2bf4d07d81f11add906b449d76efcd04c267d1fd.1503352742.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1503352742.git.mirq-linux@rere.qmqm.pl>
References: <cover.1503352742.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 6/7] iio: accel: kxcjk1013: make sampling_frequency_avail
 per-type
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Make sampling_frequency_avail per-type - like sampling_frequency is.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/iio/accel/kxcjk-1013.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 11bf9afbd248..48b9a97e8a58 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -889,12 +889,13 @@ static ssize_t kxcjk1013_get_samp_freq_avail(struct device *dev,
 	return sprintf(buf, "%s\n", samp_freq_avail);
 }
 
-static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(kxcjk1013_get_samp_freq_avail);
+static IIO_DEVICE_ATTR(in_accel_sampling_frequency_available, S_IRUGO,
+		       kxcjk1013_get_samp_freq_avail, NULL, 0);
 
 static IIO_CONST_ATTR(in_accel_scale_available, "0.009582 0.019163 0.038326");
 
 static struct attribute *kxcjk1013_attributes[] = {
-	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_in_accel_sampling_frequency_available.dev_attr.attr,
 	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
 	NULL,
 };
-- 
2.11.0

