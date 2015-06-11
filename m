Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org,
	pmeerw@pmeerw.net,
	vlad.dogaru@intel.com,
	tiberiu.a.breana@intel.com
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 2/2] iio: proximity: sx9500: Fix proximity value
Date: Thu, 11 Jun 2015 18:49:34 +0300
Message-Id: <1434037774-22081-3-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1434037774-22081-1-git-send-email-daniel.baluta@intel.com>
References: <1434037774-22081-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Because of the ABI confusion proximity value exposed by SX9500
was inverted.

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/proximity/sx9500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 2042e37..01494cd 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -281,7 +281,7 @@ static int sx9500_read_prox_data(struct sx9500_data *data,
 	if (ret < 0)
 		return ret;
 
-	*val = 32767 - (s16)be16_to_cpu(regval);
+	*val = be16_to_cpu(regval);
 
 	return IIO_VAL_INT;
 }
-- 
1.9.1
