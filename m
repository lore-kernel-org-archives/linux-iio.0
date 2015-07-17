Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH 5/8] iio:magnetometer:bmc150_magn: add error handling on gpio probe
Date: Fri, 17 Jul 2015 10:52:28 +0200
Message-Id: <655373255075b12f451e644d81b36aa0588aa9c1.1437090791.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437090791.git.knaack.h@gmx.de>
References: <cover.1437090791.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437090791.git.knaack.h@gmx.de>
References: <cover.1437090791.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

bmc150_magn_gpio_probe() may return some error codes, so better check
them.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/magnetometer/bmc150_magn.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index f1b6a4dc40ea..e1f804b2b244 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -920,8 +920,13 @@ static int bmc150_magn_probe(struct i2c_client *client,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmc150_magn_info;
 
-	if (client->irq <= 0)
+	if (client->irq <= 0) {
 		client->irq = bmc150_magn_gpio_probe(client);
+		if (client->irq < 0) {
+			ret = client->irq;
+			goto err_poweroff;
+		}
+	}
 
 	if (client->irq > 0) {
 		data->dready_trig = devm_iio_trigger_alloc(&client->dev,
-- 
2.4.3
