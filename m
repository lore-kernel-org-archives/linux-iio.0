Return-Path: <SRS0=D05P=6T=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald-Stadler <pmeerw@pmeerw.net>, =?UTF-8?q?Stefan=20Br=C3=BCns?=
	<stefan.bruens@rwth-aachen.de>
Subject: [PATCH 2/2] iio: Documentation: Add ina2xx shunt_resistor attribute documentation
Date: Mon, 17 Jul 2017 01:34:10 +0200
In-Reply-To: <20170716233410.22880-1-stefan.bruens@rwth-aachen.de>
References: <20170716233410.22880-1-stefan.bruens@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Message-ID: <2351a045a0564f5bb2af6c652d1fa5e3@rwthex-w2-b.rwth-ad.de>
List-ID: <linux-iio@vger.kernel.org>

The ina2xx driver appeared in the Linux kernel version 4.5, but provided
no documentation. Contrary to other uses of resistance in IIO, ina2xx uses
microohms instead of ohms in the sysfs attribute.

Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
---
 Documentation/ABI/testing/sysfs-bus-iio-adc-ina2xx-adc | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ina2xx-adc

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ina2xx-adc b/Documentation/ABI/testing/sysfs-bus-iio-adc-ina2xx-adc
new file mode 100644
index 000000000000..9525098f6822
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ina2xx-adc
@@ -0,0 +1,7 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_shunt_resistor
+Date:		December 2015
+KernelVersion:	4.5
+Contact:	linux-iio@vger.kernel.org
+Description: 	The value of the shunt resistor connected to the V_IN+ and V_IN-
+		inputs, used to compute the current flowing through the shunt and
+		the corresponding power. In microohms.
-- 
2.13.2
