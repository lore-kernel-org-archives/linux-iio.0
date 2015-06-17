Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: [PATCH v2 7/7] iio:light:cm3323: add empty lines for code structure
Date: Thu, 18 Jun 2015 00:32:05 +0200
Message-Id: <b12e8ab9927598c03f55206140753a33eaa53b90.1434578207.git.knaack.h@gmx.de>
In-Reply-To: <cover.1434578207.git.knaack.h@gmx.de>
References: <cover.1434578207.git.knaack.h@gmx.de>
In-Reply-To: <cover.1434578207.git.knaack.h@gmx.de>
References: <cover.1434578207.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Add some empty lines to visually separate logical structure blocks, as
after if-blocks or before regular returns.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/light/cm3323.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
index 1fc9f78..0831f06 100644
--- a/drivers/iio/light/cm3323.c
+++ b/drivers/iio/light/cm3323.c
@@ -131,9 +131,11 @@ static int cm3323_set_it_bits(struct cm3323_data *data, int val, int val2)
 				return ret;
 
 			data->reg_conf = reg_conf;
+
 			return 0;
 		}
 	}
+
 	return -EINVAL;
 }
 
@@ -146,6 +148,7 @@ static int cm3323_get_it_bits(struct cm3323_data *data)
 
 	if (bits >= ARRAY_SIZE(cm3323_int_time))
 		return -EINVAL;
+
 	return bits;
 }
 
@@ -241,11 +244,13 @@ static int cm3323_probe(struct i2c_client *client,
 		dev_err(&client->dev, "cm3323 chip init failed\n");
 		return ret;
 	}
+
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		dev_err(&client->dev, "failed to register iio dev\n");
 		goto err_init;
 	}
+
 	return 0;
 err_init:
 	cm3323_disable(indio_dev);
-- 
2.3.6
