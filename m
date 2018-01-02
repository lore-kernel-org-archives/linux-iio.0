Return-Path: <SRS0=Hf5a=D5=lip6.fr=Julia.Lawall@kernel.org>
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Jonathan Cameron <jic23@kernel.org>
Cc: kernel-janitors@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] iio: common: ssp_sensors: account for const type of of_device_id.data
Date: Tue,  2 Jan 2018 14:28:07 +0100
Message-Id: <1514899688-27844-12-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
List-ID: <linux-iio@vger.kernel.org>

This driver creates a number of const structures that it stores in the
data field of an of_device_id array.

Add const to the declaration of the location that receives a value
from the data field to ensure that the compiler will continue to check
that the value is not modified and remove the const-dropping cast on
the access to the data field.

Done using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/iio/common/ssp_sensors/ssp.h     |    2 +-
 drivers/iio/common/ssp_sensors/ssp_dev.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -u -p a/drivers/iio/common/ssp_sensors/ssp.h b/drivers/iio/common/ssp_sensors/ssp.h
--- a/drivers/iio/common/ssp_sensors/ssp.h
+++ b/drivers/iio/common/ssp_sensors/ssp.h
@@ -188,7 +188,7 @@ struct ssp_sensorhub_info {
  */
 struct ssp_data {
 	struct spi_device *spi;
-	struct ssp_sensorhub_info *sensorhub_info;
+	const struct ssp_sensorhub_info *sensorhub_info;
 	struct timer_list wdt_timer;
 	struct work_struct work_wdt;
 	struct delayed_work work_refresh;
diff -u -p a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -486,7 +486,7 @@ static struct ssp_data *ssp_parse_dt(str
 	if (!match)
 		goto err_mcu_reset_gpio;
 
-	data->sensorhub_info = (struct ssp_sensorhub_info *)match->data;
+	data->sensorhub_info = match->data;
 
 	dev_set_drvdata(dev, data);
 
