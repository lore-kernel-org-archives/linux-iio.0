Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: [PATCH 1/7] iio:light:cm3323: clear bitmask before set
Date: Wed, 17 Jun 2015 00:17:00 +0200
Message-Id: <5c3a23e64da5989f97bb6948c4290642d1e642b7.1434492557.git.knaack.h@gmx.de>
In-Reply-To: <cover.1434492557.git.knaack.h@gmx.de>
References: <cover.1434492557.git.knaack.h@gmx.de>
In-Reply-To: <cover.1434492557.git.knaack.h@gmx.de>
References: <cover.1434492557.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

When setting the bits for integration time, the appropriate bitmask needs
to be cleared first.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/light/cm3323.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
index 869033e..1e6092a 100644
--- a/drivers/iio/light/cm3323.c
+++ b/drivers/iio/light/cm3323.c
@@ -123,7 +123,7 @@ static int cm3323_set_it_bits(struct cm3323_data *data, int val, int val2)
 	for (i = 0; i < ARRAY_SIZE(cm3323_int_time); i++) {
 		if (val == cm3323_int_time[i].val &&
 		    val2 == cm3323_int_time[i].val2) {
-			reg_conf = data->reg_conf;
+			reg_conf = data->reg_conf & CM3323_CONF_IT_MASK;
 			reg_conf |= i << CM3323_CONF_IT_SHIFT;
 
 			ret = i2c_smbus_write_word_data(data->client,
-- 
2.3.6
