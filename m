Return-Path: <SRS0=zKlK=HL=gmail.com=davidjulianveenstra@kernel.org>
Date: Mon, 23 Apr 2018 00:02:51 +0200
From: David Veenstra <davidjulianveenstra@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net
Cc: robh+dt@kernel.org, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	linux-iio@vger.kernel.org, daniel.baluta@nxp.com,
	devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: [PATCH v3 1/9] staging: iio: ad2s1200: Add kernel docs to driver
 state
Message-ID: <b880e7be5b1b70f0805db41dcd41571a50785fab.1524432236.git.davidjulianveenstra@gmail.com>
References: <cover.1524432236.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1524432236.git.davidjulianveenstra@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Add missing kernel docs to the ad2s1200 driver state.

Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
---
Changes in v3:
 - Added more explanation to mutex lock.

 drivers/staging/iio/resolver/ad2s1200.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index 357fe3c382b3..17d65cb437fd 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -33,6 +33,15 @@
 /* clock period in nano second */
 #define AD2S1200_TSCLK	(1000000000 / AD2S1200_HZ)
 
+/**
+ * struct ad2s1200_state - driver instance specific data.
+ * @lock:	protects both the GPIO pins and the rx buffer, to prevent
+ *		concurrent spi transactions.
+ * @sdev:	spi device.
+ * @sample:	GPIO pin SAMPLE.
+ * @rdvel:	GPIO pin RDVEL.
+ * @rx:		buffer for spi transfers.
+ */
 struct ad2s1200_state {
 	struct mutex lock;
 	struct spi_device *sdev;
-- 
2.16.2
