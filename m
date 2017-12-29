Return-Path: <SRS0=UY19=DZ=gmail.com=mastichi@kernel.org>
From: Dmitry Mastykin <mastichi@gmail.com>
To: 
Cc: Dmitry Mastykin <mastichi@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jacopo Mondi <jacopo+renesas@jmondi.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Rob Herring <robh@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: adc: max9611: fix module auto-loading
Date: Fri, 29 Dec 2017 16:59:48 +0300
Message-Id: <1514556006-23293-1-git-send-email-mastichi@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The simplest fix is to move to ->probe_new() since the driver is not
used out of DT/ACPI enumeration.

Signed-off-by: Dmitry Mastykin <mastichi@gmail.com>
---
 drivers/iio/adc/max9611.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
index b1dd17c..ce0115a 100644
--- a/drivers/iio/adc/max9611.c
+++ b/drivers/iio/adc/max9611.c
@@ -523,8 +523,7 @@ static const struct of_device_id max9611_of_table[] = {
 };
 
 MODULE_DEVICE_TABLE(of, max9611_of_table);
-static int max9611_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static int max9611_probe(struct i2c_client *client)
 {
 	const char * const shunt_res_prop = "shunt-resistor-micro-ohms";
 	const struct device_node *of_node = client->dev.of_node;
@@ -576,7 +575,7 @@ static struct i2c_driver max9611_driver = {
 		   .owner = THIS_MODULE,
 		   .of_match_table = max9611_of_table,
 	},
-	.probe = max9611_probe,
+	.probe_new = max9611_probe,
 };
 module_i2c_driver(max9611_driver);
 
-- 
2.7.4
