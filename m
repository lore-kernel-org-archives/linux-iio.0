Return-Path: <sst@poczta.fm>
From: Slawomir Stepien <sst@poczta.fm>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH 03/10] iio: adc: vf610_adc: fix case label indent
Date: Thu, 14 Apr 2016 21:36:35 +0200
Message-Id: <1460662602-2951-4-git-send-email-sst@poczta.fm>
In-Reply-To: <1460662602-2951-1-git-send-email-sst@poczta.fm>
References: <1460662602-2951-1-git-send-email-sst@poczta.fm>
List-ID: <linux-iio@vger.kernel.org>

This fixes the error reported by checkpatch.pl:

ERROR: switch and case should be at the same indent

Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 drivers/iio/adc/vf610_adc.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index b10f629..653bf13 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -714,19 +714,19 @@ static int vf610_write_raw(struct iio_dev *indio_dev,
 	int i;
 
 	switch (mask) {
-		case IIO_CHAN_INFO_SAMP_FREQ:
-			for (i = 0;
-				i < ARRAY_SIZE(info->sample_freq_avail);
-				i++)
-				if (val == info->sample_freq_avail[i]) {
-					info->adc_feature.sample_rate = i;
-					vf610_adc_sample_set(info);
-					return 0;
-				}
-			break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		for (i = 0;
+			i < ARRAY_SIZE(info->sample_freq_avail);
+			i++)
+			if (val == info->sample_freq_avail[i]) {
+				info->adc_feature.sample_rate = i;
+				vf610_adc_sample_set(info);
+				return 0;
+			}
+		break;
 
-		default:
-			break;
+	default:
+		break;
 	}
 
 	return -EINVAL;
-- 
2.8.0
