Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:11217 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752788AbcDSJTE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 19 Apr 2016 05:19:04 -0400
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Denis Ciocca <denis.ciocca@st.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Gregor Boirie <gregor.boirie@parrot.com>
Subject: [RFC PATCH v1 8/9] iio:st_sensors: emulate SMBus block read if needed
Date: Tue, 19 Apr 2016 11:18:39 +0200
Message-ID: <fa302cda642b6fe11163bfa497e4ba7fd451f255.1461056711.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1461056711.git.gregor.boirie@parrot.com>
References: <cover.1461056711.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use SMBus "block read" protocol only when supported by adapter.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 drivers/iio/common/st_sensors/st_sensors_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
index 98cfee29..b43aa36 100644
--- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
+++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
@@ -48,8 +48,8 @@ static int st_sensors_i2c_read_multiple_byte(
 	if (multiread_bit)
 		reg_addr |= ST_SENSORS_I2C_MULTIREAD;
 
-	return i2c_smbus_read_i2c_block_data(to_i2c_client(dev),
-							reg_addr, len, data);
+	return i2c_smbus_read_i2c_block_data_or_emulated(to_i2c_client(dev),
+							 reg_addr, len, data);
 }
 
 static int st_sensors_i2c_write_byte(struct st_sensor_transfer_buffer *tb,
-- 
2.1.4

