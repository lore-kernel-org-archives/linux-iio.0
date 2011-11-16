Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Dimitris Papastamos
	<dp@opensource.wolfsonmicro.com>, Jonathan Cameron <jic23@kernel.org>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>
Subject: [PATCH 4/7] regmap: Try cached read before checking if a hardware read is possible
Date: Wed, 16 Nov 2011 16:28:19 +0100
Message-ID: <1321457302-8724-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1321457302-8724-1-git-send-email-lars@metafoo.de>
References: <1321457302-8724-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

For some register format types we do not provide a parse_val so we can not do a
hardware read. But a cached read is still possible, so try to read from the
cache first, before checking whether a hardware read is possible. Otherwise the
cache becomes pretty useless for these register types.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/base/regmap/regmap.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 3cf4785..b96cf72 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -434,15 +434,15 @@ static int _regmap_read(struct regmap *map, unsigned int reg,
 {
 	int ret;
 
-	if (!map->format.parse_val)
-		return -EINVAL;
-
 	if (!map->cache_bypass) {
 		ret = regcache_read(map, reg, val);
 		if (ret == 0)
 			return 0;
 	}
 
+	if (!map->format.parse_val)
+		return -EINVAL;
+
 	if (map->cache_only)
 		return -EBUSY;
 
-- 
1.7.7.1
