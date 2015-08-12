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
Subject: [PATCH 01/20] regmap: Add missing comments about struct regmap_bus
Date: Wed, 12 Aug 2015 12:12:26 +0200
Message-Id: <1439374365-20623-2-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

There are some fields of this struct undocumented or old. This patch
updates the missing comments.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 include/linux/regmap.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 59c55ea0f0b5..6ff83c9ddb45 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -296,8 +296,11 @@ typedef void (*regmap_hw_free_context)(void *context);
  *                if not implemented  on a given device.
  * @async_write: Write operation which completes asynchronously, optional and
  *               must serialise with respect to non-async I/O.
+ * @reg_write: Write operation for a register. Writes value to register.
  * @read: Read operation.  Data is returned in the buffer used to transmit
  *         data.
+ * @reg_read: Read operation for a register. Reads a value from a register.
+ * @free_conetext: Free context.
  * @async_alloc: Allocate a regmap_async() structure.
  * @read_flag_mask: Mask to be set in the top byte of the register when doing
  *                  a read.
@@ -307,7 +310,6 @@ typedef void (*regmap_hw_free_context)(void *context);
  * @val_format_endian_default: Default endianness for formatted register
  *     values. Used when the regmap_config specifies DEFAULT. If this is
  *     DEFAULT, BIG is assumed.
- * @async_size: Size of struct used for async work.
  */
 struct regmap_bus {
 	bool fast_io;
-- 
2.4.6
