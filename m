Return-Path: <SRS0=bf/5=F5=gmail.com=hariprasath.elango@kernel.org>
From: hariprasath.elango@gmail.com
To: lars@metafoo.de
Cc: hariprasath.elango@gmail.com,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: adc: Remove reduntant __func__ from debug print
Date: Wed,  7 Mar 2018 10:40:05 +0530
Message-Id: <20180307051005.13038-1-hariprasath.elango@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

From: HariPrasath Elango <hariprasath.elango@gmail.com>

dev_dbg includes the function name & line number by default when dynamic
debugging is enabled. Hence__func__ is reduntant here and removed.

Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
---
 drivers/staging/iio/meter/ade7758_trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/meter/ade7758_trigger.c b/drivers/staging/iio/meter/ade7758_trigger.c
index 1f0d1a0..da489ae 100644
--- a/drivers/staging/iio/meter/ade7758_trigger.c
+++ b/drivers/staging/iio/meter/ade7758_trigger.c
@@ -34,7 +34,7 @@ static int ade7758_data_rdy_trigger_set_state(struct iio_trigger *trig,
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 
-	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
+	dev_dbg(&indio_dev->dev, "(%d)\n", state);
 	return ade7758_set_irq(&indio_dev->dev, state);
 }
 
-- 
2.10.0.GIT
