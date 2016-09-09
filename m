Return-Path: <ico@pruts.nl>
From: Ico Doornekamp <ico@pruts.nl>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Ico Doornekamp <ico@pruts.nl>
Subject: [PATCH] Fixed superfluous indent white space in sca3000_core.c
Date: Fri,  9 Sep 2016 16:32:11 +0200
Message-Id: <20160909143211.13038-1-ico@pruts.nl>
List-ID: <linux-iio@vger.kernel.org>


Signed-off-by: Ico Doornekamp <ico@pruts.nl>
---
 drivers/staging/iio/accel/sca3000_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index b5625f5..61f3241 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -412,7 +412,7 @@ static const struct iio_event_spec sca3000_event = {
 		},						\
 		.event_spec = &sca3000_event,			\
 		.num_event_specs = 1,				\
-	 }
+	}
 
 static const struct iio_chan_spec sca3000_channels[] = {
 	SCA3000_CHAN(0, IIO_MOD_X),
-- 
2.9.3
