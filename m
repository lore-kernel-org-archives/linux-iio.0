Return-Path: <SRS0=fQkM=K2=gmail.com=marcus.folkesson@kernel.org>
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
Subject: [PATCH 3/3] MAINTAINERS: add entry for ltc166x DAC driver
Date: Sat, 11 Aug 2018 22:02:26 +0200
Message-Id: <20180811200226.28776-3-marcus.folkesson@gmail.com>
In-Reply-To: <20180811200226.28776-1-marcus.folkesson@gmail.com>
References: <20180811200226.28776-1-marcus.folkesson@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Add entry for ltc166x DAC driver and add myself as
maintainer of this driver.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9276da915d9d..2dc4c773fb2e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8363,6 +8363,13 @@ L:	linux-scsi@vger.kernel.org
 S:	Maintained
 F:	drivers/scsi/sym53c8xx_2/
 
+LTC166X DAC DRIVER
+M:	Marcus Folkesson <marcus.folkesson@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/dac/ltc166x.txt
+F:	drivers/iio/dac/ltc166x.c
+
 LTC4261 HARDWARE MONITOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-hwmon@vger.kernel.org
-- 
2.11.0.rc2
