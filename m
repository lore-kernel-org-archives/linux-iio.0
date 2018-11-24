Return-Path: <SRS0=Sgfl=OD=gmail.com=marcelo.schmitt1@kernel.org>
Date: Sat, 24 Nov 2018 11:18:57 -0200
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2] staging: iio: ad5933: add device tree support
Message-ID: <20181124131857.ur6rt7nnjinmj6gm@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Add a of_device_id struct variable and subsequent call to
MODULE_DEVICE_TABLE macro to complete device tree support.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index edb8b540bbf1..6faa2700dc8d 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -771,9 +771,18 @@ static const struct i2c_device_id ad5933_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, ad5933_id);
 
+static const struct of_device_id ad5933_of_match[] = {
+	{ .compatible = "adi,ad5933" },
+	{ .compatible = "adi,ad5934" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, ad5933_of_match);
+
 static struct i2c_driver ad5933_driver = {
 	.driver = {
 		.name = "ad5933",
+		.of_match_table = ad5933_of_match,
 	},
 	.probe = ad5933_probe,
 	.remove = ad5933_remove,
-- 
2.17.1
