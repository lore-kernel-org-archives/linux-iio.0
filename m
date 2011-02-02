Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Greg KH <greg@kroah.com>
CC: "jic23@cam.ac.uk" <jic23@cam.ac.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	"broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
Date: Wed, 2 Feb 2011 20:13:56 +0000
Subject: RE: [PATCH] IIO: TRIGGER: New sysfs based trigger
Message-ID: <544AC56F16B56944AEC3BD4E3D591771324C1659CB@LIMKCMBX1.ad.analog.com>
References: <1296674468-24251-1-git-send-email-michael.hennerich@analog.com>
 <20110202194318.GB27065@kroah.com>
In-Reply-To: <20110202194318.GB27065@kroah.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Greg KH wrote on 2011-02-02:
> On Wed, Feb 02, 2011 at 08:21:08PM +0100, michael.hennerich@analog.com
> wrote:
>> +static struct platform_driver iio_sysfs_trigger_driver =3D {
>> +    .driver =3D {
>> +            .name =3D "iio_sysfs_trigger",
>> +            .owner =3D THIS_MODULE,
>> +    },
>> +    .probe =3D iio_sysfs_trigger_probe,
>> +    .remove =3D __devexit_p(iio_sysfs_trigger_remove),
>> +};
>
> Why is this a platform device?  It doesn't seem to be platform
> specific at all, does it?

What else do you think it should be?
Construct driver on initcall, and use module parameters?
IMHO it is platform specific, since platform device bus allows me to regist=
er and run multiple instances.
Depending on the use case, which may vary from board/platform - multiple in=
stances are required.

Like Mark indicated - in EMBEDDED if it doesn't belong to any other bus - i=
t's likely a platform bus driver.

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
