Return-Path: <roberta.dobrescu@gmail.com>
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: linux-iio@vger.kernel.org
Cc: daniel.baluta@intel.com,
	octavian.purdila@intel.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	vlad.dogaru@intel.com,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH] iio: accel: mma9551: Check gpiod_to_irq return value
Date: Mon,  2 Mar 2015 12:39:12 +0200
Message-Id: <1425292752-7768-1-git-send-email-roberta.dobrescu@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The return value of gpiod_to_irq should be checked before giving
it to devm_request_threaded_irq in order to not pass an error
code in case it fails.

Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
Reviewed-by: Vlad Dogaru <vlad.dogaru@intel.com>
---
gpiod_to_irq also appears in the following drivers:
	* drivers/iio/accel/bmc150-accel.c
	* drivers/iio/accel/kxcjk-1013.c
	* drivers/iio/accel/mma9553.c
	* drivers/iio/gyro/bmg160.c
	* drivers/iio/imu/kmx61.c
	* drivers/iio/proximity/sx9500.c,

something like this:

<code>
	ret = gpiod_to_irq(gpio);

	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);

	return ret;
</code>

The return value of the functions containing the above code is checked,
so the only problem would be that the debug message would contain a wrong
value for irq in case gpiod_to_irq fails. So it doesn't affects much.

 drivers/iio/accel/mma9551.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 46c3835..b6f3041 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -428,7 +428,11 @@ static int mma9551_gpio_probe(struct iio_dev *indio_dev)
 		if (ret)
 			return ret;
 
-		data->irqs[i] = gpiod_to_irq(gpio);
+		ret = gpiod_to_irq(gpio);
+		if (ret < 0)
+			return ret;
+
+		data->irqs[i] = ret;
 		ret = devm_request_threaded_irq(dev, data->irqs[i],
 				NULL, mma9551_event_handler,
 				IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-- 
1.9.1
