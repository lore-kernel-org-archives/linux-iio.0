Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>, "gregkh@suse.de" <gregkh@suse.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"uclinux-dist-devel@blackfin.uclinux.org"
	<uclinux-dist-devel@blackfin.uclinux.org>
Date: Tue, 9 Mar 2010 09:35:56 +0000
Subject: [PATCH] iio-trig-gpio:Remove redundant gpio_request
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712D6B1D96B4@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Remove redundant gpio_request:
The GPIO used as trigger IRQ, is also requested as gpio, but actually never=
 read.

Use platform resource facility to get IRQs numbers and flags.
Make sure this driver can be used with any system IRQ, not necessarily limi=
ted to GPIO-IRQs.
Use dev_err(dev...) and friends instead of printk(KERN_ERR...)

From: Michael Hennerich <Michael.Hennerich@analog.com>

Index: drivers/staging/iio/trigger/iio-trig-gpio.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/staging/iio/trigger/iio-trig-gpio.c (revision 7916)
+++ drivers/staging/iio/trigger/iio-trig-gpio.c (working copy)
@@ -13,7 +13,6 @@
  * TODO:
  *
  * Add board config elements to allow specification of startup settings.
- * Add configuration settings (irq type etc)
  */

 #include <linux/kernel.h>
@@ -30,7 +29,7 @@

 struct iio_gpio_trigger_info {
        struct mutex in_use;
-       int gpio;
+       unsigned int irq;
 };
 /*
  * Need to reference count these triggers and only enable gpio interrupts
@@ -57,78 +56,77 @@
        .attrs =3D iio_gpio_trigger_attrs,
 };

-static int iio_gpio_trigger_probe(struct platform_device *dev)
+static int iio_gpio_trigger_probe(struct platform_device *pdev)
 {
-       int *pdata =3D dev->dev.platform_data;
        struct iio_gpio_trigger_info *trig_info;
        struct iio_trigger *trig, *trig2;
-       int i, irq, ret =3D 0;
-       if (!pdata) {
-               printk(KERN_ERR "No IIO gpio trigger platform data found\n"=
);
-               goto error_ret;
-       }
-       for (i =3D 0;; i++) {
-               if (!gpio_is_valid(pdata[i]))
+       unsigned long irqflags;
+       struct resource *irq_res;
+       int irq, ret =3D 0, irq_res_cnt =3D 0;
+
+       do {
+               irq_res =3D platform_get_resource(pdev,
+                               IORESOURCE_IRQ, irq_res_cnt);
+
+               if (irq_res =3D=3D NULL) {
+                       if (irq_res_cnt =3D=3D 0)
+                               dev_err(&pdev->dev, "No GPIO IRQs specified=
");
                        break;
-               trig =3D iio_allocate_trigger();
-               if (!trig) {
-                       ret =3D -ENOMEM;
-                       goto error_free_completed_registrations;
                }
+               irqflags =3D (irq_res->flags & IRQF_TRIGGER_MASK) | IRQF_SH=
ARED;

-               trig_info =3D kzalloc(sizeof(*trig_info), GFP_KERNEL);
-               if (!trig_info) {
-                       ret =3D -ENOMEM;
-                       goto error_put_trigger;
-               }
-               trig->control_attrs =3D &iio_gpio_trigger_attr_group;
-               trig->private_data =3D trig_info;
-               trig_info->gpio =3D pdata[i];
-               trig->owner =3D THIS_MODULE;
-               trig->name =3D kmalloc(IIO_TRIGGER_NAME_LENGTH, GFP_KERNEL)=
;
-               if (!trig->name) {
-                       ret =3D -ENOMEM;
-                       goto error_free_trig_info;
-               }
-               snprintf((char *)trig->name,
-                        IIO_TRIGGER_NAME_LENGTH,
-                        "gpiotrig%d",
-                        pdata[i]);
-               ret =3D gpio_request(trig_info->gpio, trig->name);
-               if (ret)
-                       goto error_free_name;
+               for (irq =3D irq_res->start; irq <=3D irq_res->end; irq++) =
{

-               ret =3D gpio_direction_input(trig_info->gpio);
-               if (ret)
-                       goto error_release_gpio;
+                       trig =3D iio_allocate_trigger();
+                       if (!trig) {
+                               ret =3D -ENOMEM;
+                               goto error_free_completed_registrations;
+                       }

-               irq =3D gpio_to_irq(trig_info->gpio);
-               if (irq < 0) {
-                       ret =3D irq;
-                       goto error_release_gpio;
-               }
+                       trig_info =3D kzalloc(sizeof(*trig_info), GFP_KERNE=
L);
+                       if (!trig_info) {
+                               ret =3D -ENOMEM;
+                               goto error_put_trigger;
+                       }
+                       trig->control_attrs =3D &iio_gpio_trigger_attr_grou=
p;
+                       trig->private_data =3D trig_info;
+                       trig_info->irq =3D irq;
+                       trig->owner =3D THIS_MODULE;
+                       trig->name =3D kmalloc(IIO_TRIGGER_NAME_LENGTH,
+                                       GFP_KERNEL);
+                       if (!trig->name) {
+                               ret =3D -ENOMEM;
+                               goto error_free_trig_info;
+                       }
+                       snprintf((char *)trig->name,
+                                IIO_TRIGGER_NAME_LENGTH,
+                                "irqtrig%d", irq);

-               ret =3D request_irq(irq, iio_gpio_trigger_poll,
-                                 IRQF_TRIGGER_RISING,
-                                 trig->name,
-                                 trig);
-               if (ret)
-                       goto error_release_gpio;
+                       ret =3D request_irq(irq, iio_gpio_trigger_poll,
+                                         irqflags, trig->name, trig);
+                       if (ret) {
+                               dev_err(&pdev->dev,
+                                       "request IRQ-%d failed", irq);
+                               goto error_free_name;
+                       }

-               ret =3D iio_trigger_register(trig);
-               if (ret)
-                       goto error_release_irq;
+                       ret =3D iio_trigger_register(trig);
+                       if (ret)
+                               goto error_release_irq;

-               list_add_tail(&trig->alloc_list, &iio_gpio_trigger_list);
+                       list_add_tail(&trig->alloc_list,
+                                       &iio_gpio_trigger_list);
+               }

-       }
+               irq_res_cnt++;
+       } while (irq_res !=3D NULL);
+
+
        return 0;

 /* First clean up the partly allocated trigger */
 error_release_irq:
        free_irq(irq, trig);
