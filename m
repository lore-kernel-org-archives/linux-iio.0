Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:46766 "EHLO
	ppsw-1.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549Ab0CHNKi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 8 Mar 2010 08:10:38 -0500
Message-ID: <4B94F7CE.9030703@cam.ac.uk>
Date: Mon, 08 Mar 2010 13:12:46 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"uclinux-dist-devel@blackfin.uclinux.org"
	<uclinux-dist-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] iio-trig-gpio:Remove redundant gpio_request
References: <544AC56F16B56944AEC3BD4E3D5917712D6B1D944D@LIMKCMBX1.ad.analog.com> <4B94D847.1040209@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D5917712D6B1D94C9@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917712D6B1D94C9@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/08/10 11:38, Hennerich, Michael wrote:
> Hi Jonathan,
> Jonathan Cameron wrote on 2010-03-08:
>> Hi Michael,
>>
>> I'm wondering about this one.  Are you sure all platforms have the
>> correct gpio setup when doing the request_irq?
>> (those that need it obviously, basically the question is whether all
>> platforms default to having gpio's as inputs).
>>
>> If the do there is certainly a lot of redundant code about based on =
a
>> quick bit of grepping. (loads of it in arm/mach-pxa for starters).  =
In
>> that particular case all gpio's are configured as inputs, but I'm no=
t
>> sure other platforms are so well behaved.
>>
>>
>> Unless I'm completely wrong that means we have run into a rather
>> general issue.
>=20
> By no means - you have to first configure a GPIO_IRQ as GPIO-Input an=
d then as IRQ.
> irq_type takes care of it. In your case you gave the IRQF_TRIGGER_RIS=
ING flag with request_irq().
> In case such a IRQF_TRIGGER_XXX flag is present the common IRQ infras=
tructure will call the associated irq_chips irq_type() function.
> This function is supposed to take care for all of it.(GPIO input, set=
ting the level, edge and polarity)
>=20
> As an alternative you can request_irq() without the  IRQF_TRIGGER_XXX=
 flags and use set_irq_type() anytime later, or even in advance.
Ah fair enough. Thanks for cleaning that up for me.

Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

Please send it on to Greg KH
>=20
>>
>> Also, if this is fine, the right fix is probably to have the interru=
pt
>> as the platform data parameter rather than the gpio.  It makes the
>> code more general and moves a lot of these direction issues etc into
>> the board specific areas rather than here.
>=20
> Of course this is an option.
>=20
> Regards,
> Michael
>=20
>>
>> Also, CC Greg KH on any patches like this which are fixes.
>>
>> Jonathan
>>
>>> Remove redundant gpio_request. The GPIO used as trigger IRQ, is als=
o
>>> requested as gpio, but actually never read. On some platforms a GPI=
O
>>> requested as IRQ can't be requested as GPIO as well.
>>>
>>> From: Michael Hennerich <Michael.Hennerich@analog.com>
>>>
>>> Index: drivers/staging/iio/trigger/iio-trig-gpio.c
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- drivers/staging/iio/trigger/iio-trig-gpio.c (revision 8368)
>>> +++ drivers/staging/iio/trigger/iio-trig-gpio.c (working copy)
>>> @@ -94,18 +94,11 @@
>>>                          IIO_TRIGGER_NAME_LENGTH,
>>>                          "gpiotrig%d",
>>>                          pdata[i]);
>>> -               ret =3D gpio_request(trig_info->gpio, trig->name);
>>> -               if (ret)
>>> -                       goto error_free_name;
>>>
>>> -               ret =3D gpio_direction_input(trig_info->gpio);
>>> -               if (ret)
>>> -                       goto error_release_gpio;
>>> -
>>>                 irq =3D gpio_to_irq(trig_info->gpio);
>>>                 if (irq < 0) {
>>>                         ret =3D irq;
>>> -                       goto error_release_gpio;
>>> +                       goto error_free_name;
>>>                 }
>>>
>>>                 ret =3D request_irq(irq, iio_gpio_trigger_poll, @@
>>> -113,7 +106,7 @@
>>>                                   trig->name,
>>>                                   trig);
>>>                 if (ret)
>>> -                       goto error_release_gpio;
>>> +                       goto error_free_name;
>>>
>>>                 ret =3D iio_trigger_register(trig);
>>>                 if (ret)
>>> @@ -127,8 +120,6 @@
>>>  /* First clean up the partly allocated trigger */
>>>  error_release_irq:
>>>         free_irq(irq, trig);
>>> -error_release_gpio:
>>> -       gpio_free(trig_info->gpio);
>>>  error_free_name:
>>>         kfree(trig->name);
>>>  error_free_trig_info:
>>> @@ -143,7 +134,6 @@
>>>                                  alloc_list) {
>>>                 trig_info =3D trig->private_data;
>>>                 free_irq(gpio_to_irq(trig_info->gpio), trig); -
>>>                       gpio_free(trig_info->gpio); kfree(trig->name)=
;
>>>                 kfree(trig_info); iio_trigger_unregister(trig); @@
>>>                 -166,7 +156,6 @@ trig_info =3D trig->private_data;
>>>                 iio_trigger_unregister(trig);
>>>                 free_irq(gpio_to_irq(trig_info->gpio), trig); -
>>>                       gpio_free(trig_info->gpio); kfree(trig->name)=
;
>>>                 kfree(trig_info); iio_put_trigger(trig);
>>>
>>>
>>> ------------------------------------------------------------------
>>> ********* Analog Devices GmbH              Open Platform Solutions
>>> **  *****
>>> **     ** Wilhelm-Wagenfeld-Strasse 6
>>> **  ***** D-80807 Munich
>>> ********* Germany
>>> Registergericht M=FCnchen HRB 40368,  Gesch=E4ftsf=FChrer: Thomas W=
essel,
>>> William A. Martin, Margaret K. Seif
>>>
> Greetings,
> Michael
>=20
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Ges=
chaeftsfuehrer Thomas Wessel, William A. Martin, Margaret Seif
>=20
>=20

