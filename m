Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	Denis CIOCCA <denis.ciocca@st.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 01/10] iio: st_sensors: print error when failing to get IRQ
Date: Thu, 30 Apr 2015 15:15:46 +0200
Message-Id: <1430399755-26475-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Print a proper error message if we're missing the trigger
IRQ.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/common/st_sensors/st_sensors_trigger.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index 8d8ca6f1e16a..3e907040c2c7 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -37,8 +37,10 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 			IRQF_TRIGGER_RISING,
 			sdata->trig->name,
 			sdata->trig);
-	if (err)
+	if (err) {
+		dev_err(&indio_dev->dev, "failed to request trigger IRQ.\n");
 		goto request_irq_error;
+	}
 
 	iio_trigger_set_drvdata(sdata->trig, indio_dev);
 	sdata->trig->ops = trigger_ops;
-- 
1.9.3
