Return-Path: <SRS0=wvzB=7T=rere.qmqm.pl=mirq-linux@kernel.org>
Date: Thu, 17 Aug 2017 16:21:37 +0200
Message-Id: <f65b8c2d74d216be9eaf2707ce7cbf7a94f4b2ae.1502979014.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1502979014.git.mirq-linux@rere.qmqm.pl>
References: <cover.1502979014.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 5/6] iio: accel: kxcjk1013: make sampling_frequency_avail
 per-type
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
List-ID: <linux-iio@vger.kernel.org>

Make sampling_frequency_avail per-type - like sampling_frequency is.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/iio/accel/kxcjk-1013.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 50d9eefa745f..8bde6bead073 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -891,12 +891,13 @@ static ssize_t kxcjk1013_get_samp_freq_avail(struct device *dev,
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
