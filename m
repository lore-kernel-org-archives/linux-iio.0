Return-Path: <SRS0=D05P=6T=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald-Stadler <pmeerw@pmeerw.net>, =?UTF-8?q?Stefan=20Br=C3=BCns?=
	<stefan.bruens@rwth-aachen.de>
Subject: [PATCH 1/2] iio: Documentation: Add missing documentation for power attribute
Date: Mon, 17 Jul 2017 01:34:09 +0200
In-Reply-To: <20170716233410.22880-1-stefan.bruens@rwth-aachen.de>
References: <20170716233410.22880-1-stefan.bruens@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Message-ID: <819f6f2699b34549becf3f7d8f565c19@rwthex-w2-b.rwth-ad.de>
List-ID: <linux-iio@vger.kernel.org>

Commit c43a102e67db ("iio: ina2xx: add support for TI INA2xx Power Monitors")
introduced the in_powerY_raw attribute, but omitted the corresponding
documentation.

The description is correct for the INA2xx and the MAX9611 IIO drivers.

Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
---
 Documentation/ABI/testing/sysfs-bus-iio | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 2db2cdf42d54..7eead5f97e02 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -119,6 +119,15 @@ Description:
 		unique to allow association with event codes. Units after
 		application of scale and offset are milliamps.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_raw
+KernelVersion:	4.5
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw (unscaled no bias removal etc.) power measurement from
+		channel Y. The number must always be specified and
+		unique to allow association with event codes. Units after
+		application of scale and offset are milliwatts.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceY_raw
 KernelVersion:	3.2
 Contact:	linux-iio@vger.kernel.org
-- 
2.13.2
