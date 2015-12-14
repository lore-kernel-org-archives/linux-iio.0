Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38842 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932140AbbLNLBX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 14 Dec 2015 06:01:23 -0500
Received: by wmpp66 with SMTP id p66so55469496wmp.1
        for <linux-iio@vger.kernel.org>; Mon, 14 Dec 2015 03:01:22 -0800 (PST)
From: Marc Titinger <mtitinger@baylibre.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marc Titinger <mtitinger@baylibre.com>
Subject: [PATCH] iio: ina2xx: add ABI documentation entry sysfs-bus-iio-ina2xx-adc
Date: Mon, 14 Dec 2015 12:01:10 +0100
Message-Id: <1450090870-11452-1-git-send-email-mtitinger@baylibre.com>
In-Reply-To: <566C439B.5080406@kernel.org>
References: <566C439B.5080406@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Documentation for attributes:

 * in_allow_async_readout
 * in_shunt_resistor

Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-ina2xx-adc | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-ina2xx-adc

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-ina2xx-adc b/Documentation/ABI/testing/sysfs-bus-iio-ina2xx-adc
new file mode 100644
index 0000000..8916f7e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-ina2xx-adc
@@ -0,0 +1,24 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_allow_async_readout
+Date:		December 2015
+KernelVersion:	4.4
+Contact:	linux-iio@vger.kernel.org
+Description:
+		By default (value '0'), the capture thread checks for the Conversion
+		Ready Flag to being set prior to committing a new value to the sample
+		buffer. This synchronizes the in-chip conversion rate with the
+		in-driver readout rate at the cost of an additional register read.
+
+		Writing '1' will remove the polling for the Conversion Ready Flags to
+		save the additional i2c transaction, which will improve the bandwidth
+		available for reading data. However, samples can be occasionally skipped
+		or repeated, depending on the beat between the capture and conversion
+		rates.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_shunt_resistor
+Date:		December 2015
+KernelVersion:	4.4
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The value of the shunt resistor may be known only at runtime fom an
+		eeprom content read by a client application. This attribute allows to
+		set its value in ohms.
-- 
1.9.1

