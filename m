Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:37149 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753080AbeDMQjB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2018 12:39:01 -0400
Received: by mail-qk0-f193.google.com with SMTP id w6so9720843qkb.4
        for <linux-iio@vger.kernel.org>; Fri, 13 Apr 2018 09:39:00 -0700 (PDT)
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
Subject: [PATCH v2 12/14] staging: iio: ad7746: Add ABI documentation
Date: Fri, 13 Apr 2018 13:36:49 -0300
Message-Id: <1523637411-8531-13-git-send-email-hernan@vanguardiasur.com.ar>
In-Reply-To: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The use cases for this driver don't comply with the current ABI. The
ad7746 and ad7152 need an external capacitance or voltage reference to
automatically calibrate themselves which is not the normal use case of
the calibscale and calibbias ABIs, a new ABI was needed.

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 Documentation/ABI/testing/sysfs-bus-iio-ad7746 | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-ad7746

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-ad7746 b/Documentation/ABI/testing/sysfs-bus-iio-ad7746
new file mode 100644
index 0000000..96a41b7
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-ad7746
@@ -0,0 +1,17 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceX_calibscale_calibration
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage0_calibscale_calibration
+KernelVersion:	4.17.0
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Enter gain calibration mode, in which a full-scale
+		{capacitance, voltage reference} must be connected to the
+		{capacitance, voltage} input beforehand to automatically
+		calibrate the device.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceX_calibbias_calibration
+KernelVersion:	4.17.0
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Enter offset calibration mode, in which a zero-scale
+		capacitance must be connected to the capacitance input
+		beforehand to automatically calibrate the device.
-- 
2.7.4

