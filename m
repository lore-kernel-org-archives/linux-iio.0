Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:33815 "EHLO
	ppsw-7.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794Ab0CIMnQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2010 07:43:16 -0500
Message-ID: <4B9642E8.6020507@cam.ac.uk>
Date: Tue, 09 Mar 2010 12:45:28 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "gregkh@suse.de" <gregkh@suse.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"uclinux-dist-devel@blackfin.uclinux.org"
	<uclinux-dist-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] iio-trig-gpio:Remove redundant gpio_request
References: <544AC56F16B56944AEC3BD4E3D5917712D6B1D96B4@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917712D6B1D96B4@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Again,

This patch probably needs.

Signed-off-by: Michael Hennerich <Michael.Hennerich@analog.com>

and you can add
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

p.s. For those not following original thread this is a fix for=20
am misunderstanding of mine when I wrote the original code.
(Thanks!)

> Remove redundant gpio_request:
> The GPIO used as trigger IRQ, is also requested as gpio, but actually=
 never read.
>=20
> Use platform resource facility to get IRQs numbers and flags.
> Make sure this driver can be used with any system IRQ, not necessaril=
y limited to GPIO-IRQs.
> Use dev_err(dev...) and friends instead of printk(KERN_ERR...)
>=20
> From: Michael Hennerich <Michael.Hennerich@analog.com>
>=20
> Index: drivers/staging/iio/trigger/iio-trig-gpio.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- drivers/staging/iio/trigger/iio-trig-gpio.c (revision 7916)
> +++ drivers/staging/iio/trigger/iio-trig-gpio.c (working copy)
> @@ -13,7 +13,6 @@
>   * TODO:
>   *
>   * Add board config elements to allow specification of startup setti=
ngs.
> - * Add configuration settings (irq type etc)
>   */
>=20
>  #include <linux/kernel.h>
> @@ -30,7 +29,7 @@
>=20
>  struct iio_gpio_trigger_info {
>         struct mutex in_use;
> -       int gpio;
> +       unsigned int irq;
>  };
>  /*
>   * Need to reference count these triggers and only enable gpio inter=
rupts
> @@ -57,78 +56,77 @@
>         .attrs =3D iio_gpio_trigger_attrs,
>  };
>=20
> -static int iio_gpio_trigger_probe(struct platform_device *dev)
> +static int iio_gpio_trigger_probe(struct platform_device *pdev)
>  {
> -       int *pdata =3D dev->dev.platform_data;
>         struct iio_gpio_trigger_info *trig_info;
>         struct iio_trigger *trig, *trig2;
> -       int i, irq, ret =3D 0;
> -       if (!pdata) {
> -               printk(KERN_ERR "No IIO gpio trigger platform data fo=
und\n");
> -               goto error_ret;
> -       }
> -       for (i =3D 0;; i++) {
> -               if (!gpio_is_valid(pdata[i]))
> +       unsigned long irqflags;
> +       struct resource *irq_res;
> +       int irq, ret =3D 0, irq_res_cnt =3D 0;
> +
> +       do {
> +               irq_res =3D platform_get_resource(pdev,
> +                               IORESOURCE_IRQ, irq_res_cnt);
> +
> +               if (irq_res =3D=3D NULL) {
> +                       if (irq_res_cnt =3D=3D 0)
> +                               dev_err(&pdev->dev, "No GPIO IRQs spe=
cified");
>                         break;
> -               trig =3D iio_allocate_trigger();
> -               if (!trig) {
> -                       ret =3D -ENOMEM;
> -                       goto error_free_completed_registrations;
>                 }
> +               irqflags =3D (irq_res->flags & IRQF_TRIGGER_MASK) | I=
RQF_SHARED;
>=20
> -               trig_info =3D kzalloc(sizeof(*trig_info), GFP_KERNEL)=
;
> -               if (!trig_info) {
> -                       ret =3D -ENOMEM;
> -                       goto error_put_trigger;
> -               }
> -               trig->control_attrs =3D &iio_gpio_trigger_attr_group;
> -               trig->private_data =3D trig_info;
> -               trig_info->gpio =3D pdata[i];
> -               trig->owner =3D THIS_MODULE;
> -               trig->name =3D kmalloc(IIO_TRIGGER_NAME_LENGTH, GFP_K=
ERNEL);
> -               if (!trig->name) {
> -                       ret =3D -ENOMEM;
> -                       goto error_free_trig_info;
> -               }
> -               snprintf((char *)trig->name,
> -                        IIO_TRIGGER_NAME_LENGTH,
> -                        "gpiotrig%d",
> -                        pdata[i]);
> -               ret =3D gpio_request(trig_info->gpio, trig->name);
> -               if (ret)
> -                       goto error_free_name;
> +               for (irq =3D irq_res->start; irq <=3D irq_res->end; i=
rq++) {
>=20
> -               ret =3D gpio_direction_input(trig_info->gpio);
> -               if (ret)
> -                       goto error_release_gpio;
> +                       trig =3D iio_allocate_trigger();
> +                       if (!trig) {
> +                               ret =3D -ENOMEM;
> +                               goto error_free_completed_registratio=
ns;
> +                       }
>=20
> -               irq =3D gpio_to_irq(trig_info->gpio);
> -               if (irq < 0) {
> -                       ret =3D irq;
> -                       goto error_release_gpio;
> -               }
> +                       trig_info =3D kzalloc(sizeof(*trig_info), GFP=
_KERNEL);
> +                       if (!trig_info) {
> +                               ret =3D -ENOMEM;
> +                               goto error_put_trigger;
> +                       }
> +                       trig->control_attrs =3D &iio_gpio_trigger_att=
r_group;
> +                       trig->private_data =3D trig_info;
> +                       trig_info->irq =3D irq;
> +                       trig->owner =3D THIS_MODULE;
> +                       trig->name =3D kmalloc(IIO_TRIGGER_NAME_LENGT=
H,
> +                                       GFP_KERNEL);
> +                       if (!trig->name) {
> +                               ret =3D -ENOMEM;
> +                               goto error_free_trig_info;
> +                       }
> +                       snprintf((char *)trig->name,
> +                                IIO_TRIGGER_NAME_LENGTH,
> +                                "irqtrig%d", irq);
>=20
> -               ret =3D request_irq(irq, iio_gpio_trigger_poll,
> -                                 IRQF_TRIGGER_RISING,
> -                                 trig->name,
> -                                 trig);
> -               if (ret)
> -                       goto error_release_gpio;
> +                       ret =3D request_irq(irq, iio_gpio_trigger_pol=
l,
> +                                         irqflags, trig->name, trig)=
;
> +                       if (ret) {
> +                               dev_err(&pdev->dev,
> +                                       "request IRQ-%d failed", irq)=
;
> +                               goto error_free_name;
> +                       }
>=20
> -               ret =3D iio_trigger_register(trig);
> -               if (ret)
> -                       goto error_release_irq;
> +                       ret =3D iio_trigger_register(trig);
> +                       if (ret)
> +                               goto error_release_irq;
>=20
> -               list_add_tail(&trig->alloc_list, &iio_gpio_trigger_li=
st);
> +                       list_add_tail(&trig->alloc_list,
> +                                       &iio_gpio_trigger_list);
> +               }
>=20
> -       }
> +               irq_res_cnt++;
> +       } while (irq_res !=3D NULL);
> +
> +
>         return 0;
>=20
>  /* First clean up the partly allocated trigger */
>  error_release_irq:
>         free_irq(irq, trig);
> -error_release_gpio:
> -       gpio_free(trig_info->gpio);
>  error_free_name:
>         kfree(trig->name);
>  error_free_trig_info:
> @@ -142,18 +140,16 @@
>                                  &iio_gpio_trigger_list,
>                                  alloc_list) {
>                 trig_info =3D trig->private_data;
> -               free_irq(gpio_to_irq(trig_info->gpio), trig);
> -               gpio_free(trig_info->gpio);
> +               free_irq(gpio_to_irq(trig_info->irq), trig);
>                 kfree(trig->name);
>                 kfree(trig_info);
>                 iio_trigger_unregister(trig);
>         }
>=20
> -error_ret:
>         return ret;
>  }
>=20
> -static int iio_gpio_trigger_remove(struct platform_device *dev)
> +static int iio_gpio_trigger_remove(struct platform_device *pdev)
>  {
>         struct iio_trigger *trig, *trig2;
>         struct iio_gpio_trigger_info *trig_info;
> @@ -165,8 +161,7 @@
>                                  alloc_list) {
>                 trig_info =3D trig->private_data;
>                 iio_trigger_unregister(trig);
> -               free_irq(gpio_to_irq(trig_info->gpio), trig);
> -               gpio_free(trig_info->gpio);
> +               free_irq(trig_info->irq, trig);
>                 kfree(trig->name);
>                 kfree(trig_info);
>                 iio_put_trigger(trig);
>=20
>=20
> ------------------------------------------------------------------
> ********* Analog Devices GmbH              Open Platform Solutions
> **  *****
> **     ** Wilhelm-Wagenfeld-Strasse 6
> **  ***** D-80807 Munich
> ********* Germany
> Registergericht M=FCnchen HRB 40368,  Gesch=E4ftsf=FChrer: Thomas Wes=
sel, William A. Martin, Margaret K. Seif
>=20

