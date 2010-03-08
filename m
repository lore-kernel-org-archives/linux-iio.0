Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>, Jonathan Cameron
	<jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"uclinux-dist-devel@blackfin.uclinux.org"
	<uclinux-dist-devel@blackfin.uclinux.org>
Date: Mon, 8 Mar 2010 14:47:12 +0000
Subject: RE: [PATCH] iio-trig-gpio:Remove redundant gpio_request
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712D6B1D956D@LIMKCMBX1.ad.analog.com>
References: <544AC56F16B56944AEC3BD4E3D5917712D6B1D944D@LIMKCMBX1.ad.analog.com>
 <4B94D847.1040209@cam.ac.uk>
 <544AC56F16B56944AEC3BD4E3D5917712D6B1D94C9@LIMKCMBX1.ad.analog.com>
 <4B94F7CE.9030703@cam.ac.uk>
 <544AC56F16B56944AEC3BD4E3D5917712D6B1D9521@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917712D6B1D9521@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hennerich, Michael wrote on 2010-03-08:
> Jonathan Cameron wrote on 2010-03-08:
>> On 03/08/10 11:38, Hennerich, Michael wrote:
>>> Hi Jonathan,
>>> Jonathan Cameron wrote on 2010-03-08:
>>>> Hi Michael,
>>>>
>>>> I'm wondering about this one.  Are you sure all platforms have the
>>>> correct gpio setup when doing the request_irq? (those that need it
>>>> obviously, basically the question is whether all platforms default to
>>>> having gpio's as inputs).
>>>>
>>>> If the do there is certainly a lot of redundant code about based on a
>>>> quick bit of grepping. (loads of it in arm/mach-pxa for starters). In
>>>> that particular case all gpio's are configured as inputs, but I'm not
>>>> sure other platforms are so well behaved.
>>>>
>>>>
>>>> Unless I'm completely wrong that means we have run into a rather
>>>> general issue.
>>>
>>> By no means - you have to first configure a GPIO_IRQ as GPIO-Input and
>>> then as IRQ. irq_type takes care of it. In your case you gave the
>>> IRQF_TRIGGER_RISING flag with request_irq(). In case such a
>>> IRQF_TRIGGER_XXX flag is present the common IRQ infrastructure will
>>> call the associated irq_chips irq_type() function. This function is
>>> supposed to take care for all of it.(GPIO input, setting the level,
>>> edge and polarity)
>>>
>>> As an alternative you can request_irq() without the
>>> IRQF_TRIGGER_XXX
>> flags and use set_irq_type() anytime later, or even in advance.
>> Ah fair enough. Thanks for cleaning that up for me.
>>
>> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
>>
>> Please send it on to Greg KH
>
> Shall I change the driver to loop on while(irq_res !=3D NULL)?
> And get the irqflags from the platform data struct resource?

What do you think about this one?

Example Platform Data:

#if defined(CONFIG_IIO_GPIO_TRIGGER) || \
        defined(CONFIG_IIO_GPIO_TRIGGER_MODULE)

static struct resource iio_gpio_trigger_resources[] =3D {
        [0] =3D {
                .start  =3D IRQ_PF5,
                .end    =3D IRQ_PF5,
                .flags  =3D IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
        },
        [1] =3D {
                .start  =3D IRQ_PF2,
                .end    =3D IRQ_PF3,
                .flags  =3D IORESOURCE_IRQ | IORESOURCE_IRQ_LOWEDGE,
        },
};

static struct platform_device iio_gpio_trigger =3D {
        .name =3D "iio_gpio_trigger",
        .num_resources =3D ARRAY_SIZE(iio_gpio_trigger_resources),
        .resource =3D iio_gpio_trigger_resources,
};
#endif

This way allows you to specify different GPIO Edge/Polarity behavior as wel=
l as GPIO-IRQ sequences.
Patch below is an top of my previous one.
I wonder I we should change all references to gpio completely (replace with=
 irq), since this driver can also be used with any other system IRQ as well=
.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/staging/iio/trigger/iio-trig-gpio.c (revision 8415)
+++ drivers/staging/iio/trigger/iio-trig-gpio.c (working copy)
@@ -57,64 +57,73 @@
        .attrs =3D iio_gpio_trigger_attrs,
 };

-static int iio_gpio_trigger_probe(struct platform_device *dev)
+static int iio_gpio_trigger_probe(struct platform_device *pdev)
 {
-       int *pdata =3D dev->dev.platform_data;
+       int *pdata =3D pdev->dev.platform_data;
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
+       unsigned gpio;
+
+       do {
+               irq_res =3D platform_get_resource(pdev, IORESOURCE_IRQ, irq=
_res_cnt);
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
+               irqflags =3D irq_res->flags & IRQF_TRIGGER_MASK;

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
+               for (irq =3D irq_res->start; irq <=3D irq_res->end; irq++) =
{
+                       gpio =3D irq_to_gpio(irq);
+                       if (!gpio_is_valid(gpio))
+                               break;
+                       trig =3D iio_allocate_trigger();
+                       if (!trig) {
+                               ret =3D -ENOMEM;
+                               goto error_free_completed_registrations;
+                       }

-               irq =3D gpio_to_irq(trig_info->gpio);
-               if (irq < 0) {
-                       ret =3D irq;
-                       goto error_free_name;
+                       trig_info =3D kzalloc(sizeof(*trig_info), GFP_KERNE=
L);
+                       if (!trig_info) {
+                               ret =3D -ENOMEM;
+                               goto error_put_trigger;
+                       }
+                       trig->control_attrs =3D &iio_gpio_trigger_attr_grou=
p;
+                       trig->private_data =3D trig_info;
+                       trig_info->gpio =3D gpio;
+                       trig->owner =3D THIS_MODULE;
+                       trig->name =3D kmalloc(IIO_TRIGGER_NAME_LENGTH, GFP=
_KERNEL);
+                       if (!trig->name) {
+                               ret =3D -ENOMEM;
+                               goto error_free_trig_info;
+                       }
+                       snprintf((char *)trig->name,
+                                IIO_TRIGGER_NAME_LENGTH,
+                                "gpiotrig%d",
+                                gpio);
+
+                       ret =3D request_irq(irq, iio_gpio_trigger_poll,
+                                         irqflags,
+                                         trig->name,
+                                         trig);
+                       if (ret)
+                               goto error_free_name;
+
+                       ret =3D iio_trigger_register(trig);
+                       if (ret)
+                               goto error_release_irq;
+
+                       list_add_tail(&trig->alloc_list, &iio_gpio_trigger_=
list);
                }

-               ret =3D request_irq(irq, iio_gpio_trigger_poll,
-                                 IRQF_TRIGGER_RISING,
-                                 trig->name,
-                                 trig);
-               if (ret)
-                       goto error_free_name;
+               irq_res_cnt++;
+       } while (irq_res !=3D NULL);

-               ret =3D iio_trigger_register(trig);
-               if (ret)
-                       goto error_release_irq;

-               list_add_tail(&trig->alloc_list, &iio_gpio_trigger_list);
-
-       }
        return 0;

 /* First clean up the partly allocated trigger */
@@ -143,7 +152,7 @@
        return ret;
 }

-static int iio_gpio_trigger_remove(struct platform_device *dev)
+static int iio_gpio_trigger_remove(struct platform_device *pdev)
 {
        struct iio_trigger *trig, *trig2;
        struct iio_gpio_trigger_info *trig_info;
