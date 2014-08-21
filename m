Return-Path: <Sanjeev_Sharma@mentor.com>
From: "Sharma, Sanjeev" <Sanjeev_Sharma@mentor.com>
To: "Sharma, Sanjeev" <Sanjeev_Sharma@mentor.com>, "jic23@kernel.org"
	<jic23@kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] iio: remove .owner field for driver using
 module_platform_driver
Date: Thu, 21 Aug 2014 12:21:56 +0000
Message-ID: <FDC088D3B5555644AE135ED28A7ABDE94DF3137C@EU-MBX-02.mgc.mentorg.com>
References: <1408527157-9318-1-git-send-email-sanjeev_sharma@mentor.com>
In-Reply-To: <1408527157-9318-1-git-send-email-sanjeev_sharma@mentor.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Adding Greg into CC list.

Sanjeev Sharma

-----Original Message-----
From: Sanjeev Sharma [mailto:sanjeev_sharma@mentor.com]=20
Sent: Wednesday, August 20, 2014 3:03 PM
To: jic23@kernel.org; kgene.kim@samsung.com
Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; devel@driverde=
v.osuosl.org; Sharma, Sanjeev; Sharma, Sanjeev
Subject: [PATCH] iio: remove .owner field for driver using module_platform_=
driver

This patch removes the .owner field for drivers which use the platform_driv=
er_register api because this is overriden in _platform_driver_register.

Signed-off-by: Sanjeev Sharma <Sanjeev_Sharma@mentor.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c       | 1 -
 drivers/iio/adc/exynos_adc.c                  | 1 -
 drivers/iio/adc/lp8788_adc.c                  | 1 -
 drivers/iio/adc/ti_am335x_adc.c               | 1 -
 drivers/iio/adc/twl4030-madc.c                | 1 -
 drivers/iio/adc/twl6030-gpadc.c               | 1 -
 drivers/iio/adc/vf610_adc.c                   | 1 -
 drivers/iio/adc/viperboard_adc.c              | 1 -
 drivers/iio/gyro/hid-sensor-gyro-3d.c         | 1 -
 drivers/iio/humidity/dht11.c                  | 1 -
 drivers/iio/light/hid-sensor-als.c            | 1 -
 drivers/iio/light/hid-sensor-prox.c           | 1 -
 drivers/iio/light/lm3533-als.c                | 1 -
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 1 -  drivers/iio/orientati=
on/hid-sensor-incl-3d.c  | 1 -  drivers/iio/orientation/hid-sensor-rotation=
.c | 1 -
 drivers/iio/pressure/hid-sensor-press.c       | 1 -
 drivers/iio/trigger/iio-trig-interrupt.c      | 1 -
 18 files changed, 18 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hi=
