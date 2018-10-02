Return-Path: <SRS0=8j9Q=MO=analog.com=alexandru.Ardelean@kernel.org>
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>, <Michael.Hennerich@analog.com>,
	<Dragos.Bogdan@analog.com>, <jic23@kernel.org>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, Dragos Bogdan
	<dragos.bogdan@analog.com>, Alexandru Ardelean
	<alexandru.ardelean@analog.com>
Subject: [PATCH 4/4] staging: iio: ad5933: Add of_device_id table
Date: Tue, 2 Oct 2018 14:58:00 +0300
Message-ID: <20181002115800.12399-4-alexandru.ardelean@analog.com>
In-Reply-To: <20181002115800.12399-1-alexandru.ardelean@analog.com>
References: <20181002115800.12399-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Dragos Bogdan <dragos.bogdan@analog.com>

As part of finalizing the device-tree support for this driver, this patch
adds the of_device_id table with supported devices.

Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 04208a1df48e..ab8b93fd39ed 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -809,6 +809,14 @@ static int ad5933_remove(struct i2c_client *client)
 	return 0;
 }
 
+static const struct of_device_id of_ad5933_match[] = {
+	{ .compatible = "adi,ad5933", 0},
+	{ .compatible = "adi,ad5934", 0},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, of_ad5933_match);
+
 static const struct i2c_device_id ad5933_id[] = {
 	{ "ad5933", 0 },
 	{ "ad5934", 0 },
-- 
2.17.1
