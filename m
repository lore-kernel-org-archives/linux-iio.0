Return-Path: <SRS0=G+O7=DE=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	=?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>, Maciej Purski
	<m.purski@samsung.com>, <linux-kernel@vger.kernel.org>, "Andrew F . Davis"
	<afd@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron
	<jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, "Javier Martinez
 Canillas" <javier@osg.samsung.com>
Subject: [PATCH v1 6/7] iio: adc: ina2xx: Align timestamp with conversion ready flag
Date: Fri, 8 Dec 2017 18:41:51 +0100
In-Reply-To: <20171208174152.30341-1-stefan.bruens@rwth-aachen.de>
References: <20171208174152.30341-1-stefan.bruens@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Message-ID: <736b34cf-67f8-4f3b-b0b6-f1dfe18255ba@rwthex-w2-a.rwth-ad.de>
List-ID: <linux-iio@vger.kernel.org>

As the timestamp is no longer (ab-)used to measure the function run time,
it can be taken at the correct time, i.e. when the conversion has finished.

Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
---

 drivers/iio/adc/ina2xx-adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 65bd9e69faf2..0a6745e15a5d 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -706,8 +706,6 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
 	s64 time;
 	unsigned int alert;
 
-	time = iio_get_time_ns(indio_dev);
-
 	/*
 	 * Because the timer thread and the chip conversion clock
 	 * are asynchronous, the period difference will eventually
@@ -736,6 +734,8 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
 
 		} while (!alert);
 
+	time = iio_get_time_ns(indio_dev);
+
 	/*
 	 * Single register reads: bulk_read will not work with ina226/219
 	 * as there is no auto-increment of the register pointer.
-- 
2.15.1
