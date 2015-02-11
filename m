Return-Path: <vthakkar1994@gmail.com>
Date: Wed, 11 Feb 2015 14:47:27 +0530
From: Vaishali Thakkar <vthakkar1994@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: gp2ap020a00f: Use put_unaligned_le32
Message-ID: <20150211091727.GA17552@vaishali-Ideapad-Z570>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This patch introduces the use of function put_unaligned_le32.

This is done using Coccinelle and semantic patch used is as follows:

@@ identifier tmp; expression ptr; expression y,e; type T; @@

- tmp = cpu_to_le32(y);

  <+... when != tmp
- memcpy(ptr, (T)&tmp, ...);
+ put_unaligned_le32(y,ptr);
  ...+>
? tmp = e

@@ type T; identifier tmp; @@

- T tmp;
...when != tmp

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
---
 drivers/iio/light/gp2ap020a00f.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 221ed16..650c05f 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -966,7 +966,6 @@ static irqreturn_t gp2ap020a00f_trigger_handler(int irq, void *data)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct gp2ap020a00f_data *priv = iio_priv(indio_dev);
 	size_t d_size = 0;
-	__le32 light_lux;
 	int i, out_val, ret;
 
 	for_each_set_bit(i, indio_dev->active_scan_mask,
@@ -981,8 +980,8 @@ static irqreturn_t gp2ap020a00f_trigger_handler(int irq, void *data)
 		    i == GP2AP020A00F_SCAN_MODE_LIGHT_IR) {
 			out_val = le16_to_cpup((__le16 *)&priv->buffer[d_size]);
 			gp2ap020a00f_output_to_lux(priv, &out_val);
-			light_lux = cpu_to_le32(out_val);
-			memcpy(&priv->buffer[d_size], (u8 *)&light_lux, 4);
+
+			put_unaligned_le32(out_val, &priv->buffer[d_size]);
 			d_size += 4;
 		} else {
 			d_size += 2;
-- 
1.9.1
