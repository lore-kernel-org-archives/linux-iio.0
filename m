Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51773 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752765AbdJLMgi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Oct 2017 08:36:38 -0400
From: Maciej Purski <m.purski@samsung.com>
To: devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v2 3/4] dt-bindings: hwmon: Add
 ti-max-expected-current-microamp property to ina2xx
Date: Thu, 12 Oct 2017 14:36:04 +0200
Message-id: <1507811765-31005-4-git-send-email-m.purski@samsung.com>
In-reply-to: <1507811765-31005-1-git-send-email-m.purski@samsung.com>
References: <1507811765-31005-1-git-send-email-m.purski@samsung.com>
        <CGME20171012123635eucas1p1ff9a982db9d541cd0475d44d114ff92a@eucas1p1.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add optional max expected current property which allows calibrating
the ina sensor in order to achieve requested measure scale. Document
the changes in Documentation/hwmon/ina2xx.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 Documentation/devicetree/bindings/hwmon/ina2xx.txt | 4 +++-
 Documentation/hwmon/ina2xx                         | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ina2xx.txt b/Documentation/devicetree/bindings/hwmon/ina2xx.txt
index 02af0d9..49ef0be 100644
--- a/Documentation/devicetree/bindings/hwmon/ina2xx.txt
+++ b/Documentation/devicetree/bindings/hwmon/ina2xx.txt
@@ -14,11 +14,13 @@ Optional properties:
 
 - shunt-resistor
 	Shunt resistor value in micro-Ohm
-
+- ti-max-expected-current-microamp
+	Max expected current value in mA
 Example:
 
 ina220@44 {
 	compatible = "ti,ina220";
 	reg = <0x44>;
 	shunt-resistor = <1000>;
+	ti-max-expected-current-microamp = <3000>;
 };
diff --git a/Documentation/hwmon/ina2xx b/Documentation/hwmon/ina2xx
index cfd31d9..30620e8 100644
--- a/Documentation/hwmon/ina2xx
+++ b/Documentation/hwmon/ina2xx
@@ -55,6 +55,9 @@ The shunt value in micro-ohms can be set via platform data or device tree at
 compile-time or via the shunt_resistor attribute in sysfs at run-time. Please
 refer to the Documentation/devicetree/bindings/i2c/ina2xx.txt for bindings
 if the device tree is used.
+The max expected current value in miliamp can be set via platform data
+or device tree at compile-time or via currX_max attribute in sysfs
+at run-time.
 
 Additionally ina226 supports update_interval attribute as described in
 Documentation/hwmon/sysfs-interface. Internally the interval is the sum of
-- 
2.7.4

