Return-Path: <SRS0=bHRo=3J=gmail.com=singhalsimran0@kernel.org>
Date: Sat, 1 Apr 2017 19:39:21 +0530
From: simran singhal <singhalsimran0@gmail.com>
To: jic23@kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: common: ms_sensors: Remove unnecessary cast on void
 pointer
Message-ID: <20170401140921.GA24486@singhal-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

The following Coccinelle script was used to detect this:
@r@
expression x;
void* e;
type T;
identifier f;
@@
(
  *((T *)e)
|
  ((T *)x)[...]
|
  ((T*)x)->f
|
- (T*)
  e
)

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
index ecf7721..125b5ff 100644
--- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
+++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
@@ -74,7 +74,7 @@ EXPORT_SYMBOL(ms_sensors_reset);
 int ms_sensors_read_prom_word(void *cli, int cmd, u16 *word)
 {
 	int ret;
-	struct i2c_client *client = (struct i2c_client *)cli;
+	struct i2c_client *client = cli;
 
 	ret = i2c_smbus_read_word_swapped(client, cmd);
 	if (ret < 0) {
@@ -107,7 +107,7 @@ int ms_sensors_convert_and_read(void *cli, u8 conv, u8 rd,
 {
 	int ret;
 	__be32 buf = 0;
-	struct i2c_client *client = (struct i2c_client *)cli;
+	struct i2c_client *client = cli;
 
 	/* Trigger conversion */
 	ret = i2c_smbus_write_byte(client, conv);
-- 
2.7.4
