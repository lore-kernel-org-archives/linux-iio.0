Return-Path: <srinivas.pandruvada@intel.com>
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: "lars@metafoo.de" <lars@metafoo.de>
Subject: RE: [PATCH] staging:iio: hid-sensors Use iio_push_to_buffer
Date: Thu, 6 Sep 2012 22:17:30 +0000
Message-ID: <4FA419E87744DF4DAECD5BCE1214B7A9193AF658@ORSMSX104.amr.corp.intel.com>
References: <1346966403-14517-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1346966403-14517-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Tested and works for me. You can add my ACK.

-----Original Message-----
From: J.I. Cameron [mailto:jic23@hermes.cam.ac.uk] On Behalf Of Jonathan Ca=
meron
Sent: Thursday, September 06, 2012 2:20 PM
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de; Pandruvada, Srinivas; Jonathan Cameron
Subject: [PATCH] staging:iio: hid-sensors Use iio_push_to_buffer

Consistently use iio_push_to_buffer instead of manually calling the buffers=
 store_to callback.

These crossed with Lars-Peter's patch set doing every other case.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/accel/hid-sensor-accel-3d.c       | 2 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c         | 2 +-
 drivers/iio/light/hid-sensor-als.c            | 2 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hi=
d-sensor-accel-3d.c
index 33aa97c..c593eb23 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -212,7 +212,7 @@ static void hid_sensor_push_data(struct iio_dev *indio_=
dev, u8 *data, int len)
 				datum_sz);
 		return;
 	}
-	buffer->access->store_to(buffer, (u8 *)data, timestamp);
+	iio_push_to_buffer(buffer, (u8 *)data, timestamp);
 }
=20
 /* Callback handler to send event after all samples are received and captu=
red */ diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyr=
o/hid-sensor-gyro-3d.c
index 50ec09b..94a4740 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -212,7 +212,7 @@ static void hid_sensor_push_data(struct iio_dev *indio_=
dev, u8 *data, int len)
 				datum_sz);
 		return;
 	}
-	buffer->access->store_to(buffer, (u8 *)data, timestamp);
+	iio_push_to_buffer(buffer, (u8 *)data, timestamp);
 }
=20
 /* Callback handler to send event after all samples are received and captu=
red */ diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/=
hid-sensor-als.c
index 2cff7d5..b3c8e91 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -191,7 +191,7 @@ static void hid_sensor_push_data(struct iio_dev *indio_=
dev, u8 *data, int len)
 				datum_sz);
 		return;
 	}
-	buffer->access->store_to(buffer, (u8 *)data, timestamp);
+	iio_push_to_buffer(buffer, (u8 *)data, timestamp);
 }
=20
 /* Callback handler to send event after all samples are received and captu=
red */ diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers=
/iio/magnetometer/hid-sensor-magn-3d.c
index 07591f4..397704e 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -213,7 +213,7 @@ static void hid_sensor_push_data(struct iio_dev *indio_=
dev, u8 *data, int len)
 				datum_sz);
 		return;
 	}
-	buffer->access->store_to(buffer, (u8 *)data, timestamp);
+	iio_push_to_buffer(buffer, (u8 *)data, timestamp);
 }
=20
 /* Callback handler to send event after all samples are received and captu=
red */
--
1.7.11.4
