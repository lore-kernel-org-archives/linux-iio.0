Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"uclinux-dist-devel@blackfin.uclinux.org"
	<uclinux-dist-devel@blackfin.uclinux.org>
Date: Mon, 8 Mar 2010 13:45:49 +0000
Subject: RE: [PATCH] iio-trig-gpio:Remove redundant gpio_request
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712D6B1D9521@LIMKCMBX1.ad.analog.com>
References: <544AC56F16B56944AEC3BD4E3D5917712D6B1D944D@LIMKCMBX1.ad.analog.com>
 <4B94D847.1040209@cam.ac.uk>
 <544AC56F16B56944AEC3BD4E3D5917712D6B1D94C9@LIMKCMBX1.ad.analog.com>
 <4B94F7CE.9030703@cam.ac.uk>
In-Reply-To: <4B94F7CE.9030703@cam.ac.uk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2010-03-08:
> On 03/08/10 11:38, Hennerich, Michael wrote:
>> Hi Jonathan,
>> Jonathan Cameron wrote on 2010-03-08:
>>> Hi Michael,
>>>
>>> I'm wondering about this one.  Are you sure all platforms have the
>>> correct gpio setup when doing the request_irq?
>>> (those that need it obviously, basically the question is whether
>>> all platforms default to having gpio's as inputs).
>>>
>>> If the do there is certainly a lot of redundant code about based on a
>>> quick bit of grepping. (loads of it in arm/mach-pxa for starters). In
>>> that particular case all gpio's are configured as inputs, but I'm not
>>> sure other platforms are so well behaved.
>>>
>>>
>>> Unless I'm completely wrong that means we have run into a rather
>>> general issue.
>>
>> By no means - you have to first configure a GPIO_IRQ as GPIO-Input and
>> then as IRQ. irq_type takes care of it. In your case you gave the
>> IRQF_TRIGGER_RISING flag with request_irq(). In case such a
>> IRQF_TRIGGER_XXX flag is present the common IRQ infrastructure will
>> call the associated irq_chips irq_type() function. This function is
>> supposed to take care for all of it.(GPIO input, setting the level,
>> edge and polarity)
>>
>> As an alternative you can request_irq() without the
>> IRQF_TRIGGER_XXX
> flags and use set_irq_type() anytime later, or even in advance.
> Ah fair enough. Thanks for cleaning that up for me.
>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
>
> Please send it on to Greg KH

Shall I change the driver to loop on while(irq_res !=3D NULL)?
And get the irqflags from the platform data struct resource?


        unsigned long irqflags;
        struct resource *irq_res;
        int i =3D 0;



        irq_res =3D platform_get_resource(pdev, IORESOURCE_IRQ, i++);

        irqflags =3D irq_res->flags & IRQF_TRIGGER_MASK;

        [ -- snip -- ]

        ret =3D request_irq(irq, iio_gpio_trigger_poll,
                          irqflags,
                          trig->name,
                          trig);


-Michael

>>
>>>
>>> Also, if this is fine, the right fix is probably to have the interrupt
>>> as the platform data parameter rather than the gpio.  It makes the
>>> code more general and moves a lot of these direction issues etc into
>>> the board specific areas rather than here.
>>
>> Of course this is an option.
>>
>> Regards,
>> Michael
>>
>>>
>>> Also, CC Greg KH on any patches like this which are fixes.
>>>
>>> Jonathan
>>>
>>>> Remove redundant gpio_request. The GPIO used as trigger IRQ, is also
>>>> requested as gpio, but actually never read. On some platforms a GPIO
>>>> requested as IRQ can't be requested as GPIO as well.
>>>>
>>>> From: Michael Hennerich <Michael.Hennerich@analog.com>
>>>>
>>>> Index: drivers/staging/iio/trigger/iio-trig-gpio.c
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> =3D
>>>> --- drivers/staging/iio/trigger/iio-trig-gpio.c (revision 8368)
>>>> +++ drivers/staging/iio/trigger/iio-trig-gpio.c (working copy)
>>>> @@ -94,18 +94,11 @@
>>>>                          IIO_TRIGGER_NAME_LENGTH,
>>>>                          "gpiotrig%d",
>>>>                          pdata[i]);
>>>> -               ret =3D gpio_request(trig_info->gpio, trig->name);
>>>> -               if (ret)
>>>> -                       goto error_free_name;
>>>>
>>>> -               ret =3D gpio_direction_input(trig_info->gpio);
>>>> -               if (ret)
>>>> -                       goto error_release_gpio;
>>>> -
>>>>                 irq =3D gpio_to_irq(trig_info->gpio);
>>>>                 if (irq < 0) {
>>>>                         ret =3D irq;
>>>> -                       goto error_release_gpio;
>>>> +                       goto error_free_name;
>>>>                 }
>>>>
>>>>                 ret =3D request_irq(irq, iio_gpio_trigger_poll, @@
>>>> -113,7 +106,7 @@
>>>>                                   trig->name,
>>>>                                   trig);
>>>>                 if (ret)
>>>> -                       goto error_release_gpio;
>>>> +                       goto error_free_name;
>>>>
>>>>                 ret =3D iio_trigger_register(trig);
>>>>                 if (ret)
>>>> @@ -127,8 +120,6 @@
>>>>  /* First clean up the partly allocated trigger */
>>>>  error_release_irq:
>>>>         free_irq(irq, trig);
>>>> -error_release_gpio:
>>>> -       gpio_free(trig_info->gpio);
>>>>  error_free_name:
>>>>         kfree(trig->name);
>>>>  error_free_trig_info:
>>>> @@ -143,7 +134,6 @@
>>>>                                  alloc_list) {
>>>>                 trig_info =3D trig->private_data;
>>>>                 free_irq(gpio_to_irq(trig_info->gpio), trig); -
>>>>                       gpio_free(trig_info->gpio); kfree(trig-
>> name);
>>>>                 kfree(trig_info); iio_trigger_unregister(trig); @@
>>>>                 -166,7 +156,6 @@ trig_info =3D trig->private_data;
>>>>                 iio_trigger_unregister(trig);
>>>>                 free_irq(gpio_to_irq(trig_info->gpio), trig); -
>>>>                       gpio_free(trig_info->gpio); kfree(trig-
>> name);
>>>>                 kfree(trig_info); iio_put_trigger(trig);
>>>>
>>>> ------------------------------------------------------------------
>>>> ********* Analog Devices GmbH              Open Platform Solutions
>>>> **  *****
>>>> **     ** Wilhelm-Wagenfeld-Strasse 6
>>>> **  ***** D-80807 Munich
>>>> ********* Germany
>>>> Registergericht M=FCnchen HRB 40368,  Gesch=E4ftsf=FChrer: Thomas
>>>> Wessel, William A. Martin, Margaret K. Seif
>>>>
>> Greetings,
>> Michael
>>
>> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
>> Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036
>> Geschaeftsfuehrer Thomas Wessel, William A. Martin, Margaret Seif
>>
>>
Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeft=
sfuehrer Thomas Wessel, William A. Martin, Margaret Seif
