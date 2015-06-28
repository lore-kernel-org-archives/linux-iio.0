Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: [PATCH 2/2] iio:light:ltr501: fix variable in ltr501_init
Date: Sun, 28 Jun 2015 12:31:53 +0200
Message-Id: <d0d577c23f2ecb473c776cf6a684e82e07c0ab74.1435487041.git.knaack.h@gmx.de>
In-Reply-To: <cover.1435487041.git.knaack.h@gmx.de>
References: <cover.1435487041.git.knaack.h@gmx.de>
In-Reply-To: <cover.1435487041.git.knaack.h@gmx.de>
References: <cover.1435487041.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

When filling data->als_contr, the register content read into status needs
to be used, instead of the return status value of regmap_read.

This fixes: 	8592a7eefa540303dd9e60fa49340d09ca9376b4
		"iio: ltr501: Add support for ltr559 chip"

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/light/ltr501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 1ef7d37..b5a0e66 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1302,7 +1302,7 @@ static int ltr501_init(struct ltr501_data *data)
 	if (ret < 0)
 		return ret;
 
-	data->als_contr = ret | data->chip_info->als_mode_active;
+	data->als_contr = status | data->chip_info->als_mode_active;
 
 	ret = regmap_read(data->regmap, LTR501_PS_CONTR, &status);
 	if (ret < 0)
-- 
2.3.6
