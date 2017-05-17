Return-Path: <SRS0=lF10=4X=idt.com=franziska.naepelt@kernel.org>
Cc: linux-iio@vger.kernel.org
To: jic23@kernel.org
From: Franziska Naepelt <franziska.naepelt@idt.com>
Subject: [PATCH] iio: light: ltr501 Fix interchanged als/ps register field
Message-ID: <d42349ae-0202-38aa-2f24-610180772ab5@idt.com>
Date: Wed, 17 May 2017 12:41:19 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

The register mapping for the IIO driver for the Liteon Light and Proximity
sensor LTR501 interrupt mode is interchanged (ALS/PS).
There is a register called INTERRUPT register (address 0x8F)
Bit 0 represents PS measurement trigger.
Bit 1 represents ALS measurement trigger.
This two bit fields are interchanged within the driver.
see datasheet page 24:
http://optoelectronics.liteon.com/upload/download/DS86-2012-0006/S_110_LTR-501ALS-01_PrelimDS_ver1%5B1%5D.pdf

Signed-off-by: Franziska Naepelt <franziska.naepelt@idt.com>
Acked-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
---
  drivers/iio/light/ltr501.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index b30e0c1..67838ed 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -74,9 +74,9 @@
  static const struct reg_field reg_field_it =
                  REG_FIELD(LTR501_ALS_MEAS_RATE, 3, 4);
  static const struct reg_field reg_field_als_intr =
-                REG_FIELD(LTR501_INTR, 0, 0);
-static const struct reg_field reg_field_ps_intr =
                  REG_FIELD(LTR501_INTR, 1, 1);
+static const struct reg_field reg_field_ps_intr =
+                REG_FIELD(LTR501_INTR, 0, 0);
  static const struct reg_field reg_field_als_rate =
                  REG_FIELD(LTR501_ALS_MEAS_RATE, 0, 2);
  static const struct reg_field reg_field_ps_rate =
-- 
1.9.1
