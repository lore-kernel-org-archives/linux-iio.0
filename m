Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH 7/8] iio:magnetometer:bmc150_magn: expand mutex in trigger_handler
Date: Fri, 17 Jul 2015 10:52:30 +0200
Message-Id: <6b1b2b7f33cc5a9654f32785626a10c8276d73e6.1437090791.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437090791.git.knaack.h@gmx.de>
References: <cover.1437090791.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437090791.git.knaack.h@gmx.de>
References: <cover.1437090791.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Keep the mutex locked, until the content of data->buffer has been pushed
out.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/magnetometer/bmc150_magn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index ac0cdbde813b..bdcf49ee75df 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -664,7 +664,6 @@ static irqreturn_t bmc150_magn_trigger_handler(int irq, void *p)
 
 	mutex_lock(&data->mutex);
 	ret = bmc150_magn_read_xyz(data, data->buffer);
-	mutex_unlock(&data->mutex);
 	if (ret < 0)
 		goto err;
 
@@ -672,6 +671,7 @@ static irqreturn_t bmc150_magn_trigger_handler(int irq, void *p)
 					   pf->timestamp);
 
 err:
+	mutex_unlock(&data->mutex);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
-- 
2.4.3
