Return-Path: <SRS0=2qIu=DR=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	=?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>, Maciej Purski
	<m.purski@samsung.com>, <linux-kernel@vger.kernel.org>, "Andrew F . Davis"
	<afd@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron
	<jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH v2 1/7] iio: adc: ina2xx: Remove bogus cast for data argument
Date: Thu, 21 Dec 2017 19:31:32 +0100
In-Reply-To: <20171221183138.361-1-stefan.bruens@rwth-aachen.de>
References: <20171221183138.361-1-stefan.bruens@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Message-ID: <b59a9f59-da42-41b6-926b-50fb5b7909c3@rwthex-w2-a.rwth-ad.de>
List-ID: <linux-iio@vger.kernel.org>

iio_push_to_buffers_with_timestamp expects a void pointer, so the cast
is both unnecessary and misleading.

Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
---

Changes in v2: None

 drivers/iio/adc/ina2xx-adc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index ddf878163bf9..3195f8754c3b 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -767,8 +767,7 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
 
 	time_b = iio_get_time_ns(indio_dev);
 
-	iio_push_to_buffers_with_timestamp(indio_dev,
-					   (unsigned int *)data, time_a);
+	iio_push_to_buffers_with_timestamp(indio_dev, data, time_a);
 
 	return (unsigned long)(time_b - time_a) / 1000;
 };
-- 
2.15.1
