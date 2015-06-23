Return-Path: <borneo.antonio@gmail.com>
From: Antonio Borneo <borneo.antonio@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Karol Wrona <k.wrona@samsung.com>,
	linux-iio@vger.kernel.org
Cc: Antonio Borneo <borneo.antonio@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] iio: ssp_sensors: Remove redundant spi driver bus initialization
Date: Tue, 23 Jun 2015 22:52:28 +0800
Message-Id: <1435071148-24453-1-git-send-email-borneo.antonio@gmail.com>
In-Reply-To: <1435070714-24174-1-git-send-email-borneo.antonio@gmail.com>
References: <1435070714-24174-1-git-send-email-borneo.antonio@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

In ancient times it was necessary to manually initialize the bus
field of an spi_driver to spi_bus_type. These days this is done in
spi_register_driver(), so we can drop the manual assignment.

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
To: Karol Wrona <k.wrona@samsung.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/iio/common/ssp_sensors/ssp_dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index 9a40097..d338bb5 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -700,7 +700,6 @@ static struct spi_driver ssp_driver = {
 	.remove = ssp_remove,
 	.driver = {
 		.pm = &ssp_pm_ops,
-		.bus = &spi_bus_type,
 		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(ssp_of_match),
 		.name = "sensorhub"
-- 
2.4.4
