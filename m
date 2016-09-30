Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:14819 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932988AbcI3QiF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Sep 2016 12:38:05 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Letux-kernel] [PATCH v3 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CA+Ot1Owa_evu62LJpH+TdUkLWd0n+0Dm30Q1-5KFJ6w_UBPfQQ@mail.gmail.com>
Date: Fri, 30 Sep 2016 18:36:47 +0200
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-iio@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        linux-input@vger.kernel.org, Michael Welling <mwelling@ieee.org>,
        "Andrew F. Davis" <afd@ti.com>,
        Igor Grinberg <grinberg@compulab.co.il>
Message-Id: <BB701067-29E9-4491-BEB5-AD0EBE89A28A@goldelico.com>
References: <cover.1474634475.git.hns@goldelico.com> <1409ed9845f17445a8a67bd6fb16c902c3e4f69c.1474634475.git.hns@goldelico.com> <CA+Ot1Owa_evu62LJpH+TdUkLWd0n+0Dm30Q1-5KFJ6w_UBPfQQ@mail.gmail.com>
To: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Christ,

> Am 30.09.2016 um 18:23 schrieb Christ van Willegen =
<cvwillegen@gmail.com>:
>=20
> Hi,
>=20
> I saw this earlier, but didn't think it important to mention, but:
>=20
>=20
> On Fri, Sep 23, 2016 at 2:41 PM, H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>=20
>> diff --git a/drivers/input/touchscreen/tsc2007.c =
b/drivers/input/touchscreen/tsc2007.c
>> index 5d0cd51..9a11509 100644
>> --- a/drivers/input/touchscreen/tsc2007.c
>> +++ b/drivers/input/touchscreen/tsc2007.c
>=20
>> +                       /* scale ADC values to desired output range =
*/
>> +                       sx =3D (ts->prop.max_x * (tc.x - ts->min_x))
>> +                               / (ts->max_x - ts->min_x);
>> +                       sy =3D (ts->prop.max_y * (tc.y - ts->min_y))
>> +                               / (ts->max_y - ts->min_y);
>> +                       rt =3D (input->absinfo[ABS_PRESSURE].maximum =
* rt) /
>> +                               ts->max_rt;
>=20
> If ts->max_rt is zero, or ts->max_x =3D=3D ts->min_x, or ts->max_y =3D=3D=

> ts->min_y, these yield a division by zero error.

Ah, that is a good observation!

>=20
> Ofcourse, this is under control of the DT-maintainer(s) of the device
> (if I'm not mistaking)

Yes, the DT should be designed properly.

> , but throwing an error on DT parse if (one of)
> these condition(s) is met yields better info to the DT-maintainer than
> a /0 error...

Yes, but I wonder how likely it is to happen at all.

In an case there is an indicative message (either /0 or an explaining =
one) in
the boot log which goes away as soon as it has been fixed.

This is already better than in many other cases where things simply fail =
without
any message...

So I would weight the likelihood of happening vs. the additional code
to check every time.

>=20
> If you (or others) agree, could you add this to the patch?

If maintainers request, I can easily add it. But personally I do not see
it as absolutely necessary.

BR and many thanks,
Nikolaus

