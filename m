Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-kernel@vger.kernel.org,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v2 05/17] iio: accel: mma9551_core: wrong doc fixes
Date: Mon, 13 Apr 2015 18:40:52 +0300
Message-Id: <1428939664-12503-6-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
References: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Fix docummentation for mma9553_read_* functions.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Reported-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/accel/mma9551_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
index c6d5a3a..efe09a3 100644
--- a/drivers/iio/accel/mma9551_core.c
+++ b/drivers/iio/accel/mma9551_core.c
@@ -374,7 +374,7 @@ EXPORT_SYMBOL(mma9551_read_status_word);
  * @app_id:	Application ID
  * @reg:	Application register
  * @len:	Length of array to read in bytes
- * @val:	Array of words to read
+ * @buf:	Array of words to read
  *
  * Read multiple configuration registers (word-sized registers).
  *
@@ -414,7 +414,7 @@ EXPORT_SYMBOL(mma9551_read_config_words);
  * @app_id:	Application ID
  * @reg:	Application register
  * @len:	Length of array to read in bytes
- * @val:	Array of words to read
+ * @buf:	Array of words to read
  *
  * Read multiple status registers (word-sized registers).
  *
@@ -454,7 +454,7 @@ EXPORT_SYMBOL(mma9551_read_status_words);
  * @app_id:	Application ID
  * @reg:	Application register
  * @len:	Length of array to write in bytes
- * @val:	Array of words to write
+ * @buf:	Array of words to write
  *
  * Write multiple configuration registers (word-sized registers).
  *
-- 
1.9.1
