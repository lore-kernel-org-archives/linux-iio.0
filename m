Return-Path: <SRS0=+OQt=GE=arndb.de=arnd@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
Subject: [PATCH 47/47] staging: iio: remove iio-trig-bfin-timer driver
Date: Wed, 14 Mar 2018 16:36:00 +0100
Message-Id: <20180314153603.3127932-48-arnd@arndb.de>
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de>
List-ID: <linux-iio@vger.kernel.org>

The blackfin architecture is getting removed, so the timer trigger
driver is now obsolete. Since this is the last remaining iio trigger
driver in staging, I'm removing the entire directory.

I'm not sure about the other staging iio drivers though: almost
all of them are for Analog Devices devices like this one. They
are likely used along with blackfin SoCs, but could easily be
used on any others as well.

It might be time to consider whether they should be removed, but
it doesn't feel like a decision that I should be making.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS                                       |   1 -
 drivers/staging/iio/Kconfig                       |   1 -
 drivers/staging/iio/Makefile                      |   1 -
 drivers/staging/iio/trigger/Kconfig               |  19 --
 drivers/staging/iio/trigger/Makefile              |   5 -
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c | 292 ----------------------
 drivers/staging/iio/trigger/iio-trig-bfin-timer.h |  25 --
 7 files changed, 344 deletions(-)
 delete mode 100644 drivers/staging/iio/trigger/Kconfig
 delete mode 100644 drivers/staging/iio/trigger/Makefile
 delete mode 100644 drivers/staging/iio/trigger/iio-trig-bfin-timer.c
 delete mode 100644 drivers/staging/iio/trigger/iio-trig-bfin-timer.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6eb7387bb1e9..c85ce0cd5038 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -859,7 +859,6 @@ F:	drivers/iio/*/ad*
 F:	drivers/iio/adc/ltc2497*
 X:	drivers/iio/*/adjd*
 F:	drivers/staging/iio/*/ad*
-F:	drivers/staging/iio/trigger/iio-trig-bfin-timer.c
 
 ANDES ARCHITECTURE
 M:	Greentime Hu <green.hu@gmail.com>
diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index 8abc1ab3c0c7..bd9445956511 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -14,6 +14,5 @@ source "drivers/staging/iio/impedance-analyzer/Kconfig"
 source "drivers/staging/iio/light/Kconfig"
 source "drivers/staging/iio/meter/Kconfig"
 source "drivers/staging/iio/resolver/Kconfig"
-source "drivers/staging/iio/trigger/Kconfig"
 
 endmenu
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 455bffc29649..e99a375c07b9 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -13,4 +13,3 @@ obj-y += impedance-analyzer/
 obj-y += light/
 obj-y += meter/
 obj-y += resolver/
-obj-y += trigger/
diff --git a/drivers/staging/iio/trigger/Kconfig b/drivers/staging/iio/trigger/Kconfig
deleted file mode 100644
index 0b01d24cea51..000000000000
diff --git a/drivers/staging/iio/trigger/Makefile b/drivers/staging/iio/trigger/Makefile
deleted file mode 100644
index 1300a21363db..000000000000
diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
deleted file mode 100644
index 71f11d7472c0..000000000000
diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.h b/drivers/staging/iio/trigger/iio-trig-bfin-timer.h
deleted file mode 100644
index fb05a2a8397c..000000000000
-- 
2.9.0
