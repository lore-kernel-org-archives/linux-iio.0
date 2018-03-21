Return-Path: <SRS0=Ao9w=GL=onstation.org=masneyb@kernel.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: [PATCH 03/11] staging: iio: tsl2x7x: no need to clear interrupt flag when getting lux
Date: Wed, 21 Mar 2018 06:29:04 -0400
Message-Id: <20180321102912.5130-4-masneyb@onstation.org>
In-Reply-To: <20180321102912.5130-1-masneyb@onstation.org>
References: <20180321102912.5130-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

tsl2x7x_get_lux() does not need to clear the interrupt flag when
querying the ALS. The interrupt flag is cleared in
tsl2x7x_event_handler(). This patches removes the unnecessary code.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 59921850a226..9c929e273135 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -387,10 +387,6 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 		buf[i] = ret;
 	}
 
-	ret = tsl2x7x_clear_interrupts(chip, TSL2X7X_CMD_ALS_INT_CLR);
-	if (ret < 0)
-		goto out_unlock;
-
 	/* extract ALS/lux data */
 	ch0 = le16_to_cpup((const __le16 *)&buf[0]);
 	ch1 = le16_to_cpup((const __le16 *)&buf[2]);
-- 
2.14.3
