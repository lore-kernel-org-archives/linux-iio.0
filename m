Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [RFC PATCH 2/2] staging:iio: Introduce IIO_CHAN_INFO_*_MASK
Date: Fri, 21 Oct 2011 14:24:15 +0200
Message-ID: <1319199855-24834-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1319199855-24834-1-git-send-email-lars@metafoo.de>
References: <1319199855-24834-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Introduce IIO_CHAN_INFO_*_MASK defines which can be used for specifying channel
a channel_spec info_mask attribute. This should be more convenient and also
more readable than creating the mask manually in each driver using the shift
operator.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Patch based on linux-iio/master
---
 drivers/staging/iio/iio.h |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index d7c5f3f..7ff8c98 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -46,6 +46,43 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE,
 };
 
+#define IIO_CHAN_INFO_SCALE_SHARED_MASK				\
+	BIT(IIO_CHAN_INFO_SCALE_SHARED)
+#define IIO_CHAN_INFO_SCALE_SEPARATE_MASK			\
+	BIT(IIO_CHAN_INFO_SCALE_SEPARATE)
+#define IIO_CHAN_INFO_OFFSET_SHARED_MASK			\
+	BIT(IIO_CHAN_INFO_OFFSET_SHARED)
+#define IIO_CHAN_INFO_OFFSET_SEPARATE_MASK			\
+	BIT(IIO_CHAN_INFO_OFFSET_SEPARATE)
+#define IIO_CHAN_INFO_CALIBSCALE_SHARED_MASK			\
+	BIT(IIO_CHAN_INFO_CALIBSCALE_SHARED)
+#define IIO_CHAN_INFO_CALIBSCALE_SEPARATE_MASK			\
+	BIT(IIO_CHAN_INFO_CALIBSCALE_SEPARATE)
+#define IIO_CHAN_INFO_CALIBBIAS_SHARED_MASK			\
+	BIT(IIO_CHAN_INFO_CALIBBIAS_SHARED)
+#define IIO_CHAN_INFO_CALIBBIAS_SEPARATE_MASK			\
+	BIT(IIO_CHAN_INFO_CALIBBIAS_SEPARATE)
+#define IIO_CHAN_INFO_PEAK_SHARED_MASK				\
+	BIT(IIO_CHAN_INFO_PEAK_SHARED)
+#define IIO_CHAN_INFO_PEAK_SEPARATE_MASK			\
+	BIT(IIO_CHAN_INFO_PEAK_SEPARATE)
+#define IIO_CHAN_INFO_PEAK_SCALE_SHARED_MASK			\
+	BIT(IIO_CHAN_INFO_PEAK_SCALE_SHARED)
+#define IIO_CHAN_INFO_PEAK_SCALE_SHARED_MASK			\
+	BIT(IIO_CHAN_INFO_PEAK_SCALE_SHARED)
+#define IIO_CHAN_INFO_SCALE_SHARED_MASK				\
+	BIT(IIO_CHAN_INFO_SCALE_SHARED)
+#define IIO_CHAN_INFO_SCALE_SEPARATE_MASK			\
+	BIT(IIO_CHAN_INFO_SCALE_SEPARATE)
+#define IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SHARED_MASK	\
+	BIT(IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SHARED)
+#define IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE_MASK	\
+	BIT(IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE)
+#define IIO_CHAN_INFO_AVERAGE_RAW_SHARED_MASK			\
+	BIT(IIO_CHAN_INFO_AVERAGE_RAW_SHARED)
+#define IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE_MASK			\
+	BIT(IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE)
+
 enum iio_endian {
 	IIO_CPU,
 	IIO_BE,
-- 
1.7.6.3
