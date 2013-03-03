Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Patrick Vasseur <patrick.vasseur@c-s.fr>,
	"Signed-off-by: Christophe Leroy" <christophe.leroy@c-s.fr>
Subject: [PATCH 2/2] iio:adc:ad7923 move to info_mask_(shared_by_type/separate)
Date: Sun,  3 Mar 2013 20:03:53 +0000
Message-Id: <1362341033-9506-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1362341033-9506-1-git-send-email-jic23@kernel.org>
References: <1362341033-9506-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Patrick Vasseur <patrick.vasseur@c-s.fr>
cc: Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/iio/adc/ad7923.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 28b2bda..766c740 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -69,8 +69,8 @@ struct ad7923_state {
 		.type = IIO_VOLTAGE,					\
 		.indexed = 1,						\
 		.channel = index,					\
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |		\
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,				\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
 		.address = index,					\
 		.scan_index = index,					\
 		.scan_type = {						\
-- 
1.8.1.4
