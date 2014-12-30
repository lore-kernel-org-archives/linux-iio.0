Return-Path: <roberta.dobrescu@gmail.com>
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: octavian.purdila@intel.com,
	daniel.baluta@intel.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH 2/2] iio: light: lm3533-als: Remove space before ','
Date: Tue, 30 Dec 2014 20:48:50 +0200
Message-Id: <1419965330-4102-3-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1419965330-4102-1-git-send-email-roberta.dobrescu@gmail.com>
References: <1419965330-4102-1-git-send-email-roberta.dobrescu@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch fixes the following checkpatch.pl error:
ERROR: space prohibited before that ',' (ctx:WxE)

Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
---
 drivers/iio/light/lm3533-als.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index ae3c71b..076bc46 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -657,7 +657,7 @@ static ALS_HYSTERESIS_ATTR_RO(3);
 #define ILLUMINANCE_ATTR_RO(_name) \
 	DEVICE_ATTR(in_illuminance0_##_name, S_IRUGO, show_##_name, NULL)
 #define ILLUMINANCE_ATTR_RW(_name) \
-	DEVICE_ATTR(in_illuminance0_##_name, S_IRUGO | S_IWUSR , \
+	DEVICE_ATTR(in_illuminance0_##_name, S_IRUGO | S_IWUSR, \
 						show_##_name, store_##_name)
 /*
  * ALS Zone threshold-event enable
-- 
1.9.1
