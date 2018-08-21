Return-Path: <SRS0=0k+x=LE=gmail.com=marcus.folkesson@kernel.org>
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] MAINTAINERS: add entry for ltc1660 DAC driver
Date: Tue, 21 Aug 2018 21:31:26 +0200
Message-Id: <20180821193126.15733-3-marcus.folkesson@gmail.com>
In-Reply-To: <20180821193126.15733-1-marcus.folkesson@gmail.com>
References: <20180821193126.15733-1-marcus.folkesson@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Add entry for ltc1660 DAC driver and add myself as
maintainer of this driver.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v2:
    	- rename enumerated files, ltc166x* -> ltc1660*

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9276da915d9d..3db1edaf68bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8363,6 +8363,13 @@ L:	linux-scsi@vger.kernel.org
 S:	Maintained
 F:	drivers/scsi/sym53c8xx_2/
 
+LTC1660 DAC DRIVER
+M:	Marcus Folkesson <marcus.folkesson@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/dac/ltc1660.txt
+F:	drivers/iio/dac/ltc1660.c
+
 LTC4261 HARDWARE MONITOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-hwmon@vger.kernel.org
-- 
2.11.0.rc2
