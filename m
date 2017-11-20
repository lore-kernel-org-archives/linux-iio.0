Return-Path: <SRS0=LSmz=CS=gmail.com=cjx.private@kernel.org>
From: Jesse Chan <jc@linux.com>
To: 
Cc: Jesse Chan <jc@linux.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: accel: kxsd9-i2c: add missing MODULE_AUTHOR/DESCRIPTION/LICENSE
Date: Mon, 20 Nov 2017 12:55:18 -0800
Message-Id: <20171120205520.84809-1-jc@linux.com>
List-ID: <linux-iio@vger.kernel.org>

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/iio/accel/kxsd9-i2c.o
see include/linux/module.h for more information

This adds the license as "GPL v2", which matches the header of the file.

MODULE_DESCRIPTION and MODULE_AUTHOR are also added.

Signed-off-by: Jesse Chan <jc@linux.com>
---
 drivers/iio/accel/kxsd9-i2c.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
index 98fbb628d5bd..40f82ada6a52 100644
--- a/drivers/iio/accel/kxsd9-i2c.c
+++ b/drivers/iio/accel/kxsd9-i2c.c
@@ -63,3 +63,7 @@ static struct i2c_driver kxsd9_i2c_driver = {
 	.id_table	= kxsd9_i2c_id,
 };
 module_i2c_driver(kxsd9_i2c_driver);
+
+MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
+MODULE_DESCRIPTION("Kionix KXSD9 I2C driver");
+MODULE_LICENSE("GPL v2");
-- 
2.14.1
