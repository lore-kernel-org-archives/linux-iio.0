Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 11/20] regmap: _regmap_raw_read: Add handling of busses without bus->read()
Date: Wed, 12 Aug 2015 12:12:36 +0200
Message-Id: <1439374365-20623-12-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

Handle easy reads by using bus->reg_read(). Return with an error value
if a read is requested that can not be handled with reg_read().

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/base/regmap/regmap.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 87f15fb60bc5..3b663350c573 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2071,6 +2071,21 @@ static int _regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 
 	WARN_ON(!map->bus);
 
+	/*
+	 * There are busses that do not have a read function as it is optional.
+	 * Use their reg_read function instead if the requested number of bytes
+	 * is correct.
+	 */
+	if (!map->bus->read) {
+		/*
+		 * bus_reg_read() does not support reading values that are not
+		 * exactly the size of format.val_bytes
+		 */
+		if (val_len != map->format.val_bytes)
+			return -EINVAL;
+		return _regmap_bus_reg_read(map, reg, val);
+	}
+
 	range = _regmap_range_lookup(map, reg);
 	if (range) {
 		ret = _regmap_select_page(map, &reg, range,
-- 
2.4.6
