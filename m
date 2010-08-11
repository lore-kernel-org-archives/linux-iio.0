Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Barry.Song@analog.com,
	m_brugger@web.de,
	mensch0815@googlemail.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/2] staging:iio:adis16260 add id table support
Date: Wed, 11 Aug 2010 15:12:18 +0100
Message-Id: <1281535939-7190-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1281535939-7190-1-git-send-email-jic23@cam.ac.uk>
References: <1281535939-7190-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/adis16260_core.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 134dfaa..cf9d9c6 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -633,6 +633,12 @@ err_ret:
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
@@ -640,6 +646,7 @@ static struct spi_driver adis16260_driver = {
 	},
 	.probe = adis16260_probe,
 	.remove = __devexit_p(adis16260_remove),
+	.id_table = adis16260_id,
 };
 
 static __init int adis16260_init(void)
-- 
1.7.1
