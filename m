Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH 3/8] iio:magnetometer:bmc150_magn: output intended variable
Date: Fri, 17 Jul 2015 10:52:26 +0200
Message-Id: <8f490c090729953bfdb9c02c9ad36cc873a701d7.1437090791.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437090791.git.knaack.h@gmx.de>
References: <cover.1437090791.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437090791.git.knaack.h@gmx.de>
References: <cover.1437090791.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

According to the debug/error string, the content of chip_id is supposed to
be output, rather than the return value of the previous operation.

Fixes: c91746a2361d ("iio: magn: Add support for BMC150 magnetometer")

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/magnetometer/bmc150_magn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index cd002710dd02..7da4ce9409e8 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -694,11 +694,11 @@ static int bmc150_magn_init(struct bmc150_magn_data *data)
 		goto err_poweroff;
 	}
 	if (chip_id != BMC150_MAGN_CHIP_ID_VAL) {
-		dev_err(&data->client->dev, "Invalid chip id 0x%x\n", ret);
+		dev_err(&data->client->dev, "Invalid chip id 0x%x\n", chip_id);
 		ret = -ENODEV;
 		goto err_poweroff;
 	}
-	dev_dbg(&data->client->dev, "Chip id %x\n", ret);
+	dev_dbg(&data->client->dev, "Chip id %x\n", chip_id);
 
 	preset = bmc150_magn_presets_table[BMC150_MAGN_DEFAULT_PRESET];
 	ret = bmc150_magn_set_odr(data, preset.odr);
-- 
2.4.3
