Return-Path: <SRS0=3BSW=Y6=osadl.org=hofrat@kernel.org>
From: Nicholas Mc Guire <hofrat@osadl.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] iio: health: max30100: use msleep() for long uncritical delays
Date: Mon, 16 Jan 2017 16:35:53 +0100
Message-Id: <1484580953-29817-1-git-send-email-hofrat@osadl.org>
List-ID: <linux-iio@vger.kernel.org>

ulseep_range() uses hrtimers and provides no advantage over msleep()
for larger delays. Fix up the 35ms delays here to use msleep() and
reduce the load on the hrtimer subsystem. 

Fixes: commit 4d33615df58b ("iio: light: add MAX30100 oximeter driver support")
Link: http://lkml.org/lkml/2017/1/11/377
Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---
Problem located with coccinelle script

Patch was compile tested with: x86_64_defconfig + CONFIG_IIO=m + 
CONFIG_MAX30100=m

Patch is aginast 4.10-rc3 (localversion-next is next-20170116)

 drivers/iio/health/max30100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
index 90ab8a2d..9648c69 100644
--- a/drivers/iio/health/max30100.c
+++ b/drivers/iio/health/max30100.c
@@ -378,7 +378,7 @@ static int max30100_get_temp(struct max30100_data *data, int *val)
 	if (ret)
 		return ret;
 
-	usleep_range(35000, 50000);
+	msleep(35);
 
 	return max30100_read_temp(data, val);
 }
-- 
2.1.4
