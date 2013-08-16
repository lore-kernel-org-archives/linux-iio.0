Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from exprod5og109.obsmtp.com ([64.18.0.188]:46570 "EHLO
	exprod5og109.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194Ab3HPMMb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 16 Aug 2013 08:12:31 -0400
Received: by mail-la0-f50.google.com with SMTP id ek20so1370175lab.23
        for <linux-iio@vger.kernel.org>; Fri, 16 Aug 2013 05:12:29 -0700 (PDT)
From: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
To: devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com,
	swarren@wwwdotorg.org, ian.campbell@citrix.com, rob@landley.net,
	jic23@cam.ac.uk, o.v.kravchenko@globallogic.com,
	denis.ciocca@st.com, srinivas.pandruvada@linux.intel.com,
	lars@metafoo.de
Subject: [PATCH v4 1/2] staging: iio: Documentation sysfs-bus-iio add power_mode
Date: Fri, 16 Aug 2013 15:12:04 +0300
Message-Id: <1376655125-13421-1-git-send-email-o.v.kravchenko@globallogic.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add description about in_accelX_power_mode and
in_accel_power_mode_available.

Signed-off-by: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
---
 Documentation/ABI/testing/sysfs-bus-iio |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index dda81ff..1a333f3 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -792,3 +792,13 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		This attribute is used to read the amount of quadrature error
 		present in the device at a given time.
+
+What:		/sys/.../iio:deviceX/in_accelX_power_mode
+KernelVersion:	3.11
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Specifies the chip power mode.
+		low_noise: reduce noise level from ADC,
+		low_power: enable low current consumption.
+		For a list of available output power modes read
+		in_accel_power_mode_available.
-- 
1.7.9.5

