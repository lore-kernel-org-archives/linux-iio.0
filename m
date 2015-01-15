Return-Path: <roberta.dobrescu@gmail.com>
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: octavian.purdila@intel.com,
	daniel.baluta@intel.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH] iio: light: cm32181: Fix typo 's/claibscale/calibscale/'
Date: Fri, 16 Jan 2015 00:24:41 +0200
Message-Id: <1421360681-1443-1-git-send-email-roberta.dobrescu@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
---
 drivers/iio/light/cm32181.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index ad36b29..5d12ae54 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -169,7 +169,7 @@ static int cm32181_write_als_it(struct cm32181_chip *cm32181, int val)
  * @cm32181:	pointer of struct cm32181.
  *
  * Convert sensor raw data to lux.  It depends on integration
- * time and claibscale variable.
+ * time and calibscale variable.
  *
  * Return: Positive value is lux, otherwise is error code.
  */
-- 
1.9.1
