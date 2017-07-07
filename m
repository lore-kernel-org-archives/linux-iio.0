Return-Path: <SRS0=PFE5=6K=canonical.com=colin.king@kernel.org>
From: Colin King <colin.king@canonical.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Rob Herring <robh@kernel.org>,
	linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: accel: make array init_data static to reduce code size
Date: Fri,  7 Jul 2017 16:55:19 +0100
Message-Id: <20170707155519.18736-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Making the const array init_data static rather having it on the
stack saves us a couple hundreds of bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
   3175	    848	      0	   4023	    fb7	drivers/iio/accel/da311.o

After:
   text	   data	    bss	    dec	    hex	filename
   2860	    936	      0	   3796	    ed4	drivers/iio/accel/da311.o

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/accel/da311.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/da311.c b/drivers/iio/accel/da311.c
index 537cfa8b6edf..c0c1620d2a2f 100644
--- a/drivers/iio/accel/da311.c
+++ b/drivers/iio/accel/da311.c
@@ -139,7 +139,7 @@ static int da311_register_mask_write(struct i2c_client *client, u16 addr,
 /* Init sequence taken from the android driver */
 static int da311_reset(struct i2c_client *client)
 {
-	const struct {
+	static const struct {
 		u16 addr;
 		u8 mask;
 		u8 data;
-- 
2.11.0
