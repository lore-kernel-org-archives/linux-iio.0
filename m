Return-Path: <tolga.ceylan@gmail.com>
From: Tolga Ceylan <tolga.ceylan@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	tolga.ceylan@gmail.com
Subject: [PATCH 1/3] Staging: iio: meter: ade7854-i2c: code style improvements
Date: Sat, 14 Feb 2015 20:32:43 -0800
Message-Id: <1423974765-1782-1-git-send-email-tolga.ceylan@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Code reformatting based on checkpatch.pl with --strict:
Alignment should match open paranthesis cases corrected

Signed-off-by: Tolga Ceylan <tolga.ceylan@gmail.com>
---
 drivers/staging/iio/meter/ade7854-i2c.c | 34 ++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index 5b33c7f..85a7e84 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -16,8 +16,8 @@
 #include "ade7854.h"
 
 static int ade7854_i2c_write_reg_8(struct device *dev,
-		u16 reg_address,
-		u8 value)
+				   u16 reg_address,
+				   u8 value)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -35,8 +35,8 @@ static int ade7854_i2c_write_reg_8(struct device *dev,
 }
 
 static int ade7854_i2c_write_reg_16(struct device *dev,
-		u16 reg_address,
-		u16 value)
+				    u16 reg_address,
+				    u16 value)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -55,8 +55,8 @@ static int ade7854_i2c_write_reg_16(struct device *dev,
 }
 
 static int ade7854_i2c_write_reg_24(struct device *dev,
-		u16 reg_address,
-		u32 value)
+				    u16 reg_address,
+				    u32 value)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -76,8 +76,8 @@ static int ade7854_i2c_write_reg_24(struct device *dev,
 }
 
 static int ade7854_i2c_write_reg_32(struct device *dev,
-		u16 reg_address,
-		u32 value)
+				    u16 reg_address,
+				    u32 value)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -98,8 +98,8 @@ static int ade7854_i2c_write_reg_32(struct device *dev,
 }
 
 static int ade7854_i2c_read_reg_8(struct device *dev,
-		u16 reg_address,
-		u8 *val)
+				  u16 reg_address,
+				  u8 *val)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
@@ -124,8 +124,8 @@ out:
 }
 
 static int ade7854_i2c_read_reg_16(struct device *dev,
-		u16 reg_address,
-		u16 *val)
+				   u16 reg_address,
+				   u16 *val)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
@@ -150,8 +150,8 @@ out:
 }
 
 static int ade7854_i2c_read_reg_24(struct device *dev,
-		u16 reg_address,
-		u32 *val)
+				   u16 reg_address,
+				   u32 *val)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
@@ -176,8 +176,8 @@ out:
 }
 
 static int ade7854_i2c_read_reg_32(struct device *dev,
-		u16 reg_address,
-		u32 *val)
+				   u16 reg_address,
+				   u32 *val)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7854_state *st = iio_priv(indio_dev);
@@ -202,7 +202,7 @@ out:
 }
 
 static int ade7854_i2c_probe(struct i2c_client *client,
-		const struct i2c_device_id *id)
+			     const struct i2c_device_id *id)
 {
 	int ret;
 	struct ade7854_state *st;
-- 
2.3.0