-error_release_gpio:
-       gpio_free(trig_info->gpio);
 error_free_name:
        kfree(trig->name);
 error_free_trig_info:
@@ -142,18 +140,16 @@
                                 &iio_gpio_trigger_list,
                                 alloc_list) {
                trig_info =3D trig->private_data;
-               free_irq(gpio_to_irq(trig_info->gpio), trig);
-               gpio_free(trig_info->gpio);
+               free_irq(gpio_to_irq(trig_info->irq), trig);
                kfree(trig->name);
                kfree(trig_info);
                iio_trigger_unregister(trig);
        }

-error_ret:
        return ret;
 }

-static int iio_gpio_trigger_remove(struct platform_device *dev)
+static int iio_gpio_trigger_remove(struct platform_device *pdev)
 {
        struct iio_trigger *trig, *trig2;
        struct iio_gpio_trigger_info *trig_info;
@@ -165,8 +161,7 @@
                                 alloc_list) {
                trig_info =3D trig->private_data;
                iio_trigger_unregister(trig);
-               free_irq(gpio_to_irq(trig_info->gpio), trig);
-               gpio_free(trig_info->gpio);
+               free_irq(trig_info->irq, trig);
                kfree(trig->name);
                kfree(trig_info);
                iio_put_trigger(trig);


------------------------------------------------------------------
********* Analog Devices GmbH              Open Platform Solutions
**  *****
**     ** Wilhelm-Wagenfeld-Strasse 6
**  ***** D-80807 Munich
********* Germany
Registergericht M=FCnchen HRB 40368,  Gesch=E4ftsf=FChrer: Thomas Wessel, W=
illiam A. Martin, Margaret K. Seif
