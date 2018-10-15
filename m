Return-Path: <MAILER-DAEMON>
From: Martin Kelly <martin@martingkelly.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Martin Kelly <martin@martingkelly.com>
Subject: [RFC][PATCH] iio:st_magn: enable device after trigger
Date: Sun, 14 Oct 2018 18:53:36 -0700
Message-Id: <20181015015336.21066-1-martin@martingkelly.com>
List-ID: <linux-iio@vger.kernel.org>

From: Martin Kelly <martin@martingkelly.com>

I'd like to get others' opinions on this patch before I submit it. It fixes
an issue I've seen with a driver I'm working on (LSM9DS1 magnetometer
driver, waiting on this before I send a patch). However, I have a few
concerns about the generality of this approach:

(1) Possible data races between st_sensors_set_enable and IRQ handlers,
    since both could run concurrently. Although we can protect this with a
    lock, we'd need to touch each driver, which will be tricky to test.
    Alternatively, we could audit each driver and see if there are any real
    races. The only property touched by st_sensors_set_enable appears to be
    the "enabled" property, which is unlikely to be read/written by any IRQ
    handlers. That said, the fact that the race exists makes me concerned
    about potential mistakes in the future.
(2) If this is a good approach to solve the issue, then we should make the
    same change to the ST accelerometer, gyroscope, and pressure drivers.
    But again, we'd need to re-test every driver, which is tricky.

I'd be happy to hear opinions or suggested alternative approaches. Thanks!

Patch:
--------------------------------------------------------------------------
Currently, we enable the device before we enable the device trigger. At
high frequencies, this can cause interrupts that don't yet have a poll
function associated with them and are thus treated as spurious. At high
frequencies with level interrupts, this can even cause an interrupt storm
of repeated spurious interrupts (~100,000 on my Beagleboard with the
LSM9DS1 magnetometer). If these repeat too much, the interrupt will get
disabled and the device will stop functioning.

To prevent these problems, enable the device prior to enabling the device
trigger, and disable the divec prior to disabling the trigger. This means
there's no window of time during which the device creates interrupts but we
have no trigger to answer them.

Signed-off-by: Martin Kelly <martin@martingkelly.com>
---
 drivers/iio/magnetometer/st_magn_buffer.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
index 0a9e8fadfa9d..37ab30566464 100644
--- a/drivers/iio/magnetometer/st_magn_buffer.c
+++ b/drivers/iio/magnetometer/st_magn_buffer.c
@@ -30,11 +30,6 @@ int st_magn_trig_set_state(struct iio_trigger *trig, bool state)
 	return st_sensors_set_dataready_irq(indio_dev, state);
 }

-static int st_magn_buffer_preenable(struct iio_dev *indio_dev)
-{
-	return st_sensors_set_enable(indio_dev, true);
-}
-
 static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
 {
 	int err;
@@ -50,7 +45,7 @@ static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
 	if (err < 0)
 		goto st_magn_buffer_postenable_error;

-	return err;
+	return st_sensors_set_enable(indio_dev, true);

 st_magn_buffer_postenable_error:
 	kfree(mdata->buffer_data);
@@ -63,11 +58,11 @@ static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
 	int err;
 	struct st_sensor_data *mdata = iio_priv(indio_dev);

-	err = iio_triggered_buffer_predisable(indio_dev);
+	err = st_sensors_set_enable(indio_dev, false);
 	if (err < 0)
 		goto st_magn_buffer_predisable_error;

-	err = st_sensors_set_enable(indio_dev, false);
+	err = iio_triggered_buffer_predisable(indio_dev);

 st_magn_buffer_predisable_error:
 	kfree(mdata->buffer_data);
@@ -75,7 +70,6 @@ static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
 }

 static const struct iio_buffer_setup_ops st_magn_buffer_setup_ops = {
-	.preenable = &st_magn_buffer_preenable,
 	.postenable = &st_magn_buffer_postenable,
 	.predisable = &st_magn_buffer_predisable,
 };
--
2.11.0