d-sensor-accel-3d.c
index 54e464e..d5d9531 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -419,7 +419,6 @@ static struct platform_driver hid_accel_3d_platform_dri=
ver =3D {
 	.id_table =3D hid_accel_3d_ids,
 	.driver =3D {
 		.name	=3D KBUILD_MODNAME,
-		.owner	=3D THIS_MODULE,
 	},
 	.probe		=3D hid_accel_3d_probe,
 	.remove		=3D hid_accel_3d_remove,
diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c in=
dex fc9dfc2..b4373f7 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -606,7 +606,6 @@ static struct platform_driver exynos_adc_driver =3D {
 	.remove		=3D exynos_adc_remove,
 	.driver		=3D {
 		.name	=3D "exynos-adc",
-		.owner	=3D THIS_MODULE,
 		.of_match_table =3D exynos_adc_match,
 		.pm	=3D &exynos_adc_pm_ops,
 	},
diff --git a/drivers/iio/adc/lp8788_adc.c b/drivers/iio/adc/lp8788_adc.c in=
dex 5c8c915..152cfc8 100644
--- a/drivers/iio/adc/lp8788_adc.c
+++ b/drivers/iio/adc/lp8788_adc.c
@@ -244,7 +244,6 @@ static struct platform_driver lp8788_adc_driver =3D {
 	.remove =3D lp8788_adc_remove,
 	.driver =3D {
 		.name =3D LP8788_DEV_ADC,
-		.owner =3D THIS_MODULE,
 	},
 };
 module_platform_driver(lp8788_adc_driver);
diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_ad=
c.c index d5dc4c6..b730864 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -545,7 +545,6 @@ MODULE_DEVICE_TABLE(of, ti_adc_dt_ids);  static struct =
platform_driver tiadc_driver =3D {
 	.driver =3D {
 		.name   =3D "TI-am335x-adc",
-		.owner	=3D THIS_MODULE,
 		.pm	=3D TIADC_PM_OPS,
 		.of_match_table =3D ti_adc_dt_ids,
 	},
diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.=
c index eb86786..94c5f05 100644
--- a/drivers/iio/adc/twl4030-madc.c
+++ b/drivers/iio/adc/twl4030-madc.c
@@ -883,7 +883,6 @@ static struct platform_driver twl4030_madc_driver =3D {
 	.remove =3D twl4030_madc_remove,
 	.driver =3D {
 		   .name =3D "twl4030_madc",
-		   .owner =3D THIS_MODULE,
 		   .of_match_table =3D of_match_ptr(twl_madc_of_match),
 	},
 };
diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpad=
c.c index 15282f1..89d8aa1 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -994,7 +994,6 @@ static struct platform_driver twl6030_gpadc_driver =3D =
{
 	.remove		=3D twl6030_gpadc_remove,
 	.driver		=3D {
 		.name	=3D DRIVER_NAME,
-		.owner	=3D THIS_MODULE,
 		.pm	=3D &twl6030_gpadc_pm_ops,
 		.of_match_table =3D of_twl6030_match_tbl,
 	},
diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c inde=
x 44799eb5..4a10ae9 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -698,7 +698,6 @@ static struct platform_driver vf610_adc_driver =3D {
 	.remove         =3D vf610_adc_remove,
 	.driver         =3D {
 		.name   =3D DRIVER_NAME,
-		.owner  =3D THIS_MODULE,
 		.of_match_table =3D vf610_adc_match,
 		.pm     =3D &vf610_adc_pm_ops,
 	},
diff --git a/drivers/iio/adc/viperboard_adc.c b/drivers/iio/adc/viperboard_=
adc.c
index 9acf6b6..3be2e35 100644
--- a/drivers/iio/adc/viperboard_adc.c
+++ b/drivers/iio/adc/viperboard_adc.c
@@ -145,7 +145,6 @@ static int vprbrd_adc_probe(struct platform_device *pde=
v)  static struct platform_driver vprbrd_adc_driver =3D {
 	.driver =3D {
 		.name	=3D "viperboard-adc",
-		.owner	=3D THIS_MODULE,
 	},
 	.probe		=3D vprbrd_adc_probe,
 };
diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-s=
ensor-gyro-3d.c
index fa034a3..a3ea1e8 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -416,7 +416,6 @@ static struct platform_driver hid_gyro_3d_platform_driv=
er =3D {
 	.id_table =3D hid_gyro_3d_ids,
 	.driver =3D {
 		.name	=3D KBUILD_MODNAME,
-		.owner	=3D THIS_MODULE,
 	},
 	.probe		=3D hid_gyro_3d_probe,
 	.remove		=3D hid_gyro_3d_remove,
diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c in=
dex d8771f5..623c145 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -281,7 +281,6 @@ static int dht11_probe(struct platform_device *pdev)  s=
tatic struct platform_driver dht11_driver =3D {
 	.driver =3D {
 		.name	=3D DRIVER_NAME,
-		.owner	=3D THIS_MODULE,
 		.of_match_table =3D dht11_dt_ids,
 	},
 	.probe  =3D dht11_probe,
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sen=
sor-als.c
index 96e71e1..a5283d7 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -381,7 +381,6 @@ static struct platform_driver hid_als_platform_driver =
=3D {
 	.id_table =3D hid_als_ids,
 	.driver =3D {
 		.name	=3D KBUILD_MODNAME,
-		.owner	=3D THIS_MODULE,
 	},
 	.probe		=3D hid_als_probe,
 	.remove		=3D hid_als_remove,
diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-se=
nsor-prox.c
index 412bae8..f5a5146 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -373,7 +373,6 @@ static struct platform_driver hid_prox_platform_driver =
=3D {
 	.id_table =3D hid_prox_ids,
 	.driver =3D {
 		.name	=3D KBUILD_MODNAME,
-		.owner	=3D THIS_MODULE,
 	},
 	.probe		=3D hid_prox_probe,
 	.remove		=3D hid_prox_remove,
diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.=
c index c1aadc6..ae3c71b 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -915,7 +915,6 @@ static int lm3533_als_remove(struct platform_device *pd=
ev)  static struct platform_driver lm3533_als_driver =3D {
 	.driver	=3D {
 		.name	=3D "lm3533-als",
-		.owner	=3D THIS_MODULE,
 	},
 	.probe		=3D lm3533_als_probe,
 	.remove		=3D lm3533_als_remove,
diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/ma=
gnetometer/hid-sensor-magn-3d.c
index 3ec777a..03a13d4 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -533,7 +533,6 @@ static struct platform_driver hid_magn_3d_platform_driv=
er =3D {
 	.id_table =3D hid_magn_3d_ids,
 	.driver =3D {
 		.name	=3D KBUILD_MODNAME,
-		.owner	=3D THIS_MODULE,
 	},
 	.probe		=3D hid_magn_3d_probe,
 	.remove		=3D hid_magn_3d_remove,
diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/ori=
entation/hid-sensor-incl-3d.c
index 2478f6c..1ff181b 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -437,7 +437,6 @@ static struct platform_driver hid_incl_3d_platform_driv=
er =3D {
 	.id_table =3D hid_incl_3d_ids,
 	.driver =3D {
 		.name	=3D KBUILD_MODNAME,
-		.owner	=3D THIS_MODULE,
 	},
 	.probe		=3D hid_incl_3d_probe,
 	.remove		=3D hid_incl_3d_remove,
diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/or=
ientation/hid-sensor-rotation.c
index dccf848..4afb6c7 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -334,7 +334,6 @@ static struct platform_driver hid_dev_rot_platform_driv=
er =3D {
 	.id_table =3D hid_dev_rot_ids,
 	.driver =3D {
 		.name	=3D KBUILD_MODNAME,
-		.owner	=3D THIS_MODULE,
 	},
 	.probe		=3D hid_dev_rot_probe,
 	.remove		=3D hid_dev_rot_remove,
diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure=
/hid-sensor-press.c
index 2c0d2a4..7649286 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -382,7 +382,6 @@ static struct platform_driver hid_press_platform_driver=
 =3D {
 	.id_table =3D hid_press_ids,
 	.driver =3D {
 		.name	=3D KBUILD_MODNAME,
-		.owner	=3D THIS_MODULE,
 	},
 	.probe		=3D hid_press_probe,
 	.remove		=3D hid_press_remove,
diff --git a/drivers/iio/trigger/iio-trig-interrupt.c b/drivers/iio/trigger=
/iio-trig-interrupt.c
index 7a149a7..572bc6f 100644
--- a/drivers/iio/trigger/iio-trig-interrupt.c
+++ b/drivers/iio/trigger/iio-trig-interrupt.c
@@ -109,7 +109,6 @@ static struct platform_driver iio_interrupt_trigger_dri=
ver =3D {
 	.remove =3D iio_interrupt_trigger_remove,
 	.driver =3D {
 		.name =3D "iio_interrupt_trigger",
-		.owner =3D THIS_MODULE,
 	},
 };
=20
--
1.7.11.7
