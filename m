Return-Path: <SRS0=HeX8=JJ=it-klinger.de=ak@kernel.org>
Date: Sat, 23 Jun 2018 20:55:18 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	robh+dt@kernel.org, mark.rutland@arm.com, mchehab@kernel.org,
	davem@davemloft.net, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, linus.walleij@linaro.org,
	rdunlap@infradead.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] iio: hx711: add maintainer for driver
Message-ID: <20180623185518.GA17864@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

add a maintainer for driver hx711

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b65225d443a..cfb8a08777ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2535,6 +2535,13 @@ S:	Maintained
 F:	drivers/auxdisplay/
 F:	include/linux/cfag12864b.h
 
+AVIA HX711 ANALOG DIGITAL CONVERTER IIO DRIVER
+M:	Andreas Klinger <ak@it-klinger.de>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
+F:	drivers/iio/adc/hx711.c
+
 AX.25 NETWORK LAYER
 M:	Ralf Baechle <ralf@linux-mips.org>
 L:	linux-hams@vger.kernel.org
-- 
2.1.4
