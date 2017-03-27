Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:40353 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753428AbdC0POa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Mar 2017 11:14:30 -0400
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: geert@linux-m68k.org, wsa+renesas@sang-engineering.com,
        magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 2/4] iio: Documentation: Add max9611 sysfs documentation
Date: Mon, 27 Mar 2017 17:12:56 +0200
Message-Id: <1490627578-15938-3-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1490627578-15938-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1490627578-15938-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add documentation for max9611 driver.
Document attributes describing value of shunt resistor installed between
RS+ and RS- voltage sense inputs.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 Documentation/ABI/testing/sysfs-bus-iio-adc-max9611 | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-max9611

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-max9611 b/Documentation/ABI/testing/sysfs-bus-iio-adc-max9611
new file mode 100644
index 0000000..5020d00
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-max9611
@@ -0,0 +1,17 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_power_shunt_resistor
+Date:		March 2017
+KernelVersion:	4.12
+Contact:	linux-iio@vger.kernel.org
+Description: 	The value of the shunt resistor used to compute power drain on
+                common input voltage pin (RS+). In micro Ohms.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_current_shunt_resistor
+Date:		March 2017
+KernelVersion:	4.12
+Contact:	linux-iio@vger.kernel.org
+Description: 	The value of the shunt resistor used to compute current flowing
+                between RS+ and RS- voltage sense inputs. In micro Ohms.
+
+These attributes describe a single physical component, exposed as two distinct
+attributes as it is used to calculate two different values: power load and
+current flowing between RS+ and RS- inputs.
-- 
2.7.4

