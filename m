Return-Path: <SRS0=zJOI=G5=wanadoo.fr=christophe.jaillet@kernel.org>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	nfarnesi4@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 2/2] iio: sca3000: Handle errors returned by 'sca3000_configure_ring()' in 'sca3000_probe()'
Date: Sun,  8 Apr 2018 21:44:15 +0200
Message-Id: <20180408194415.18399-1-christophe.jaillet@wanadoo.fr>
List-ID: <linux-iio@vger.kernel.org>

'sca3000_configure_ring()' can fail, so test its return value and
propagate it if needed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Same as v1
---
 drivers/iio/accel/sca3000.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 562f125235db..4dceb75e3586 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1481,7 +1481,9 @@ static int sca3000_probe(struct spi_device *spi)
 	}
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	sca3000_configure_ring(indio_dev);
+	ret = sca3000_configure_ring(indio_dev);
+	if (ret)
+		return ret;
 
 	if (spi->irq) {
 		ret = request_threaded_irq(spi->irq,
-- 
2.14.1
