Return-Path: <SRS0=CNSD=KR=gmail.com=marcus.folkesson@kernel.org>
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] MAINTAINERS: Add entry for mcp3911 ADC driver
Date: Thu,  2 Aug 2018 21:15:54 +0200
Message-Id: <20180802191554.20176-3-marcus.folkesson@gmail.com>
In-Reply-To: <20180802191554.20176-1-marcus.folkesson@gmail.com>
References: <20180802191554.20176-1-marcus.folkesson@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Add an entry for mcp3911 ADC driver and add myself and
Kent Gustavsson as maintainers of this driver.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Signed-off-by: Kent Gustavsson <kent@minoris.se>
---

Notes:
    v3:
    	- no changes
    v2:
    	- no changes

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 79bb02ff812f..9276da915d9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9271,6 +9271,14 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/microchip/lan743x_*
 
+MICROCHIP / ATMEL MCP3911 ADC DRIVER
+M:	Marcus Folkesson <marcus.folkesson@gmail.com>
+M:	Kent Gustavsson <kent@minoris.se>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	drivers/iio/adc/mcp3911.c
+F:	Documentation/devicetree/bindings/iio/adc/mcp3911.txt
+
 MICROCHIP USB251XB DRIVER
 M:	Richard Leitner <richard.leitner@skidata.com>
 L:	linux-usb@vger.kernel.org
-- 
2.11.0.rc2
