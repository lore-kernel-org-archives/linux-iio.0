Return-Path: <ldewangan@nvidia.com>
From: Laxman Dewangan <ldewangan@nvidia.com>
To: <jic23@cam.ac.uk>, <gregkh@linuxfoundation.org>,
	<grant.likely@secretlab.ca>, <rob.herring@calxeda.com>,
	<jbrenner@taosinc.com>, <rklein@nvidia.com>, <max@stro.at>
CC: <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
	<linux-kernel@vger.kernel.org>, <devicetree-discuss@lists.ozlabs.org>, Laxman
 Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V5 1/2] staging: iio: add channel info for sampling frequency
Date: Fri, 13 Apr 2012 16:03:31 +0530
Message-ID: <1334313212-23618-2-git-send-email-ldewangan@nvidia.com>
In-Reply-To: <1334313212-23618-1-git-send-email-ldewangan@nvidia.com>
References: <1334313212-23618-1-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Adding channel info IIO_CHAN_INFO_SAMP_FREQ to select
different sampling frequency per channel wise.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
changes from V3:
 - Change the info name to "sampling_frequency"
Changes from V4:
- No change, just to sync with the patch series.

 drivers/staging/iio/iio.h               |    5 +++++
 drivers/staging/iio/industrialio-core.c |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index b9cd454..9aa0dd5 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -36,6 +36,7 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW,
 	IIO_CHAN_INFO_AVERAGE_RAW,
 	IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY,
+	IIO_CHAN_INFO_SAMP_FREQ,
 };
 
 #define IIO_CHAN_INFO_SHARED_BIT(type) BIT(type*2)
@@ -81,6 +82,10 @@ enum iio_chan_info_enum {
 #define IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SEPARATE_BIT \
 	IIO_CHAN_INFO_SEPARATE_BIT(			       \
 		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY)
+#define IIO_CHAN_INFO_SAMP_FREQ_SEPARATE_BIT		\
+	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_SAMP_FREQ)
+#define IIO_CHAN_INFO_SAMP_FREQ_SHARED_BIT			\
+	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_SAMP_FREQ)
 
 enum iio_endian {
 	IIO_CPU,
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index d303bfb..9e42713 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -90,6 +90,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_AVERAGE_RAW] = "mean_raw",
 	[IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY]
 	= "filter_low_pass_3db_frequency",
+	[IIO_CHAN_INFO_SAMP_FREQ] = "sampling_frequency",
 };
 
 const struct iio_chan_spec
-- 
1.7.1.1
