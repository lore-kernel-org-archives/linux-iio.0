Return-Path: <SRS0=aC7W=OD=usp.br=matheus.bernardino@kernel.org>
From: Matheus Tavares <matheus.bernardino@usp.br>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	kernel-usp@googlegroups.com,
	victorcolombo@gmail.com
Subject: [PATCH v3 6/7] staging:iio:ad2s90: Add comment to device state mutex
Date: Fri, 23 Nov 2018 22:23:11 -0200
Message-Id: <20181124002312.6923-7-matheus.bernardino@usp.br>
In-Reply-To: <20181124002312.6923-1-matheus.bernardino@usp.br>
References: <20181124002312.6923-1-matheus.bernardino@usp.br>
List-ID: <linux-iio@vger.kernel.org>

From: Victor Colombo <victorcolombo@gmail.com>

Fix the checkpatch.pl issue:
"CHECK: struct mutex definition without comment".

Signed-off-by: Victor Colombo <victorcolombo@gmail.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
Changes in v3:
 - none

Changes in v2:
 - Patch added in v2

 drivers/staging/iio/resolver/ad2s90.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 678351dabe6b..a41f5cb10da5 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -22,7 +22,7 @@
 #define AD2S90_MAX_SPI_FREQ_HZ  830000
 
 struct ad2s90_state {
-	struct mutex lock;
+	struct mutex lock; /* lock to protect rx buffer */
 	struct spi_device *sdev;
 	u8 rx[2] ____cacheline_aligned;
 };
-- 
2.18.0
