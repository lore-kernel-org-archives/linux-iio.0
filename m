Return-Path: <robert.dolca@intel.com>
From: Robert Dolca <robert.dolca@intel.com>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Robert Dolca <robert.dolca@intel.com>,
	Denis CIOCCA <denis.ciocca@st.com>
Subject: [PATCH RFC 3/3] iio: Use with iio_trigger_register_with_dev to register trigger
Date: Thu, 16 Apr 2015 12:01:08 +0300
Message-Id: <1429174868-11953-4-git-send-email-robert.dolca@intel.com>
In-Reply-To: <1429174868-11953-1-git-send-email-robert.dolca@intel.com>
References: <1429174868-11953-1-git-send-email-robert.dolca@intel.com>
List-ID: <linux-iio@vger.kernel.org>

The trigger registered by the driver has the main purpose to be used
with this driver so it should be linked to the IIO device. This
way the user space applications can find the connection between them.

Signed-off-by: Robert Dolca <robert.dolca@intel.com>
---
 drivers/iio/common/st_sensors/st_sensors_trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index 8d8ca6f..6681a7d 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -44,7 +44,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 	sdata->trig->ops = trigger_ops;
 	sdata->trig->dev.parent = sdata->dev;
 
-	err = iio_trigger_register(sdata->trig);
+	err = iio_trigger_register_with_dev(indio_dev, sdata->trig);
 	if (err < 0) {
 		dev_err(&indio_dev->dev, "failed to register iio trigger.\n");
 		goto iio_trigger_register_error;
-- 
1.9.1
