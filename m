Return-Path: <SRS0=Nfwt=NH=usp.br=matheus.bernardino@kernel.org>
From: Matheus Tavares <matheus.bernardino@usp.br>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	kernel-usp@googlegroups.com
Subject: [PATCH v2 3/6] staging:iio:ad2s90: Remove always overwritten assignment
Date: Fri, 26 Oct 2018 23:00:02 -0300
Message-Id: <20181027020005.3140-4-matheus.bernardino@usp.br>
In-Reply-To: <20181027020005.3140-1-matheus.bernardino@usp.br>
References: <20181027020005.3140-1-matheus.bernardino@usp.br>
List-ID: <linux-iio@vger.kernel.org>

This patch removes an initial assignment to the variable ret at probe,
that was always overwritten.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 drivers/staging/iio/resolver/ad2s90.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index d6a42e3f1bd8..c20d37dc065a 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -64,7 +64,7 @@ static int ad2s90_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct ad2s90_state *st;
-	int ret = 0;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
-- 
2.18.0
