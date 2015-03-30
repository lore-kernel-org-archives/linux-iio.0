Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 132.79-246-81.adsl-static.isp.belgacom.be ([81.246.79.132]:45386
	"EHLO viper.mind.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908AbbC3IfR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2015 04:35:17 -0400
From: =?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?=
	<vianney.leclement@essensium.com>
To: linux-iio@vger.kernel.org
Cc: =?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?=
	<vianney.leclement@essensium.com>,
	"Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Subject: [PATCH v3 1/5] iio: core: Introduce IIO_CHAN_INFO_CALIBEMISSIVITY
Date: Mon, 30 Mar 2015 10:34:58 +0200
Message-Id: <1427704502-22347-2-git-send-email-vianney.leclement@essensium.com>
In-Reply-To: <1427704502-22347-1-git-send-email-vianney.leclement@essensium.com>
References: <1427704502-22347-1-git-send-email-vianney.leclement@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Contact-less IR temperature sensors measure the temperature of an object
by using its thermal radiation.  Surfaces with different emissivity
ratios emit different amounts of energy at the same temperature.

IIO_CHAN_INFO_CALIBEMISSIVITY allows the user to inform the sensor of the
emissivity of the object in front of it, in order to effectively measure
its temperature.

A device providing such setting is Melexis's MLX90614:
http://melexis.com/Assets/IR-sensor-thermometer-MLX90614-Datasheet-5152.aspx.

Signed-off-by: Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
Cc: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>

---

v3: rename EMISSIVITY to CALIBEMISSIVITY
v2: new patch
---
 Documentation/ABI/testing/sysfs-bus-iio | 11 +++++++++++
 drivers/iio/industrialio-core.c         |  1 +
 include/linux/iio/iio.h                 |  1 +
 3 files changed, 13 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 103dd9b..cf67f63 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1364,3 +1364,14 @@ Description:
 		hwfifo_watermak_min but not equal to any of the values in this
 		list, the driver will chose an appropriate value for the
 		hardware fifo watermark level.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_temp_calibemissivity
+What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_calibemissivity
+What:		/sys/bus/iio/devices/iio:deviceX/in_temp_object_calibemissivity
+What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_object_calibemissivity
+KernelVersion:	4.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The emissivity ratio of the surface in the field of view of the
+		contactless temperature sensor.  Emissivity varies from 0 to 1,
+		with 1 being the emissivity of a black body.
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index aaba9d3..e3730be 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -128,6 +128,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_CALIBWEIGHT] = "calibweight",
 	[IIO_CHAN_INFO_DEBOUNCE_COUNT] = "debounce_count",
 	[IIO_CHAN_INFO_DEBOUNCE_TIME] = "debounce_time",
+	[IIO_CHAN_INFO_CALIBEMISSIVITY] = "calibemissivity",
 };
 
 /**
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index d86b753..b1e46ae 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -43,6 +43,7 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_CALIBWEIGHT,
 	IIO_CHAN_INFO_DEBOUNCE_COUNT,
 	IIO_CHAN_INFO_DEBOUNCE_TIME,
+	IIO_CHAN_INFO_CALIBEMISSIVITY,
 };
 
 enum iio_shared_by {
-- 
2.3.4

