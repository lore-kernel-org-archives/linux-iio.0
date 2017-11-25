Return-Path: <SRS0=LWwp=CX=wunner.de=lukas@kernel.org>
Message-Id: <af37130bfebe4424156f6f1c86a000d7d2dc3e0d.1511601745.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 25 Nov 2017 10:27:19 +0100
Subject: [PATCH] MAINTAINERS: Add missing IIO ABI entries
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, William Breathitt Gray <vilhelm.gray@gmail.com>, Michael Hennerich <Michael.Hennerich@analog.com>, Andreas Klinger <ak@it-klinger.de>
List-ID: <linux-iio@vger.kernel.org>

Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Andreas Klinger <ak@it-klinger.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 650aa0e0e9d8..0f8e17d99400 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -262,6 +262,7 @@ ACCES 104-QUAD-8 IIO DRIVER
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
 F:	drivers/iio/counter/104-quad-8.c
 
 ACCES PCI-IDIO-16 GPIO DRIVER
@@ -851,6 +852,8 @@ M:	Michael Hennerich <Michael.Hennerich@analog.com>
 W:	http://wiki.analog.com/
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
+F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
+F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
 F:	drivers/iio/*/ad*
 F:	drivers/iio/adc/ltc2497*
 X:	drivers/iio/*/adjd*
@@ -4055,6 +4058,7 @@ DEVANTECH SRF ULTRASONIC RANGER IIO DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-iio-distance-srf08
 F:	drivers/iio/proximity/srf*.c
 
 DEVICE COREDUMP (DEV_COREDUMP)
@@ -6735,6 +6739,8 @@ R:	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
 L:	linux-iio@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
 S:	Maintained
+F:	Documentation/ABI/testing/configfs-iio*
+F:	Documentation/ABI/testing/sysfs-bus-iio*
 F:	Documentation/devicetree/bindings/iio/
 F:	drivers/iio/
 F:	drivers/staging/iio/
-- 
2.11.0
