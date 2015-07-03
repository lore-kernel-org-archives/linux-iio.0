Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Wolfram Sang <wsa@the-dreams.de>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v3 2/8] eeprom: at24: use i2c_smbus_read_i2c_block_data_or_emulated
Date: Fri,  3 Jul 2015 12:33:31 +0300
Message-Id: <1435916017-12859-3-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1435916017-12859-1-git-send-email-irina.tirdea@intel.com>
References: <1435916017-12859-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

For i2c busses that support only SMBUS extensions, the eeprom at24
driver reads data from the device using the SMBus block, word or byte
read protocols depending on availability.

Replace the block read emulation from the driver with the
i2c_smbus_read_i2c_block_data_or_emulated call from i2c core.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/misc/eeprom/at24.c | 40 +++++++++-------------------------------
 1 file changed, 9 insertions(+), 31 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 2d3db81..d13795a 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -186,19 +186,11 @@ static ssize_t at24_eeprom_read(struct at24_data *at24, char *buf,
 	if (count > io_limit)
 		count = io_limit;
 
-	switch (at24->use_smbus) {
-	case I2C_SMBUS_I2C_BLOCK_DATA:
+	if (at24->use_smbus) {
 		/* Smaller eeproms can work given some SMBus extension calls */
 		if (count > I2C_SMBUS_BLOCK_MAX)
 			count = I2C_SMBUS_BLOCK_MAX;
-		break;
-	case I2C_SMBUS_WORD_DATA:
-		count = 2;
-		break;
-	case I2C_SMBUS_BYTE_DATA:
-		count = 1;
-		break;
-	default:
+	} else {
 		/*
 		 * When we have a better choice than SMBus calls, use a
 		 * combined I2C message. Write address; then read up to
@@ -229,27 +221,13 @@ static ssize_t at24_eeprom_read(struct at24_data *at24, char *buf,
 	timeout = jiffies + msecs_to_jiffies(write_timeout);
 	do {
 		read_time = jiffies;
-		switch (at24->use_smbus) {
-		case I2C_SMBUS_I2C_BLOCK_DATA:
-			status = i2c_smbus_read_i2c_block_data(client, offset,
-					count, buf);
-			break;
-		case I2C_SMBUS_WORD_DATA:
-			status = i2c_smbus_read_word_data(client, offset);
-			if (status >= 0) {
-				buf[0] = status & 0xff;
-				buf[1] = status >> 8;
-				status = count;
-			}
-			break;
-		case I2C_SMBUS_BYTE_DATA:
-			status = i2c_smbus_read_byte_data(client, offset);
-			if (status >= 0) {
-				buf[0] = status;
-				status = count;
-			}
-			break;
-		default:
+		if (at24->use_smbus) {
+			status =
+			    i2c_smbus_read_i2c_block_data_or_emulated(client,
+								      offset,
+								      count,
+								      buf);
+		} else {
 			status = i2c_transfer(client->adapter, msg, 2);
 			if (status == 2)
 				status = count;
-- 
1.9.1
