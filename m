Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: [PATCH 4/7] iio:light:cm3323: drop barely used variable
Date: Wed, 17 Jun 2015 00:17:03 +0200
Message-Id: <942e9ba3437c35f946e6979ca63469941f81f289.1434492557.git.knaack.h@gmx.de>
In-Reply-To: <cover.1434492557.git.knaack.h@gmx.de>
References: <cover.1434492557.git.knaack.h@gmx.de>
In-Reply-To: <cover.1434492557.git.knaack.h@gmx.de>
References: <cover.1434492557.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

In cm3323_disable() ret is just used to check for errors during I2C write.
Consolidate the write and the check to save a variable and two lines of
code.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/light/cm3323.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
index f88a0ed..8945e0c 100644
--- a/drivers/iio/light/cm3323.c
+++ b/drivers/iio/light/cm3323.c
@@ -106,12 +106,10 @@ static int cm3323_init(struct iio_dev *indio_dev)
 
 static void cm3323_disable(struct iio_dev *indio_dev)
 {
-	int ret;
 	struct cm3323_data *data = iio_priv(indio_dev);
 
-	ret = i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF,
-					CM3323_CONF_SD_BIT);
-	if (ret < 0)
+	if (i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF,
+				      CM3323_CONF_SD_BIT) < 0)
 		dev_err(&data->client->dev, "Error writing reg_conf\n");
 }
 
-- 
2.3.6
