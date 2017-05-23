Return-Path: <SRS0=T1uy=45=cogentembedded.com=nikita.yoush@kernel.org>
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Sanchayan Maity <maitysanchayan@gmail.com>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Matt Ranostay <mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Healy <Chris.Healy@zii.aero>,
	Jeff White <Jeff.White@zii.aero>,
	Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] iio: hi8435: fix race between event enable and event generation
Date: Tue, 23 May 2017 11:07:29 +0300
Message-Id: <20170523080729.20459-1-nikita.yoush@cogentembedded.com>
List-ID: <linux-iio@vger.kernel.org>

Add locking to avoid interference between reading/processing current
sence in event enable and event generation paths.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/iio/adc/hi8435.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
index ab59969b7c49..28fc699f00f6 100644
--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -144,6 +144,8 @@ static int hi8435_write_event_config(struct iio_dev *idev,
 	int ret;
 	u32 tmp;
 
+	mutex_lock(&priv->lock);
+
 	if (state) {
 		ret = hi8435_readl(priv, HI8435_SO31_0_REG, &tmp);
 		if (ret < 0)
@@ -157,6 +159,8 @@ static int hi8435_write_event_config(struct iio_dev *idev,
 	} else
 		priv->event_scan_mask &= ~BIT(chan->channel);
 
+	mutex_unlock(&priv->lock);
+
 	return 0;
 }
 
@@ -449,12 +453,16 @@ static irqreturn_t hi8435_trigger_handler(int irq, void *private)
 	u32 val;
 	int ret;
 
+	mutex_lock(&priv->lock);
+
 	ret = hi8435_readl(priv, HI8435_SO31_0_REG, &val);
 	if (ret < 0)
 		goto err_read;
 
 	hi8435_iio_push_event(idev, val);
 
+	mutex_unlock(&priv->lock);
+
 err_read:
 	iio_trigger_notify_done(idev->trig);
 
-- 
2.11.0
