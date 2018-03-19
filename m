Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr40123.outbound.protection.outlook.com ([40.107.4.123]:22145
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967002AbeCSRDE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 19 Mar 2018 13:03:04 -0400
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/3] iio: rename the multiplexer category to wrapper
Date: Mon, 19 Mar 2018 18:02:44 +0100
Message-Id: <20180319170246.26830-2-peda@axentia.se>
In-Reply-To: <20180319170246.26830-1-peda@axentia.se>
References: <20180319170246.26830-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Paves the way for other wrappers.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../bindings/iio/{multiplexer => wrapper}/io-channel-mux.txt          | 0
 MAINTAINERS                                                           | 4 ++--
 drivers/iio/Kconfig                                                   | 2 +-
 drivers/iio/Makefile                                                  | 2 +-
 drivers/iio/{multiplexer => wrapper}/Kconfig                          | 4 ++--
 drivers/iio/{multiplexer => wrapper}/Makefile                         | 2 +-
 drivers/iio/{multiplexer => wrapper}/iio-mux.c                        | 0
 7 files changed, 7 insertions(+), 7 deletions(-)
 rename Documentation/devicetree/bindings/iio/{multiplexer => wrapper}/io-channel-mux.txt (100%)
 rename drivers/iio/{multiplexer => wrapper}/Kconfig (88%)
 rename drivers/iio/{multiplexer => wrapper}/Makefile (67%)
 rename drivers/iio/{multiplexer => wrapper}/iio-mux.c (100%)

diff --git a/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt b/Documentation/devicetree/bindings/iio/wrapper/io-channel-mux.txt
similarity index 100%
rename from Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
rename to Documentation/devicetree/bindings/iio/wrapper/io-channel-mux.txt
diff --git a/MAINTAINERS b/MAINTAINERS
index 3bdc260e36b7..96e5503bfb60 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6865,8 +6865,8 @@ IIO MULTIPLEXER
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
-F:	drivers/iio/multiplexer/iio-mux.c
+F:	Documentation/devicetree/bindings/iio/wrapper/io-channel-mux.txt
+F:	drivers/iio/wrapper/iio-mux.c
 
 IIO SUBSYSTEM AND DRIVERS
 M:	Jonathan Cameron <jic23@kernel.org>
diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index b3c8c6ef0dff..c4d25746c585 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -83,7 +83,6 @@ source "drivers/iio/humidity/Kconfig"
 source "drivers/iio/imu/Kconfig"
 source "drivers/iio/light/Kconfig"
 source "drivers/iio/magnetometer/Kconfig"
-source "drivers/iio/multiplexer/Kconfig"
 source "drivers/iio/orientation/Kconfig"
 if IIO_TRIGGER
    source "drivers/iio/trigger/Kconfig"
@@ -93,5 +92,6 @@ source "drivers/iio/potentiostat/Kconfig"
 source "drivers/iio/pressure/Kconfig"
 source "drivers/iio/proximity/Kconfig"
 source "drivers/iio/temperature/Kconfig"
+source "drivers/iio/wrapper/Kconfig"
 
 endif # IIO
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index b16b2e9ddc40..dc5486f6c148 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -29,7 +29,6 @@ obj-y += humidity/
 obj-y += imu/
 obj-y += light/
 obj-y += magnetometer/
-obj-y += multiplexer/
 obj-y += orientation/
 obj-y += potentiometer/
 obj-y += potentiostat/
@@ -37,3 +36,4 @@ obj-y += pressure/
 obj-y += proximity/
 obj-y += temperature/
 obj-y += trigger/
+obj-y += wrapper/
diff --git a/drivers/iio/multiplexer/Kconfig b/drivers/iio/wrapper/Kconfig
similarity index 88%
rename from drivers/iio/multiplexer/Kconfig
rename to drivers/iio/wrapper/Kconfig
index 735a7b0e6fd8..f27de347c9b3 100644
--- a/drivers/iio/multiplexer/Kconfig
+++ b/drivers/iio/wrapper/Kconfig
@@ -1,9 +1,9 @@
 #
-# Multiplexer drivers
+# Wrapper drivers
 #
 # When adding new entries keep the list in alphabetical order
 
-menu "Multiplexers"
+menu "Wrapers"
 
 config IIO_MUX
 	tristate "IIO multiplexer driver"
diff --git a/drivers/iio/multiplexer/Makefile b/drivers/iio/wrapper/Makefile
similarity index 67%
rename from drivers/iio/multiplexer/Makefile
rename to drivers/iio/wrapper/Makefile
index 68be3c4abd07..53a7b78734e3 100644
--- a/drivers/iio/multiplexer/Makefile
+++ b/drivers/iio/wrapper/Makefile
@@ -1,5 +1,5 @@
 #
-# Makefile for industrial I/O multiplexer drivers
+# Makefile for industrial I/O wrapper drivers
 #
 
 # When adding new entries keep the list in alphabetical order
diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/wrapper/iio-mux.c
similarity index 100%
rename from drivers/iio/multiplexer/iio-mux.c
rename to drivers/iio/wrapper/iio-mux.c
-- 
2.11.0

