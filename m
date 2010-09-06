Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: m_brugger@web.de,
	Michael.Hennerich@analog.com,
	Robin.Getz@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/2] staging:iio:adis16260 add id table support
Date: Mon,  6 Sep 2010 16:16:17 +0100
Message-Id: <1283786178-6466-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1283786178-6466-1-git-send-email-jic23@cam.ac.uk>
References: <1283786178-6466-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/adis16260_core.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index c1ad0c8..36e5757 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -635,6 +635,12 @@ err_ret:
 	return ret;
 }
 
+static const struct spi_device_id adis16260_id[] = {
+	{"adis16260", 0},
+	{"adis16265", 0},
+	{}
+};
+
 static struct spi_driver adis16260_driver = {
 	.driver = {
 		.name = "adis16260",
@@ -642,6 +648,7 @@ static struct spi_driver adis16260_driver = {
 	},
 	.probe = adis16260_probe,
 	.remove = __devexit_p(adis16260_remove),
+	.id_table = adis16260_id,
 };
 
 static __init int adis16260_init(void)
-- 
1.7.1
