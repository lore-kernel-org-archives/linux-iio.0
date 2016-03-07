Return-Path: <ludovic.desroches@atmel.com>
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <nicolas.ferre@atmel.com>, Ludovic
 Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH v2 1/2] iio: core: introduce IIO_CHAN_INFO_SIGNED
Date: Mon, 7 Mar 2016 15:29:56 +0100
Message-ID: <1457360997-29179-2-git-send-email-ludovic.desroches@atmel.com>
In-Reply-To: <1457360997-29179-1-git-send-email-ludovic.desroches@atmel.com>
References: <1457360997-29179-1-git-send-email-ludovic.desroches@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

The same channel can be used to perform a signed or an unsigned
conversion. Add a new infomask element to be able to select the type of
conversion wanted: a raw one or a signed raw one.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 10 ++++++++++
 drivers/iio/industrialio-core.c         |  1 +
 include/linux/iio/iio.h                 |  1 +
 3 files changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 3c66248..161733c 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1501,3 +1501,13 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Raw (unscaled no offset etc.) pH reading of a substance as a negative
 		base-10 logarithm of hydrodium ions in a litre of water.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_signed
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_signed
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_signed
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_signed
+KernelVersion:	4.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Signed (unscaled no bias removal etc.) voltage measurement from
+		channel Y.
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 70cb7eb..fb2ca27 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -147,6 +147,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_DEBOUNCE_TIME] = "debounce_time",
 	[IIO_CHAN_INFO_CALIBEMISSIVITY] = "calibemissivity",
 	[IIO_CHAN_INFO_OVERSAMPLING_RATIO] = "oversampling_ratio",
+	[IIO_CHAN_INFO_SIGNED] = "signed",
 };
 
 /**
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index b2b1677..6f5eb24 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -46,6 +46,7 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_DEBOUNCE_TIME,
 	IIO_CHAN_INFO_CALIBEMISSIVITY,
 	IIO_CHAN_INFO_OVERSAMPLING_RATIO,
+	IIO_CHAN_INFO_SIGNED,
 };
 
 enum iio_shared_by {
-- 
2.5.0
