Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay04-haj2.antispameurope.com ([83.246.65.54]:38023 "EHLO
	relay04-haj2.antispameurope.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753264Ab0IBQkp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2010 12:40:45 -0400
Message-ID: <4C7FD38A.8090305@iis.fraunhofer.de>
Date: Thu, 02 Sep 2010 18:40:42 +0200
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
MIME-Version: 1.0
To: "J.I. Cameron" <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] staging:iio:trigger match leds trigger ABI
References: <1283441854-31560-1-git-send-email-manuel.stahl@iis.fraunhofer.de> <Prayer.1.3.3.1009021714490.10022@hermes-1.csi.cam.ac.uk>
In-Reply-To: <Prayer.1.3.3.1009021714490.10022@hermes-1.csi.cam.ac.uk>
Content-Type: multipart/mixed;
 boundary="------------060907000902060204050708"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is a multi-part message in MIME format.
--------------060907000902060204050708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by iis.fhg.de id SAA29014

Am 02.09.2010 18:14, schrieb J.I. Cameron:
> Hi Manuel,
>
> More explanation would be good.
>
> This falls into the debate of using a single sysfs param to list
> available options with the selected one highlighted in the list
> (what you have here)
>
> For every other element of iio we have gone with the separate attribute
> listing what is available.

I think it makes a big difference if the attribute accepts names or=20
numbers. With names, a list is always handy. The first time I tried to=20
use a different trigger than the device's own, I was totally lost. I=20
couldn't figure out which names are valid and which are not.

> I'm also a little dubious about this as it massively
> crosses over between different drivers (basically it gives an alternati=
ve
> way of listing all triggers currently on the system). Obviously this is
> to a certain extent true of led triggers as well, but there are relativ=
ely
> few of them (as far as I know?)

I think the led subsystem is not the only one using the list style. Just=20
have to lookup where I found other uses.

> We could easily have hundreds of triggers on a complex sensor rig. That
> makes for a very bit attribute indeed.

The same could happen to led triggers...

> So this is a nice idea, but in practice I'm not yet convinced it is
> actually
> a good idea in practice. This may be one to bounce up to lkml for a wid=
er
> set of opinions.

Yes, let's here what other think about it. Was more like a proposal=20
patch to see what it will look like and how useful it is.

>>
>> Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de> ---
>> drivers/staging/iio/industrialio-trigger.c | 27
>> ++++++++++++++++++++------- 1 files changed, 20 insertions(+), 7
>> deletions(-)
>>
>> diff --git a/drivers/staging/iio/industrialio-trigger.c
>> b/drivers/staging/iio/industrialio-trigger.c index 57dd923..25ee00f
>> 100644 --- a/drivers/staging/iio/industrialio-trigger.c +++
>> b/drivers/staging/iio/industrialio-trigger.c @@ -293,11 +293,25 @@
>> static ssize_t iio_trigger_read_current(struct device *dev,
>> char *buf)
>> {
>> struct iio_dev *dev_info =3D dev_get_drvdata(dev);
>> + struct iio_trigger *trig;
>> int len =3D 0;
>> - if (dev_info->trig)
>> - len =3D sprintf(buf,
>> - "%s\n",
>> - dev_info->trig->name);
>> +
>> + if (!dev_info->trig)
>> + len +=3D sprintf(buf+len, "[none]");
> spaces round the +? I have a vague feeling checkpatch is fussy about th=
at.
>> + else
>> + len +=3D sprintf(buf+len, "none ");
>> +
>> + mutex_lock(&iio_trigger_list_lock);
>> + list_for_each_entry(trig, &iio_trigger_list, list) {
> what is the point of this?
>> + if (dev_info->trig && !strcmp(dev_info->trig->name,
>> + trig->name))
>> + len +=3D sprintf(buf+len, " [%s]", trig->name);
>> + else
>> + len +=3D sprintf(buf+len, " %s", trig->name);
> At very least these need some protection to prevent a buffer overrun.
>> + }
>> + mutex_unlock(&iio_trigger_list_lock);
>> +
>> + len +=3D sprintf(len+buf, "\n");
>> return len;
>> }
>>
>> @@ -331,17 +345,16 @@ static ssize_t iio_trigger_write_current(struct
>> device *dev,
>> return len;
>> }
>>
>> -static DEVICE_ATTR(current_trigger, S_IRUGO | S_IWUSR,
>> +static DEVICE_ATTR(trigger, S_IRUGO | S_IWUSR,
>> iio_trigger_read_current,
>> iio_trigger_write_current);
>>
>> static struct attribute *iio_trigger_consumer_attrs[] =3D {
>> - &dev_attr_current_trigger.attr,
>> + &dev_attr_trigger.attr,
>> NULL,
>> };
>>
>> static const struct attribute_group iio_trigger_consumer_attr_group =3D=
 {
>> - .name =3D "trigger",
>> .attrs =3D iio_trigger_consumer_attrs,
>> };
>>
>>


--=20
Dipl.-Inf. Manuel Stahl
Fraunhofer-Institut f=FCr Integrierte Schaltungen IIS
- Leistungsoptimierte Systeme -
Nordostpark 93                Telefon  +49 (0)911/58061-6419
90411 N=FCrnberg                Fax      +49 (0)911/58061-6398
http://www.iis.fraunhofer.de  manuel.stahl@iis.fraunhofer.de

--------------060907000902060204050708
Content-Type: text/x-vcard; charset=utf-8;
 name="manuel_stahl.vcf"
Content-Disposition: attachment;
 filename="manuel_stahl.vcf"
Content-Transfer-Encoding: quoted-printable

begin:vcard
fn:Manuel Stahl
n:Stahl;Manuel
email;internet:manuel.stahl@iis.fraunhofer.de
tel;work:+49 911 58061-6419
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------060907000902060204050708--
