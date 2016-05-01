Return-Path: <vilhelm.gray@gmail.com>
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v2 04/10] iio: stx104: Add X86 dependency to STX104 Kconfig option
Date: Sun,  1 May 2016 18:43:54 -0400
Message-Id: <c06b0b7a5f4ab67e6eba3a9f4451566ee747d3bd.1462141338.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1462141338.git.vilhelm.gray@gmail.com>
References: <cover.1462141338.git.vilhelm.gray@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The Apex Embedded Systems STX104 DAC driver expects the STX104 device to
be I/O port-mapped addressable on an X86 platform. This patch adds an
explicit X86 dependency to the STX104 configuration option to prevent
building on non-X86 architectures.

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/iio/dac/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index a995139..6abcfb8 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -210,7 +210,7 @@ config MCP4922
 
 config STX104
 	tristate "Apex Embedded Systems STX104 DAC driver"
-	depends on ISA
+	depends on X86 && ISA
 	help
 	  Say yes here to build support for the 2-channel DAC on the Apex
 	  Embedded Systems STX104 integrated analog PC/104 card. The base port
-- 
2.7.3
