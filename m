Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Dimitris Papastamos
	<dp@opensource.wolfsonmicro.com>, Jonathan Cameron <jic23@kernel.org>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>
Subject: [PATCH 5/7] regmap: Check if a register is writable instead of readable in regcache_read
Date: Wed, 16 Nov 2011 16:28:20 +0100
Message-ID: <1321457302-8724-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1321457302-8724-1-git-send-email-lars@metafoo.de>
References: <1321457302-8724-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

One of the reasons for using a cache is to have a software shadow of a register
which is writable but not readable. This allows us to do a read-modify-write
operation on such a register.

Currently regcache checks whether a register is readable when performing a
cached read and returns an error if not. Change this check to test whether the
register is writable. This makes more sense, since reading from the cache when
the register is not readable allows the operation described above, but if the
register is not writable there shouldn't  be a value for it in the cache anyway.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/base/regmap/regcache.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 6f0dbc0..a004a7a 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -206,7 +206,7 @@ int regcache_read(struct regmap *map,
 
 	BUG_ON(!map->cache_ops);
 
-	if (!regmap_readable(map, reg))
+	if (!regmap_writeable(map, reg))
 		return -EIO;
 
 	if (!regmap_volatile(map, reg))
-- 
1.7.7.1
